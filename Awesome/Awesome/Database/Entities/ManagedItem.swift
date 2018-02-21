//
//  ManagedItem.swift
//  Awesome
//
//  Created by Artak on 1/9/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import Foundation
import CoreData

class ManagedItem : NSManagedObject , CommonItemProtocol{    
    @NSManaged var date : Date?
    @NSManaged var id : String
    @NSManaged var imageUrl : String?
    @NSManaged var level : Int
    @NSManaged var longDesc : String?
    @NSManaged var serverId : String?
    @NSManaged var shortDesc : String
    @NSManaged var title : String
    @NSManaged var type : String
    @NSManaged var status : Int
}
