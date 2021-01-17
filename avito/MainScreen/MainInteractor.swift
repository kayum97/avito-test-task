//
//  MainInteractor.swift
//  avito
//
//  Created by Admin on 13.01.2021.
//

import Foundation

protocol MainInteractorProtocol: class {
    func getAllProposals(completion: @escaping (ResultModel?) -> Void)
}

class MainInteractor: MainInteractorProtocol {
    private var service =  ProposalsService()

    func getAllProposals(completion: @escaping (ResultModel?) -> Void) {
        service.getAllInfo(completion: completion)
    }
}
