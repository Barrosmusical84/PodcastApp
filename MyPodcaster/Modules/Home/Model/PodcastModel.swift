import Foundation

struct PodcastModel: Codable {
    var url: String?
    var title: String?
    var image: String?
    var description: String?
    var gender: String?
    var episodes: [EpisodeModel] = []
}
