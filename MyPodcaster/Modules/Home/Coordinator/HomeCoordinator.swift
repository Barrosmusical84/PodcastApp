import Foundation

protocol HomeCoordinatorProtocol {
    func openPodcastDetail(_ podcast: PodcastModel)
}

final class HomeCoordinator: HomeCoordinatorProtocol {

    weak var homeViewController: HomeViewController?

    func openPodcastDetail(_ podcast: PodcastModel) {
        let detailViewController = DetailViewController(podcast: podcast)
        homeViewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
