//
//  GistListViewController.swift
//  GistList
//
//  Created by Joao Victor Flores da Costa on 23/05/24.
//

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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FruitCell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func fetchFruits() {
        // Simulando uma chamada assíncrona
        DispatchQueue.global().async {
            // Simulando um atraso de rede
            sleep(2)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "FruitCell", for: indexPath)
        cell.textLabel?.text = fruits[indexPath.row]
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
