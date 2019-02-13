//
//  EmailRouter.swift
//  Email
//
//  Created by Karim Alweheshy on 2/11/19.
//  Copyright © 2019 Karim Alweheshy. All rights reserved.
//

import UIKit

protocol EmailListRouterType {
    func pushController(_: UIViewController)
    func popController(_: UIViewController)
}

final class EmailListRouter {
    fileprivate let viewController: EmailListViewController
    
    init(viewController: EmailListViewController) {
        self.viewController = viewController
    }
}

// MARK: - EmailListRouterType
extension EmailListRouter: EmailListRouterType {
    func pushController(_ viewController: UIViewController) {
        self.viewController.navigationController?.pushViewController(viewController,
                                                                     animated: true)
    }
    func popController(_: UIViewController) {
        viewController.navigationController?.popToViewController(viewController,
                                                                 animated: true)
    }
}
