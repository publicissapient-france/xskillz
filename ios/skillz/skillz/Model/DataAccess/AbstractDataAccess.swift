//
//  AbstractDataAccess.swift
//  skillz
//
//  Created by Florent Capon on 11/12/2015.
//  Copyright © 2015 Xebia IT Architects. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

public typealias ProgressMultiTasks = (completedCount: Int, totalCount: Int)
public typealias ProgressTask = (bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64)

public class AbstractDataAccess: NSObject {
    
    private var root: String
    
    init(root: String) {
        self.root = root
    }
    
    public func GET(endpoint: String, absolute: Bool = false) -> Request {
        if absolute {
            return Alamofire.request(.GET, endpoint)
        }
        else {
            let path = self.root + endpoint
            return Alamofire.request(.GET, path)
        }
    }
    
    class func GET(path: String) -> Request {
        return Alamofire.request(.GET, path)
    }
    
    class func activityIndicatorInStatusBarVisible(visible: Bool) -> Void {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = visible
    }
}
