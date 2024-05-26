//
//  GistListInteractor.swift
//  GistList
//
//  Created by Joao Victor Flores da Costa on 23/05/24.
//

protocol GistListInteractorProtocol {
    func populateGists()
    func gistSelected(index: Int)
    func showPreviousPage()
    func showNextPage()
}

final class GistListInteractor {
    let service: GistListServiceProtocol
    let presenter: GistListPresenterProtocol
    var model: [GistModel] = []
    var currentIndex = 0
    
    init(
        service: GistListServiceProtocol,
        presenter: GistListPresenterProtocol
    ) {
        self.service = service
        self.presenter = presenter
    }
    
    private func convertToGistCellModel(gistModel: [GistModel]) -> [GistCellModel] {
        gistModel.map {
            GistCellModel(
                userName: $0.owner?.login,
                userImageUrl: $0.owner?.avatarUrl,
                filesAmount: "Files: \($0.files.count)")
        }
    }
}

extension GistListInteractor: GistListInteractorProtocol {
    func showPreviousPage() {
        guard currentIndex > 0 else {
            return
        }
        currentIndex -= 1
        presenter.presentCurrentPage(index: currentIndex)
        populateGistsPage(index: currentIndex)
    }
    
    func showNextPage() {
        currentIndex += 1
        presenter.presentCurrentPage(index: currentIndex)
        populateGistsPage(index: currentIndex)
    }
    
    func gistSelected(index: Int) {
        guard index < model.count else {
            return
        }
        presenter.presentGistDetail(model: model[index])
    }
    
    func populateGists() {
        populateGistsPage()
    }
    
    func populateGistsPage(index: Int = 0) {
        self.presenter.presentLoading()
        
        service.fetchData(index: index) { result in
            switch result {
            case .success(let model):
                self.model = model
                let gistModelCellArray = self.convertToGistCellModel(gistModel: model)
                self.presenter.presentGists(data: gistModelCellArray)
                
            case .failure(let error):
                self.presenter.presentError(title: "Erro", subtitle: error.localizedDescription, buttonText: "Tentar novamente")
                
            case .failure(NetworkError.emptyData):
                self.presenter.presentError(title: "Erro", subtitle: "emptyData", buttonText: "Tentar novamente")
                
            case .failure(NetworkError.decodingFailed):
                self.presenter.presentError(title: "Erro", subtitle: "decodingFailed", buttonText: "Tentar novamente")
            }
        }
    }
}
