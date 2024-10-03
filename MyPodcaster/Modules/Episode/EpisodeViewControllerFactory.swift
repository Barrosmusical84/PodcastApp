import UIKit

final class EpisodeViewControllerFactory {

    static func make(_ episode: EpisodeModel) -> EpisodeViewController {
        let viewModel = EpisodeViewModel(episode: episode)
        let episodeViewController = EpisodeViewController(viewModel: viewModel)
        return episodeViewController
    }
}
