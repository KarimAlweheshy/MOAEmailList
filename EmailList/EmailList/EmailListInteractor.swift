//
//  EmailInteractor.swift
//  Email
//
//  Created by Karim Alweheshy on 2/11/19.
//  Copyright © 2019 Karim Alweheshy. All rights reserved.
//

import UIKit
import Networking

protocol EmailListInteractorType {
    func showEmailDetails(id: UUID,
                          presentationBlock: @escaping (UIViewController) -> Void,
                          dismissBlock: @escaping (UIViewController) -> Void,
                          completionHandler: @escaping (Result<EmailResponse>) -> Void) 
    
    func showEmailForm(presentationBlock: @escaping (UIViewController) -> Void,
                       dismissBlock: @escaping (UIViewController) -> Void,
                       completionHandler: @escaping (Result<EmailResponse>) -> Void)
}

final class EmailListInteractor {
    fileprivate let networking: NetworkingType
    
    init(networking: NetworkingType) {
        self.networking = networking
    }
}

// MARK: - EmailListInteractorType
extension EmailListInteractor: EmailListInteractorType {
    func showEmailDetails(id: UUID,
                          presentationBlock: @escaping (UIViewController) -> Void,
                          dismissBlock: @escaping (UIViewController) -> Void,
                          completionHandler: @escaping (Result<EmailResponse>) -> Void) {
        
        let requestBody = EmailDetailsRequestBody(emailID: id)
        let request = EmailDetailsRequest(data: requestBody)
        
        networking.execute(request: request,
                           presentationBlock: presentationBlock,
                           dismissBlock: dismissBlock,
                           completionHandler: completionHandler)
    }
    func showEmailForm(presentationBlock: @escaping (UIViewController) -> Void,
                       dismissBlock: @escaping (UIViewController) -> Void,
                       completionHandler: @escaping (Result<EmailResponse>) -> Void) {
        let requestBody = EmailCreationRequestBody(draftID: nil, receiversIDs: nil, ccIDs: nil, bccIDs: nil, subject: nil, body: nil, attachementsURLs: nil)
        let request = EmailCreationRequest(data: requestBody)
        networking.execute(request: request,
                           presentationBlock: presentationBlock,
                           dismissBlock: dismissBlock,
                           completionHandler: completionHandler)
    }
}
