//
//  DatabaseFactory.swift
//  Awesome
//
//  Created by Artak on 12/27/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import Foundation

class DatabaseFactory {
    static func getManager() -> DatabaseManager {
        return CoreDataManager()
    }
}

