//
//  CommonViewModel.swift
//  TheAhoyappTest
//
//  Created by Shahid Ali on 2/26/21.
//  Copyright © 2021 Shahid. All rights reserved.
//


import RxSwift

//MARK:CommonViewModel will contain common functions and properties across the view models
class CommonViewModel {

	private var indicatorPS=PublishSubject<Bool>()
	func getActivityIndicatorPS() -> PublishSubject<Bool>
	{
	return indicatorPS
	}
	
	func setIndicatorPSValue(value:Bool)
	{
		indicatorPS.onNext(value)
	}
	
}
