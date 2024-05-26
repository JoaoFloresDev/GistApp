//
//  UIImage+Extension.swift
//  GistList
//
//  Created by Joao Victor Flores da Costa on 26/05/24.
//

import UIKit

extension UIImageView {
    func fetchImage(from url: URL?) {
        guard let url = url else {
            return
        }
        DispatchQueue.global().async {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil, let image = UIImage(data: data) else {
                    return
                }
                DispatchQueue.main.async {
                    self.image = image
                }
            }
            task.resume()
        }
    }
}

