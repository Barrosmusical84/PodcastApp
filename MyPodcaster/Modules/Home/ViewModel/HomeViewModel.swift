import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func show(podcast: PodcastModel)
    func showStoredPodcasts(podcast: [PodcastModel])
    func showServerError()
    func showErrorForInvalidURL()
}

final class HomeViewModel {

    private let userDefaultsManager: UserDefaultsManagerProtocol
    private let sessionManager: URLSessionManagerProtocol
    private let coordinator: HomeCoordinatorProtocol

    weak var delegate: HomeViewModelDelegate?

    init(sessionManager: URLSessionManagerProtocol,
         userDefaultsManager: UserDefaultsManagerProtocol,
         coordinator: HomeCoordinatorProtocol) {
        self.sessionManager = sessionManager
        self.userDefaultsManager = userDefaultsManager
        self.coordinator = coordinator
    }

    func fetchStoredPodcasts() {
        let podcasts = userDefaultsManager.fetchPodcasts()
        self.delegate?.showStoredPodcasts(podcast: podcasts)
    }

    func fetchPodcast(url: String) {
        guard let url = URL(string: url) else {
            self.delegate?.showErrorForInvalidURL()
            return
        }
        sessionManager.fetchPodcast(url: url)
    }

    func didSelectPodcast(_ podcast: PodcastModel) {
        coordinator.openPodcastDetail(podcast)
    }
}

extension HomeViewModel: URLSessionManagerDelegate {
    
    func didFailToFetchWrongURL() {
        DispatchQueue.main.async {
            self.delegate?.showErrorForInvalidURL()
        }
    }
    

    func didFetchPodcast(podcast: PodcastModel) {
        //userDefaultsManager.save(podcast: podcast)
        DispatchQueue.main.async {
            self.delegate?.show(podcast: podcast)
        }
    }
    
    func didFailToFetchPodcast() {
        DispatchQueue.main.async {
            self.delegate?.showServerError()
        }
    }
}
