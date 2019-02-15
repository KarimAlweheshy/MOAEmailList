//
//  EmailListTests.swift
//  EmailListTests
//
//  Created by Karim Alweheshy on 2/11/19.
//  Copyright © 2019 Karim Alweheshy. All rights reserved.
//

import XCTest
import Networking
@testable import EmailList

class ModuleTests: XCTestCase {
    
    private let networking = MockNetworking()
    private let requests: [InternalRequest] = [EmailListRequest(data: EmailListRequestBody(filters: [:])),
                                               EmailSelectionRequest(data: EmailListRequestBody(filters: [:]))]
    
    override func setUp() {
    }

    override func tearDown() {
    }
    
    func testModuleCapabilitiesCount() {
        assert(Module.capabilities.count == requests.count)
    }
    
    func testModuleCapabilities() {
        assert(!requests.contains { assumedCapability in
            !Module.capabilities.contains { registeredCapabilitiy in
                registeredCapabilitiy == type(of: assumedCapability)
            }
        })
    }
    
    func testModuleConfrontsToCapabilities() {
        var expectations = [XCTestExpectation]()
        
        requests.forEach { request in
            let expectation = XCTestExpectation(description: #function)
            
            let request = EmailListRequest(data: EmailListRequestBody(filters: [:]))
            networking.execute(request: request, presentationBlock: { (viewController) in
                expectation.fulfill()
            }, dismissBlock: { _ in
                
            }, completionHandler: { (result: Result<EmailResponse>) in
                expectation.fulfill()
            })
            expectations.append(expectation)
        }
        wait(for: expectations, timeout: 1)
    }

    func testCorrectViewControllerType() {
        let expectation = XCTestExpectation(description: #function)
        
        let request = EmailListRequest(data: EmailListRequestBody(filters: [:]))
        networking.execute(request: request, presentationBlock: { (viewController) in
            XCTAssert(viewController is EmailListViewController)
            expectation.fulfill()
        }, dismissBlock: { _ in
            
        }, completionHandler: { (result: Result<EmailResponse>) in
            
        })
        
        wait(for: [expectation], timeout: 1)
    }

    func testErrorOnWrongRequest() {
        let expectation = XCTestExpectation(description: #function)
        
        let request = ExplicitLoginRequest(data: ExplicitLoginRequestBody(email: nil, password: nil))
        networking.execute(request: request, presentationBlock: { (viewController) in

        }, dismissBlock: { _ in
            
        }, completionHandler: { (result: Result<AuthenticationResponse>) in
            switch result {
            case .error(let error):
                assert(error is ResponseError)
                guard let error = error as? ResponseError else { return }
                assert(error.errorCode ==  ResponseError.badRequest400(error: nil).errorCode)
                expectation.fulfill()
            case .success: XCTFail()
            }
        })
        
        wait(for: [expectation], timeout: 1)
    }
}
