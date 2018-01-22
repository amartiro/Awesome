//
//  DataSourceManager.swift
//  Awesome
//
//  Created by Artak on 12/27/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import Foundation

protocol DataSourceManager {
    init(networkManager : NetworkManager, databaseManager : DatabaseManager)
   
    func getItems(itemType : ItemType, completion: @escaping (([CommonItem]) -> Void))
    func addItem(item : CommonItem)
    func editItem(item : CommonItem)
    func deleteItem(item : CommonItem)
    
    func save()
}
