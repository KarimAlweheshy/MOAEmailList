//
//  MockView.swift
//  EmailListTests
//
//  Created by Karim Alweheshy on 2/15/19.
//  Copyright © 2019 Karim Alweheshy. All rights reserved.
//

import Foundation
@testable import EmailList

final class MockView: EmailListView {
    var filters: String?
    var emails: [String]?
    var isShowingError = false
    
    func update(filters: String) { self.filters = filters }
    
    func update(emails: [String]) { self.emails = emails }
    
    func show(errorMessage: String) { isShowingError = true }
}
