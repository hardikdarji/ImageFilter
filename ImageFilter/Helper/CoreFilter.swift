//
//  CoreFilter.swift
//  ImageFilter
//
//  Created by ilumi Solutions on 7/29/23.
//

import UIKit

struct CoreFilter {
    static func applyColors(_ image: UIImage, name: ColorControls, value: Float) -> UIImage? {
        // Create a CIImage from the input image
        guard let ciImage = CIImage(image: image) else {
            return nil
        }
        
        // Apply the CIColorControls filter to adjust brightness
        let filter = CIFilter(name: "CIColorControls")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        filter?.setValue(value, forKey: name.key)
        
        // Get the filtered CIImage
        guard let outputCIImage = filter?.outputImage else {
            return nil
        }
        
        // Convert the filtered CIImage to a UIImage and return it
        let context = CIContext(options: nil)
        guard let outputCGImage = context.createCGImage(outputCIImage, from: outputCIImage.extent) else {
            return nil
        }
        let outputImage = UIImage(cgImage: outputCGImage, scale: image.scale, orientation: image.imageOrientation)
        return outputImage
    }

    static func applyBlurs(_ image: UIImage, name: ColorBlurs, intensity: Float) -> UIImage? {
        
        // Create a CIImage from the input image
        guard let ciImage = CIImage(image: image) else {
            return nil
        }
        
        // Apply the blur filter
        let filter = CIFilter(name: name.rawValue)
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        filter?.setValue(intensity, forKey: kCIInputRadiusKey) // Adjust the radius to control the blur intensity
        
        // Get the filtered CIImage
        guard let outputCIImage = filter?.outputImage else {
            return nil
        }
        
        // Convert the filtered CIImage to a UIImage and return it
        let context = CIContext(options: nil)
        guard let outputCGImage = context.createCGImage(outputCIImage, from: outputCIImage.extent) else {
            return nil
        }
        
        let outputImage = UIImage(cgImage: outputCGImage, scale: image.scale, orientation: image.imageOrientation)
        return outputImage
    }
}

