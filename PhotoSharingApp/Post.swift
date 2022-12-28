//
//  Post.swift
//  PhotoSharingApp
//
//  Created by Harun Demirkaya on 28.12.2022.
//

import Foundation

class Post{
    var postAuthor: String
    var postImage: String
    var postDescription: String
    
    init(postAuthor: String, postImage: String, postDescription: String) {
        self.postAuthor = postAuthor
        self.postImage = postImage
        self.postDescription = postDescription
    }
}
