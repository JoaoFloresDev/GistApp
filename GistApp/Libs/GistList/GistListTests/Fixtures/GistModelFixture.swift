//
//  GistModelFixture.swift
//  GistListTests
//
//  Created by Joao Victor Flores da Costa on 26/05/24.
//

@testable import GistList

extension GistModel {
    static func emptyFixture() -> GistModel {
        return GistModel(
            url: nil,
            forksUrl: nil,
            commitsUrl: nil,
            id: nil,
            nodeId: nil,
            gitPullUrl: nil,
            gitPushUrl: nil,
            htmlUrl: nil,
            files: [:],
            isPublic: nil,
            createdAt: nil,
            updatedAt: nil,
            description: nil,
            comments: nil,
            user: "user",
            commentsUrl: nil,
            owner: nil,
            truncated: nil
        )
    }
}
