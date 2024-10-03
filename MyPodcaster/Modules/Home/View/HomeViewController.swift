import UIKit

final class HomeViewController: UIViewController {

    //MARK: - Private Variables

    private let viewModel: HomeViewModelProtocol

    private lazy var homeView: HomeView = {
        let homeView = HomeView()
        homeView.delegate = self
        return homeView
    }()

    //MARK: - ViewController Life Cycle

    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }

    override func loadView() {
        self.view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        viewModel.fetchStoredPodcasts()
    }
}


//MARK: - HomeViewModelDelegate

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
        
        let alert = UIAlertController(title: Constants.Alert.alertError.localized,
                                      message: Constants.Alert.alertErrorMessage.localized,
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: Constants.Alert.alertOk.localized,
                                      style: .default,
                                      handler: nil))

        self.present(alert, animated: true, completion: nil)
    }

    func showErrorForInvalidURL() {
        self.homeView.stopLoading()
        
        let alert = UIAlertController(title: Constants.Alert.alertError.localized,
                                      message: Constants.Alert.alertInvalidURL.localized,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: Constants.Alert.alertOk.localized,
                                      style: .default,
                                      handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - HomeViewDelegate

extension HomeViewController: HomeViewDelegate {

    func didSelectePodcast(podcast: PodcastModel) {
        viewModel.didSelectPodcast(podcast)
    }
}

//MARK: - Private Helpers

extension HomeViewController {

    private func setupNavigation() {
        let rightButton = UIBarButtonItem(title: Constants.Navigation.rightButton.localized, 
                                          style: .plain,
                                          target: self,
                                          action: #selector(didTapRightButton))
        
        navigationItem.rightBarButtonItem = rightButton
        appearanceNavegation()
    }

    @objc private func didTapRightButton() {
        let alertInsertURL = UIAlertController(title: Constants.Alert.alertInsertURL.localized, 
                                               message: nil,
                                               preferredStyle: .alert)

        alertInsertURL.addTextField { textField in
            textField.placeholder = Constants.Alert.alertInsertURLPlaceholder.localized
            textField.keyboardType = .URL
        }

        let cancelAction = UIAlertAction(title: Constants.Alert.cancelAction.localized, 
                                         style: .cancel,
                                         handler: nil)
       
        let followAction = UIAlertAction(title: Constants.Alert.followAction.localized,
                                         style: .default) { [weak alertInsertURL] _ in
            if let urlText = alertInsertURL?.textFields?.first?.text, !urlText.isEmpty {
                self.fetch(url: urlText)
            }
        }

        alertInsertURL.addAction(cancelAction)
        alertInsertURL.addAction(followAction)

        present(alertInsertURL, animated: true, completion: nil)
    }

    private func fetch(url: String) {
        homeView.startLoading()
        viewModel.fetchPodcast(url: url)
    }
}
