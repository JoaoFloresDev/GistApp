//
//  GistFileModel.swift
//  GistList
//
//  Created by Joao Victor Flores da Costa on 23/05/24.
//

import Foundation

struct GistFileModel: Decodable {
    let filename: String?
    let type: String?
    let language: String?
    let rawUrl: String?
    let size: Int?
}
