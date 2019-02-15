//
//  MockNetworking.swift
//  EmailListTests
//
//  Created by Karim Alweheshy on 2/15/19.
//  Copyright © 2019 Karim Alweheshy. All rights reserved.
//

import Foundation
import Networking
@testable import EmailList

class MockNetworking: NetworkingType {
    let registeredModules: [ModuleType.Type] = [Module.self]
    var inMemoryModule = [ModuleType]()
    
    func execute<T: Codable>(request: RemoteRequest,
                             completionHandler: @escaping (_ result: Result<T>) -> Void) {
    }
}
