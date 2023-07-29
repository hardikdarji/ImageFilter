//
//  ImagePicker.swift
//  ImageFilter
//
//  Created by Hardik Darji on 7/29/23.
//

import UIKit
//MARK: IMAGE PICKER FUNCS
class ImagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    typealias completionHandler = (_ image:UIImage?) -> Void

    static var shared = ImagePicker()
    private override init() {}
    
    private var completion: completionHandler?
    
    //create block to make return piker image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {            
            completion?(image)
        }

        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        completion?(nil)
        picker.dismiss(animated: true, completion: nil)
    }
    
    //MARK: SHOW IMAGE PICKER OPTIONS
    func showImagePicker(_ inView: UIViewController,
                         completion: @escaping completionHandler) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        self.completion = completion
        // Choose camera or photo
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
                imagePickerController.sourceType = .camera
                inView.present(imagePickerController, animated: true, completion: nil)
            }))
        }

        actionSheet.addAction(UIAlertAction(title: "Choose from Library", style: .default, handler: { _ in
            imagePickerController.sourceType = .photoLibrary
            inView.present(imagePickerController, animated: true, completion: nil)
        }))

        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        inView.present(actionSheet, animated: true, completion: nil)
    }
}
