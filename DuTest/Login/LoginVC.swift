//
//  LoginVC.swift
//  DuTest
//
//  Created by Shahid Ali on 3/9/21.
//  Copyright © 2021 Shahid. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxSwiftExt

class LoginVC: UIViewController {
	private let viewModel=LoginVM()
	
	private var disposeBag=DisposeBag()
	
	@IBOutlet weak var loginTag: UILabel!
	@IBOutlet weak var emailTF: UITextField!
	@IBOutlet weak var passwordTF: UITextField!
	@IBOutlet weak var loginBtn: UIButton!
	@IBOutlet weak var validationMessageLbl: UILabel!
	
	var validEmailObservable:Observable<Bool>?
	var validPasswordObservable:Observable<Bool>?
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		emailTF.text="test@test.com"
		passwordTF.text="12345678"
		
		setupEmailTF()
		setupPasswordTF()
		setupLogin()
	}
	
	
	//MARK:observer is bieng setup to monitor value change of email textfield
	private func setupEmailTF()
	{
		//observable from emailTF.rx
		 validEmailObservable=emailTF.rx.text
			.observeOn(MainScheduler.asyncInstance)
			.throttle(RxTimeInterval.microseconds(500), scheduler: MainScheduler.instance)
			.unwrap()
			.map{[weak self] in
				return self?.viewModel.isEmailValid(email: $0)} //call emailvalidation from vm
			.unwrap()
		.distinctUntilChanged()
		.share(replay:1)
		
		
		validEmailObservable?.subscribe({
			print($0)
		}).disposed(by:disposeBag)
		
	}
	
	//MARK:observer is bieng setup to monitor value change of password textfield
	private func setupPasswordTF()
	{
		//observable from passwordTF.rx
		 validPasswordObservable=passwordTF.rx.text
			.observeOn(MainScheduler.asyncInstance)
			.throttle(RxTimeInterval.microseconds(500), scheduler: MainScheduler.instance)
			.unwrap()
			.map{[weak self] in
				return self?.viewModel.isValidPassword(password:$0)} //call isvalidpassword from vm
			.unwrap()
		.distinctUntilChanged()
		.share(replay:1)
		
		validPasswordObservable?.subscribe({
			print($0)
		}).disposed(by:disposeBag)
		
	}
    
	
	//MARK:setupLogin
	private func setupLogin()
	{
		guard let validEmailObservable=validEmailObservable,
			  let validPasswordobservable=validPasswordObservable
			else {return}
		
		
		//combine obseravable to monitor change in email & password observer
		let everythingValid:Observable<Bool>=Observable.combineLatest(validEmailObservable,validPasswordobservable){first,second in
			return first && second
		}.share(replay:1)
		
		//change login button background color according to value recieved from combine observable
		everythingValid.bind(onNext: {[weak self] in
			self?.loginBtn.backgroundColor=($0==true ? UIColor.red:UIColor.lightGray)
		}).disposed(by:disposeBag)
		
		//enable/disable login button according to the value received from combile observable
		everythingValid.bind(to:loginBtn.rx.isEnabled)
		.disposed(by:disposeBag)
		
		
		
		//if login button is enabled, open the home screen scene
		loginBtn
		.rx
		.tap
		.throttle(RxTimeInterval.microseconds(1000), scheduler:MainScheduler.instance)
		.bind{
			let storyboard = UIStoryboard(name: "Main", bundle: nil)
			if let homeTabbedVC=storyboard.instantiateViewController(identifier:"HomeTabVC") as? HomeTabVC
			{
				(UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(homeTabbedVC)
			}
			}
		.disposed(by:disposeBag)
	}
	
	

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
