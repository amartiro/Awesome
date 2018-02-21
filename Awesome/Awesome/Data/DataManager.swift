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
        networkManager.getItems(itemType: nil) { (response, error) in
            if !(response is NSNull) {
                for dict in response as! [[String:AnyObject]] {
                    let item = ItemFactory.parseItem(dict: dict)
                    items.append(item)
                }
            }

            for item in items {
                self.databaseManager.addOrUpdateItem(item: item)
            }
        }
    }
    
    func reset() {
        databaseManager.reset()

        loadData()
        UserDefaults.standard.set(true, forKey: "Loaded")
        UserDefaults.standard.synchronize()
    }
    
    func getItems(itemType : ItemType, completion: @escaping (([CommonItem]) -> Void)) {
        databaseManager.getItems(itemType: itemType) { (items) in
            completion(items)
        }
    }
    
    func getItem(itemId : String, completion: @escaping ((CommonItem?) -> Void)) {
        databaseManager.getItem(itemId: itemId) { (item) in
            completion(item)
        }
        
    }
    
    func addItem(item : CommonItem) {
//        networkManager.addItem(item: item) { (response, error) in
//            print(error ?? "No Error", response!)
//        }

        self.databaseManager.addItem(item: item)
    }
    
    func editItem(item : CommonItem) {
//        networkManager.editItem(item: item) { (response, error) in
//            print(error ?? "No Error", response!)
//        }
   //     DispatchQueue.global(qos: .background) .async {
            self.databaseManager.editItem(item: item)
 //       }
    }
    
    func deleteItem(item : CommonItem) {
        networkManager.deleteItem(item: item) { (response, error) in
            print(error ?? "No Error", response!)
        }
        
        databaseManager.deleteItem(item: item)
    }

    
    func save(){
        databaseManager.save()
    }
    
    func sync() {
        
        var syncableItems = [CommonItem]()
        databaseManager.getItems(itemStatus: ItemStatus.panding_add) { (items) in
            syncableItems.append(contentsOf: items)
        }
        
        databaseManager.getItems(itemStatus: ItemStatus.panding_update) { (items) in
            syncableItems.append(contentsOf: items)
        }
        
        databaseManager.getItems(itemStatus: ItemStatus.panding_delete) { (items) in
            syncableItems.append(contentsOf: items)
        }
        
        
    }

}

