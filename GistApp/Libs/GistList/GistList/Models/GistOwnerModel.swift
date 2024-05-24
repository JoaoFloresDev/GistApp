//
//  GistOwnerModel.swift
//  GistList
//
//  Created by Joao Victor Flores da Costa on 23/05/24.
//

import Foundation

struct GistOwnerModel: Decodable {
    let login: String?
    let id: Int?
    let nodeId: String?
    let avatarUrl: URL?
    let gravatarId: String?
    let url: String?
    let htmlUrl: String?
    let followersUrl: String?
    let followingUrl: String?
    let gistsUrl: String?
    let starredUrl: String?
    let subscriptionsUrl: String?
    let organizationsUrl: String?
    let reposUrl: String?
    let eventsUrl: String?
    let receivedEventsUrl: String?
    let type: String?
    let siteAdmin: Bool?
}
