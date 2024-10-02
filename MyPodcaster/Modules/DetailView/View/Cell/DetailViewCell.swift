import UIKit

final class DetailViewCell: UITableViewCell {
    static let identifier = "DetailViewCell"
    
    private lazy var detailStackView: UIStackView = {
        let detailStackView = UIStackView(arrangedSubviews: [dateLabel,
                                                             titleLabel,
                                                             descriptionLabel,
                                                             timerStackButton])
        detailStackView.translatesAutoresizingMaskIntoConstraints = false
        detailStackView.axis = .vertical
        detailStackView.distribution = .fillProportionally
        detailStackView.spacing = 0
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
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = .zero
        return titleLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = .systemFont(ofSize: 12)
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = .zero
        return descriptionLabel
    }()
    
    private lazy var timerStackButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "arrowtriangle.right.fill")
        config.imagePadding = 4
        config.imagePlacement = .leading
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 10)
        config.titlePadding = 12
        
        config.baseForegroundColor = .purple
        config.background.backgroundColor = .systemGray6
        config.background.cornerRadius = 8
        config.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 6, bottom: 4, trailing: 6)
        button.configuration = config
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func configure(items: RSSItem) {
        dateLabel.text = items.pubDate
        titleLabel.text = items.title
        descriptionLabel.text = items.summary ?? "No summary available"
        setupButton(items: items)        
    }
    
    private func setupButton(items: RSSItem) {
        var config = timerStackButton.configuration ?? UIButton.Configuration.plain()
        
        if let duration = items.duration {
            let formattedDuration = convertDurationToHoursAndMinutes(durationInSeconds: duration)
            var attributedTitle = AttributedString("\(formattedDuration)")
            attributedTitle.font = UIFont.boldSystemFont(ofSize: 10)
            config.attributedTitle = attributedTitle
            timerStackButton.configuration = config
        } else {
            config.title = "N/A"
            timerStackButton.configuration = config
        }
    }
    
    private func convertDurationToHoursAndMinutes(durationInSeconds: Int) -> String {
        let hours = durationInSeconds / 3600
        let minutes = (durationInSeconds % 3600) / 60
        
        if hours > 0 {
            return "\(hours)h \(minutes)min"
        } else {
            return "\(minutes)m"
        }
    }
}

extension DetailViewCell: ViewCode {
    func buildViewHierarchy() {
        addSubview(detailStackView)
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            detailStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            detailStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            detailStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            detailStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            
            timerStackButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .clear
    }
}
