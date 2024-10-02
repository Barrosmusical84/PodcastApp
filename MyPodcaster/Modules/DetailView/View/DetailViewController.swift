import UIKit

final class DetailViewController: UIViewController {
    
    var podcast: PodcastModel

    init(podcast: PodcastModel) {
        self.podcast = podcast
        super.init(nibName: nil, bundle: nil)
    }
    
    private lazy var detailView = DetailView()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .medium
        activityIndicator.color = .white
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = detailView
        setupView()
        configureDetailView()
        detailView.items = podcast.episodes
        detailView.delegate = self
    }
    
    private func configureDetailView() {
        detailView.configureView(podcast)
        if let imageUrl = podcast.image {
            activityIndicator.startAnimating()
            ImageLoader.shared.loadImage(from: imageUrl) { [weak self] image in
                self?.detailView.imageView.image = image
                self?.activityIndicator.stopAnimating() 
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

extension DetailViewController: ViewCode {
    func buildViewHierarchy() {
        view.addSubview(activityIndicator)
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
    }
}
