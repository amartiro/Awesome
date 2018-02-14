//
//  ItemDetailsInteractor.swift
//  Awesome
//
//  Created by Artak on 2/6/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import Foundation

class ItemDetailsInteractor {
    var dataManager : ItemDetailsDataManager?
    var output: ItemDetailsInteractorOutput?
    
    init(dataManager: ItemDetailsDataManager) {
        self.dataManager = dataManager
    }
}

extension ItemDetailsInteractor: ItemDetailsInteractorInput {
    func getItem(id: String) {
        dataManager?.getItem(id){(item) in
            if let item = item {
                self.output?.foundItem(item)
            }
        }
    }
    
    
}
