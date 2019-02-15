//
//  MockRouter.swift
//  EmailListTests
//
//  Created by Karim Alweheshy on 2/15/19.
//  Copyright © 2019 Karim Alweheshy. All rights reserved.
//

import UIKit
import Networking
@testable import EmailList

final class MockRouter: EmailListRouterType {
    func presentController(_: UIViewController) {
    }
    
    func dismissController(_: UIViewController) {
    }
    
    func pushController(_: UIViewController) {
    }
    
    func popController(_: UIViewController) {
    }
}
