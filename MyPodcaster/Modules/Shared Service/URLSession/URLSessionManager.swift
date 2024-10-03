import Foundation

protocol URLSessionManagerProtocol {
    func fetchPodcast(url: URL)
}

protocol URLSessionManagerDelegate:AnyObject {
    func didFetchPodcast(podcast: PodcastModel)
    func didFailToFetchPodcast()
    func didFailToFetchWrongURL()
}

final class URLSessionManager: URLSessionManagerProtocol {

    weak var delegate: URLSessionManagerDelegate?

    private let session: URLSession

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    func fetchPodcast(url: URL) {
        let task = session.dataTask(with: url) { data, response, error in

            guard let data = data, error == nil else {
                if let nsError = error as? NSError, nsError.code == -1002 {
                    self.delegate?.didFailToFetchWrongURL()
                } else {
                    self.delegate?.didFailToFetchPodcast()
                }
                return
            }

            let mapper = PodcastMapper()
            mapper.completion = { [weak self] podcast in
                guard let self, let podcast = podcast else {
                    self?.delegate?.didFailToFetchPodcast()
                    return
                }
                self.delegate?.didFetchPodcast(podcast: podcast)
            }
            mapper.parseXML(data: data, url: url.absoluteString)
        }
        task.resume()
    }
}
