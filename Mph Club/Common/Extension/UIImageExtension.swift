//
//  UIImageExtension.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/9/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Foundation
import PromiseKit

// ==============
// MARK: - Errors
// ==============
extension UIImage {
    enum Errors: Error, LocalizedError {
        case invalidImage
        
        public var errorDescription: String? {
            let message: String
            
            switch self {
            case .invalidImage:
                message = "Could not generate data from this image"
            }
            
            return message
        }
    }
}

extension UIImage {
    
    /// Compresses this image, generating JPEG representation Data
    ///
    /// - Parameter size: Desired image size in bytes
    /// - Returns: Compressed JPEG representation Data of this image
    /// - Throws: `UIImage.Errors.invalidImage` if could not generate JPEG representation Data of this image
    func compress(toSize size: Int) throws -> Data {
        guard let originalImageData = self.jpegData(compressionQuality: 1) else {
            throw Errors.invalidImage
        }
        
        let imageData: Data
        let compressionRate = CGFloat(Double(size) / Double(originalImageData.count)) - 0.1
        if originalImageData.count > size,
            let compresedImageData = self.jpegData(compressionQuality: compressionRate) {
            imageData = compresedImageData
        } else {
            imageData = originalImageData
        }
        
        return imageData
    }
    
    /// Compresses this image, generating JPEG representation Data
    ///
    /// - Parameter size: Desired image size in bytes
    /// - Returns: Promise of compressed JPEG representation Data of this image
    func compress(toSize size: Int) -> Promise<Data> {
        do {
            return Promise.value(try compress(toSize: size))
        } catch {
            return Promise(error: error)
        }
    }
    
}
