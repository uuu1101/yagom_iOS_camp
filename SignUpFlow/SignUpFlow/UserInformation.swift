//
//  UserInformation.swift
//  SignUpFlow
//
//  Created by 김태형 on 2020/12/01.
//

import UIKit

class UserInformation {
    
    let id: String?
    private(set) var password: String?
    private(set) var profileImage: UIImage?
    private(set) var introduction: String?
    private(set) var phoneNumber: String?
    private(set) var dateOfBirth: Date?
    
    init (_ id: String) {
        self.id = id
    }
    
    func setPassword(_ password: String) {
        self.password = password
    }
    
    func setProfileImage(_ profileImage: UIImage) {
        self.profileImage = profileImage
    }
    
    func setIntroduction(_ introduction: String) {
        self.introduction = introduction
    }
    
    func setPhoneNumber(_ phoneNumber: String) {
        self.phoneNumber = phoneNumber
    }
    
    func setDateOfBirth(_ dateOfBirth: Date) {
        self.dateOfBirth = dateOfBirth
    }
}

class ErrorDescripter: LocalizedError {
    var errorDescription: String?
    init(message: String) {
        errorDescription = message
    }
}

class MemberList {
    static let common = MemberList()
    private init() {}
    typealias MemberId = String
    
    private(set) var members = [MemberId : UserInformation]()
    
    func addNewMember(id: String) -> Result<String, ErrorDescripter> {
        if members[id] == nil {
            members[id] = UserInformation(id)
            return .success("성공하였습니다.")
        } else {
            return .failure(ErrorDescripter(message: "이미 존재하는 아이디입니다."))
        }
    }
}
