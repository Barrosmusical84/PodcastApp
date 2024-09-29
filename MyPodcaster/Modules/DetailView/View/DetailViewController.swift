import UIKit

final class DetailViewController: UIViewController {
    
    var items: RSSItem?
    private lazy var detailView = DetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = detailView
        configureDetailView()
        detailView.items = [items].compactMap { $0 }
    }
    
    private func configureDetailView() {
        guard let item = items else { return }
        detailView.configureView(item)
        detailView.setupImageView(item)
    }
}
