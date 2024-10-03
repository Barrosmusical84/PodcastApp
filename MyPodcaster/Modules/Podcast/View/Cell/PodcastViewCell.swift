import UIKit

final class PodcastViewCell: UITableViewCell {
    
    private lazy var detailStackView: UIStackView = {
        let detailStackView = UIStackView(arrangedSubviews: [
                                                             titleLabel,
                                                             descriptionLabel,
                                                             dateLabel])
        detailStackView.translatesAutoresizingMaskIntoConstraints = false
        detailStackView.axis = .vertical
        detailStackView.distribution = .fillProportionally
        detailStackView.spacing = 8
        detailStackView.alignment = .leading
        return detailStackView
    }()
    
    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = .systemFont(ofSize: 14)
        dateLabel.textColor = .white
        return dateLabel
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2
        return titleLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = .systemFont(ofSize: 12)
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 3
        return descriptionLabel
    }()
    
    private var separatorView: UIView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func configure(items: EpisodeModel) {
        dateLabel.text = items.formatedDate
        titleLabel.text = items.title
        if let text = items.summary?.attributedHtmlString, !text.string.isEmpty {
            descriptionLabel.text = text.string
        } else {
            descriptionLabel.text = Constants.PodcastView.descriptionUnavailable.localized
        }
    }
    
    private func convertDurationToHoursAndMinutes(durationInSeconds: Int) -> String {
        let hours = durationInSeconds / 3600
        let minutes = (durationInSeconds % 3600) / 60
        
        if hours > 0 {
            return "\(hours)\(Constants.PodcastView.hours.localized) \(minutes)\(Constants.PodcastView.minutes.localized)"
        } else {
            return "\(minutes)\(Constants.PodcastView.minutes.localized)"
        }
    }
}

extension PodcastViewCell: ViewCode {
    func buildViewHierarchy() {
        addSubview(detailStackView)
        separatorView = addSeparatorView()
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            detailStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            detailStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            detailStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),            
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .clear
        self.accessoryType = .disclosureIndicator
    }
}

extension String {

    var utfData: Data {
        return Data(utf8)
    }

    var attributedHtmlString: NSAttributedString? {

        do {
            return try NSAttributedString(data: utfData, options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue,
            ],
                                          documentAttributes: nil)
        } catch {
            return nil
        }
    }
}
