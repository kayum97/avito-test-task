//
//  MainRouter.swift
//  avito
//
//  Created by Admin on 17.01.2021.
//

import Foundation

protocol MainRouterProtocol: class {
    func userChoiceAlert(resultString: String)
    func toContinueWithoutChanges()
}

class MainRouter: MainRouterProtocol {
    weak var viewController: MainViewController!
    
    init(viewController: MainViewController) {
        self.viewController = viewController
    }
    
    func userChoiceAlert(resultString: String) {
        viewController.showSimpleAlert(title: "Выбранные услуги:", message: resultString)
    }
    
    func toContinueWithoutChanges() {
        //TODO переход на следующий экран
    }
}
