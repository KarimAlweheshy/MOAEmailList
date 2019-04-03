//
//  InteractorTests.swift
//  EmailListTests
//
//  Created by Karim Alweheshy on 2/15/19.
//  Copyright © 2019 Karim Alweheshy. All rights reserved.
//

import XCTest
import Networking
@testable import EmailList

class InteractorTests: XCTestCase {
    private var presenter: EmailListPresenter!
    private var router: MockRouter!
    private var view: MockView!
    private var interactor: EmailListInteractor!
}
