//
//  FilterVC.swift
//  TestImage
//
//  Created by Hardik Darji on 7/17/23.
//

import UIKit

class FilterVC: UIViewController {
    //UI ELEMENTS...
    @IBOutlet weak var imageViewFiltered: UIImageView!
    @IBOutlet weak var filterSlider: UISlider!
    @IBOutlet weak var labelErrorMsg: UILabel!
    @IBOutlet weak var labelInfoMsg: UILabel!

    //ViewModel object
    var objFilterVM: FilterVM = FilterVM()
    
    //On change current Filter Index, apply filter
    var currentFilterInx: FitersName = .GaussianBlur {
        didSet{
            //TO RESTORE LAST VALUE IN SLIDER OF FILTER
            self.filterSlider.value = objFilterVM.arrFiter[Int(currentFilterInx.rawValue)].value
            self.filterAction()
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //SET DELEGATE
        self.objFilterVM.filterVMDelegate = self
        
        //INIT VALUES
        initSetup()
    }
}

//MARK: @IBOutlet UI ACTIONS..i.e. Button, Slider val change
extension FilterVC {
    
    // BUTTONS/ IBAction ACTIONS
    @IBAction func applyFilterTouched(_ sender: UIBarButtonItem) {
        showFilterOptions()
    }
    @IBAction func saveImageTouched(_ sender: UIBarButtonItem) {
        if let img = self.imageViewFiltered.image
        {
            saveImageToPhotosAlbum(img)
        }
    }

    @IBAction func ResetTouched(_ sender: UIBarButtonItem) {
        self.filterSlider.value = 0.0
        if let data = self.objFilterVM.originImgData
        {
            self.imageViewFiltered.image = UIImage(data: data)
        }
        self.setInfoTitle()
    }
    
    @IBAction func pickImageTouched(_ sender: UIBarButtonItem) {
        ImagePicker.shared.showImagePicker(self) { image in
            if let image = image
            {
                self.objFilterVM.originImgData = image.pngData()
            }
        }
    }
    //SLIDER CHANGE ACTION
    @IBAction func sliderChange(_ sender: UISlider) {
        filterAction()
    }
}

//Delegation pattern:
extension FilterVC: FilterVMDelegate {
    func originalImgDataChange() {
        self.filterAction()
        self.labelErrorMsg.text = ""
    }
}

//HELPER METHODS
extension FilterVC {
    func initSetup()
    {
        self.filterSlider.value = 0.0
        self.labelInfoMsg.text = ""
        
        if self.objFilterVM.originImgData == nil
        {
            self.labelErrorMsg.text = objFilterVM.showErrorMsg()
        }
        else
        {
            self.labelErrorMsg.text = ""
        }
        currentFilterInx = .GaussianBlur

    }
    func filterAction()
    {
        if let data = self.objFilterVM.originImgData
        {
            //RESTORE ORIGINAL BEFORE APPLY FILTER
            self.imageViewFiltered.image = UIImage(data: data)
            
            //Store value to be remember next time
            self.objFilterVM.storeFilterVal(filter: currentFilterInx, filterVal: self.filterSlider.value)
            
            //APPLY FILTER TO IMAGE
            self.objFilterVM.applyFilter(imgData: data,
                                         filter: currentFilterInx,
                                         filterVal: self.filterSlider.value) { img in
                
                //CODE IF SUCCESS
                if let image = img
                {
                    self.imageViewFiltered.image = image
                    self.setInfoTitle()
                }
            } failure: { error in
                //TODO SHOW ERROR MSG FROM ERROR
                labelErrorMsg.text = objFilterVM.showErrorMsg()
            }
        }
    }
    
   

    //MARK: SAVE IMAGE TO PHOTOS
    func saveImageToPhotosAlbum(_ image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(imageSaved(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    @objc func imageSaved(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeMutableRawPointer?) {
        
        if let error = error {
            // Handle the error condition, if any.
            let msg = "Image saving failed with error: \(error.localizedDescription)"
            let alert = UIAlertController(title: "Failed", message: msg, preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(dismiss)
            self.present(alert, animated: true, completion: nil)
            
        } else {
            let msg = "Image saved successfully to Photos library."
            let alert = UIAlertController(title: "Saved", message: msg, preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(dismiss)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: FILTER OPTIONS FUNCS
    func showFilterOptions()
    {
        let actionSheetController = UIAlertController(title: "Filter Options", message: "Please select filter option to apply", preferredStyle: .actionSheet)
        
        // Create and add the Cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            // dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        
        for option in self.objFilterVM.arrFiter {
            let filterAction = UIAlertAction(title: option.name.getStringValue(), style: .default) { action -> Void in
                if let title = action.title,
                   let filter = FitersName(stringValue: title)
                {
                    self.currentFilterInx = filter
                }
            }
            actionSheetController.addAction(filterAction)
        }
        // Present the AlertController
        self.present(actionSheetController, animated: true, completion: nil)
    }
    func setInfoTitle() {
        labelInfoMsg.text = "Current Filter: \(self.currentFilterInx.getStringValue())\n Value: \(self.filterSlider.value)"
    }
    
}
