//
//  FileCachedService.swift
//  Czechgram
//
//  Created by 최예주 on 2022/07/21.
//

import UIKit

class FileCachedService {

    static let shared = NSCache<NSString, NSData>()
    static let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first

    static func saveData(data: NSData, createdTime: Date) {
        shared.setObject(data, forKey: NSString(string: "\(createdTime)"))

        guard let pathURL = path else { return }
        let fileManager = FileManager()
        var filePath = URL(fileURLWithPath: pathURL)
        filePath.appendPathComponent("\(createdTime)")

        guard !fileManager.fileExists(atPath: filePath.path) else { return }

        fileManager.createFile(atPath: filePath.path, contents: data as Data)
    }

//    static func loadData(createdTime: Date) -> MediaImageEntity? {
//        guard let data = shared.object(forKey: NSString(string: "\(createdTime)")) else {
//
//            guard let pathURL = path else { return nil }
//            let fileManager = FileManager()
//            var filePath = URL(fileURLWithPath: pathURL)
//            filePath.appendPathComponent("\(createdTime)")
//
//            if fileManager.fileExists(atPath: filePath.path) {
//                guard let mediaImageEntity = try? Data(contentsOf: filePath) else { return nil }
//                let jsonConverter = JSONConverter<MediaImageEntity>()
//
//                return mediaImageEntity
//            }
//            else {
//                return nil
//            }
//        }
//        return data as? MediaImageEntity
//
//
//    }

}
