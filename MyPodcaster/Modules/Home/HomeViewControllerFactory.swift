import Foundation

final class HomeViewControllerFactory {

    static func make() -> HomeViewController  {
        let homeCoordinator = HomeCoordinator()
        let sessionManager = URLSessionManager()
        let userDefaultsManager = UserDefaultsManager()

        let viewModel = HomeViewModel(sessionManager: sessionManager,
                                      userDefaultsManager: userDefaultsManager,
                                      coordinator: homeCoordinator)

        let homeViewController = HomeViewController(viewModel: viewModel)

        sessionManager.delegate = viewModel
        viewModel.delegate = homeViewController
        homeCoordinator.homeViewController = homeViewController

        return homeViewController
    }
}
