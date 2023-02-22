//
//  RandomFact.swift
//  BYOA4.3
//
//  Created by Jake Gloschat on 2/22/23.
//

import Foundation

import Foundation

class RandomFact {
    
    let text: String
    
    init(text: String) {
        self.text = text
    }
}

extension RandomFact {
    
    enum Keys: String {
        case text
    }
    
    convenience init?(randomFactDictionary: [String: Any]) {
        guard let text = randomFactDictionary[Keys.text.rawValue] as? String else { return nil }
        
        self.init(text: text)
    }
}
