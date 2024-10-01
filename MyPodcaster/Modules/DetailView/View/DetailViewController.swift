import UIKit

final class DetailViewController: UIViewController {
    
    var podcast: PodcastModel?
    var items: RSSItem?
    
    private lazy var detailView = DetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = detailView
        configureDetailView()
        detailView.items = [items].compactMap { $0 }
        detailView.delegate = self
    }
    
    private func configureDetailView() {
        guard let item = items else { return }
        detailView.configureView(item)
        detailView.setupImageView(item)
    }
}

extension DetailViewController: DetailViewProtocol {
    func didTapEpisodeButton() {
        guard let item = items else { return }
        let episodeViewController = EpisodeViewController()
        episodeViewController.items = item
        navigationController?.pushViewController(episodeViewController, animated: true)
    }
}
