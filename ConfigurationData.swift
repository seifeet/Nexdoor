//
//  ConfigurationData.swift
//  Nextdoor
//
//  Created by AT on 5/4/16.
//  Copyright © 2016 AT. All rights reserved.
//

import Foundation

class ConfigurationData {
    
    lazy var imageData:[ImageModel] = {
        let fileLoader = ImageFileLoader()
        
        if let result = fileLoader.loadFileWithName("Server_Response") {
            return result as! [ImageModel]
        }
        
        return [ImageModel]()
    }()
    
    static let sharedInstance = ConfigurationData()
    private init() {}
}