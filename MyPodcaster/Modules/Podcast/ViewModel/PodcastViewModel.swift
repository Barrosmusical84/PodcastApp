import Foundation

protocol PodcastModelProtocol {
   func fetchPodcast() -> PodcastModel
}

final class PodcastViewModel: PodcastModelProtocol {
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
