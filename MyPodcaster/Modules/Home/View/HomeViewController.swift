import UIKit

class HomeViewController: UIViewController {
    
    var items: [RSSItem] = []
//    lazy var detailView = DetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view = detailView
        showRSSFeed()
    }
    
//    func showRSSFeed() {
//        let manager = DataManager()
//        manager.fetchRSSFeed(url: "https://feeds.megaphone.fm/la-cotorrisa")
//        
//        manager.completion = { items in
//            self.items = items
////            print(items)
//        }
//    }
    
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
          let detailVC = DetailViewController()
          detailVC.items = item
          self.present(detailVC, animated: true, completion: nil)
      }
}
