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
    
    //Get the Index
    
    func getIndex(_ title:String) -> Int
    {
        var count: Int = 0;
        
        for movie in array
        {
            if (movie.get_title() == title)
            {
                return count;
            }
            count+=1;
        }
        
        return -1;
    }
    
    //Add:
    
    func add_movie(_ title:String, _ genre:String, _ price:Int16)
    {
        array.append(movieRecord(new_title: title, new_genre: genre, new_price: price));
    }
    
    //Delete
    
    func delete_movie(_ title: String)
    {
        array.removeAll(where: {$0.get_title() == title})
    }
    
    //Search
    
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
    
    //Edit
    
    func edit_movie(changeIndex: Int,_ newGenre: String, _ newPrice: Int16)
    {
        array[changeIndex].change_genre(new_genre: newGenre);
        array[changeIndex].change_price(new_price: newPrice);
    }
    
    //Navigate Previous
    
    func getPrevious(_ index:Int) -> movieRecord?
    {
        if (index == 0)
        {
            return nil;
        }
        
        return array[index-1];
    }
    
    
    
    //Navigate Next
    
    func getNext(_ index: Int) -> movieRecord?
    {
        if (index == (array.count - 1))
        {
            return nil;
        }
        
        return array[index+1];
    }
    
}
