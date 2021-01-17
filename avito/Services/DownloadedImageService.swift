//
//  DownloadedImageService.swift
//  avito
//
//  Created by Admin on 09.01.2021.
//

import Foundation
import UIKit

class DownloadedImageService {
    static let shared = DownloadedImageService()
    private var imagesCache = [String: Data]()
    
    func downloadImage(withURL url: URL, completion: @escaping (Data?) -> Void) {
        if let data = imagesCache[url.absoluteString] {
            completion(data)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                completion(nil)
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print(httpStatus.statusCode)
            }
            completion(data)
        }
        task.resume()
    }
}
