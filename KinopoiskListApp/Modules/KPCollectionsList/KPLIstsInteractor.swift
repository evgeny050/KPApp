//
//  KPCollectionLIstInteractor.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 17.04.2024.
//
//  This file was generated by the 🐍 VIPER generator
//

final class KPListsInteractor: KPListsInteractorInputProtocol {
    private unowned let presenter: KPListsInteractorOutputProtocol
    private let category: String
    
    required init(presenter: KPListsInteractorOutputProtocol, and category: String) {
        self.presenter = presenter
        self.category = category
    }
    
    func fetchData() {
        NetworkingManager.shared.fetchDataFaster(
            type: KPListSection.self,
            parameters: [
                "limit": ["250"],
                "notNullFields": ["cover.url"],
                "category": [category]
            ]
            
        ) { [unowned self] result in
            switch result {
            case .success(let value):
                let dataStore = CommonDataStore(kpLists: value.docs)
                presenter.didReceiveData(with: dataStore, and: category)
            case .failure(let error):
                print(error)
            }
        }
    }
}