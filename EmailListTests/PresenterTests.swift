//
//  PresenterTests.swift
//  EmailListTests
//
//  Created by Karim Alweheshy on 2/15/19.
//  Copyright © 2019 Karim Alweheshy. All rights reserved.
//

import XCTest
import Networking
@testable import EmailList

class PresenterTests: XCTestCase {
    private var presenter: EmailListPresenter!
    private var router: MockRouter!
    private var view: MockView!
    private var interactor: MockInteractors!
    
    override func setUp() {
        let requestBody = EmailListRequestBody(filters: ["": ""])
        router = MockRouter()
        view = MockView()
        interactor = MockInteractors()
        
        presenter = EmailListPresenter(router: router,
                                       interactor: interactor,
                                       view: view,
                                       requestBody: requestBody,
                                       isSelection: false,
                                       resultCallback: { (result: Result<EmailResponse>) in
            
        })
    }
    
    override func tearDown() {
    }
    
    func testViewDidLoad() {
        presenter.viewDidLoad()
        assert(view.filters != nil)
    }
    
    func testDidTapAdd() {
        presenter.didTapAdd()
        assert(interactor.didShowEmailForm)
    }
    
    func testDidTapEmail() {
        interactor.emailFormResult = .success(EmailResponse())
        presenter.didTapAdd()
        presenter.didTapEmail(at: 0)
        assert(interactor.didShowEmailDetails)
    }
}
