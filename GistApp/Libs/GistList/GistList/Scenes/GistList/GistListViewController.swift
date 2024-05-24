import UIKit
import SnapKit

struct ErrorModel {
    let title: String
    let subtitle: String?
    let buttonText: String
}

protocol GistListViewControllerProtocol {
    func displayGists(data: [GistCellModel])
    func displayError(model: ErrorModel)
    func displayLoading()
}

public class GistListViewController: UIViewController {
    // MARK: - Variables
    private var dataSource = TableViewDataSource()
    var interactor: GistListInteractorProtocol
    
    // MARK: - Views
    private lazy var loadingAlert: UIAlertController = {
        let alert = UIAlertController(title: "", message: nil, preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(50)
        }
        
        alert.view.snp.makeConstraints { make in
            make.width.height.equalTo(80)
        }
        
        alert.view.backgroundColor = .clear
        alert.view.layer.cornerRadius = 10
        
        return alert
    }()
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .yellow
        return tableView
    }()

    // MARK: - Initialization
    init(interactor: GistListInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        title = "GistApp"
        setupViewHierarchy()
        setupConstraints()
        fetchFruits()
        displayLoading()
    }
    
    // MARK: - Private Functions
    private func setupViewHierarchy() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func fetchFruits() {
        DispatchQueue.global().async {
            sleep(1)
            let gistArray: [GistCellModel] = [
                .init(userName: "userName", userImageUrl: URL(string: "https://avatars.githubusercontent.com/u/120196790?v=4"), filesAmount: "filesAmount"),
                .init(userName: "userName", userImageUrl: URL(string: "https://avatars.githubusercontent.com/u/120196790?v=4"), filesAmount: "filesAmount"),
                .init(userName: "userName", userImageUrl: URL(string: "https://avatars.githubusercontent.com/u/120196790?v=4"), filesAmount: "filesAmount"),
                .init(userName: "userName", userImageUrl: URL(string: "https://avatars.githubusercontent.com/u/120196790?v=4"), filesAmount: "filesAmount"),
                .init(userName: "userName", userImageUrl: URL(string: "https://avatars.githubusercontent.com/u/120196790?v=4"), filesAmount: "filesAmount"),
            ]
            DispatchQueue.main.async {
                self.dataSource.update(data: gistArray)
                self.tableView.reloadData()
            }
        }
    }
}

extension GistListViewController: GistListViewControllerProtocol {
    func displayGists(data: [GistCellModel]) {
        loadingAlert.dismiss(animated: true)
        
        DispatchQueue.main.async {
            self.dataSource.update(data: data)
            self.tableView.reloadData()
        }
    }
    
    func displayError(model: ErrorModel) {
        let alert = UIAlertController(title: model.title, message: model.subtitle, preferredStyle: .alert)
        
        let buttonTitle = model.buttonText
        let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
            
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func displayLoading() {
        present(loadingAlert, animated: true, completion: nil)
    }
}

extension GistListViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let fruit = dataSource.getDataFor(index: indexPath.row)
        print("Selected fruit: \(fruit)")
        let alert = UIAlertController(title: "Fruit Selected", message: "You selected \(fruit)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
