import UIKit
import SnapKit

protocol GistListViewControllerProtocol {
    
}

public class GistListViewController: UIViewController, GistListViewControllerProtocol {
    // MARK: - Variables
    private var dataSource = TableViewDataSource()
    var interactor: GistListInteractorProtocol
    
    // MARK: - Views
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
                self.dataSource.updateData(gistsArray: gistArray)
                self.tableView.reloadData()
            }
        }
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
