//
//  GistListCoordinator.swift
//  GistList
//
//  Created by Joao Victor Flores da Costa on 23/05/24.
//

protocol GistListCoordinatorProtocol {
    var viewController: GistListViewControllerProtocol? { get set }
}

class GistListCoordinator: GistListCoordinatorProtocol {
    var viewController: GistListViewControllerProtocol?
    
}
