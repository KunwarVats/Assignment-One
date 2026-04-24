//
//  ImageCache.swift
//  Assignment-One
//
//  Created by Kunwar Vats on 23/04/26.
//

import Foundation
import UIKit

protocol ImageCacheProtocol {
    func set(_ image: UIImage, for key: String)
    func get(for key: String) -> UIImage?
    func remove(for key: String)
    func clear()
}

final class ImageCache: ImageCacheProtocol {
    
    private let cache = NSCache<NSString, UIImage>()
    
    func set(_ image: UIImage, for key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func get(for key: String) -> UIImage? {
        cache.object(forKey: key as NSString)
    }
    
    func remove(for key: String) {
        cache.removeObject(forKey: key as NSString)
    }
    
    func clear() {
        cache.removeAllObjects()
    }
}
