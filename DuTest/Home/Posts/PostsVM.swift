//
//  PostsVM.swift
//  DuTest
//
//  Created by Shahid Ali on 3/9/21.
//  Copyright © 2021 Shahid. All rights reserved.
//

import RealmSwift
import RxSwift



class PostsVM:CommonViewModel{

	//subject which will be bind with tableview
	private var postsPS=PublishSubject<[Post]>()
	
	//MARK:getPostsPS
	func getPostsPS() -> PublishSubject<[Post]>
	{
	return postsPS
	}
	
	
	//MARK:getPostsFromServer get posts from server
	private func getPostsFromServer()
	{
		APICall.request(APIRouter.getPosts) {[weak self](result: Result<[Post],Error>) in
		switch result{
		case .success(let posts):
			do {
				let realm = try Realm()

				try! realm.write {
					//add all posts into local db
					for post in posts
					{
					realm.add(post, update: .modified )
					}
					//notify the observer in vc
					self?.postsPS.onNext(posts)
				}
			} catch let error as NSError {
				//we can pass proper error message to viewcontroller to show to the user
				print("error1 \(error.localizedDescription)")
			}
		case .failure(let error):
			//we can pass proper error message to viewcontroller to show to the user
			print("error2 \(error)")
		}
		}
	}
	
	//MARK:getPosts get posts from local db
	func getPosts()
	{
		
		getPostsFromServer()
		
		do {
		let realm = try Realm()

	    //fetch posts object from local db
		let results = realm.objects(Post.self)
		
		//notify the observer in vc
		postsPS.onNext(Array(results))
        } catch let error as NSError {
				print(error.localizedDescription)
		}
	}
	
	
	//MARK:addToFav when tapped add item to fav list
	func addToFav(post:Post)
	{
		do {
				//create FavPostObject
				let favPost=FavPost()
					favPost.userId=post.userId
					favPost.id=post.id
					favPost.title=post.title
					favPost.body=post.body
					
				let realm = try Realm()

				try! realm.write {
					//add Favpost to local db
					 realm.add(favPost, update: .modified )
				}
				} catch let error as NSError {
						print(error.localizedDescription)
				}
	}
}
