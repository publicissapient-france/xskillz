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
    public var session: Session!
    
    init(root: String) {
        self.root = root
    }
    
    public func GET(endpoint: String, absolute: Bool = false, parameters: [String: AnyObject]? = nil) -> Request {
        if absolute {
            return Alamofire.request(.GET, endpoint, parameters: parameters, encoding: ParameterEncoding.JSON, headers: self.headers())
        }
        else {
            let path = self.root + endpoint
            return Alamofire.request(.GET, path, parameters: parameters, encoding: ParameterEncoding.JSON, headers: self.headers())
        }
    }
    
    public func POST(endpoint: String, absolute: Bool = false, parameters: [String: AnyObject]? = nil) -> Request {
        if absolute {
            return Alamofire.request(.POST, endpoint, parameters: parameters, encoding: ParameterEncoding.JSON, headers: self.headers())
        }
        else {
            let path = self.root + endpoint
            return Alamofire.request(.POST, path, parameters: parameters, encoding: ParameterEncoding.JSON, headers: self.headers())
        }
    }
    
    private func headers() -> [String: String]? {
        var headers: [String: String]? = nil
        if ((self.session.skillzToken) != nil) {
            headers = ["token": (self.session.skillzToken as? String)!]
        }
        return headers
    }
    
    class func activityIndicatorInStatusBarVisible(visible: Bool) -> Void {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = visible
    }
}
