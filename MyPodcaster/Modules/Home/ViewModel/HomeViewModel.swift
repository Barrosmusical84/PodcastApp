import Foundation

class HomeViewModel {

    private var manager: NetworkManager


    init(manager: NetworkManager = NetworkManager()) {
        self.manager = manager
    }

    func fetchPodcast(url: String, completion: @escaping(PodcastModel) -> ()) {
        guard let url = URL(string: url) else {
            return
        }

        manager.fetchRSSFeed(url: url)

        manager.completion = { podcast in

            DispatchQueue.main.async {
                completion(podcast)
            }
        }
    }
}
