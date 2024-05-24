import UIKit
import SnapKit

struct GistDetailModel {
    let userName: String?
    let userImageUrl: URL?
}

protocol GistDetailsViewControllerProtocol: AnyObject {
    func displayGistDetail(data: GistDetailModel)
}

public class GistDetailsViewController: UIViewController {
    // MARK: - Variables
    var interactor: GistDetailsInteractorProtocol
    
    // MARK: - Views
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = Spaces.base02.value()
        stack.alignment = .center
        return stack
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = Spaces.base01.value()
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Initialization
    init(interactor: GistDetailsInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
        setupBackButton()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
//        interactor.populateGist()
        displayGistDetail(data: .init(userName: "userName", userImageUrl: URL(string: "https://avatars.githubusercontent.com/u/194955?v=4")))
        setupUI()
    }
    
    // MARK: - Private Functions
    private func setupBackButton() {
        let backItem = UIBarButtonItem()
        backItem.title = "Voltar"
        navigationItem.backBarButtonItem = backItem
    }
    
    private func setupUI() {
        title = "Gist Details"
        view.backgroundColor = .white
        setupViewHierarchy()
        setupConstraints()
    }
    
    private func setupViewHierarchy() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(nameLabel)
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.leading.top.equalTo(view.safeAreaLayoutGuide).offset(Spaces.base03.value())
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(Spaces.base03.value())
        }
        
        imageView.snp.makeConstraints {
            $0.height.width.equalTo(100)
        }
    }
}

extension GistDetailsViewController: GistDetailsViewControllerProtocol {
    func displayGistDetail(data: GistDetailModel) {
        nameLabel.text = data.userName
        
        if let url = data.userImageUrl {
            fetchImage(from: url) { [weak self] image in
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
        }
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
