import UIKit
import SnapKit

enum Spaces: Double {
    case base01 = 8
    case base02 = 16
    case base03 = 24
    case base04 = 32
    case base05 = 40
    case base06 = 48
    case base07 = 56
    case base08 = 64
    case base09 = 72
    case base10 = 80
    
    func value() -> Double {
        return self.rawValue
    }
}

struct GistCellModel {
    let userName: String?
    let userImageUrl: String?
    let filesAmount: String?
}

class GistCell: UITableViewCell {
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.boldSystemFont(
            ofSize: UIFont.preferredFont(forTextStyle: .subheadline).pointSize
        )
        nameLabel.numberOfLines = 0
        return nameLabel
    }()
    
    private let filesLabel: UILabel = {
        let filesLabel = UILabel()
        filesLabel.font = .preferredFont(forTextStyle: .body)
        filesLabel.numberOfLines = 0
        return filesLabel
    }()
    
    private let avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.contentMode = .scaleToFill
        avatarImageView.layer.cornerRadius = Spaces.base03.value()
        avatarImageView.clipsToBounds = true
        return avatarImageView
    }()
    
    init(model: GistCellModel) {
        super.init(style: .default, reuseIdentifier: "\(type(of: self))")
        setupViews()
        configure(with: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(filesLabel)
        contentView.addSubview(avatarImageView)
        
        avatarImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Spaces.base02.value())
            $0.top.equalToSuperview().offset(Spaces.base01.value())
            $0.width.height.equalTo(Spaces.base06.value())
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Spaces.base01.value())
            $0.leading.equalTo(avatarImageView.snp.trailing).offset(Spaces.base02.value())
            $0.trailing.equalToSuperview().inset(Spaces.base02.value())
        }
        
        filesLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(Spaces.base01.value())
            $0.leading.equalTo(avatarImageView.snp.trailing).offset(Spaces.base02.value())
            $0.trailing.equalToSuperview().inset(Spaces.base02.value())
            $0.bottom.equalToSuperview().inset(Spaces.base01.value())
        }
    }
    
    private func configure(with model: GistCellModel) {
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
