//
//  UIImageViewExtension.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/8/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    @discardableResult
    func setImage(with resource: Resource?,
                  placeholder: Placeholder? = nil,
                  options: KingfisherOptionsInfo? = nil,
                  progressBlock: DownloadProgressBlock? = nil,
                  completionHandler: CompletionHandler? = nil) -> RetrieveImageTask {
        return kf.setImage(with: resource,
                           placeholder: placeholder,
                           options: options,
                           progressBlock: progressBlock,
                           completionHandler: completionHandler)
    }
}
