//
//  RegisterStepOneViewController.swift
//  SignUpFlow
//
//  Created by 김호준 on 2020/12/02.
//

import UIKit

class RegisterStepOneViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    lazy var imagePicker: UIImagePickerController = {
        let profileImagePicker: UIImagePickerController = UIImagePickerController()
        profileImagePicker.delegate = self
        profileImagePicker.sourceType = .photoLibrary
        return profileImagePicker
    }()
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var checkPasswordTextField: UITextField!
    @IBOutlet weak var introductionTextView: UITextView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
