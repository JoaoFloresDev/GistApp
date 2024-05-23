import UIKit
import SnapKit

public class GistListViewController: UIViewController {
    private let tableView = UITableView()
    private var fruits: [String] = []

    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        setupTableView()
        fetchFruits()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(GistCell.self, forCellReuseIdentifier: "GistCell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func fetchFruits() {
        DispatchQueue.global().async {
            sleep(1)
            let fetchedFruits = ["Apple", "Banana", "Cherry", "Date", "Elderberry", "Fig", "Grapes"]
            DispatchQueue.main.async {
                self.fruits = fetchedFruits
                self.tableView.reloadData()
            }
        }
    }
}

extension GistListViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GistCell", for: indexPath) as? GistCell else {
            return UITableViewCell()
        }
        let model = GistCellModel(userName: fruits[indexPath.row], userImageUrl: nil, filesAmount: "filesAmount")
        cell.configure(with: model)
        return cell
    }
}

extension GistListViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let fruit = fruits[indexPath.row]
        print("Selected fruit: \(fruit)")
        let alert = UIAlertController(title: "Fruit Selected", message: "You selected \(fruit)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
