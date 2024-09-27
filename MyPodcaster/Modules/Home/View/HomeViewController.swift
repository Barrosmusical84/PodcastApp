import UIKit

class HomeViewController: UIViewController {
    
    var items: [RSSItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRSSFeed()
    }
    
    func fetchRSSFeed() {
        let manager = DataManager()
        manager.fetchRSSFeed(url: "https://feeds.megaphone.fm/la-cotorrisa")
        
        manager.completion = { items in
            self.items = items
            print(items)
        }
    }
}
