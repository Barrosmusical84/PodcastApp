import UIKit

final class DetailViewController: UIViewController {
    
    var podcast: PodcastModel

    init(podcast: PodcastModel) {
        self.podcast = podcast
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var detailView = DetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = detailView
        configureDetailView()
        detailView.items = podcast.episodes
        detailView.delegate = self
    }
    
    private func configureDetailView() {
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
        guard let item = podcast.episodes.first else { return }
        let episodeViewController = EpisodeViewController()
        episodeViewController.items = item
        navigationController?.pushViewController(episodeViewController, animated: true)
    }
}
