import UIKit

extension UIViewController {

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
