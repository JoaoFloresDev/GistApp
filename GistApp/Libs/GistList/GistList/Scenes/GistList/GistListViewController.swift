//
//  GistListViewController.swift
//  GistList
//
//  Created by Joao Victor Flores da Costa on 23/05/24.
//

import UIKit
import SnapKit

public class GistListViewController: UIViewController {
    var text = UILabel()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        text.text = "aaaaa"
        view.addSubview(text)
        text.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}
