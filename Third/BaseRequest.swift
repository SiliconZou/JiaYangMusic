//
//  BaseRequest.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/17.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit

class BaseRequest {
    
    class func getWithURK(url:String!,para:NSDictionary?,callBack:@escaping (_ data:NSData?,_ error:NSError?)->Void)->Void {
        let session = URLSession.shared
        var request = URLRequest.init(url: URL.init(string: url)!)
        request.httpMethod = "GET"
        request.addValue("8460bb34be3922cb9ebaa1f3d6283168", forHTTPHeaderField: "Device-Id")
        request.addValue("10101042", forHTTPHeaderField: "App-Id")
        request.addValue("aVBob25lIE9TXzkuMy41Xzc1MCoxMzM0XzEwMDAwMTAwMF9pUGhvbmUgNg", forHTTPHeaderField: "Device-V")
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if data != nil {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    callBack(data as NSData?, nil)
                } else {
                    callBack(nil, error as NSError?)
                }
            }
        }
        dataTask.resume()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
}
