//
//  ProductCellProtocol.swift
//  FiveStarShop
//
//  Created by Egor Ledkov on 20.08.2022.
//

import UIKit

protocol ProductCellProtocol {

}

extension ProductCellProtocol {
    func getImageURL(for article: String?) -> URL? {
        let link = NetworkManager.shared.getLink(.images) + (article ?? "") + ".jpg"
        guard let url = URL(string: link) else {
            print(NetworkError.invalidURL)
            return nil
        }
        return url
    }
    
    func getImage(from url: URL, completion: @escaping(Result<UIImage, Error>) -> Void) {
        // Загружаем из кэша
        if let cachedImage = ImageCacheManager.shared.object(forKey: url.lastPathComponent as NSString) {
            print("Image from cache: ", url.lastPathComponent)
            completion(.success(cachedImage))
            return
        }
        
        // Загружаем из сети
        NetworkManager.shared.fetchImage(from: url) { result in
            switch result {
            case .success(let imageData):
                guard let uiImage = UIImage(data: imageData) else { return }
                ImageCacheManager.shared.setObject(uiImage, forKey: url.lastPathComponent as NSString)
                print("Image form NET", url.lastPathComponent)
                completion(.success(uiImage))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
