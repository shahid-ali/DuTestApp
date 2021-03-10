//
//  CommonViewModel.swift
//  TheAhoyappTest
//
//  Created by Shahid Ali on 2/26/21.
//  Copyright © 2021 Shahid. All rights reserved.
//


import RxSwift
import RxCocoa


//MARK:CommonViewModel will contain common functions and properties across the view models
class CommonViewModel {

	private let showLoading = BehaviorRelay<Bool>(value: true)
	func getActivityIndicatorBR() -> BehaviorRelay<Bool>
	{
	return showLoading
	}
	
	func setIndicatorPSValue(value:Bool)
	{
		showLoading.accept(value)
	}
	
}
