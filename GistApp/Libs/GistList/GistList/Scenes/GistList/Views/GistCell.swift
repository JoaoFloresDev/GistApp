import UIKit
import SnapKit

struct GistCellModel {
    let userName: String?
    let userImageUrl: String?
    let filesAmount: String?
}

class GistCell: UITableViewCell {
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = .preferredFont(forTextStyle: .subheadline)
        nameLabel.numberOfLines = 0 // Permite múltiplas linhas
        return nameLabel
    }()
    
    private let filesLabel: UILabel = {
        let filesLabel = UILabel()
        filesLabel.font = .preferredFont(forTextStyle: .body)
        filesLabel.numberOfLines = 0 // Permite múltiplas linhas
        return filesLabel
    }()
    
    private let avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.contentMode = .scaleToFill
        avatarImageView.layer.cornerRadius = 24
        avatarImageView.clipsToBounds = true
        avatarImageView.backgroundColor = .red
        return avatarImageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(filesLabel)
        contentView.addSubview(avatarImageView)
        
        avatarImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(8)
            $0.width.height.equalTo(48)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalTo(avatarImageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        filesLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.leading.equalTo(avatarImageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(8)
        }
    }
    
    func configure(with model: GistCellModel) {
        nameLabel.text = model.userName
        filesLabel.text = model.filesAmount
        avatarImageView.image = nil
        
        if let urlString = model.userImageUrl, let url = URL(string: urlString) {
            fetchImage(from: url) { [weak self] image in
                DispatchQueue.main.async {
                    self?.avatarImageView.image = image
                }
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        nameLabel.text = nil
        filesLabel.text = nil
    }
    
    private func fetchImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        }
        task.resume()
    }
}
