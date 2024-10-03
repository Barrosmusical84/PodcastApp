import Foundation

final class PodcastCoordinator {
    weak var detailViewController: PodcastViewController?
    
    func openEpisode(_ episode: EpisodeModel) {
        let episodeViewController = EpisodeViewControllerFactory.make(episode)
        detailViewController?.navigationController?.pushViewController(episodeViewController, animated: true)
    }
}
