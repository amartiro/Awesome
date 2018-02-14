//
//  CollectionInteractorOutput.swift
//  Awesome
//
//  Created by Artak on 2/6/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import Foundation

protocol CollectionInteractorOutput {  //With this protocol Interactor send items to Presenter
    func foundItems(_ upcomingItems: [CommonItem])
}
