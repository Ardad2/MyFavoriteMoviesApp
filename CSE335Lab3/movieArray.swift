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
        array.removeAll(where: {$0.get_title() == title})

    }
    
    func search_movie(_ title:String) -> movieRecord?
    {
        for movie in array
        {
            if (movie.get_title() == title)
            {
                return movie;
            }
        }
        
        return nil;
    }
    
    func edit_movie(changeIndex: Int,_ newGenre: String, _ newPrice: Int16)
    {
        array[changeIndex].change_genre(new_genre: newGenre);
        array[changeIndex].change_price(new_price: newPrice);
    }
}
