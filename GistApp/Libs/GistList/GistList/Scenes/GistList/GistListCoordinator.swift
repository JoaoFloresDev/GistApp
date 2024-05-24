//
//  GistListCoordinator.swift
//  GistList
//
//  Created by Joao Victor Flores da Costa on 23/05/24.
//

import UIKit

protocol GistListCoordinatorProtocol {
    var viewController: UIViewController? { get set }
    func openGistDetail(model: GistModel)
}

class GistListCoordinator: GistListCoordinatorProtocol {
    weak var viewController: UIViewController?
    
    func openGistDetail(model: GistModel) {
        let controller = UIViewController()
        controller.view.backgroundColor = .yellow
        viewController?.present(controller, animated: true)
    }
}
