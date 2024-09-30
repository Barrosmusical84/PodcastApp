import Foundation

class NetworkManager: NSObject, XMLParserDelegate {

    var rssItems: [RSSItem] = []
    
    var podcastTitle: String?
    var podcastDescription: String?
    var podcastImageURL: String?

    var currentElement = ""
    var currentTitle = ""
    var currentItunesTitle = ""
    var currentAuthor = ""
    var currentLink = ""
    var currentPubDate = ""
    var currentImageURL = ""
    var summary: String = ""
    var duration: Int?
    var currentDescription = ""

    var podcastModel = PodcastModel()
    var isHeader: Bool = true

    var completion: ((PodcastModel) -> ())?

    func fetchRSSFeed(url: URL) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(String(describing: error))")
                return
            }
            self.parseXML(data: data)
        }
        task.resume()
    }

    func parseXML(data: Data) {
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
    }

    // XMLParserDelegate methods
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {

        currentElement = elementName

        switch currentElement {
            case "item":
                isHeader = false
                currentTitle = ""
                currentItunesTitle = ""
                currentAuthor = ""
                currentLink = ""
                currentPubDate = ""
                summary = ""
                currentDescription = ""
  
            case "itunes:image":
                if let urlString = attributeDict["href"] {
                    currentImageURL = urlString
                }

            default:
                break
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
            case "title":
                if isHeader, self.podcastTitle == nil {
                    self.podcastTitle = string
                } else {
                    self.currentTitle = string
                }
            case "itunes:title":
                currentItunesTitle += string
            case "itunes:author":
                currentAuthor += string
            case "link":
                currentLink += string
            case "pubDate":
                currentPubDate += string
                currentLink += string
            case "itunes:summary":
                summary += string
            case "description":
                if isHeader, self.podcastDescription == nil {
                    self.podcastDescription = string
                } else {
                    currentDescription += string
                }
            case "itunes:duration":
                if let duration = Int(string) {
                    self.duration = duration
                }
            case "url":
                self.podcastImageURL = string
            default:
                break
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let item = RSSItem(
                title: "",
                itunesTitle: "",
                author: currentAuthor,
                description: "",
                link: "",
                pubDate: currentPubDate,
                imageURL: URL(string: currentImageURL),
                summary: nil,
                duration: duration
            )
            podcastModel.episodes.append(item)
        } else if elementName == "title" {
            podcastModel.title = podcastTitle
        } else if elementName == "description" {
            podcastModel.description = podcastDescription
        } else if elementName == "url" {
            podcastModel.image = podcastImageURL
        }

    }

    func parserDidEndDocument(_ parser: XMLParser) {
        completion?(podcastModel)
    }
}

struct RSSItem {
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
