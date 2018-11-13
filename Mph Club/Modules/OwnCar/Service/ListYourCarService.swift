//
//  ListYourCarService.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/8/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Foundation
import PromiseKit

final class ListYourCarService {
    // ============================
    // MARK: - Singleton Definition
    // ============================
    static let shared = ListYourCarService()
    private init() {}
}

// ===============
// MARK: - Methods
// ===============
extension ListYourCarService {
    func addOwnCar (_ parameters: AddOwnCarParameters?) -> Promise<ParentAddOwnCarResult> {
        return Network.network
            .post(toURL: Endpoints.ListYourCar.addOwnCar, parameters: parameters)
            .then(ParentAddOwnCarResult.jsonDecode)
            .recover(MphClubErrors.handle)
    }
    
    func uploadCarImage(_ file: ImageUploadFileModel, parameters: UploadCarImageParameters?) -> Promise<Void> {
        return Network.network.uploadFile(toURL: Endpoints.ListYourCar.addPhoto,
                                          file: file,
                                          parameters: parameters)
            .asVoid()
            .recover(MphClubErrors.handle)
    }
}
