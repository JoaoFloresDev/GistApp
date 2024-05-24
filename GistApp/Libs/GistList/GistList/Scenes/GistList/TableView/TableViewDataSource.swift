//
//  TableViewDataSource.swift
//  GistList
//
//  Created by Joao Victor Flores da Costa on 23/05/24.
//

import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource {
    // MARK: - Variables
    private var gistArray: [GistCellModel] = []
    
    // MARK: - Internal Methods
    func updateData(gistsArray: [GistCellModel]) {
        self.gistArray = gistsArray
    }
    
    func getDataFor(index: Int) -> GistCellModel {
        gistArray[index]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gistArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        GistCell(model: gistArray[indexPath.row])
    }
}
