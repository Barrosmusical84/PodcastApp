import UIKit

struct PodcastModel {
    var title: String?
    var image: String?
    var description: String?
    var episodes: [RSSItem] = []
}

class HomeViewController: UIViewController {
    
    private var viewModel: HomeViewModel

    init(viewModel: HomeViewModel = HomeViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchPodcast(url: "https://anchor.fm/s/7a186bc/podcast/rss", completion: { model in
            debugPrint(model)
        })
    }
    
    func showDetail(for item: RSSItem) {
        let detailViewController = DetailViewController()
        detailViewController.items = item
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

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
            completion(self.podcasts)
        }
    }
}





