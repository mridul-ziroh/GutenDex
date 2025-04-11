//
//  ImageCache.swift
//  GutenDex
//
//  Created by mridul-ziroh on 11/04/25.
//

import SwiftUI

final class ImageCache {
    static let shared = ImageCache()
    private init() {}
    
    private var cache = Dictionary<Int, Image>()
    
    func image(forKey key: Int) -> Image? {
        cache[key]
    }
    
    func set(_ image: Image, forKey key: Int) {
        cache[key] = image
    }
    
    func clear() {
        cache.removeAll()
    }
}
