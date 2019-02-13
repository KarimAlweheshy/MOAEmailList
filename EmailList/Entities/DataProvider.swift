//
//  DataProvider.swift
//  Email
//
//  Created by Karim Alweheshy on 2/11/19.
//  Copyright © 2019 Karim Alweheshy. All rights reserved.
//

import Foundation
import Networking
import CoreData

final class DataProvider {
    let networking: NetworkingType
    let mainContext: NSManagedObjectContext
    let backgroundContext: NSManagedObjectContext
    
    fileprivate let persistanceContainer: NSPersistentContainer
    
    init(networking: NetworkingType) {
        self.networking = networking
        
        persistanceContainer = EmailPersistanceContainer(name: "Email")
        persistanceContainer.loadPersistentStores { (_, error) in print(String(describing: error)) }
        mainContext = persistanceContainer.viewContext
        backgroundContext = persistanceContainer.newBackgroundContext()
    }
}
