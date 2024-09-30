import UIKit
import AVFoundation


final class EpisodeView: UIView {
    
    var items: [RSSItem] = []
    private var player: AVPlayer?
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .systemFill
        return containerView
    }()
    
    private lazy var headStackView: UIStackView = {
        let headStackView = UIStackView(arrangedSubviews: [imageView,
                                                           titleLabel,
                                                          ])
        headStackView.translatesAutoresizingMaskIntoConstraints = false
        headStackView.backgroundColor = .clear
        headStackView.axis = .horizontal
        headStackView.spacing = 8
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
        UIImage(systemName: "arrowshape.right.circle.fill")
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var sliderView: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 0
        slider.tintColor = .systemGray5
        slider.layer.shadowOpacity = .greatestFiniteMagnitude
        return slider
    }()
    
    private lazy var playPauseButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.fill")
        button.setImage(image, for: .normal)
        button.setTitle("   Play", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(didTapPlayPauseButtonButton), for: .touchUpInside)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(_ items: RSSItem) {
        titleLabel.text = items.title
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
    
    
    @objc func didTapPlayPauseButtonButton() {
        if  playPauseButton.title(for: .normal) != "   Play" {
            let image = UIImage(systemName: "play.fill")
            playPauseButton.setImage(image, for: .normal)
            playPauseButton.setTitle("   Play", for: .normal)
        } else {
            let image = UIImage(systemName: "pause")
            playPauseButton.setImage(image, for: .normal)
            playPauseButton.setTitle("   Pause", for: .normal)
        }
    }
}

extension EpisodeView: ViewCode {
    
    func buildViewHierarchy() {
        addSubview(containerView)
        containerView.addSubview(headStackView)
        containerView.addSubview(sliderView)
        containerView.addSubview(playPauseButton)
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            headStackView.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor),
            headStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            headStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -16),
            headStackView.heightAnchor.constraint(equalToConstant: 200),
            
            imageView.heightAnchor.constraint(equalToConstant: 130),
            imageView.widthAnchor.constraint(equalToConstant: 120),
            
            sliderView.topAnchor.constraint(equalTo: headStackView.bottomAnchor),
            sliderView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            sliderView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -16),
            sliderView.widthAnchor.constraint(equalToConstant: 200),
            
            playPauseButton.topAnchor.constraint(equalTo: sliderView.bottomAnchor, constant: 16),
            playPauseButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            playPauseButton.heightAnchor.constraint(equalToConstant: 40),
            playPauseButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func setupAdditionalConfiguration() {}
}
