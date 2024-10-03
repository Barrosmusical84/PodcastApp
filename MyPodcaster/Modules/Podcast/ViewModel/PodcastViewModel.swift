import Foundation

protocol PodcastModelProtocol {
   func fetchPodcast() -> PodcastModel
   func didSelectEpisode(_ episode: EpisodeModel)
}

final class PodcastViewModel: PodcastModelProtocol {
    private let podcast: PodcastModel
    private let coordinator: PodcastCoordinator
    
    init(podcast: PodcastModel, coordinator: PodcastCoordinator) {
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
