//
//  NetworkFactory.swift
//  Awesome
//
//  Created by Artak on 12/27/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import Foundation


class NetworkFactory {
    static func getManager() -> NetworkManager {
        return AlamofireNetworkManager()
        
    }
}
