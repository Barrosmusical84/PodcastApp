import UIKit

final class EpisodeViewController: UIViewController {
    
    var items: RSSItem?
    
    private lazy var episodeView = EpisodeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = episodeView
        configureEpisodeView()
    }
    
    private func configureEpisodeView() {
        guard let item = items else { return }
        episodeView.configureView(item)
        episodeView.setupImageView(item)
    }
}
