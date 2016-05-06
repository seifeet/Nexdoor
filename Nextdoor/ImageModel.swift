//
//  ImageModel.swift
//  Nextdoor
//
//  Created by AT on 5/4/16.
//  Copyright © 2016 AT. All rights reserved.
//

import UIKit

class ImageModel : BasicModel {

    enum State {
        case New, Failed, Downloaded
    }
    
    let name:String
    let url:NSURL
    var image = UIImage(named: "Placeholder40")
    var state = State.New
    
    init(name:String, url:NSURL) {
        self.name = name
        self.url = url
    }
    
    override var description: String {
        return "name: \(name), url: \(url)"
    }
}
