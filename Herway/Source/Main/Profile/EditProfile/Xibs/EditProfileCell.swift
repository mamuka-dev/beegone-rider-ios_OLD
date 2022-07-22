//
//  EditProfileCell.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/26.
//

import UIKit
import SDWebImage

class EditProfileCell: TableCell {
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtNameSecond: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var vwMain: UIView!

    var imagePicker: ImagePicker!
    var cellData: EditProfileCellData {get {return data as! EditProfileCellData}}
    
    override func setupUI() {
        super.setupUI()
        
        imgProfile.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imgStr = cellData.viewModel.profileData?.picture
        let url = URL(string: "\(IMAGE_BASE_URL)\(imgStr ?? "")")
        imgProfile.sd_setImage(with: url, placeholderImage: UIImage.init(named: "iconUserPlaceholder"))
        
        txtName.text = cellData.viewModel.profileData?.firstName
        txtNameSecond.text = cellData.viewModel.profileData?.lastName
        txtEmail.text = cellData.viewModel.profileData?.email
        txtPhone.text = cellData.viewModel.profileData?.mobile
        
        txtName.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtNameSecond.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        self.imagePicker = ImagePicker(presentationController: parentController, delegate: self)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {

        if textField == txtName {
            if let text = txtName.text {
                cellData.viewModel.profileData?.firstName = text
            }
        } else if textField == txtNameSecond {
            if let text = txtNameSecond.text {
                cellData.viewModel.profileData?.lastName = text
            }
        }
    }
    
    override func setupTheme() {
        super.setupTheme()
        
        vwMain.layer.cornerRadius = 12
    }
    
    
    @IBAction func btnEditProfileTapped(_ sender: Any) {
        
        cellData.viewModel.updateData {
            self.delegate?.cellWasTapped(cell: self, tag: "")
        }
    }
    
    @IBAction func btnProfileImgTapped(_ sender: UIButton) {
        
        self.imagePicker.present(from: sender, showCamera: true, showLibrary: true)
    }
    
    @IBAction func btnChangePass(_ sender: Any) {
        
        let vc = ChangePasswordVC.instantiateAuth()
        vc.theInitialize(isForgetPass: false)
        self.parentController.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}

class EditProfileCellData: TableCellData {
    
    var viewModel: EditProfileVM {get {return model as! EditProfileVM}}
    init() {
        super.init(nibId: "EditProfileCell")
    }
}


extension EditProfileCell: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        self.imgProfile.image = image
        cellData.viewModel.imageProfile = image
        
    }
    
    func didSelect(videoUrl: NSURL?) {
        
    }
    
    
}
