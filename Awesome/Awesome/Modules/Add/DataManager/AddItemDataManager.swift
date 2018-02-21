//
//  AddItemDataManager.swift
//  Awesome
//
//  Created by Artak on 1/26/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import Foundation


class AddItemDataManager: NSObject {
    fileprivate var dataManager : DataSourceManager!
    
    init(dataManager: DataSourceManager){
        self.dataManager = dataManager
    }
    
    func addNewItem(_ item: CommonItem) {
        dataManager.addItem(item: item)
    }
}
