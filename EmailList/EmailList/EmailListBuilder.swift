//
//  EmailListBuilder.swift
//  Email
//
//  Created by Karim Alweheshy on 2/11/19.
//  Copyright © 2019 Karim Alweheshy. All rights reserved.
//

import UIKit
import Networking

final class EmailListBuilder: NSObject {
    static func make(networking: NetworkingType,
                     requestBody: EmailListRequestBody, isSelection: Bool,
                     resultCallback: @escaping (Result<EmailResponse>) -> Void) -> EmailListViewController {
        let storyboard = UIStoryboard(name: "EmailList", bundle: Bundle(for: self))
        let viewController = storyboard.instantiateInitialViewController() as! EmailListViewController
        let interactor = EmailListInteractor(networking: networking)
        let router = EmailListRouter(viewController: viewController)
        let presenter = EmailListPresenter(router: router, interactor: interactor, view: viewController,
                                           requestBody: requestBody, isSelection: isSelection, resultCallback: resultCallback)
        viewController.presenter = presenter
        return viewController
    }
}
