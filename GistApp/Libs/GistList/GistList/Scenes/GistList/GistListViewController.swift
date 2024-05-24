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
    private lazy var loadingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.2)
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        
        let loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.startAnimating()
        
        view.addSubview(loadingIndicator)
        
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        view.isHidden = true
        return view
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
        setupBackButton()
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
        view.addSubview(loadingView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        loadingView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(100)
        }
    }
    
    private func setupBackButton() {
        let backButton = UIBarButtonItem(title: "Voltar", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
    }
}

extension GistListViewController: GistListViewControllerProtocol {
    func displayGists(data: [GistCellModel]) {
        dataSource.update(data: data)
        DispatchQueue.main.async { [weak self] in
            self?.loadingView.isHidden = true
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
            self?.loadingView.isHidden = true
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    func displayLoading() {
        loadingView.isHidden = false
    }
}

extension GistListViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        interactor.gistSelected(index: indexPath.row)
    }
}
