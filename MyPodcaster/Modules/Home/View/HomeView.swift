import UIKit

protocol HomeViewDelegate: AnyObject {
    func didSelectePodcast(podcast: PodcastModel)
}

final class HomeView: UIView {

    var podcasts: [PodcastModel] = []
    
    weak var delegate: HomeViewDelegate?
    
    public lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.delegate = self
        collection.dataSource = self
        collection.contentInsetAdjustmentBehavior = .never
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = UIColor.customBackground
        return collection
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.text = "Shows"
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logo2")
        imageView.alpha = .greatestFiniteMagnitude
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
//        uploadData()
    }
    
    func configure(podcast: PodcastModel) {
        self.titleLabel.text = podcast.title
    }
    
    func show(podcasts: [PodcastModel]) {
        self.podcasts = podcasts
        self.collectionView.reloadData()
    }

    private func registerCell() {
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        podcasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.identifier, for: indexPath) as? HomeCell
        cell?.configure(podcast: podcasts[indexPath.item])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPocast = podcasts[indexPath.item]
        delegate?.didSelectePodcast(podcast: selectedPocast)
    }
}

extension HomeView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: 120)
    }
}

extension HomeView: ViewCode {
    func buildViewHierarchy() {
        addSubview(titleLabel)
        addSubview(imageView)
        addSubview(collectionView)
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            
            collectionView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 34),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    func setupAdditionalConfiguration() {
        registerCell()
        self.backgroundColor = UIColor.customBackground
    }
}
