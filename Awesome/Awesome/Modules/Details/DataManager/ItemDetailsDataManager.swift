//
//  ItemDetailsDataManager.swift
//  Awesome
//
//  Created by Artak on 2/6/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import Foundation

class ItemDetailsDataManager: NSObject {
    var dataManager : DataSourceManager?
    
    init(dataManager: DataSourceManager){
        self.dataManager = dataManager
    }
    
    func getItem(_ itemId: String, completion: ((CommonItem?) -> Void)!) {
        dataManager?.getItem(itemId: itemId) { (item) in
            completion(item)
        }
    }
}
