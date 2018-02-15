//
//  MainDataManager.swift
//  Awesome
//
//  Created by Artak on 2/13/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import Foundation

class MainDataManager {
    var dataManager : DataSourceManager!
    
    init(dataManager: DataSourceManager){
        self.dataManager = dataManager
    }
    
    func itemsWithType(_ itemType: ItemType, completion: (([CommonItem]) -> Void)!) {
        dataManager.getItems(itemType: itemType, completion: { (items) in
            completion(items)
        })
    }
    
    func deleteItem(item : CommonItem) {
        dataManager.deleteItem(item: item)
    }
    
    func resetItems() {
        dataManager?.reset()
    }
    
    func editItem(_ item: CommonItem) {
        dataManager?.editItem(item: item)
    }
    
}
