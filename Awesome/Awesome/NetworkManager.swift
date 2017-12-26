//
//  NetworkManager.swift
//  Awesome
//
//  Created by Artak on 12/8/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
   
    var countOfRequest: Int = 0

    let baseURL = "http://138.197.26.187/"
    static let sharedInstance: NetworkManager = NetworkManager()
    
    func handleTheResult (_ inResponse: DataResponse<Any>) -> [AnyObject] {
        
        countOfRequest += 1
        print(inResponse.request?.url! as Any, " ---  --- ", countOfRequest)
        
        if inResponse.result.isFailure {
            return [NSNull(), "The Internet connection appears to be offline" as AnyObject]
        } else {
            let value = inResponse.result.value as! [String : AnyObject]
            if let error = value["error"] {
                return[NSNull(), error]
            }
            
            if let data = value["data"] {
                return [data, NSNull()]
            }
            
            return [NSNull(), NSNull()]
        }
    }
    
    func getItem (itemId: String, _ responseHandle: @escaping (_ response: AnyObject?, _ error: AnyObject?) -> Void) {
        
        let path: String = baseURL + "items" + itemId
        
        Alamofire.request(path, method: .get).responseJSON() { response in
            print(response)
            
            let result: [AnyObject] = self.handleTheResult(response)
            responseHandle(result[0] as AnyObject?, result[1] as AnyObject?)
        }
    }
    
    func getItems (itemType: String, _ responseHandle: @escaping (_ response: AnyObject?, _ error: AnyObject?) -> Void) {
        
        let path: String = baseURL + "items"
        
        var paramDict = [String: String]()
        paramDict["item_type"] = itemType
        
        Alamofire.request(path, method: .get, parameters: paramDict).responseJSON() { response in
            print(response)
            
            let result: [AnyObject] = self.handleTheResult(response)
            responseHandle(result[0] as AnyObject?, result[1] as AnyObject?)
        }
    }
    
    func addItem(type: String, title: String, shortDesc: String, longDesc: String, level: Int, _ responseHandle: @escaping (_ response: AnyObject?, _ error: AnyObject?) -> Void)  {
        
        let path: String = baseURL + "items"
        
        var paramDict = [String: String]()
        paramDict["title"] = title
        paramDict["item_type"] = type
        paramDict["short_desc"] = shortDesc
        paramDict["long_desc"] = longDesc
        paramDict["level"] = "\(level)"

        Alamofire.request(path, method: .post, parameters: paramDict).responseJSON() { response in
            print(response)
            
            let result: [AnyObject] = self.handleTheResult(response)
            responseHandle(result[0] as AnyObject?, result[1] as AnyObject?)
        }
    }
}
    

