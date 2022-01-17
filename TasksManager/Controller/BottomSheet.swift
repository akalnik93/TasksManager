import UIKit

class BottomSheet: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        contraintsForTitleTextView()
    }

    var titleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    func contraintsForTitleTextView() {
        self.view.addSubview(titleTextView)
            NSLayoutConstraint.activate([
                titleTextView.topAnchor.constraint(equalTo: self.view.topAnchor),
                titleTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                titleTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                titleTextView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
    }
    
}
