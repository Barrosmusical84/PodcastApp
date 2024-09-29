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
        detailStackView.spacing = 6
        detailStackView.alignment = .leading
        return detailStackView
    }()
    
    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = .systemFont(ofSize: 10)
        dateLabel.textColor = .systemGray
        return dateLabel
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .boldSystemFont(ofSize: 12)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = .zero
        return titleLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = .systemFont(ofSize: 10)
        descriptionLabel.textColor = .systemGray
        descriptionLabel.numberOfLines = .zero
        return descriptionLabel
    }()
    
    private lazy var timerStackButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "arrowtriangle.right.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 10))
        button.setImage(image, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        button.setTitleColor(.purple, for: .normal)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 8
        button.tintColor = .purple
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
        if let duration = items.duration {
            timerStackButton.setTitle(" \(duration)m", for: .normal)
        } else {
            timerStackButton.setTitle(" N/A", for: .normal)
        }
    }
}

extension DetailViewCell: ViewCode {
    func buildViewHierarchy() {
        addSubview(detailStackView)
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            detailStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            detailStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            detailStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            detailStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            
            timerStackButton.widthAnchor.constraint(equalToConstant: 40),
            timerStackButton.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .clear
    }    
}
