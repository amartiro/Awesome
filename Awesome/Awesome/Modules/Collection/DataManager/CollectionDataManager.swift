//
//  CollectionDataManager.swift
//  Awesome
//
//  Created by Artak on 1/12/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import Foundation

class CollectionDataManager : NSObject {
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
}
