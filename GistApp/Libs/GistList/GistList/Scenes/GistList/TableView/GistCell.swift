import UIKit
import SnapKit

enum Spaces: Double {
    case base00 = 4
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
    let userImageUrl: URL?
    let filesAmount: String?
}

class GistCell: UITableViewCell {
    // MARK: - Views
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = Spaces.base02.value()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: .zero, height: 1)
        view.layer.shadowRadius = 4
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        nameLabel.numberOfLines = 0
        return nameLabel
    }()
    
    private lazy var filesLabel: UILabel = {
        let filesLabel = UILabel()
        filesLabel.font = .preferredFont(forTextStyle: .body)
        filesLabel.numberOfLines = 0
        return filesLabel
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.contentMode = .scaleToFill
        avatarImageView.layer.cornerRadius = Spaces.base03.value()
        avatarImageView.clipsToBounds = true
        return avatarImageView
    }()
    
    // MARK: - Initialization
    init(model: GistCellModel) {
        super.init(style: .default, reuseIdentifier: "\(type(of: self))")
        configure(with: model)
        setupViewHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        nameLabel.text = nil
        filesLabel.text = nil
    }
    
    // MARK: - Private Functions
    private func setupViewHierarchy() {
        contentView.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(filesLabel)
        containerView.addSubview(avatarImageView)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Spaces.base01.value())
            $0.top.bottom.equalToSuperview().inset(Spaces.base00.value())
        }
        
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
        
        fetchImage(from: model.userImageUrl) { [weak self] image in
            DispatchQueue.main.async {
                self?.avatarImageView.image = image
            }
        }
    }
    
    private func fetchImage(from url: URL?, completion: @escaping (UIImage?) -> Void) {
        guard let url = url else {
            completion(nil)
            return
        }
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
