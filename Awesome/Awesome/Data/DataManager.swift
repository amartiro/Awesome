//
//  DataManager.swift
//  Awesome
//
//  Created by Artak on 12/27/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import Foundation

class DataManager : DataSourceManager {
    var databaseManager : DatabaseManager
    var networkManager: NetworkManager
    
    required init(networkManager: NetworkManager, databaseManager: DatabaseManager) {
        self.networkManager = networkManager
        self.databaseManager = databaseManager
        
        let loaded = UserDefaults.standard.value(forKey: "Loaded")
        if loaded == nil {
            loadData()
            UserDefaults.standard.set(true, forKey: "Loaded")
            UserDefaults.standard.synchronize()
        }
    }
    
    func loadData() {
        var items : [CommonItem] = []
        self.networkManager.getItems(itemType: nil) { (response, error) in
            if !(response is NSNull) {
                for dict in response as! [[String:AnyObject]] {
                    let item = ItemFactory.parseItem(dict: dict)
                    items.append(item)
                }
//                self.itemsTableView.reloadData()
            }

            for item in items {
                self.databaseManager.addOrUpdateItem(item: item)
            }
        }
    }
    
    func getItems(itemType : ItemType, completion: @escaping (([CommonItem]) -> Void)) {
        databaseManager.getItems(itemType: itemType) { (items) in
            completion(items)
        }
    }
    
    func addItem(item : CommonItem) {
        self.networkManager.addItem(item: item) { (response, error) in
            print(error ?? "No Error", response!)
        }

        self.databaseManager.addOrUpdateItem(item: item)
    }
    
    func editItem(item : CommonItem) {
        self.networkManager.addItem(item: item) { (response, error) in
            print(error ?? "No Error", response!)
        }
        
    }
    
    func save(){
        databaseManager.save()
        
    }

}

