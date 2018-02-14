//
//  ItemDetailsViewInterface.swift
//  Awesome
//
//  Created by Artak on 2/6/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import Foundation

protocol ItemDetailsViewInterface {
    func setItemTitle(_ title: String)
    func setItemShortDesc(_ desc: String)
    func setItemLongDesc(_ desc: String?)
    func setItemLevel(_ level: Int)
}
