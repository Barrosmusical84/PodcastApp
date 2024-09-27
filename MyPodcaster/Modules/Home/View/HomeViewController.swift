import UIKit

class HomeViewController: UIViewController {
    
    var items: [RSSItem] = []
    lazy var detailView = DetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = detailView
        showRSSFeed()
    }
    
    func showRSSFeed() {
        let manager = DataManager()
        manager.fetchRSSFeed(url: "https://feeds.megaphone.fm/la-cotorrisa")
        
        manager.completion = { items in
            self.items = items
//            print(items)
        }
    }
}
