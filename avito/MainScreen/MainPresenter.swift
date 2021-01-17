//
//  MainPresenter.swift
//  avito
//
//  Created by Admin on 13.01.2021.
//

import Foundation

protocol MainPresenterProtocol: class {
    init(view: MainViewControllerProtocol, interactor: MainInteractorProtocol, router: MainRouterProtocol)
    func getAllProposals()
    func tapOnSubmitButton(proposals: [ProposalModel])
    func toContinueWithoutChanges()
}

class MainPresenter: MainPresenterProtocol {
    private weak var view: MainViewControllerProtocol?
    private let interactor: MainInteractorProtocol
    private let router: MainRouterProtocol
    
    required init(view: MainViewControllerProtocol, interactor: MainInteractorProtocol, router: MainRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func getAllProposals() {
        interactor.getAllProposals() { [weak self] data in
            guard let data = data else { return }
            self?.view?.showResult(data)
        }
    }
    
    func tapOnSubmitButton(proposals: [ProposalModel]) {
        let resultString: String = proposals
            .filter { $0.isSelected }
            .map { $0.title }
            .joined(separator: "\n")
        
        router.userChoiceAlert(resultString: resultString)
    }
    
    func toContinueWithoutChanges() {
        router.toContinueWithoutChanges()
    }
}
