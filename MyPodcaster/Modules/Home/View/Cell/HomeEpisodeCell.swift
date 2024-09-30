import UIKit

final class HomeEpisodeCell: UICollectionViewCell {
    
    static let identifier = "HomeEpisodeCell"
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(podcast: PodcastModel) {
        self.titleLabel.text = podcast.title
    }
}

extension HomeEpisodeCell: ViewCode {
    func buildViewHierarchy() {
        addSubview(titleLabel)
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
        ])
    }
    
    func setupAdditionalConfiguration() {
        
    }
}
