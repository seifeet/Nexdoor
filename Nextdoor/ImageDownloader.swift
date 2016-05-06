//
//  ImageDownloader.swift
//  Nextdoor
//
//  Created by AT on 5/5/16.
//  Copyright © 2016 AT. All rights reserved.
//

import UIKit

class ImageDownloader: NSOperation {
    let imageModel: ImageModel
    
    init(imageModel: ImageModel) {
        self.imageModel = imageModel
    }
    
    override func main() {

        if self.cancelled {
            return
        }

        let imageData = NSData(contentsOfURL:self.imageModel.url)
        
        if self.cancelled {
            return
        }
        
        if imageData?.length > 0 {
            self.imageModel.image = UIImage(data:imageData!)
            self.imageModel.state = .Downloaded
        } else {
            self.imageModel.image = UIImage(named: "Placeholder40")
            self.imageModel.state = .Failed
        }
    }
}