import UIKit

extension UIView {

    static var identifier: String {
        String(describing: Self.self)
    }

    func addSeparatorView(color: UIColor = .gray, height: CGFloat = 1.0) -> UIView {
        let separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = color
        addSubview(separatorView)
        
        NSLayoutConstraint.activate([
            separatorView.heightAnchor.constraint(equalToConstant: height),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        return separatorView
    }

    func addActivityIndicator(style: UIActivityIndicatorView.Style = .large, color: UIColor = .gray) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = style
        activityIndicator.color = color
        activityIndicator.hidesWhenStopped = true
        addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        return activityIndicator
    }
    
    func removeActivityIndicator() {
        let activityIndicator = subviews.first(where: { $0 is UIActivityIndicatorView }) as? UIActivityIndicatorView
        activityIndicator?.removeFromSuperview()
    }
}
