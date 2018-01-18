//
//  NetworkManager.swift
//  Awesome
//
//  Created by Artak on 12/8/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import Foundation

protocol NetworkManager {
    
    func getItems (itemType: String?, _ responseHandle: @escaping (_ response: AnyObject?, _ error: AnyObject?) -> Void)
    func getItem (itemId: String, _ responseHandle: @escaping (_ response: AnyObject?, _ error: AnyObject?) -> Void)
    func addItem(item : CommonItemProtocol, _ responseHandle: @escaping (_ response: AnyObject?, _ error: AnyObject?) -> Void)
    func editItem(item : CommonItemProtocol, _ responseHandle: @escaping (_ response: AnyObject?, _ error: AnyObject?) -> Void)

}
    

