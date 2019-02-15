//
//  MockInteractor.swift
//  EmailListTests
//
//  Created by Karim Alweheshy on 2/15/19.
//  Copyright © 2019 Karim Alweheshy. All rights reserved.
//

import UIKit
import Networking
@testable import EmailList

final class MockInteractors: EmailListInteractorType {
    var didShowEmailDetails = false
    var didShowEmailForm = false
    var emailFormResult: Result<EmailResponse>?

    func showEmailDetails(id: UUID,
                          presentationBlock: @escaping (UIViewController) -> Void,
                          dismissBlock: @escaping (UIViewController) -> Void,
                          completionHandler: @escaping (Result<EmailResponse>) -> Void) {
        didShowEmailDetails = true
    }
    
    func showEmailForm(presentationBlock: @escaping (UIViewController) -> Void,
                       dismissBlock: @escaping (UIViewController) -> Void,
                       completionHandler: @escaping (Result<EmailResponse>) -> Void) {
        didShowEmailForm = true
        if let emailFormResult = emailFormResult {
            completionHandler(emailFormResult)
        }
    }
    
}
