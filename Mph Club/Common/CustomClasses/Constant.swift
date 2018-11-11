//
//  Constant.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/26/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Foundation
import AWSCognitoIdentityProvider

let cognitoIdentityUserPoolRegion: AWSRegionType = .USEast1
let cognitoIdentityUserPoolId = "us-east-1_aJVqbEZra"
let cognitoIdentityUserPoolAppClientId = "55onnfa25rft9cduiaedu98n1h"
let cognitoIdentityUserPoolAppClientSecret = "jlgfja8u8cl8j1ohu4b74kp2u1a3ieej19qb44bn4jqnavn3m6g"

let AWSCognitoUserPoolsSignInProviderKey = "UserPool"

struct Constant {
    static var viewIndex = 0
    static var closeIcon = "close28Px"
    static var backArrowIcon = "arrowLeft28Px"
    static var accessToken = ""
    static var carKey = ""
}
