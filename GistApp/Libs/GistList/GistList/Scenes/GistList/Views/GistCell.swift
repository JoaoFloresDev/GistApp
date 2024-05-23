//
//  GistCell.swift
//  GistList
//
//  Created by Joao Victor Flores da Costa on 23/05/24.
//

import UIKit
import SnapKit

class GistCell: UITableViewCell {
    static let identifier = "GistCell"
        
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: 20)
        
        return nameLabel
    }()
    
    private let filesLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: 17)
        
        return nameLabel
    }()
    
    private let avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.contentMode = .scaleToFill
        avatarImageView.layer.cornerRadius = 8
        avatarImageView.clipsToBounds = true
        
        return avatarImageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(filesLabel)
        contentView.addSubview(avatarImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(name: String, nFiles: Int, avatarImage: UIImage?) {
        nameLabel.text = name
        filesLabel.text = "\(nFiles) files"
        
        guard let avatarImage else { return }
        avatarImageView.image = avatarImage
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        nameLabel.text = nil
        filesLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        avatarImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalTo(16)
            $0.bottom.equalToSuperview().inset(8)
            $0.width.equalTo(48)
            $0.height.equalTo(48)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalTo(avatarImageView.snp.trailing).offset(16)
        }
        
        filesLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(8)
            $0.leading.equalTo(avatarImageView.snp.trailing).offset(16)
        }
    }
}

