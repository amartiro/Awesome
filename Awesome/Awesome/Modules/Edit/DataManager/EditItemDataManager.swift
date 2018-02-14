//
//  EditItemDataManager.swift
//  Awesome
//
//  Created by Artak on 2/6/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import Foundation

class EditItemDataManager: NSObject {
    var dataManager : DataSourceManager?
    
    init(dataManager: DataSourceManager){
        self.dataManager = dataManager
    }
    
    func editItem(_ item: CommonItem) {
        dataManager?.editItem(item: item)
    }
}
