//
//  Spaces.swift
//  GistList
//
//  Created by Joao Victor Flores da Costa on 26/05/24.
//

import Foundation

enum Spaces: Double {
    case base00 = 4
    case base01 = 8
    case base02 = 16
    case base03 = 24
    case base04 = 32
    case base05 = 40
    case base06 = 48
    case base07 = 56
    case base08 = 64
    case base09 = 72
    case base10 = 80
    
    func value() -> Double {
        return self.rawValue
    }
}
