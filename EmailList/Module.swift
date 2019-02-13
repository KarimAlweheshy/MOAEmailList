//
//  Module.swift
//  EmailList
//
//  Created by Karim Alweheshy on 2/11/19.
//  Copyright © 2019 Karim Alweheshy. All rights reserved.
//

import UIKit
import Networking

open class Module: ModuleType {
    public static var capabilities: [InternalRequest.Type] = [EmailListRequest.self,
                                                              EmailSelectionRequest.self]
    
    fileprivate let presentationBlock: (UIViewController) -> Void
    fileprivate let dismissBlock: (UIViewController) -> Void
    
    public required init(presentationBlock: @escaping (UIViewController) -> Void,
                         dismissBlock: @escaping (UIViewController) -> Void) {
        self.presentationBlock = presentationBlock
        self.dismissBlock = dismissBlock
    }
    
    public func execute<T>(networking: NetworkingType,
                           request: InternalRequest,
                           completionHandler: @escaping (Result<T>) -> Void) {
        guard let completionBlock = completionHandler as? ((Result<EmailResponse>) -> Void) else {
            completionHandler(.error(ResponseError.badRequest400(error: nil)))
            return
        }
        
        var viewController: UIViewController!
        if let request = request as? EmailListRequest {
            viewController = EmailListBuilder.make(networking: networking,
                                                   requestBody: request.data,
                                                   isSelection: false) { result in
                self.dismissBlock(viewController)
                completionBlock(result)
            }
        } else if let request = request as? EmailSelectionRequest {
            viewController = EmailListBuilder.make(networking: networking,
                                                   requestBody: request.data,
                                                   isSelection: true) { result in
                self.dismissBlock(viewController)
                completionBlock(result)
            }
        } else {
            completionBlock(.error(ResponseError.badRequest400(error: nil)))
            return
        }
        presentationBlock(viewController)
    }
}
