//
//  EditItemEventHandler.swift
//  Awesome
//
//  Created by Artak on 2/6/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import Foundation

protocol EditItemEventHandler {
    func cancelEditItem()
    func editItemWithTitle(_ title: String, shortDesc : String, longDesc : String?, level : Int)
    func viewLoaded()
}
