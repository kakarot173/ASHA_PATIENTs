//
//  DotRecordsImagePicker+Photos+Camera+extension.swift
//  Dot_Health_1
//
//  Created by Animesh Mohanty on 04/08/20.
//  Copyright © 2020 Animesh Mohanty. All rights reserved.
//

import Foundation
import Photos
import UIKit
extension DotRecordsViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate, UNUserNotificationCenterDelegate{

func displayUploadImageDialog(btnSelected: UIButton) {
    let picker = UIImagePickerController()
    picker.delegate = self
    picker.allowsEditing = true
    let alertController = UIAlertController(title: "", message: "Upload profile photo?".localized, preferredStyle: .actionSheet)
    let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel action"), style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
        alertController.dismiss(animated: true) {() -> Void in }
    })
    alertController.addAction(cancelAction)
    let cameraRollAction = UIAlertAction(title: NSLocalizedString("Open library".localized, comment: "Open library action"), style: .default, handler: {(_ action: UIAlertAction) -> Void in
        if UI_USER_INTERFACE_IDIOM() == .pad {
            OperationQueue.main.addOperation({() -> Void in
                picker.sourceType = .photoLibrary
                self.present(picker, animated: true) {() -> Void in }
            })
        }
        else {
            picker.sourceType = .camera
            self.present(picker, animated: true) {() -> Void in }
        }
    })
    alertController.addAction(cameraRollAction)
    alertController.view.tintColor = .black
    present(alertController, animated: true) {() -> Void in }
}

func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    let image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as! UIImage
//    profileImage.image = image
    let imageData = image.jpegData(compressionQuality: 0.05)
    let images = image.pngData()
    self.dismiss(animated: true, completion: nil)
}

func checkPermission() {
    let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
    switch authStatus {
    case .authorized:
        self.displayUploadImageDialog(btnSelected: self.downButton)
    case .denied:
        print("Error")
    default:
        break
    }
}

func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    self.dismiss(animated: true, completion: nil)
}

func checkLibrary() {
    let photos = PHPhotoLibrary.authorizationStatus()
    if photos == .authorized {
        switch photos {
        case .authorized:
            self.displayUploadImageDialog(btnSelected: self.downButton)
        case .denied:
            print("Error")
        default:
            break
        }
    }
}
}
