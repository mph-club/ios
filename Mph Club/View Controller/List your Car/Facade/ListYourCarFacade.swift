//
//  ListYourCarFacade.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/8/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Foundation
import PromiseKit

final class ListYourCarFacade {
    // ============================
    // MARK: - Singleton Definition
    // ============================
    static let shared = ListYourCarFacade()
    private init() {}
    
    // ================
    // MARK: - Services
    // ================
    private let listYourCarService = ListYourCarService.shared
}

// ========================
// MARK: - Service Requests
// ========================
extension ListYourCarFacade {
    func addOwnCar (_ parameters: AddOwnCarParameters?) -> Promise<ParentAddOwnCarResult> {
        return listYourCarService.addOwnCar(parameters)
    }
    
    func uploadCarImage(_ file: ImageUploadFileModel, parameters: UploadCarImageParameters?) -> Promise<Void> {
        return listYourCarService.uploadCarImage(file, parameters: parameters)
    }
}
