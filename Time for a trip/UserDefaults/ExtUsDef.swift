//
//  ExtUsDef.swift
//  Time for a trip
//
//  Created by Евгений Житников on 15.05.2023.
//

import Foundation

extension UserDefaults {
    func saveLikeState(_ isLiked: Bool, for searchToken: String) {
        set(isLiked, forKey: searchToken)
    }
    
    func getLikeState(for searchToken: String) -> Bool {
        return bool(forKey: searchToken)
    }
}

