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
    @IBOutlet weak var passwordMatchStatusLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idTextField.delegate = self
        passwordTextField.delegate = self
        checkPasswordTextField.delegate = self
        introductionTextView.delegate = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(loadImageFromLibrary(tapGestureRecognizer:)))
        profileImageView.addGestureRecognizer(tapGestureRecognizer)
        profileImageView.isUserInteractionEnabled = true
        
        nextButton.isEnabled = false
        
    }
    
    func determineNextButtonEnable() {
        if isCompletedAllRequirement() {
            nextButton.isEnabled = true
            return
        }
        nextButton.isEnabled = false
        return
    }
    
    func isCompletedAllRequirement() -> Bool {
        guard passwordTextField.isfilledTextField(),
              checkPasswordTextField.isfilledTextField(),
              isSamePassword(),
              idTextField.isfilledTextField(),
              introductionTextView.isfilledTextView(),
              profileImageView.image != nil else { return false }
        return true
    }
    
    func changeLableText(matchStaus: Status) {
        switch matchStaus {
        case .match:
            passwordMatchStatusLable.text = Status.match.rawValue
            passwordMatchStatusLable.textColor = .black
        case .unmatch:
            passwordMatchStatusLable.text = Status.unmatch.rawValue
            passwordMatchStatusLable.textColor = .red
        }
    }
    
    private func isSamePassword() -> Bool {
        if passwordTextField.text == checkPasswordTextField.text {
            changeLableText(matchStaus: .match)
            return true
        }
        changeLableText(matchStaus: .unmatch)
        nextButton.isEnabled = false
        return false
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func dismissRegisterStepOneView() {
        dismiss(animated: true, completion: nil)
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        determineNextButtonEnable()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        determineNextButtonEnable()
    }
}

//MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension RegisterStepOneViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @objc func loadImageFromLibrary(tapGestureRecognizer: UITapGestureRecognizer) {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage: UIImage = info[.editedImage] as? UIImage {
            self.profileImageView.image = editedImage
            determineNextButtonEnable()
        }
        dismiss(animated: true, completion: nil)
    }
}

//MARK:- UITextView
extension UITextView {
    func isfilledTextView() -> Bool {
        guard let text = self.text else { return false }
        if text.isEmpty { return false }
        return true
    }
}

//MARK:- UITextView
extension UITextField {
    func isfilledTextField() -> Bool {
        guard let text = self.text else { return false }
        if text.isEmpty { return false }
        return true
    }
}

//MARK: - Password Match Status Message
enum Status: String {
    case match = "비밀번호가 일치합니다."
    case unmatch = "비밀번호가 일치하지 않습니다."
}
