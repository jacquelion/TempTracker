//
//  TTManager.swift
//  TempTracker
//
//  Created by Jacqueline Sloves on 3/20/20.
//  Copyright © 2020 Jacqueline Sloves. All rights reserved.
//

import Foundation

class TTCacheManager {

    static let shared: TTCacheManager = TTCacheManager()
    
    private var dataCache = NSCache<NSString, TTTempRecord>()

    private init() {
        // no-op
    }

    func loadHistory(userId: String, completion: @escaping (TTTempRecord?) -> Void) {

        if let cachedLocation = dataCache.object(forKey: userId as NSString) {
            completion(cachedLocation)
            return
        } else {
            return
        }
    }
}
