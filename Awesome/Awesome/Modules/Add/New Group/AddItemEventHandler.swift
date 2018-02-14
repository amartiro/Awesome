//
//  AddItemEventHandler.swift
//  Awesome
//
//  Created by Artak on 1/30/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import Foundation

protocol AddItemEventHandler{
    func cancelAddItem()
    func saveAddItemWithTitle(_ title: String, shortDesc : String, longDesc : String?, level : Int)
    func viewLoaded()
}
