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
    
    func change_price(new_price:Int16)
    {
        self.price = new_price;
    }
    
    func get_title() -> String
    {
        return self.title!;
    }
    
    func get_genre() -> String
    {
        return self.genre!;
    }
    
    func get_price() -> Int16
    {
        return self.price!;
    }
    
    
}
