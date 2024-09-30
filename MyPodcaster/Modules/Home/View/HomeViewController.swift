import UIKit


class HomeViewController: UIViewController {

    var viewModel = HomeViewModel()

    private lazy var homeView = HomeView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = homeView
        setupNavegation()
    }
    
    func setupNavegation() {
        let rightButton = UIBarButtonItem(title: "Add URL", style: .plain, target: self, action: #selector(didTapRightButton))
        navigationItem.rightBarButtonItem = rightButton
    }

    func showDetail(for item: RSSItem) {
        let detailViewController = DetailViewController()
        detailViewController.items = item
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    @objc func didTapRightButton() {
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
        viewModel.fetchPodcast(url: url, completion: { model in
            self.homeView.show(podcasts: model)
        })
    }
}


