import UIKit

final class DetailViewController: UIViewController {
    
    var items: RSSItem?
    lazy var detailView = DetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = detailView
        
        if let item = items {
            detailView.configureView(item)
        }
    }
}

