//
//  TableViewController.swift
//  Nextdoor
//
//  Created by AT on 5/4/16.
//  Copyright © 2016 AT. All rights reserved.
//

import UIKit

class ImageTableViewController: UITableViewController {
    
    let downloaderHelper = DownloaderHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ConfigurationData.sharedInstance.imageData.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("imageCell") as! ImageTableViewCell
        
        if cell.accessoryView == nil {
            let indicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
            cell.accessoryView = indicator
        }
        let indicator = cell.accessoryView as! UIActivityIndicatorView
        
        let imageData = ConfigurationData.sharedInstance.imageData[indexPath.row]
        cell.txtLabel.text = imageData.name
        cell.imgView.image = imageData.image
        
        switch (imageData.state){
        case .Failed, .Downloaded:
            indicator.stopAnimating()
            break
        case .New:
            indicator.startAnimating()
            startImageDownload(imageData, indexPath: indexPath)
            break
        }

        return cell
    }
    
    /**
     https://www.raywenderlich.com/76341/use-nsoperation-nsoperationqueue-swift
     
     start downloading an image
     
     - Parameter imageModel: Image model
     - Parameter indexPath: Cell index path
     */
    
    func startImageDownload(imageModel: ImageModel, indexPath: NSIndexPath) {
        if (downloaderHelper.downloadsInProgress[indexPath] != nil) {
            return
        }
        
        let downloader = ImageDownloader(imageModel: imageModel)

        downloader.completionBlock = {
            if downloader.cancelled {
                return
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.downloaderHelper.downloadsInProgress.removeValueForKey(indexPath)
                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            })
        }
        
        downloaderHelper.downloadsInProgress[indexPath] = downloader
        downloaderHelper.downloadQueue.addOperation(downloader)
    }

}
