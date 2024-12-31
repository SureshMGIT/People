//
//  CacheManager.swift
//  People
//
//  Created by Suresh M on 31/12/24.
//

import Foundation
import UIKit

final class CacheManager {
    let cache: NSCache<NSString, NSData> = {
        let cacheObj = NSCache<NSString, NSData>()
        cacheObj.countLimit = 1000
        return cacheObj
    }()
    
    func downloadImage(path: String, indexpath: IndexPath? = nil, compltion: @escaping (UIImage?, IndexPath?) -> Void) {
        if let imageData = cache.object(forKey: NSString(string: path)) {
            compltion(UIImage(data: Data(imageData)), indexpath)
            return
        }
        Task {
            let data = await NetworkManager().downloadImage(path: path)
            DispatchQueue.main.async { [weak self] in
                if let data {
                    self?.cache.setObject(NSData(data: data), forKey: NSString(string: path))
                    compltion(UIImage(data: Data(data)), indexpath)
                } else {
                    compltion(nil, indexpath)
                }
            }
        }
    }
}
