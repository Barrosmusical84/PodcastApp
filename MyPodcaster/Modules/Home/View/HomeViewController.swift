import UIKit

final class HomeViewController: UIViewController {

    var viewModel = HomeViewModel()

    private lazy var homeView = HomeView()

    var urls = [
        "https://feeds.megaphone.fm/la-cotorrisa",
        "https://anchor.fm/s/7a186bc/podcast/rss",
        "http://feeds.feedburner.com/GeekNights",
    ]

    var index = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = homeView
        setupNavegation()
        homeView.delegate = self
    }
    
    func setupNavegation() {
        let rightButton = UIBarButtonItem(title: "Add URL", style: .plain, target: self, action: #selector(didTapRightButton))
        navigationItem.rightBarButtonItem = rightButton
        appearanceNavegation()
    }
    
    @objc func didTapRightButton() {
        let url = urls[index]
        self.processRSSFeed(url)
        index = index + 1
        return
        let alert = UIAlertController(title: "Insira a URL", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Podcast URL"
            textField.keyboardType = .URL
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        let followAction = UIAlertAction(title: "Seguir", style: .default) { [weak alert] _ in
            if let urlText = alert?.textFields?.first?.text, !urlText.isEmpty {
                print("URL inserida: \(urlText)")
                self.processRSSFeed(urlText)
            }
        }
        alert.addAction(cancelAction)
        alert.addAction(followAction)
        present(alert, animated: true, completion: nil)
    }

    func processRSSFeed(_ url: String) {
        homeView.startLoading()
        viewModel.fetchPodcast(url: url, completion: { [weak self] model in
            guard let self else { return }
            self.homeView.show(podcasts: model)
            self.homeView.stopLoading()
        })
    }
}

extension HomeViewController: HomeViewDelegate {

    func didSelectePodcast(podcast: PodcastModel) {
        let detailViewController = DetailViewController(podcast: podcast)
        detailViewController.podcast = podcast
        navigationController?.pushViewController(detailViewController, animated: true)
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
        navigationController?.navigationBar.tintColor = .white //
    }
}
