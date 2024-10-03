import UIKit

final class HomeViewController: UIViewController {

    private let viewModel: HomeViewModel

    private lazy var homeView: HomeView = {
        let homeView = HomeView()
        homeView.delegate = self
        return homeView
    }()

    var urls = [
        "https://feeds.megaphone.fm/la-cotorrisa",
        "https://anchor.fm/s/7a186bc/podcast/rss",
        "http://feeds.feedburner.com/GeekNights",
    ]

    var index = 0

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavegation()
        viewModel.fetchStoredPodcasts()
    }
    
    func setupNavegation() {
        let rightButton = UIBarButtonItem(title: Constants.Navigation.rightButton.localized, style: .plain, target: self, action: #selector(didTapRightButton))
        navigationItem.rightBarButtonItem = rightButton
        appearanceNavegation()
    }
    
    @objc func didTapRightButton() {
        let url = urls[index]
        self.fetch(url: url)
        index = index + 1
        return
        let alertInsertURL = UIAlertController(title: Constants.Alert.alertInsertURL.localized, message: nil, preferredStyle: .alert)
        alertInsertURL.addTextField { textField in
            textField.placeholder = Constants.Alert.alertInsertURLPlaceholder.localized
            textField.keyboardType = .URL
        }
        let cancelAction = UIAlertAction(title: Constants.Alert.cancelAction.localized, style: .cancel, handler: nil)
        let followAction = UIAlertAction(title: Constants.Alert.followAction.localized, style: .default) { [weak alertInsertURL] _ in
            if let urlText = alertInsertURL?.textFields?.first?.text, !urlText.isEmpty {
                print("\(Constants.Alert.followAction.localized) \(urlText)")
                self.fetch(url: urlText)
            }
        }
        alertInsertURL.addAction(cancelAction)
        alertInsertURL.addAction(followAction)
        present(alertInsertURL, animated: true, completion: nil)
    }

    func fetch(url: String) {
        homeView.startLoading()
        viewModel.fetchPodcast(url: url)
    }
}

extension HomeViewController: HomeViewModelDelegate {
    
    func showStoredPodcasts(podcast: [PodcastModel]) {
        self.homeView.showPodcastList(podcasts: podcast)
    }

    func show(podcast: PodcastModel) {
        self.homeView.stopLoading()
        self.homeView.show(podcast: podcast)
    }

    func showServerError() {
        self.homeView.stopLoading()
        let alert = UIAlertController(title: Constants.Alert.alertError.localized, message: Constants.Alert.alertErrorMessage.localized, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func showErrorForInvalidURL() {
        self.homeView.stopLoading()
        let alert = UIAlertController(title: Constants.Alert.alertError.localized, message: Constants.Alert.alertInvalidURL.localized, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension HomeViewController: HomeViewDelegate {

    func didSelectePodcast(podcast: PodcastModel) {
        viewModel.didSelectPodcast(podcast)
    }
}

extension HomeViewController {

    func appearanceNavegation() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.customBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.buttonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = .white 
    }
}
