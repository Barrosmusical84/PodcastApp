import Foundation

struct PodcastModel {
    var title: String?
    var image: String?
    var description: String?
    var episodes: [RSSItem] = []

}
