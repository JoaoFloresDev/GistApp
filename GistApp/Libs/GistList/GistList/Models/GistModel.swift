//
//  GistModel.swift
//  GistList
//
//  Created by Joao Victor Flores da Costa on 23/05/24.
//

import Foundation

struct GistModel: Decodable {
    let url: String?
    let forksUrl: String?
    let commitsUrl: String?
    let id: String?
    let nodeId: String?
    let gitPullUrl: String?
    let gitPushUrl: String?
    let htmlUrl: String?
    let files: [String: GistFileModel]
    let isPublic: Bool?
    let createdAt: String?
    let updatedAt: String?
    let description: String?
    let comments: Int?
    let user: String?
    let commentsUrl: String?
    let owner: GistOwnerModel?
    let truncated: Bool?
}
