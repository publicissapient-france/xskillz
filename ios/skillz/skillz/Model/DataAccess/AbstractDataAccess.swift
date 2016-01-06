//
//  AbstractDataAccess.swift
//  skillz
//
//  Created by Florent Capon on 11/12/2015.
//  Copyright © 2015 Xebia IT Architects. All rights reserved.
//

import UIKit
import Alamofire

public typealias ProgressTask = (bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64)

public class AbstractDataAccess: NSObject {
    
    private var root: String
    
    init(root: String) {
        self.root = root
    }
    
    public func GET(endpoint: String) -> Request {
        let path = self.root + endpoint
        return Alamofire.request(.GET, path)
    }
    
}
