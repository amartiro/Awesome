//
//  DataSourceFactory.swift
//  Awesome
//
//  Created by Artak on 12/27/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import Foundation

class DataSourceFactory {
    static func getManager(networkManager: NetworkManager, databaseManager: DatabaseManager) -> DataSourceManager {
        return DataManager(networkManager: networkManager, databaseManager: databaseManager)
    }
}
