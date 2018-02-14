//
//  ItemDetailsEventHandler.swift
//  Awesome
//
//  Created by Artak on 2/6/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import Foundation

protocol ItemDetailsEventHandler { // View sends user actions to Presenter with this protocol
    func editItem()
    func reloadItem()
    func viewLoaded()
}
