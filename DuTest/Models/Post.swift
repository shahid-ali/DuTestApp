//
//  Post.swift
//  DuTest
//
//  Created by Shahid Ali on 3/9/21.
//  Copyright © 2021 Shahid. All rights reserved.
//


import RealmSwift

class Post:Object,Codable {
    @objc dynamic var userId=0
    @objc dynamic var id=0
	@objc dynamic var title=""
	@objc dynamic var body=""
	
	// Return the name of the primary key property
    override static func primaryKey() -> String? {
        return "id"
    }
	
}


