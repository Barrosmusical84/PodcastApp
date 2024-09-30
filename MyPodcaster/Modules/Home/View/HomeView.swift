import UIKit

final class HomeView: UIView {

    var podcasts: [PodcastModel] = []

    public lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.delegate = self
        collection.dataSource = self
        collection.contentInsetAdjustmentBehavior = .never
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    //  uploadData()
    }

    func show(podcasts: [PodcastModel]) {
        self.podcasts = podcasts
        self.collectionView.reloadData()
    }

    private func registerCell() {
        collectionView.register(HomeEpisodeCell.self, forCellWithReuseIdentifier: HomeEpisodeCell.identifier)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeEpisodeCell.identifier, for: indexPath) as? HomeEpisodeCell
        cell?.configure(podcast: podcasts[indexPath.item])
        return cell ?? UICollectionViewCell()
    }
}

extension HomeView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
           return CGSize(width: width, height: 60)
    }
}

extension HomeView: ViewCode {
    func buildViewHierarchy() {
        addSubview(collectionView)
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    func setupAdditionalConfiguration() {
        registerCell()
        self.backgroundColor = .white
    }
}
