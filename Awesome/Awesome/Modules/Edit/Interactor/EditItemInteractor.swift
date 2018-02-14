//
//  EditItemInteractor.swift
//  Awesome
//
//  Created by Artak on 2/6/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import Foundation

class EditItemInteractor: NSObject {
    var dataManager : EditItemDataManager!
    
    init(dataManager: EditItemDataManager) {
        self.dataManager = dataManager
    }
    
    func saveItem(_ item: CommonItem) {
        dataManager.editItem(item)
    }
}
