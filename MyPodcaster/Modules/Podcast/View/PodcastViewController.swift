import UIKit

final class PodcastViewController: UIViewController {

    private let viewModel: PodcastModelProtocol
    
    init(viewModel: PodcastModelProtocol) {
        self.viewModel = viewModel
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
    }
    
    private func configureDetailView() {
        detailView.delegate = self
        let podcast = viewModel.fetchPodcast()
        detailView.configureView(podcast: podcast)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PodcastViewController: DetailViewProtocol {
    func didSelectEpisodeButton(selectedEpisode: EpisodeModelProtocol) {
        let episodeViewController = EpisodeViewController(viewModel: selectedEpisode)
        navigationController?.pushViewController(episodeViewController, animated: true)
    }
    
    func didTapEpisodeButton() {
        let podcast = viewModel.fetchPodcast()
        guard let episode = podcast.episodes.first else { return }
        let episodeViewController = EpisodeViewController(viewModel: episode)
        navigationController?.pushViewController(episodeViewController, animated: true)
    }
}

extension PodcastViewController: ViewCode {
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
