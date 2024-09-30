import Foundation

class HomeViewModel {

    private var manager: NetworkManager

    private var podcasts: [PodcastModel] = []

    init(manager: NetworkManager = NetworkManager()) {
        self.manager = manager
    }

    func fetchLocalPodcasts() -> [PodcastModel] {
        return podcasts
    }

    func fetchPodcast(url: String, completion: @escaping([PodcastModel]) -> ()) {
        guard let url = URL(string: url) else {
            return
        }

        manager.fetchRSSFeed(url: url)
        manager.completion = { [weak self] podcast in

            guard let self = self else {
                return
            }
            self.podcasts.append(podcast)
            DispatchQueue.main.async {
                completion(self.podcasts)
            }
        }
    }
}
