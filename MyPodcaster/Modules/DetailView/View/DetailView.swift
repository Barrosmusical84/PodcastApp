import UIKit

final class DetailView: UIView {
    
    var items: [RSSItem] = [] {
        didSet {
            tableview.reloadData()
        }
    }
    
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
        return tableview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapEpisodeButton() {
        headStackView.backgroundColor = .blue
    }
    
    func configureView(_ items: RSSItem) {
        titleLabel.text = items.author
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
    
    private func registerCell() {
        tableview.register(DetailViewCell.self, forCellReuseIdentifier: DetailViewCell.identifier)
    }
    
}

extension DetailView: ViewCode {
    func buildViewHierarchy() {
        addSubview(containerView)
        containerView.addSubview(headStackView)
        containerView.addSubview(tableview)
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            headStackView.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 24),
            headStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            headStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            headStackView.heightAnchor.constraint(equalToConstant: 300),
            
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 160),
            
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

extension DetailView: UITableViewDelegate {
}

extension DetailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailViewCell.identifier, for: indexPath) as? DetailViewCell
        let item = items[indexPath.row]
        cell?.configure(items: item)
        return cell ?? UITableViewCell()
    }
}
