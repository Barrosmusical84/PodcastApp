import UIKit

protocol DetailViewModelProtocol {
   func fetchPodcast() -> PodcastModel
}

final class DetailViewModel: DetailViewModelProtocol {
    private let podcast: PodcastModel
    private let coordinator: DetailCoordinator
    
    init(podcast: PodcastModel, coordinator: DetailCoordinator) {
        self.podcast = podcast
        self.coordinator = coordinator
    }
    
    func fetchPodcast() -> PodcastModel {
        return podcast
    }
    
    func didSelectEpisode(_ episode: EpisodeModel) {
        coordinator.openEpisode(episode)
    }
}


final class DetailViewController: UIViewController {

    private let viewModel: DetailViewModelProtocol
    
    init(viewModel: DetailViewModelProtocol) {
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

extension DetailViewController: DetailViewProtocol {
    func didSelectEpisodeButton(selectedEpisode: EpisodeModel) {
        let episodeViewController = EpisodeViewController(episode: selectedEpisode)
        navigationController?.pushViewController(episodeViewController, animated: true)
    }
    
    func didTapEpisodeButton() {
        let podcast = viewModel.fetchPodcast()
        guard let item = podcast.episodes.first else { return }
        let episodeViewController = EpisodeViewController(episode: item)
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
