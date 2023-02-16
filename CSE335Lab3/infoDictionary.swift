//
//  infoDictionary.swift
//  CSE335Lab3
//
//  Created by Arjun Dadhwal on 2/14/23.
//

import Foundation
class infoDictionary: ObservableObject
{
    // dictionary that stores person records
    @Published var infoRepository : [Int64:ticketRecord] = [Int64:ticketRecord] ()
    init() { }
  
    func add(_ title:String, _ genre:String, _ ticketPrice:Int16)
    {
        let tRecord =  ticketRecord(movieID: Int64(infoRepository.count), title: title, genre:genre, ticketPrice: ticketPrice)
        infoRepository[tRecord.movieID!] = tRecord
        
    }
    
    func getCount() -> Int
    {
        return infoRepository.count
    }
    
    func add(t:ticketRecord)
    {
        print("adding" + t.title!)
        infoRepository[t.movieID!] = t;
        
    }
    
    func search(t:Int64) -> ticketRecord?
    {
        var found = false
        
        for (movieID, _) in infoRepository
        {
            if movieID == t {
            found = true
                break
            }
        }
        if found
        {
           return infoRepository[t]
        }else  {
     
            return nil
            }
    }
    
    func deleteRec(t:Int64)
    {
        infoRepository[t] = nil
        
    }
}
