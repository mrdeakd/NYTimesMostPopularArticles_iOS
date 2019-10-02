//
//  Article.swift
//  NYTimesApi
//
//  Created by Deák Dávid on 2019. 09. 29..
//  Copyright © 2019. Deák Dávid. All rights reserved.
//

import Foundation

struct Article {
    let url : String
    let byline: String
    let photo_url : String
    let photo_format : String
    let published_date: String
    let id : String
    let title : String
    
    init(id: String, title : String, url : String, byline : String, photo_url : String, photo_format : String, published_date : String) {
        self.id = id
        self.title = title
        self.url = url
        self.byline = byline
        self.photo_url = photo_url
        self.photo_format = photo_format
        self.published_date = published_date
    }
}
