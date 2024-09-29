import UIKit

class HomeViewController: UIViewController {
    
    var items: [RSSItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showRSSFeed()
    }
    
    func showRSSFeed() {
        let manager = DataManager()
        manager.fetchRSSFeed(url: "https://feeds.megaphone.fm/la-cotorrisa")
        
        manager.completion = { [weak self] items in
            guard let self = self else { return }
            self.items = items
            DispatchQueue.main.async {
                if let firstItem = self.items.first {
                    self.showDetail(for: firstItem)
                }
            }
        }
    }
    
    func showDetail(for item: RSSItem) {
        let detailViewController = DetailViewController()
        detailViewController.items = item
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
