import Foundation

protocol UserDefaultsManagerProtocol {
    func save(podcast: PodcastModel)
    func fetchPodcasts() -> [PodcastModel]
    func remoteAll()
}

final class UserDefaultsManager: UserDefaultsManagerProtocol {

    private let urlKey: String = "podcasts_urls"
    private let defaults: UserDefaults

    init(defaults: UserDefaults = UserDefaults.standard) {
        self.defaults = defaults
    }

    func save(podcast: PodcastModel) {
        guard let data = try? JSONEncoder().encode(podcast),
              let url = podcast.url else { return }

        defaults.set(data, forKey: url)

        if var urls = defaults.stringArray(forKey: urlKey) {
            if !urls.contains(url) {
                urls.append(url)
                defaults.setValue(urls, forKey: urlKey)
            }
        } else {
            defaults.setValue([url], forKey: urlKey)
        }
    }

    func fetchPodcasts() -> [PodcastModel] {
        var podcasts: [PodcastModel] = []

        guard let urls = defaults.stringArray(forKey: urlKey) else { return [] }
        urls.forEach({ url in
            guard let data = defaults.object(forKey: url) as? Data,
                  let podcast = try? JSONDecoder().decode(PodcastModel.self, from: data) else { return }
            podcasts.append(podcast)
        })

        return podcasts
    }

    func remoteAll() {
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
        defaults.synchronize()
    }
}
