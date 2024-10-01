import UIKit

final class DetailViewController: UIViewController {
    
    var podcast: PodcastModel?
    var items: [RSSItem] = []
    
    private lazy var detailView = DetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = detailView
        configureDetailView()
        detailView.items = items
        detailView.delegate = self
    }
    
    private func configureDetailView() {
        guard let podcast = podcast else { return }
        detailView.configureView(podcast)
        if let imageUrl = podcast.image {
            ImageLoader.shared.loadImage(from: imageUrl) { [weak self] image in
                self?.detailView.imageView.image = image ?? UIImage(named: "defaultImage")
            }
        }
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
