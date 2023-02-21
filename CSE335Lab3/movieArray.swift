//
//  movieArray.swift
//  CSE335Lab3
//
//  Created by Arjun Dadhwal on 2/21/23.
//

import Foundation

class movieArray: ObservableObject
{
    
    @Published var array:[movieRecord] = [movieRecord]();
    
    init() {
        
    }
    
    func add_movie(_  title:String, _ genre:String, _ price:Int16 )
    {
        array.append(movieRecord(new_title: title, new_genre: genre, new_price: price));
    }
    
    func delete_movie(_ title: String)
    {
        for movies in array {
            if (movies.)
        }
    }
    
}
