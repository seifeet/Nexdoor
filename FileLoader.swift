//
//  FileLoader.swift
//  Nextdoor
//
//  Created by AT on 5/4/16.
//  Copyright © 2016 AT. All rights reserved.
//

import Foundation

class FileLoader {
    
    enum FileLoaderError: ErrorType {
        case NotImplemented
    }
    
    /**
     Load a file from file system
     
     - Parameter fileName: File name

     - Returns: A parsed model
     
     */
    
    func loadFileWithName(fileName: String) -> [BasicModel]? {
        if let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")
        {
            do {
                let jsonData = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                
                if let jsonResult = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as AnyObject?
                {
                    return try parseJsonResult(jsonResult)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
        return nil
    }
    
    /**
     Parse Json into a model
     Should be overriden for object spefic implementation
     
     - Parameter jsonResult: A Json object
     
     - Returns: A parsed model
     
     */
    func parseJsonResult(jsonResult: AnyObject) throws -> [BasicModel]? {
        throw FileLoaderError.NotImplemented
    }
}
