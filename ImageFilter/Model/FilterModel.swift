//
//  FilterModel.swift
//  TestImage
//
//  Created by Hardik Darji on 7/28/23.
//
import UIKit

//ENUM TO FOR COLOR CONTROL
enum ColorControls: String {
    case Brightness, Saturation, Contrast
    var key: String {
        switch self {
        case .Brightness:
            return kCIInputBrightnessKey
        case .Saturation:
            return kCIInputSaturationKey
        case .Contrast:
            return kCIInputContrastKey
        }
    }
}
//ENUM FOR BLUR
enum ColorBlurs: String {
    case
    Gaussian = "CIGaussianBlur",
    Box = "CIBoxBlur"
}

//ACTIONS
enum FitersName: UInt8{
    case
    GaussianBlur,
    BoxBlur,
    Brightness,
    Saturation,
    Contrast
    
    func getStringValue() -> String {
        switch self {
        case .GaussianBlur:
            return "GaussianBlur"
        case .BoxBlur:
            return "BoxBlur"
        case .Brightness:
            return "Brightness"
        case .Saturation:
            return "Saturation"
        case .Contrast:
            return "Contrast"
        }
    }
    
    //GET FiltersName element from String value
    init?(stringValue: String) {
        switch stringValue {
        case "GaussianBlur":
            self = .GaussianBlur
        case "BoxBlur":
            self = .BoxBlur
        case "Brightness":
            self = .Brightness
        case "Saturation":
            self = .Saturation
        case "Contrast":
            self = .Contrast
        default:
            return nil
        }
    }
}

//FILTER ELLEMENT
struct FilterElement {
    var name: FitersName
    var value: Float
    init(_ name: FitersName, value: Float = 0.0) {
        self.name = name
        self.value = value
    }
}
