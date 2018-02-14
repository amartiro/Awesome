//
//  EditItemViewInterface.swift
//  Awesome
//
//  Created by Artak on 2/6/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import Foundation

protocol EditItemViewInterface {
    func setEditItemTitle(_ title: String)
    func setEditItemShortDesc(_ desc: String)
    func setEditItemLongDesc(_ desc: String?)
    func setEditItemLevel(_ level: Int)
}
