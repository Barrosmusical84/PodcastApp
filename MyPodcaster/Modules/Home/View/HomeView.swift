import UIKit

final class HomeView: UIView {
    
    public lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.delegate = self
        collection.dataSource = self
        collection.contentInsetAdjustmentBehavior = .never
        return collection
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self, for: indexPath)
        return  UICollectionViewCell()
    }
    
    
}


extension HomeView: ViewCode {
    func buildViewHierarchy() {
        
    }
    
    func setupConstraint() {
        
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .white
    }
    
    
}
