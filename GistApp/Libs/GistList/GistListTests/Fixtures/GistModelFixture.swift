//
//  GistModelFixture.swift
//  GistListTests
//
//  Created by Joao Victor Flores da Costa on 26/05/24.
//

@testable import GistList

extension GistModel {
    static func fixture(
        url: String? = nil,
        forksUrl: String? = nil,
        commitsUrl: String? = nil,
        id: String? = nil,
        nodeId: String? = nil,
        gitPullUrl: String? = nil,
        gitPushUrl: String? = nil,
        htmlUrl: String? = nil,
        files: [String: GistFileModel] = [:],
        isPublic: Bool? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil,
        description: String? = nil,
        comments: Int? = nil,
        user: String? = nil,
        commentsUrl: String? = nil,
        owner: GistOwnerModel? = nil,
        truncated: Bool? = nil
    ) -> GistModel {
        return GistModel(
            url: url,
            forksUrl: forksUrl,
            commitsUrl: commitsUrl,
            id: id,
            nodeId: nodeId,
            gitPullUrl: gitPullUrl,
            gitPushUrl: gitPushUrl,
            htmlUrl: htmlUrl,
            files: files,
            isPublic: isPublic,
            createdAt: createdAt,
            updatedAt: updatedAt,
            description: description,
            comments: comments,
            user: user,
            commentsUrl: commentsUrl,
            owner: owner,
            truncated: truncated
        )
    }
}

extension GistOwnerModel {
    static func fixture(
        login: String? = nil,
        id: Int? = nil,
        nodeId: String? = nil,
        avatarUrl: URL? = nil,
        gravatarId: String? = nil,
        url: String? = nil,
        htmlUrl: String? = nil,
        followersUrl: String? = nil,
        followingUrl: String? = nil,
        gistsUrl: String? = nil,
        starredUrl: String? = nil,
        subscriptionsUrl: String? = nil,
        organizationsUrl: String? = nil,
        reposUrl: String? = nil,
        eventsUrl: String? = nil,
        receivedEventsUrl: String? = nil,
        type: String? = nil,
        siteAdmin: Bool? = nil
    ) -> GistOwnerModel {
        return GistOwnerModel(
            login: login,
            id: id,
            nodeId: nodeId,
            avatarUrl: avatarUrl,
            gravatarId: gravatarId,
            url: url,
            htmlUrl: htmlUrl,
            followersUrl: followersUrl,
            followingUrl: followingUrl,
            gistsUrl: gistsUrl,
            starredUrl: starredUrl,
            subscriptionsUrl: subscriptionsUrl,
            organizationsUrl: organizationsUrl,
            reposUrl: reposUrl,
            eventsUrl: eventsUrl,
            receivedEventsUrl: receivedEventsUrl,
            type: type,
            siteAdmin: siteAdmin
        )
    }
}
