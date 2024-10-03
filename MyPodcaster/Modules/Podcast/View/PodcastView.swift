import UIKit

protocol DetailViewProtocol: AnyObject {
    func didTapEpisodeButton()
    func didSelectEpisodeButton(selectedEpisode: EpisodeModel)
}


final class PodcastView: UIView {
    
    weak var delegate: DetailViewProtocol?
    
    private var podcastModel = PodcastModel() {
        didSet {
            tableview.reloadData()
        }
    }

    private lazy var tableview: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.backgroundColor = .clear
        return tableview
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    internal func configureView(podcast: PodcastModel) {
        self.podcastModel = podcast
    }

    private func registerCell() {
        tableview.register(PodcastViewCell.self, forCellReuseIdentifier: PodcastViewCell.identifier)
        tableview.register(PodcastDetailCell.self, forCellReuseIdentifier: PodcastDetailCell.identifier)
    }
}

extension PodcastView: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return podcastModel.episodes.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PodcastDetailCell.identifier, for: indexPath) as? PodcastDetailCell
            cell?.configure(podcast: podcastModel)
            cell?.selectionStyle = .none
            cell?.delegate = self
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: PodcastViewCell.identifier, for: indexPath) as? PodcastViewCell
            let item = podcastModel.episodes[indexPath.row]
            cell?.configure(items: item)
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEpisode = podcastModel.episodes[indexPath.row]
        delegate?.didSelectEpisodeButton(selectedEpisode: selectedEpisode)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 280
        } else {
            return 150
        }
    }
}

extension PodcastView: ViewCode {

    func buildViewHierarchy() {
        addSubview(tableview)
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: topAnchor),
            tableview.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableview.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        tableview.delegate = self
        tableview.dataSource = self
        registerCell()
    }
}

extension PodcastView: PodcastDetailCellDelegate {

    func didTapEpisodeButton() {
        self.delegate?.didTapEpisodeButton()
    }
}
