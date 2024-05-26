//
//  FooterView.swift
//  GistList
//
//  Created by Joao Victor Flores da Costa on 26/05/24.
//

import UIKit

protocol FooterViewDelegate: AnyObject {
    func previousButtonPressed()
    func nextButtonPressed()
}

final class FooterView: UIView {
    // MARK: - Variables
    weak var delegate: FooterViewDelegate?
    
    // MARK: - Views
    private lazy var stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var nextButton: UIButton = {
      let button = UIButton()
      button.backgroundColor = .systemGray4
      button.setTitle(">", for: .normal)
      button.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)

      button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
      
      return button
    }()

    private lazy var previousButton: UIButton = {
      let button = UIButton()
      button.backgroundColor = .systemGray4
      button.setTitle("<", for: .normal)
      button.addTarget(self, action: #selector(previousButtonPressed), for: .touchUpInside)

      button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
      
      return button
    }()
    
    private lazy var pageText: UILabel = {
       let label = UILabel()
        label.backgroundColor = .systemGray6
        label.textAlignment = .center
        label.text = "0"
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        backgroundColor = .systemGray6
        setupViewHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updatePage(index: Int) {
        pageText.text = "\(index)"
    }
    
    // MARK: - Private Functions
    private func setupViewHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubview(previousButton)
        stackView.addArrangedSubview(pageText)
        stackView.addArrangedSubview(nextButton)
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    @objc 
    private func nextButtonPressed() {
        delegate?.nextButtonPressed()
    }
    
    @objc 
    private func previousButtonPressed() {
        delegate?.previousButtonPressed()
    }
}
