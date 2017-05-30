//
//  PhotosManager.swift
//  ClassicPhotos
//
//  Created by Papoj Thamjaroenporn on 5/30/17.
//  Copyright © 2017 Papoj Thamjaroenporn. All rights reserved.
//

import Foundation


class PhotosManager {
    static var shared = PhotosManager()      // Singletons are thread-safe.
    
    // For thread-safe getting and setting of photos
    fileprivate let photoQueue =
        DispatchQueue(label: "com.laksg.concurrency.photosManagerQueue", attributes: .concurrent)
    
    fileprivate var _photos: [PhotoRecord] = []
    var photos: [PhotoRecord] {
        var threadSafePhotos: [PhotoRecord]!
        photoQueue.sync {
            threadSafePhotos = self._photos
        }
        return threadSafePhotos
    }
    
    func addPhoto(_ photo: PhotoRecord) {
        photoQueue.async(flags: .barrier) {
            self._photos.append(photo)
        }
    }
}
