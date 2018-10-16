//
//  InfoDictionary.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/15/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import Foundation

final class InfoDictionary {
    // =============
    // MARK: - Enums
    // =============
    private enum InfoDictionaryKey: String {
        case baseURL = "Base URL"
    }
    
    // ==================
    // MARK: - Properties
    // ==================
    
    // MARK: Instance
    private let dictionary: [String: Any]!
    
    // MARK: Static
    static private(set) var main = InfoDictionary(Bundle.main.infoDictionary)
    
    init(_ dictionary: [String: Any]!) {
        self.dictionary = dictionary
    }
    
    // ==============
    // MARK: - Fields
    // ==============
    
    // MARK: Base URL
    lazy private(set) var baseURL: String = self.dictionary[InfoDictionaryKey.baseURL]
}
