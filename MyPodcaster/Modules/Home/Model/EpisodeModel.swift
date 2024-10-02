import Foundation

struct EpisodeModel: Codable {
    let title: String
    let itunesTitle: String
    let author: String
    let description: String
    let link: String
    let pubDate: String
    var imageURL: URL?
    var summary: String?
    var duration: Int?
}
