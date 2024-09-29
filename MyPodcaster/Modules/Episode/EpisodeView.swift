import UIKit

final class EpisodeView: UIView {
    
    var items: [RSSItem] = []
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .systemFill
        return containerView
    }()
    
    private lazy var headStackView: UIStackView = {
        let headStackView = UIStackView(arrangedSubviews: [imageView,
                                                           titleLabel,
                                                           lastestEpisodeButton])
        headStackView.translatesAutoresizingMaskIntoConstraints = false
        headStackView.backgroundColor = .clear
        headStackView.axis = .vertical
        headStackView.spacing = 12
        headStackView.alignment = .center
        headStackView.distribution = .fillProportionally
        return headStackView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingHead
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
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
        button.setTitle("  Último Episódio", for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(didTapEpisodeButton), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapEpisodeButton() {
    }
    
    func configureView(_ items: RSSItem) {
        titleLabel.text = items.itunesTitle
    }
    
    internal func setupImageView(_ item: RSSItem) {
        if let imageURL = item.imageURL {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageURL), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }
        } else {
            imageView.image = UIImage(named: "defaultImage")
        }
    }
}

extension EpisodeView: ViewCode {
    
    func buildViewHierarchy() {
        addSubview(containerView)
        containerView.addSubview(headStackView)
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            headStackView.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 8),
            headStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            headStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            headStackView.heightAnchor.constraint(equalToConstant: 300),
            
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 160),
            
            lastestEpisodeButton.heightAnchor.constraint(equalToConstant: 40),
            lastestEpisodeButton.widthAnchor.constraint(equalToConstant: 200)
            
        ])
    }
    
    func setupAdditionalConfiguration() {
    }
}
