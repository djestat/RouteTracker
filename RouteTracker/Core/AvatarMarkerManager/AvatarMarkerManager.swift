//
//  AvatarMarkerManager.swift
//  RouteTracker
//
//  Created by Igor on 17.05.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit

class AvatarMarkerManager {

    // MARK: - New
    let imageName: String = "avatar.png"
    
    private func getPath() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func rendererMask(_ image: UIImage) -> UIImage {
        let image = image
        let mask = UIImage(named: "start.png")!
        let size = CGSize(width: 60, height: 60)

        let renderer = UIGraphicsImageRenderer(size: size)
        let newImage = renderer.image { context in
                image.draw(in: CGRect(origin: .zero, size: size), blendMode: .normal, alpha: 1)
                mask.draw(in: CGRect(origin: .zero, size: size), blendMode: .destinationIn, alpha: 1)
        }
        return newImage
    }
    
    func saveAvatarToDisk(_ image: UIImage) {
        let size: Int = 50
        let newSize = CGSize(width: size, height: size)
        let resizedImage = image.resized(to: newSize)
        let imagePath = getPath().appendingPathComponent(imageName)
        if let jpegData = resizedImage.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
            print("saveAvatarToDisk")
            print(imagePath)
        }
    }
    
    func readAvatarFromDisk() -> UIImage? {
        let imagePath = getPath().appendingPathComponent(imageName)
        let filePath = imagePath.path
        guard let image = UIImage(contentsOfFile: filePath) else { return nil }
        let renderedImage = rendererMask(image)
        print("readAvatarFromDisk")
        print(filePath)
        return renderedImage
    }
}

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
