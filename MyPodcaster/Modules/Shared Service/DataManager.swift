import Foundation

class DataManager: NSObject, XMLParserDelegate {
    var rssItems: [RSSItem] = []
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

    var completion: (([RSSItem]) -> ())?

    func fetchRSSFeed(url: String) {
        guard let feedURL = URL(string: url) else { return }

        let task = URLSession.shared.dataTask(with: feedURL) { data, response, error in
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
                currentTitle += string
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
                currentDescription += string
            case "itunes:duration":
                if let duration = Int(string) {
                    self.duration = duration
                }

            default:
                break
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let item = RSSItem(
                title: currentTitle,
                itunesTitle: currentItunesTitle,
                author: currentAuthor,
                description: currentDescription,
                link: currentLink,
                pubDate: currentPubDate,
                imageURL: URL(string: currentImageURL),
                summary: nil,
                duration: duration
            )
            rssItems.append(item)
        }
    }

    func parserDidEndDocument(_ parser: XMLParser) {
        completion?(rssItems)
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
