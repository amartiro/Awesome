//
//  MainViewInterface.swift
//  Awesome
//
//  Created by Artak on 2/13/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import Foundation

protocol MainViewInterface : CollectionViewInterface, ItemDetailsViewInterface, EditItemViewInterface {
    func showEditView()
    func showDetailsView()
}
