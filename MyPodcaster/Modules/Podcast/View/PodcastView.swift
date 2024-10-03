import UIKit

protocol DetailViewProtocol: AnyObject {
    func didTapEpisodeButton()
    func didSelectEpisodeButton(selectedEpisode: EpisodeModel)
}

final class PodcastView: UIView {
    
    weak var delegate: DetailViewProtocol?
    
    var episodes: [EpisodeModel] = [] {
        didSet {
            tableview.reloadData()
        }
    }
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor.customBackground
        return containerView
    }()
    
    private lazy var headStackView: UIStackView = {
        let headStackView = UIStackView(arrangedSubviews: [imageView,
                                                           titleLabel,
                                                           lastestEpisodeButton])
        headStackView.translatesAutoresizingMaskIntoConstraints = false
        headStackView.backgroundColor = .clear
        headStackView.axis = .vertical
        headStackView.spacing = 8
        headStackView.alignment = .center
        headStackView.distribution = .fillProportionally
        return headStackView
    }()
    
    internal lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
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
    
    private lazy var tableview: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.backgroundColor = .clear
        return tableview
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
    
    @objc func didTapEpisodeButton() {
        delegate?.didTapEpisodeButton()
    }
    
    internal func configureView(podcast: PodcastModel) {
        titleLabel.text = podcast.title
        setupImageView(podcast)
        self.episodes = podcast.episodes
    }
    
    private func setupImageView(_ podcast: PodcastModel) {
        if let imageUrl = podcast.image {
            activityIndicator?.startAnimating()
            ImageLoader.shared.loadImage(from: imageUrl) { [weak self] image in
                self?.activityIndicator?.stopAnimating()
                self?.imageView.image = image
            }
        } else {
            imageView.image = UIImage(named: "error-image")
        }
    }
    
    private func registerCell() {
        tableview.register(PodcastViewCell.self, forCellReuseIdentifier: PodcastViewCell.identifier)
    }
}

extension PodcastView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PodcastViewCell.identifier, for: indexPath) as? PodcastViewCell
        let item = episodes[indexPath.row]
        cell?.configure(items: item)
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEpisode = episodes[indexPath.row]
        delegate?.didSelectEpisodeButton(selectedEpisode: selectedEpisode)
    }
}

extension PodcastView: ViewCode {
    func buildViewHierarchy() {
        addSubview(containerView)
        containerView.addSubview(headStackView)
        containerView.addSubview(tableview)
        activityIndicator = self.addActivityIndicator(style: .medium, color: .white)
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
            headStackView.heightAnchor.constraint(equalToConstant: 280),
            
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            
            lastestEpisodeButton.heightAnchor.constraint(equalToConstant: 30),
            lastestEpisodeButton.widthAnchor.constraint(equalToConstant: 200),
            
            tableview.topAnchor.constraint(equalTo: headStackView.bottomAnchor,constant: 12),
            tableview.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            tableview.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            
        ])
    }
    
    func setupAdditionalConfiguration() {
        tableview.delegate = self
        tableview.dataSource = self
        registerCell()
    }
}
