//
//  MainBuilder.swift
//  avito
//
//  Created by Admin on 14.01.2021.
//

import Foundation
import UIKit

class MainBuilder {
    
    func build() -> UIViewController? {
        let mainViewController = MainViewController()
        let interactor = MainInteractor()
        let router = MainRouter(viewController: mainViewController)
        let presenter = MainPresenter(view: mainViewController, interactor: interactor, router: router)
        
        mainViewController.presenter = presenter
        
        return mainViewController
    }
}
