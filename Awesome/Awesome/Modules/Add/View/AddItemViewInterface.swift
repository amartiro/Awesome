//
//  AddItemViewInterface.swift
//  Awesome
//
//  Created by Artak on 1/30/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import Foundation

protocol AddItemViewInterface {
    func setItemTitle(_ title: String)
    func setItemShortDesc(_ desc: String)
    func setItemLongDesc(_ desc: String?)
    func setItemLevel(_ level: Int)
}
