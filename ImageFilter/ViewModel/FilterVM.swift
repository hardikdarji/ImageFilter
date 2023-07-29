//
//  FilterVM.swift
//  TestImage
//
//  Created by Hardik Darji on 7/18/23.
//


import UIKit
protocol FilterVMDelegate {
    func originalImgDataChange()
}
class FilterVM {
    var filterVMDelegate: FilterVMDelegate?
    var arrFiter = [FilterElement(.GaussianBlur),
                    FilterElement(.BoxBlur),
                    FilterElement(.Brightness),
                    FilterElement(.Saturation),
                    FilterElement(.Contrast)]
    
    //Hold original image data
    var originImgData: Data? {
        didSet {
            self.filterVMDelegate?.originalImgDataChange()
        }
    }
    
    func showErrorMsg() -> String
    {
        return "Take Photo or Choose from Library to apply filters"
    }
    
    //STORE FILTER VAL, to be remembered
    func storeFilterVal(filter: FitersName,
                        filterVal: Float) {
    
        let index = Int(filter.rawValue)
        self.arrFiter[index].value = filterVal
    }
    func applyFilter( imgData: Data?,
                      filter: FitersName,
                      filterVal: Float,
                     completionWithSuccess: (_ img: UIImage?) -> Void,
                     failure: (_ error: Error?) -> Void)
    {
        guard let data = imgData,
              let imgsample = UIImage(data: data)
        else {
            failure(nil)
            return
        }
        
        var img: UIImage?
        switch filter  {
        case .GaussianBlur:
            img  = CoreFilter.applyBlurs(imgsample, name: .Gaussian, intensity: filterVal * 10) // Range from 0.0 to 10.0
        case .BoxBlur:
            img = CoreFilter.applyBlurs(imgsample, name: .Box, intensity: filterVal * 10) // Range from 0.0 to 10.0
        case .Brightness:
            img = CoreFilter.applyColors(imgsample, name: .Brightness, value: filterVal) // Range from 0.0 to 1.0
        case .Saturation:
            img = CoreFilter.applyColors(imgsample, name: .Saturation, value: filterVal * 2.0) // Range from 0.0 to 2.0
        case .Contrast:
            img = CoreFilter.applyColors(imgsample, name: .Contrast, value: filterVal * 4.0) // Range from 0.0 to 4.0
            
        }
        if let img = img
        {
            completionWithSuccess(img)
        }
        else
        {
            failure(nil)
        }
    }
}
