//
//  TableViewDataSource.swift
//  GistList
//
//  Created by Joao Victor Flores da Costa on 23/05/24.
//

import UIKit

typealias TableViewDataSourceProtocol = NSObject & UITableViewDataSource
class TableViewDataSource: TableViewDataSourceProtocol {
    // MARK: - Variables
    private var data: [GistCellModel] = []
    
    // MARK: - Internal Methods
    func update(data: [GistCellModel]) {
        self.data = data
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        GistCell(model: data[indexPath.row])
    }
}
