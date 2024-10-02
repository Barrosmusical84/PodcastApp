import Foundation

protocol URLSessionManagerProtocol {
    func fetchPodcast(url: URL)
}

protocol URLSessionManagerDelegate:AnyObject {
    func didFetchPodcast(podcast: PodcastModel)
    func didFailToFetchPodcast()
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
                self.delegate?.didFailToFetchPodcast()
                return
            }

            let mapper = PodcastMapper()
            mapper.completion = { podcastModel in
                self.delegate?.didFetchPodcast(podcast: podcastModel)
            }
            mapper.parseXML(data: data, url: url.absoluteString)
        }
        task.resume()
    }
}
