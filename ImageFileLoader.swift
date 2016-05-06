//
//  ImageFileLoader.swift
//  Nextdoor
//
//  Created by AT on 5/4/16.
//  Copyright © 2016 AT. All rights reserved.
//

import Foundation

class ImageFileLoader: FileLoader {
    struct Constants {
        struct Json {
            static let Name = "name"
            static let Url = "url"
        }
    }
    
    override func parseJsonResult(jsonResult: AnyObject) throws -> [BasicModel]? {
        var result = [ImageModel]()
        if let jsonArray = jsonResult as? [NSDictionary] {
            for jsonDictionary in jsonArray {
                let name = jsonDictionary[Constants.Json.Name] as? String
                let url = jsonDictionary[Constants.Json.Url] as? String
                
                if (name != nil && url != nil) {
                    result.append(ImageModel(name: name!, url: NSURL(string:url!)!))
                }
            }
        }
        return result
    }

}