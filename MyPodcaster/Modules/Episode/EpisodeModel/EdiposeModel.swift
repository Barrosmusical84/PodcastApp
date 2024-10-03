import Foundation

protocol EpisodeModelProtocol {
   func fetchEpisode() -> EpisodeModel
}

final class EpisodeViewModel: EpisodeModelProtocol {
    private let episode: EpisodeModel
    
    init(episode: EpisodeModel) {
        self.episode = episode
    }
    
    func fetchEpisode() -> EpisodeModel {
        return episode
    }
}
