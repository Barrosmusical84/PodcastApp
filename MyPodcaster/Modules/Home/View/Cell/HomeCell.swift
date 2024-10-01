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
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = .white
        return titleLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.textColor = .white
        dateLabel.numberOfLines = 4
        return dateLabel
    }()
    
    private lazy var separatorView: UIView = {
        let separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = .darkGray
        return separatorView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(podcast: PodcastModel) {
        titleLabel.text = podcast.title
        descriptionLabel.text = podcast.description

        if let imageUrl = podcast.image {
            ImageLoader.shared.loadImage(from: imageUrl) { [weak self] image in
                self?.imageView.image = image
            }
        }
    }
}
                                         
extension HomeCell: ViewCode {
    func buildViewHierarchy() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(separatorView)
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            imageView.heightAnchor.constraint(equalToConstant: 60),
            imageView.widthAnchor.constraint(equalToConstant: 60),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            
            separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -12),
            separatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            separatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = UIColor.customBackground
    }
}
