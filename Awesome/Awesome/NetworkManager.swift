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

    func getItems (itemType: String, _ responseHandle: @escaping (_ response: AnyObject?, _ error: AnyObject?) -> Void) {
        
        let path: String = baseURL + "items"
        
        var paramDict = [String: String]()
        paramDict["item_type"] = itemType
        
        Alamofire.request(path, method: .get, parameters: paramDict).responseJSON() { response in
            print(response)
            
            let result: NSArray = self.handleTheResult(response)
            responseHandle(result[0] as AnyObject?, result[1] as AnyObject?)
        }
    }
    
    func handleTheResult (_ inResponse: DataResponse<Any>) -> NSArray {
        
        countOfRequest += 1
        print(inResponse.request?.url! as Any, " ---  --- ", countOfRequest)
        
        if inResponse.result.isFailure {
            return [NSNull(), ["status" : 1009, "message" : "The Internet connection appears to be offline"]]
        }
        else {
            let value = inResponse.result.value as! [[String : AnyObject]]
            return[value, NSNull()]
            /*if (value["status"] as! Int == 200) {
                if value["data"] as AnyObject? != nil {
                    return [value["data"] as AnyObject, NSNull()]
                }
                else {
                    if value["details"] as? [[String: AnyObject]] != nil {
                        return [value["status"] as AnyObject, (value["details"] as! [[String: AnyObject]])[0]["message"] as! String]
                    }
                    else {
                        return [value["status"] as AnyObject, value["message"]!]
                    }
                }
            }
            else {
                return[NSNull(), value]
            }*/
           
        }
    }
    
}
