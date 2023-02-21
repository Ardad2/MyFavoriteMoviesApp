//
//  movieRecord.swift
//  CSE335Lab3
//
//  Created by Arjun Dadhwal on 2/21/23.
//

import Foundation

class movieRecord
{
    var title:String? = nil;
    var genre:String? = nil;
    var price:Int16? = nil;
    
    init(new_title:String, new_genre: String, new_price:Int16) {
        self.title = new_title;
        self.genre = new_genre;
        self.price = new_price;
    }
    
    func change_genre(new_genre: String)
    {
        self.genre = new_genre;
    }
    
    func change_price(newPrice:Int16)
    {
        self.price = newPrice;
    }
    
    
}
