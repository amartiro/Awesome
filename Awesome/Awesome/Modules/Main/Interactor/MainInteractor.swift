//
//  MainInteractor.swift
//  Awesome
//
//  Created by Artak on 2/13/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import Foundation

class MainInteractor : NSObject  {
    let dataManager : MainDataManager!
    var output : MainInteractorOutput?

    init(dataManager: MainDataManager) {
        self.dataManager = dataManager
    }
    
    func saveItem(_ item: CommonItem) {
        dataManager.editItem(item)
    }
}

extension MainInteractor: MainInteractorInput{

    func getItem(id: String) {
        
    }
    
    
    func findItemsWithType(_ type: ItemType) {
        dataManager.itemsWithType(type) { (items) in
            self.output?.foundItems(items)
        }
    }
    
    func resetItems() {
        self.dataManager.resetItems()
    }
    
    func deleteItem(_ item: CommonItem) {
        self.dataManager.deleteItem(item: item)
    }
    
}
