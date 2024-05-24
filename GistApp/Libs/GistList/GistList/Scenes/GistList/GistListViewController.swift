import UIKit
import SnapKit


public class GistListViewController: UIViewController {
    // MARK: - Variables
    private var dataSource = TableViewDataSource()
    
    // MARK: - Views
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        return tableView
    }()

    // MARK: - Initialization
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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

class TableViewDataSource: NSObject, UITableViewDataSource {
    // MARK: - Variables
    private var gistsArray: [GistCellModel] = []
    
    // MARK: - Internal Methods
    func updateData(gistsArray: [GistCellModel]) {
        self.gistsArray = gistsArray
    }
    
    func getDataFor(index: Int) -> GistCellModel {
        gistsArray[index]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gistsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        GistCell(model: gistsArray[indexPath.row])
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
