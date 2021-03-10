//
//  SecondViewController.swift
//  DuTest
//
//  Created by Shahid Ali on 3/9/21.
//  Copyright © 2021 Shahid. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class FavVC: UIViewController {

	    private let viewModel=FavVM()
		private var disposeBag=DisposeBag()
		
		@IBOutlet weak var tableView: UITableView!
		@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
		
		 override func viewDidLoad() {
			 super.viewDidLoad()
			 bindViewModel()
		 }
		 
		 override func viewWillAppear(_ animated: Bool) {
			 super.viewWillAppear(animated)
			viewModel.getFavPosts()
		 }
		 
		
		override func viewDidAppear(_ animated: Bool) {
			super.viewDidAppear(animated)
		}
		
		 
		 //MARK:bindViewModel
		 private func bindViewModel() {
			//configure tableview
			tableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "FavPostCell")
			tableView.rowHeight = UITableView.automaticDimension
			tableView.estimatedRowHeight = 180
			tableView.tableFooterView = UIView()
			
			 viewModel.getActivityIndicatorBR().asObservable().observeOn(MainScheduler.instance).bind(to: activityIndicator.rx.isHidden).disposed(by: disposeBag)
			 
			 //binding tableview with response from local DB
			_=viewModel.getFavPostsPS().bind(to: tableView.rx.items){(table, index, model) in
				 
				if let cell=table.dequeueReusableCell(withIdentifier: "FavPostCell") as? PostCell {
					 cell.setFavDataToView(itemData:model)
					 return cell
				 } else {
					 return UITableViewCell()
				 }
			 }.disposed(by:disposeBag)
			  
			 //when tablecell is selected
			 tableView.rx.modelSelected(FavPost.self)
			 .subscribe(onNext: { item in
			 }).disposed(by: self.disposeBag)
		 }

	}




