//
//  File.swift
//  initgram
//
//  Created by Kelvin Lui on 2/21/18.
//  Copyright © 2018 Kelvin Lui. All rights reserved.
//

import Parse
import ParseUI

class InstagramPostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: PFImageView!
    
    var instagramPost: PFObject! {
        didSet {
            self.postImageView.file = instagramPost["media"] as? PFFile
            self.postImageView.loadInBackground()
        }
    }
}
