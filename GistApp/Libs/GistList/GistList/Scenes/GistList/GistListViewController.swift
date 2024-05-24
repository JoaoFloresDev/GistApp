import UIKit
import SnapKit

struct ErrorModel {
    let title: String
    let subtitle: String?
    let buttonText: String
}

protocol GistListViewControllerProtocol: AnyObject {
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
        
        loadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        alert.view.snp.makeConstraints {
            $0.width.height.equalTo(80)
        }
        
        return alert
    }()
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
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
        interactor.populateGists()
        setupUI()
    }
    
    // MARK: - Private Functions
    private func setupUI() {
        title = "GistApp"
        view.backgroundColor = .white
        setupViewHierarchy()
        setupConstraints()
    }
    
    private func setupViewHierarchy() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension GistListViewController: GistListViewControllerProtocol {
    func displayGists(data: [GistCellModel]) {
        DispatchQueue.main.async { [weak self] in
            self?.loadingAlert.dismiss(animated: true)
            self?.dataSource.update(data: data)
            self?.tableView.reloadData()
        }
    }
    
    func displayError(model: ErrorModel) {
        let alert = UIAlertController(title: model.title, message: model.subtitle, preferredStyle: .alert)
        
        let buttonTitle = model.buttonText
        let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
            self.interactor.populateGists()
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        
        DispatchQueue.main.async { [weak self] in
            self?.loadingAlert.dismiss(animated: true) {
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func displayLoading() {
        present(loadingAlert, animated: true, completion: nil)
    }
}

extension GistListViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        interactor.gistSelected(index: indexPath.row)
    }
}
