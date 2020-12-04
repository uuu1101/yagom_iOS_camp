//
//  RegisterStepOneViewController.swift
//  SignUpFlow
//
//  Created by 김호준 on 2020/12/02.
//

import UIKit

class RegisterStepOneViewController: UIViewController,UITextViewDelegate {
    
    lazy var imagePicker: UIImagePickerController = {
        let profileImagePicker: UIImagePickerController = UIImagePickerController()
        profileImagePicker.delegate = self
        profileImagePicker.sourceType = .photoLibrary
        profileImagePicker.allowsEditing = true
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
        
        idTextField.delegate = self
        passwordTextField.delegate = self
        checkPasswordTextField.delegate = self
        introductionTextView.delegate = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(loadImageFromLibrary(tapGestureRecognizer:)))
        profileImageView.addGestureRecognizer(tapGestureRecognizer)
        profileImageView.isUserInteractionEnabled = true
        
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}


//MARK: - UITextFieldDelegate
extension RegisterStepOneViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case idTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            checkPasswordTextField.becomeFirstResponder()
        case checkPasswordTextField:
            introductionTextView.becomeFirstResponder()
        default:
            break
        }
        return true
    }
}

//MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension RegisterStepOneViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @objc func loadImageFromLibrary(tapGestureRecognizer: UITapGestureRecognizer) {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage: UIImage = info[.editedImage] as? UIImage {
            self.profileImageView.image = editedImage
        }
        dismiss(animated: true, completion: nil)
    }
}
