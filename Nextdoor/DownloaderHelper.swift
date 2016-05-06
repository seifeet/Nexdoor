//
//  DownloaderHelper.swift
//  Nextdoor
//
//  Created by AT on 5/5/16.
//  Copyright © 2016 AT. All rights reserved.
//

import Foundation

class DownloaderHelper {
    lazy var downloadsInProgress = [NSIndexPath:NSOperation]()
    lazy var downloadQueue:NSOperationQueue = {
        var queue = NSOperationQueue()
        queue.name = "Downloader queue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
}