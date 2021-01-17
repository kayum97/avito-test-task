//
//  ProposalsService.swift
//  avito
//
//  Created by Admin on 29.12.2020.
//

import Foundation

class ProposalsService {
    func getAllInfo(completion: @escaping (ResultModel?) -> Void) {
        guard let localData = readLocalFile(forName: "results") else {
            completion(nil)
            return
        }
        completion(parseData(jsonData: localData))
    }
    
    private func readLocalFile(forName name: String) -> Data? {
        guard let bundleUrl = Bundle.main.url(forResource: name, withExtension: "json"),
              let jsonData = try? Data(contentsOf: bundleUrl) else { return nil }
        
        return jsonData
    }
    
    private func parseData(jsonData: Data) -> ResultModel? {
      guard let data = try? JSONDecoder().decode(AllInfo.self, from: jsonData) else { return nil }
        
        return data.result
    }
}
