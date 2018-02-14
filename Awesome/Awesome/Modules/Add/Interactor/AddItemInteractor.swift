//
//  AddItemIntecator.swift
//  Awesome
//
//  Created by Artak on 1/26/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import Foundation

class AddItemInteractor: NSObject {
    var dataManager : AddItemDataManager!
    
    init(dataManager: AddItemDataManager) {
        self.dataManager = dataManager
    }
    
    func saveNewItemWithTitle(_ title: String, shortDesc : String, longDesc : String?, level : Int, type : String) {
        let item : CommonItem = CommonItem()
        item.title = title
        item.shortDesc = shortDesc
        item.longDesc = longDesc
        item.type = type
        item.level = level

        dataManager.addNewItem(item)
    }
}
