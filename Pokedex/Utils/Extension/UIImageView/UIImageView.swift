//
//  UIImageView.swift
//  Pokedex
//
//  Created by Squad Apps on 07/11/23.
//

import Foundation
import UIKit

//https://www.youtube.com/watch?v=OTcQnf6ziew

extension UIImageView {
    func load(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        print(url)
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
