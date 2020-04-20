//
//  Constants.swift
//  Aking
//
//  Created by Usama Sadiq on 4/15/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import Foundation


struct KNotifcations {
    static let NEW_TASK: String = "addTask"
    static let QUICK_NOTE: String = "quickNote"
    static let CHECK_LIST: String = "checkList"
    static let HIDE_CREATE_MENU = "hidCreateMenu"
}
struct KUserData {
    static let USER_NAME = "userName"
    static let UESR_EMAIL = "email"
    static let PROVIDER_ID = "provider"
}
//MARK: - Text Field Validation
struct KFieldValid {
    static let EMPTY_USERNAME = "Please enter username"
    static let EMPTY_EMAIL = "Please enter email address"
    static let EMPTY_PASSWORD = "Please enter password"
    static let EMPTY_CONFIRM_PASSWORD = "Please confirm your password"
    static let EMPTY_PHOTO = "Please chose your photo"
    static let EMPTY_CURRENT_PASSWORD = "Please enter your current password"
    static let EMPTY_NEW_PASSWORD = "Please enter new password"
    static let PASSWORD_NOT_MATCH = "Password does not matach"
}

//MARK: -Firebase Messages
struct KFireMessages {
    static let USER_DATA_SAVED = "User data saved successfully"
    static let REGISTRATION_FAILED = "User registration failed"
    static let USER_LOGIN_FAIL = "Login failed: Check your email and password and try again"
    static let PASSWORD_CHANGE_SUCCESSFUL = "Password reset link sent to your email,\nreset your passowrd and try agian"
    static let USER_ALREADY_SIGNED_IN = "user allready signed in with"
}
