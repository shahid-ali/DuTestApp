//
//  FirstViewController.swift
//  DuTest
//
//  Created by Shahid Ali on 3/9/21.
//  Copyright © 2021 Shahid. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PostsVC: UIViewController {

	private let viewModel=PostsVM()
	private var disposeBag=DisposeBag()
	
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
	 override func viewDidLoad() {
		 super.viewDidLoad()
		 bindViewModel()
	 }
	 
	 override func viewWillAppear(_ animated: Bool) {
		 super.viewWillAppear(animated)
		viewModel.getPosts()
	 }
	 
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}
	
	 
	 //MARK:bindViewModel binding views to datasource
	 private func bindViewModel() {
		//configure tableview
		tableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "PostCell")
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 180
		tableView.tableFooterView = UIView()
		
		
		
		 viewModel.getActivityIndicatorBR().asObservable().observeOn(MainScheduler.instance).bind(to: activityIndicator.rx.isHidden).disposed(by: disposeBag)
		 
		 //binding tableview with response from server
		 _=viewModel.getPostsPS().bind(to: tableView.rx.items){(table, index, model) in
			 
			if let cell=table.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
				 cell.setDataToView(itemData:model)
				 return cell
			 } else {
				 return UITableViewCell()
			 }
		 }.disposed(by:disposeBag)
		  
		 
		 //when tablecell is selected
		 tableView.rx.modelSelected(Post.self)
		 .subscribe(onNext: {[weak self] item in
			//add item to favourite
			self?.viewModel.addToFav(post:item)
		  }).disposed(by: self.disposeBag)
	 }

}

