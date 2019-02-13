//
//  EmailPresenter.swift
//  Email
//
//  Created by Karim Alweheshy on 2/11/19.
//  Copyright © 2019 Karim Alweheshy. All rights reserved.
//

import Foundation
import Networking

protocol EmailListPresenterType {
    func viewDidLoad()
    
    func didTapAdd()
    func didTapEmail(at row: Int)
}

final class EmailListPresenter {
    fileprivate let router: EmailListRouterType
    fileprivate let interactor: EmailListInteractorType
    fileprivate let view: EmailListView
    
    fileprivate let requestBody: EmailListRequestBody
    fileprivate let isSelection: Bool
    fileprivate let resultCallback: (Result<EmailResponse>) -> Void
    
    fileprivate var emails = [EmailResponse]()
    
    init(router: EmailListRouterType, interactor: EmailListInteractorType, view: EmailListView,
         requestBody: EmailListRequestBody, isSelection: Bool,
         resultCallback: @escaping (Result<EmailResponse>) -> Void) {
        self.router = router
        self.interactor = interactor
        self.view = view

        self.requestBody = requestBody
        self.isSelection = isSelection
        self.resultCallback = resultCallback
    }
}

// MARK: - EmailListPresenterType
extension EmailListPresenter: EmailListPresenterType {
    func viewDidLoad() {
        if requestBody.filters.isEmpty {
            view.update(filters: "Emails\nNo Applyed Filters")
        } else {
            view.update(filters: requestBody.filters.reduce("Emails\nApplyed Filters:\n") { "\($0) = \($1)\n" })
        }
    }
    
    func didTapAdd() {
        interactor.showEmailForm(presentationBlock: router.presentController,
                                 dismissBlock: router.dismissController) { result in
            switch result {
            case .success(let newEmail):
                self.emails.append(newEmail)
                self.view.update(emails: self.emails.compactMap { $0.id.uuidString })
            case .error(let error):
                self.view.show(errorMessage: error.localizedDescription)
            }
        }
    }
    
    func didTapEmail(at row: Int) {
        let email = emails[row]
        interactor.showEmailDetails(id: email.id,
                                    presentationBlock: router.pushController,
                                    dismissBlock: router.popController) { (result: Result<EmailResponse>) in
                                        
        }
    }
}
