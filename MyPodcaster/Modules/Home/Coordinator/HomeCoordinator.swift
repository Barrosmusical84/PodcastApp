import Foundation

protocol HomeCoordinatorProtocol {
    func openPodcastDetail(_ podcast: PodcastModel)
}

final class HomeCoordinator: HomeCoordinatorProtocol {

    weak var homeViewController: HomeViewController?

    func openPodcastDetail(_ podcast: PodcastModel) {
        let coordinator = DetailCoordinator()
        let viewModel = DetailViewModel(podcast: podcast, coordinator: coordinator)
        let detailViewController = DetailViewController(viewModel: viewModel)
        coordinator.detailViewController = detailViewController
        homeViewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
