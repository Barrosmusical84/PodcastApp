import UIKit

protocol HomeViewDelegate: AnyObject {
    func didSelectePodcast(podcast: PodcastModel)
}

final class HomeView: UIView {

    private var podcasts: [PodcastModel] = []
    weak var delegate: HomeViewDelegate?
    
    private lazy var collectionView: UICollectionView = {
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
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        label.text = Constants.Home.titleLabel.localized
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: Constants.Assets.logoTwo.localized)
        imageView.alpha = .greatestFiniteMagnitude
        return imageView
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func show(podcast: PodcastModel) {
        if let index = self.podcasts.firstIndex(where: { $0.url == podcast.url }) {
            self.podcasts[index] = podcast
            self.collectionView.reloadData()
        } else {
            self.podcasts.insert(podcast, at: 0)
            self.collectionView.insertItems(at: [IndexPath(item: 0, section: 0)])
        }
    }

    func showPodcastList(podcasts: [PodcastModel]) {
        self.podcasts = podcasts
        self.collectionView.reloadData()
    }

    func startLoading() {
        self.activityIndicator.startAnimating()
    }

    func stopLoading() {
        self.activityIndicator.stopAnimating()
    }

    private func registerCell() {
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.identifier)
    }
}

extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        podcasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.identifier, for: indexPath) as? HomeCell
        cell?.configureCell(podcast: podcasts[indexPath.item])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPocast = podcasts[indexPath.item]
        delegate?.didSelectePodcast(podcast: selectedPocast)
    }
}

extension HomeView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/2-16
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
}

extension HomeView: ViewCode {

    func buildViewHierarchy() {
        addSubview(titleLabel)
        addSubview(imageView)
        addSubview(collectionView)
        addSubview(activityIndicator)
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalToConstant: 180),
            
            collectionView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    func setupAdditionalConfiguration() {
        registerCell()
        self.backgroundColor = UIColor.customBackground
    }
}
