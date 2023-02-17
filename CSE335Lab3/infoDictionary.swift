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
    @Published var infoRepository : [Int64:personRecord] = [Int64:personRecord] ()
    init() { }
  
    func add(_ name:String, _ ssn:Int64, _ age:Int16)
    {
        let pRecord =  personRecord(n: name, s:ssn, a: age)
        infoRepository[pRecord.title!] = pRecord
        
    }
    
    func getCount() -> Int
    {
        return infoRepository.count
    }
    
    func add(p:personRecord)
    {
        print("adding" + p.genre!)
        infoRepository[p.title!] = p
        
    }
    
    func search(s:Int64) -> personRecord?
    {
        var found = false
        
        for (title, _) in infoRepository
        {
            if title == s {
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
