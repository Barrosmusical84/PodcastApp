import UIKit

struct PodcastModel {
    let title: String
    let image: URL?
    let episodes: [RSSItem]
}

struct HomeViewModel {
    let podcasts: [PodcastModel]
}



class HomeViewController: UIViewController {
    
    var viewModel: HomeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = makeMock()
//        uploadData()
    }
    
    func makeMock() -> HomeViewModel {
        let podCast1 = PodcastModel(title: "Claro Podcast", image: nil, episodes: [])
        let podCast2 = PodcastModel(title: "Vivo Podcast", image: nil, episodes: [])
        return .init(podcasts: [podCast1, podCast2])
    }
    
    func showRSSFeed() {
        let manager = DataManager()
        manager.fetchRSSFeed(url: "https://feeds.megaphone.fm/la-cotorrisa")
        
        manager.completion = { [weak self] items in
            guard let self = self else { return }
//            self.items = items
            DispatchQueue.main.async {
//                if let firstItem = self.items.first {
//                    self.showDetail(for: firstItem)
//                }
            }
        }
    }
    
    func showDetail(for item: RSSItem) {
        let detailViewController = DetailViewController()
        detailViewController.items = item
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}


