import Foundation

final class PodcastMapper: NSObject {

    var rssItems: [EpisodeModel] = []
    var podcastTitle = ""
    var podcastDescription: String?
    var podcastImageURL = ""
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
    var currentGender = ""
    
    var podcastModel = PodcastModel()
    var isHeader: Bool = true
    var podcastURL: String = ""

    var completion: ((PodcastModel?) ->())?

    func parseXML(data: Data, url: String) {
        podcastModel.url = url
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
    }
}

extension PodcastMapper: XMLParserDelegate {

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

            case "enclosure":
                if let urlString = attributeDict["url"] {
                    currentLink = urlString
                }
            case "itunes:category":
                if let urlString = attributeDict["text"] {
                    podcastModel.gender = urlString
                }
            default:
                break
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
            case "title":
                if isHeader {
                    self.podcastTitle += string
                } else {
                    self.currentTitle += string
                }
            case "itunes:title":
                currentItunesTitle += string
            case "itunes:author":
                currentAuthor += string
            case "link":
                currentLink += string
            case "pubDate":
                currentPubDate += string
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
                self.podcastImageURL += string
            default:
                break
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let item = EpisodeModel(
                title: currentTitle,
                itunesTitle: "",
                author: currentAuthor,
                description: "",
                link: currentLink,
                pubDate: currentPubDate,
                imageURL: URL(string: currentImageURL),
                summary: summary,
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
        completion?(isPodcastModelNil() ? nil : podcastModel)
    }

    func isPodcastModelNil() -> Bool {
        return podcastModel.title == nil && podcastModel.image == nil && podcastModel.episodes.isEmpty
    }
}
