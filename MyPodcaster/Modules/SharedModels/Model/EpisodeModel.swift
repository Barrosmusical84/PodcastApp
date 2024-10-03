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

    var formatedDate: String {
        return dateFormate1() ?? ""
    }

    private func dateFormate1() -> String? {
        let dateString = pubDate.replacingOccurrences(of: "\n", with: "")
            .replacingOccurrences(of: "\t", with: "")
            .replacingOccurrences(of: "GMT", with: "").trimmingCharacters(in: .whitespaces)
            .replacingOccurrences(of: "-0000", with: "").trimmingCharacters(in: .whitespaces)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss"

        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let newDateString = dateFormatter.string(from: date)
            return newDateString
        } else {
            return nil
        }
    }
}
