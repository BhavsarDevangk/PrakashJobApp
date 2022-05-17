//
//  ImagePickerController.swift
//  ProjectSetUp
//
//  Created by PSSPL on 17/05/22.
//

import UIKit
import PhotosUI

class ImagePickerController:NSObject {
    var configuration = PHPickerConfiguration()
    var limitforPickImage:Int = 0
    var picker:PHPickerViewController?
    var viewController:UIViewController?
    var selectedImage:selectedImage?
    
    func configureImagePicker() {
        configuration.filter = .any(of: [.livePhotos, .images])
        configuration.selectionLimit = limitforPickImage
        picker = PHPickerViewController(configuration: configuration)
        picker!.delegate = self
        picker!.modalPresentationStyle = .overFullScreen
        viewController?.present(picker!, animated: true, completion: nil)
    }
    
    func setUpResult(results:[PHPickerResult]) {
        for result in results {
            let provider = result.itemProvider
            if provider.canLoadObject(ofClass: UIImage.self) {
                 provider.loadObject(ofClass: UIImage.self) { (image, error) in
                     DispatchQueue.main.async {
                         if let image = image as? UIImage {
                             self.selectedImage!(image)
                         }
                     }
                }
             }
        }
    }
}
extension ImagePickerController:PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        viewController!.dismiss(animated: true)
        guard !results.isEmpty else { return }
    }
}
