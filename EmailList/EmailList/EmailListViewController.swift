//
//  EmailListViewController.swift
//  Email
//
//  Created by Karim Alweheshy on 2/11/19.
//  Copyright © 2019 Karim Alweheshy. All rights reserved.
//

import UIKit

protocol EmailListView {
    func update(filters: String)
    func update(emails: [String])
    func show(errorMessage: String)
}

final class EmailListViewController: UIViewController {
    var presenter: EmailListPresenterType!
    
    @IBOutlet fileprivate var filtersLabel: UILabel!
    @IBOutlet fileprivate var emailButtonsStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

// MARK: - Actions
extension EmailListViewController {
    @IBAction fileprivate func didTapAdd() {
        presenter.didTapAdd()
    }
    @objc fileprivate func didTap(button: UIButton) {
        let buttonIndex = emailButtonsStackView.arrangedSubviews.firstIndex(of: button) ?? 0
        presenter.didTapEmail(at: buttonIndex)
    }
}

// MARK: - EmailListView
extension EmailListViewController: EmailListView {
    func update(filters: String) {
        filtersLabel.text = filters
    }
    
    func update(emails: [String]) {
        emailButtonsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        emails.forEach { email in
            let button = UIButton()
            button.backgroundColor = .blue
            button.setTitleColor(.white, for: .normal)
            button.setTitle(email, for: .normal)
            button.addTarget(self, action: #selector(didTap(button:)), for: .touchUpInside)
            emailButtonsStackView.addArrangedSubview(button)
        }
    }
    
    func show(errorMessage: String) {
        let alertViewController = UIAlertController(title: "Error",
                                                    message: errorMessage,
                                                    preferredStyle: .alert)
        
        alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertViewController, animated: true, completion: nil)
    }
}
