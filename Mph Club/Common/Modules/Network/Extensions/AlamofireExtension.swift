//
//  AlamofireExtension.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/7/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Alamofire
import PromiseKit

extension Alamofire.DataRequest {
    func responseData() -> Promise<Data> {
        let networkQueue: DispatchQueue = {
            DispatchQueue(label: "mph-network-queue",
                          qos: .userInitiated,
                          attributes: .concurrent,
                          autoreleaseFrequency: .inherit,
                          target: nil)
        }()
        
        return Promise { seal in
            let request = responseData(queue: networkQueue) { response in
                switch response.result {
                case .success(let data):
                    seal.fulfill(data)
                case .failure(let error):
                    seal.reject(error)
                }
            }
            debugPrint(request)
            }.ensure {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
    func responseData() -> Promise<Optional<Data>> {
        let networkQueue: DispatchQueue = {
            DispatchQueue(label: "mph-network-queue",
                          qos: .userInitiated,
                          attributes: .concurrent,
                          autoreleaseFrequency: .inherit,
                          target: nil)
        }()
        
        return Promise { seal in
            let request = responseData(queue: networkQueue) { response in
                switch response.result {
                case .success:
                    seal.fulfill(response.data)
                case .failure(let error):
                    seal.reject(error)
                }
            }
            debugPrint(request)
            }.ensure {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
}
