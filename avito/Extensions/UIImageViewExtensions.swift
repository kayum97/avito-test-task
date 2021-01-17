//
//  UIImageView.swift
//  avito
//
//  Created by Admin on 17.01.2021.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadImage(withURL url: URL?) {
        guard let url = url else {
            self.image = UIImage(systemName: "star")
            return
        }
        DownloadedImageService.shared.downloadImage(withURL: url) { [weak self] imageData  in
            DispatchQueue.main.async { [self] in
                if let imageData = imageData, let image = UIImage(data: imageData) {
                    self?.image = image
                } else {
                    self?.image = UIImage(systemName: "star")
                }
            }
        }
    }
}
