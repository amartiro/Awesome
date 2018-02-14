//
//  CollectionViewInterface.swift
//  Awesome
//
//  Created by Artak on 2/1/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import Foundation

protocol CollectionViewInterface {
  
    func showNoContentMessage()
    func showItems(_ items: [DisplayItem])
    func showItemTypeDialog()
    func setTitle(_ title: String)
}
