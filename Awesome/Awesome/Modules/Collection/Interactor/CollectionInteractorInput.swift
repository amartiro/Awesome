//
//  CollectionInteractorInput.swift
//  Awesome
//
//  Created by Artak on 2/6/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import Foundation

protocol CollectionInteractorInput {
    func findItemsWithType(_ type : ItemType)
    func resetItems()
    func deleteItem(_ item : CommonItem)
}
