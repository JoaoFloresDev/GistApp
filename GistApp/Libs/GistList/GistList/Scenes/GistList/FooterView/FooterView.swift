//
//  FooterView.swift
//  GistList
//
//  Created by Joao Victor Flores da Costa on 26/05/24.
//

import UIKit

class FooterView: UIView {
    private lazy var stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var nextButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .red
        button.setTitle(">", for: .normal)
        return button
    }()
    
    private lazy var previousButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("<", for: .normal)
        return button
    }()
    
    private lazy var pageText: UILabel = {
       let label = UILabel()
        label.backgroundColor = .blue
        label.textAlignment = .center
        label.text = "0"
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setupViewHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViewHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubview(previousButton)
        stackView.addArrangedSubview(pageText)
        stackView.addArrangedSubview(nextButton)
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
