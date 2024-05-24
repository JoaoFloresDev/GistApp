//
//  GistListInteractor.swift
//  GistList
//
//  Created by Joao Victor Flores da Costa on 23/05/24.
//

protocol GistListInteractorProtocol {
    func viewDidLoad()
}

class GistListInteractor {
    let service: GistListServiceProtocol
    let presenter: GistListPresenterProtocol
    
    init(
        service: GistListServiceProtocol,
        presenter: GistListPresenterProtocol
    ) {
        self.service = service
        self.presenter = presenter
    }
}

extension GistListInteractor: GistListInteractorProtocol {
    func viewDidLoad() {
        self.presenter.presentLoading()
        service.fetchData { result in
            switch result {
            case .success(let model):
                let modaa = model.map { gist in
                    let userName = gist.owner?.login
                    let userImageUrl = gist.owner?.avatarUrl
                    let filesAmount = "\(gist.files.count)"
                    return GistCellModel(userName: userName, userImageUrl: userImageUrl, filesAmount: filesAmount)
                }
                self.presenter.presentGists(data: modaa)
                
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
