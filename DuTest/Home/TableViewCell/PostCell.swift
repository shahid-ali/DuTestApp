//
//  PostCell.swift
//  DuTest
//
//  Created by Shahid Ali on 3/10/21.
//  Copyright © 2021 Shahid. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

	@IBOutlet weak var titleLbl: UILabel!
	@IBOutlet weak var bodyLbl: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
	}
	
	
	//MARK:set values for tableview cell
	func setDataToView(itemData : Post) {
		titleLbl.text=itemData.title
		bodyLbl.text=itemData.body
	}
	
	//MARK:set values for tableview cell
	func setFavDataToView(itemData : FavPost) {
		titleLbl.text=itemData.title
		bodyLbl.text=itemData.body
	}
    
}
