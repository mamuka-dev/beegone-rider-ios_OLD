//
//  ImagePicker.swift
//  OffSide
//
//  Created by Faizan Ali  on 2021/2/10.
//

import Foundation
import UIKit

public protocol ImagePickerDelegate: class {
    func didSelect(image: UIImage?)
    func didSelect(videoUrl: NSURL?)
}
open class ImagePicker: NSObject {
    private let pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickerDelegate?
    public init(presentationController: UIViewController, delegate: ImagePickerDelegate, allowMovie: Bool = false) {
        self.pickerController = UIImagePickerController()
        super.init()
        self.presentationController = presentationController
        self.delegate = delegate
        self.pickerController.delegate = self
        self.pickerController.allowsEditing = true
        if allowMovie {
            self.pickerController.mediaTypes = ["public.image", "public.movie"]
        } else {
            self.pickerController.mediaTypes = ["public.image"]
        }
        
    }
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }
        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = type
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }
    public func present(from sourceView: UIView, showCamera:Bool = true, showLibrary:Bool = true) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        if showCamera {
            if let action = self.action(for: .camera, title: "Take photo") {
                alertController.addAction(action)
            }
        }
        if showLibrary{
            if let action = self.action(for: .savedPhotosAlbum, title: "Camera roll") {
                alertController.addAction(action)
            }
            if let action = self.action(for: .photoLibrary, title: "Photo library") {
                alertController.addAction(action)
            }
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = sourceView
            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }
        self.presentationController?.present(alertController, animated: true)
    }
    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?, videoUrl: NSURL?) {
        controller.dismiss(animated: true, completion: nil)
        if videoUrl != nil {
            self.delegate?.didSelect(videoUrl: videoUrl)
            return
        }
        self.delegate?.didSelect(image: image)
        
    }
}
extension ImagePicker: UIImagePickerControllerDelegate {
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil, videoUrl: nil)
    }
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.editedImage] as? UIImage {
           return self.pickerController(picker, didSelect: image, videoUrl: nil)
        }
        
        if let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? NSURL {
            return self.pickerController(picker, didSelect: nil, videoUrl: videoURL)
        }
        
        self.pickerController(picker, didSelect: nil, videoUrl: nil)
    }
}
extension ImagePicker: UINavigationControllerDelegate {
}
