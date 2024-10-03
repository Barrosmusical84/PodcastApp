import UIKit


protocol EpisodeViewProtocolDelegate: AnyObject {
    func didTapPlayPauseButton()
    func setupPlayerAudio(episode: EpisodeModel)
}

final class EpisodeView: UIView {
    
    weak var delegate: EpisodeViewProtocolDelegate?
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor.customBackground
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
        return headStackView
    }()
    
    internal lazy var imageView: UIImageView = {
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
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var sliderStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [leftTimerLabel,
                                                           sliderView,
                                                       rightTimerLabel
                                                          ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var leftTimerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .gray
        label.textAlignment = .left
        label.text = Constants.EpisodeView.zeroTimer.localized
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
    
    private lazy var rightTimerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .gray
        label.textAlignment = .right
        label.text = Constants.EpisodeView.zeroTimer.localized
        return label
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [previousButton,
                                                       playPauseButton,
                                                       nextButton
                                                          ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        stackView.axis = .horizontal
        stackView.spacing = .zero
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    internal lazy var previousButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "arrowtriangle.left.fill")
        button.setImage(image, for: .normal)
        button.backgroundColor = .clear
        button.contentHorizontalAlignment = .right
//        button.addTarget(self, action: #selector(didTapPreviousButton), for: .touchUpInside)
        button.tintColor = .gray
        return button
    }()
    
    internal lazy var playPauseButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle.fill")
        button.setImage(image, for: .normal)
        button.backgroundColor = .clear
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(didTapPlayPauseButton), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()
    
    internal lazy var nextButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "arrowtriangle.right.fill")
        button.setImage(image, for: .normal)
        button.backgroundColor = .clear
        button.contentHorizontalAlignment = .left
//        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        button.tintColor = .gray
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func configureView(_ episode: EpisodeModel) {
        titleLabel.text = episode.title
        setupImageView(episode)
    }
    
    internal func setupImageView(_ episode: EpisodeModel) {
        if let imageURL = episode.imageURL {
            ImageLoader.shared.loadImage(from: imageURL.absoluteString) { [weak self] image in
                self?.imageView.image = image
            }
        } else {
            imageView.image = UIImage(named: "defaultImage")
        }
    }
    
    private func setupPlayerAudio(item: EpisodeModel) {
        delegate?.setupPlayerAudio(episode: item)
    }
    
    @objc func didTapPlayPauseButton() {
        delegate?.didTapPlayPauseButton()
    }
}

extension EpisodeView: ViewCode {
    
    func buildViewHierarchy() {
        addSubview(containerView)
        containerView.addSubview(headStackView)
        containerView.addSubview(sliderStackView)
        containerView.addSubview(buttonsStackView)
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
            
            sliderStackView.topAnchor.constraint(equalTo: headStackView.bottomAnchor),
            sliderStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            sliderStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -16),

            buttonsStackView.topAnchor.constraint(equalTo: sliderStackView.bottomAnchor, constant: 8),
            buttonsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 60),
            buttonsStackView.widthAnchor.constraint(equalToConstant: 180),
            
            previousButton.heightAnchor.constraint(equalToConstant: 40),
            playPauseButton.heightAnchor.constraint(equalToConstant: 40),
            nextButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }    
}
