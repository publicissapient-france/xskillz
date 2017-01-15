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

open class AbstractDataAccess: NSObject {
    
    fileprivate var root: String
    open var session: Session = Session.sharedInstance
    
    init(root: String) {
        self.root = root
    }
    
    open func GET(_ endpoint: String, absolute: Bool = false, parameters: [String: AnyObject]? = nil) -> DataRequest {
        if absolute {
            return Alamofire.request(endpoint, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: self.headers())
        }
        else {
            let path = self.root + endpoint
            return Alamofire.request(path, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: self.headers())
        }
    }
    
    open func POST(_ endpoint: String, absolute: Bool = false, parameters: [String: AnyObject]? = nil) -> DataRequest {
        if absolute {
            return Alamofire.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: self.headers())
        }
        else {
            let path = self.root + endpoint
            return Alamofire.request(path, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: self.headers())
        }
    }
    
    fileprivate func headers() -> [String: String]? {
        var headers: [String: String]? = nil
        if ((self.session.skillzToken) != nil) {
            headers = ["token": (self.session.skillzToken as? String)!]
        }
        return headers
    }
    
    class func activityIndicatorInStatusBarVisible(_ visible: Bool) -> Void {
        UIApplication.shared.isNetworkActivityIndicatorVisible = visible
    }
}
