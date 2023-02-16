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
        let pRecord =  ticketRecord(title: title, genre:genre, ticketPrice: ticketPrice)
        infoRepository[pRecord.ssn!] = pRecord
        
    }
    
    func getCount() -> Int
    {
        return infoRepository.count
    }
    
    func add(p:ticketRecord)
    {
        print("adding" + p.name!)
        infoRepository[p.ssn!] = p
        
    }
    
    func search(s:Int64) -> ticketRecord?
    {
        var found = false
        
        for (ssn, _) in infoRepository
        {
            if ssn == s {
            found = true
                break
            }
        }
        if found
        {
           return infoRepository[s]
        }else  {
     
            return nil
            }
    }
    
    func deleteRec(s:Int64)
    {
        infoRepository[s] = nil
        
    }
}
