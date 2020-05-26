//
//  ViewController+ImagePicker.swift
//  ios-MemeMe-v1.0
//
//  Created by Abdullah Khayat on 5/17/20.
//  Copyright © 2020 Team IOS. All rights reserved.
//

import Foundation
import UIKit

extension MemeEditorVC {
    
    func setImgPicker(_ sourceType: UIImagePickerController.SourceType) {
        
        // define imagePicker
        let imagePicker = UIImagePickerController()
        
        // assign delegate
        imagePicker.delegate = self
        
        // decide source based on the button
        imagePicker.sourceType = sourceType
        
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    // the user picked an image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // sets the image view to the selected image
        if let image = info[.originalImage] as? UIImage {
            memeImgView.image = image
            dismiss(animated: true, completion: nil)
        }
        
        shareBTN.isEnabled = true
        
    }
    
    // the user has cancelled
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
