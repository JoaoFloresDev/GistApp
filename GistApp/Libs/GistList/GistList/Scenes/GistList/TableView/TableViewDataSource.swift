//
//  TableViewDataSource.swift
//  GistList
//
//  Created by Joao Victor Flores da Costa on 23/05/24.
//

import UIKit
protocol TableDataProtocol {
    func update(data: [GistCellModel])
    func getDataFor(index: Int) -> GistCellModel
}

typealias TableViewDataSourceProtocol = NSObject & UITableViewDataSource & TableDataProtocol
class TableViewDataSource: TableViewDataSourceProtocol {
    // MARK: - Variables
    private var data: [GistCellModel] = []
    
    // MARK: - Internal Methods
    func update(data: [GistCellModel]) {
        self.data = data
    }
    
    func getDataFor(index: Int) -> GistCellModel {
        data[index]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        GistCell(model: data[indexPath.row])
    }
}
