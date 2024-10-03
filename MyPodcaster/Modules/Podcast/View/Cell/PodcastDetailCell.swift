import UIKit

protocol PodcastDetailCellDelegate: AnyObject {
    func didTapEpisodeButton()
}

final class PodcastDetailCell: UITableViewCell, ViewCode {

    private var activityIndicator: UIActivityIndicatorView?

    weak var delegate: PodcastDetailCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        contentView.addSubview(headStackView)
    }

    func setupConstraint() {
        NSLayoutConstraint.activate([
            headStackView.topAnchor.constraint(equalTo: topAnchor),
            headStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),

            podcastImageView.heightAnchor.constraint(equalToConstant: 180),
            podcastImageView.widthAnchor.constraint(equalToConstant: 200),

            lastestEpisodeButton.heightAnchor.constraint(equalToConstant: 48),
            lastestEpisodeButton.widthAnchor.constraint(equalToConstant: 200),

            spacerView.heightAnchor.constraint(equalToConstant: 8),
        ])
    }

    func setupAdditionalConfiguration() {
        backgroundColor = .customBackground
    }

    private lazy var headStackView: UIStackView = {
        let headStackView = UIStackView(arrangedSubviews: [podcastImageView,
                                                           titleLabel,
                                                           lastestEpisodeButton,
                                                           spacerView])
        headStackView.translatesAutoresizingMaskIntoConstraints = false
        headStackView.backgroundColor = .clear
        headStackView.axis = .vertical
        headStackView.spacing = 8
        headStackView.alignment = .center
        headStackView.distribution = .fillProportionally
        return headStackView
    }()

    internal lazy var podcastImageView: UIImageView = {
        let podcastImageView = UIImageView()
        podcastImageView.backgroundColor = .clear
        podcastImageView.contentMode = .scaleAspectFill
        podcastImageView.layer.cornerRadius = 8
        podcastImageView.clipsToBounds = true
        return podcastImageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingHead
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private lazy var lastestEpisodeButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "arrowtriangle.right.fill")
        button.setImage(image, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.setTitle(Constants.PodcastView.lastestEpisodeButton.localized, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(didTapEpisodeButton), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()

    private lazy var spacerView: UIView = {
        let spacerView = UIView()
        return spacerView
    }()

    internal func configure(podcast: PodcastModel) {
        titleLabel.text = podcast.gender
        setupImageView(podcast)
    }

    private func setupImageView(_ podcast: PodcastModel) {
        if let imageUrl = podcast.image {
            activityIndicator?.startAnimating()
            ImageLoader.shared.loadImage(from: imageUrl) { [weak self] image in
                self?.activityIndicator?.stopAnimating()
                self?.podcastImageView.image = image
            }
        } else {
            podcastImageView.image = UIImage(named: "error-image")
        }
    }

    @objc func didTapEpisodeButton() {
        self.delegate?.didTapEpisodeButton()
    }
}
