import UIKit

final class DetailView: UIView {
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    private lazy var headView: UIView = {
        let headView = UIView()
        headView.translatesAutoresizingMaskIntoConstraints = false
        headView.backgroundColor = .black
        return headView
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
}

extension DetailView: ViewCode {
    func buildViewHierarchy() {
        addSubview(containerView)
        containerView.addSubview(headView)
        containerView.addSubview(tableview)
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            headView.topAnchor.constraint(equalTo: containerView.topAnchor),
            headView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            headView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            headView.heightAnchor.constraint(equalToConstant: 400),
            
            tableview.topAnchor.constraint(equalTo: headView.bottomAnchor),
            tableview.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            tableview.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            
        ])
    }
    
    func setupAdditionalConfiguration() {
        tableview.delegate = self
        tableview.dataSource = self
    }
}

extension DetailView: UITableViewDelegate {
    
}

extension DetailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
