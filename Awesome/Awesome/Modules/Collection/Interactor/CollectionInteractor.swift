//
//  CollectionInteractor.swift
//  Awesome
//
//  Created by Artak on 1/31/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import Foundation

class CollectionInteractor : NSObject, CollectionInteractorInput {
    
    let dataManager : CollectionDataManager!
    var output: CollectionInteractorOutput?
    
    init(dataManager: CollectionDataManager) {
        self.dataManager = dataManager
    }
    
    func findItemsWithType(_ type: ItemType) {
        dataManager.itemsWithType(type) { (items) in
            self.output?.foundItems(items)
        }
    }
    
    func deleteItem(_ item: CommonItem) {
        self.dataManager.deleteItem(item: item)
    }
    
    func resetItems() {
        self.dataManager.resetItems()
    }

}
