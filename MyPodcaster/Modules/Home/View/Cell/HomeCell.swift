import UIKit

final class HomeCell: UICollectionViewCell {
    
    static let identifier = "HomeEpisodeCell"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .white
        return titleLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        dateLabel.textColor = .white
        dateLabel.numberOfLines = 0
        return dateLabel
    }()
    
    private var separatorView: UIView?
    private var activityIndicator: UIActivityIndicatorView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(podcast: PodcastModel) {
        titleLabel.text = podcast.title
        
        if let firstEpisode = podcast.episodes.first {
            descriptionLabel.text = firstEpisode.pubDate
        } else {
            descriptionLabel.text = "No episodes available"
        }

        if let imageUrl = podcast.image {
            activityIndicator?.startAnimating()
            ImageLoader.shared.loadImage(from: imageUrl) { [weak self] image in
                self?.activityIndicator?.stopAnimating()
                self?.imageView.image = image
            }
        } else {
            imageView.image = nil
        }
    }
}
                                         
extension HomeCell: ViewCode {
    func buildViewHierarchy() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        separatorView = self.addSeparatorView(color: .gray, height: 1)
        activityIndicator = self.addActivityIndicator(style: .medium, color: .white)
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            imageView.widthAnchor.constraint(equalToConstant: 70),

            titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = UIColor.customBackground
        
    }
}
