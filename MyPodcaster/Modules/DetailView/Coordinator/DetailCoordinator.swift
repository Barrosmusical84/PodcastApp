import Foundation

final class DetailCoordinator {
    weak var detailViewController: DetailViewController?
    
    func openEpisode(_ episode: EpisodeModel) {
        let episodeViewController = EpisodeViewController(episode: episode)
        detailViewController?.navigationController?.pushViewController(episodeViewController, animated: true)
    }
}
