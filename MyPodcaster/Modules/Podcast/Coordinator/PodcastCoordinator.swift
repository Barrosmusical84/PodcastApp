import Foundation

final class PodcastCoordinator {
    weak var detailViewController: PodcastViewController?
    
    func openEpisode(_ episode: EpisodeModel) {
        let viewModel = EpisodeViewModel(episode: episode)
        let episodeViewController = EpisodeViewController(viewModel: viewModel)
        detailViewController?.navigationController?.pushViewController(episodeViewController, animated: true)
    }
}
