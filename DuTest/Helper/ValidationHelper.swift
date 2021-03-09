//
//  ValidationHelper.swift
//  DuTest
//
//  Created by Shahid Ali on 3/9/21.
//  Copyright © 2021 Shahid. All rights reserved.
//


import UIKit

class ValidationHelper {
	
	//MARK:email validation
	func isValidEmail(_ email: String) -> Bool {
		let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

		let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
		return emailPred.evaluate(with: email)
	}
	
	//MARK:password validation
	func isPasswordValid(password: String) -> Bool {
		return (password.count >= 8 && password.count <= 15)
	}

}
