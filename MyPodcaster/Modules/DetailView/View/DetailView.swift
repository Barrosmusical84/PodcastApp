import UIKit

protocol DetailViewProtocol: AnyObject {
    func didTapEpisodeButton()
}

final class DetailView: UIView {
    
    weak var delegate: DetailViewProtocol?
    
    var podcasts: [PodcastModel] = []
    var items: [EpisodeModel] = [] {
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
        headStackView.spacing = 12
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
    
    internal func configureView(_ podcast: PodcastModel) {
        titleLabel.text = podcast.title
        setupImageView(podcast)        
    }

    internal func setupImageView(_ podcast: PodcastModel) {
        if let imageUrl = podcast.image {
            activityIndicator?.startAnimating()
            ImageLoader.shared.loadImage(from: imageUrl) { [weak self] image in
                self?.activityIndicator?.stopAnimating()
                self?.imageView.image = image 
            }
        } else {
            imageView.image = UIImage(named: "error-image")
        }
        self.items = podcast.episodes
    }
    
    private func registerCell() {
        tableview.register(DetailViewCell.self, forCellReuseIdentifier: DetailViewCell.identifier)
    }
}
    

extension DetailView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailViewCell.identifier, for: indexPath) as? DetailViewCell
        let item = items[indexPath.row]
        cell?.configure(items: item)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension DetailView: ViewCode {
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
            headStackView.heightAnchor.constraint(equalToConstant: 260),
            
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            
            lastestEpisodeButton.heightAnchor.constraint(equalToConstant: 40),
            lastestEpisodeButton.widthAnchor.constraint(equalToConstant: 200),
            
            tableview.topAnchor.constraint(equalTo: headStackView.bottomAnchor,constant: 24),
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
