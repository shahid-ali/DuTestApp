//
//  FavVM.swift
//  DuTest
//
//  Created by Shahid Ali on 3/10/21.
//  Copyright © 2021 Shahid. All rights reserved.
//

import RealmSwift
import RxSwift


class FavVM:CommonViewModel{

	//subject which will be bind with Views
	private var favPostsPS=PublishSubject<[FavPost]>()
	
	func getFavPostsPS() -> PublishSubject<[FavPost]>
	{
	return favPostsPS
	}
	
	//MARK:getFavPosts fetch Favposts from local db and notify the observer
	func getFavPosts()
	{
		do {
		let realm = try Realm()
		let results = realm.objects(FavPost.self)
		favPostsPS.onNext(Array(results))
        } catch let error as NSError {
				print(error.localizedDescription)
		}
	}
	
	
}
