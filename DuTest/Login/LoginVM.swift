//
//  LoginVM.swift
//  DuTest
//
//  Created by Shahid Ali on 3/9/21.
//  Copyright © 2021 Shahid. All rights reserved.
//




class LoginVM:CommonViewModel {
	//careating validation helper in viewmodel to hide its implememntation from view as might contain more business logic
	private let validationHelper=ValidationHelper()
	
	
	//MARK:isEmailValid
	func isEmailValid(email:String) -> Bool
	{
		return validationHelper.isValidEmail(email)
	}
	
	//MARK:isValidPassword
	func isValidPassword(password:String) -> Bool
	{
		return validationHelper.isPasswordValid(password:password)
	}
	
	
	
	
}
