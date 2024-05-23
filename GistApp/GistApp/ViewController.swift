//
//  ViewController.swift
//  GistApp
//
//  Created by Joao Victor Flores da Costa on 23/05/24.
//

import CoreApi
import CoreApiInterface
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        RequestManager().makeRequest()
    }
}

