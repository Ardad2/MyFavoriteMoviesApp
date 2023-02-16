//
//  personRecord.swift
//  CSE335Lab3
//
//  Created by Arjun Dadhwal on 2/14/23.
//

import Foundation
class personRecord
{
    var title:String? = nil
    var genre:String? = nil
    var ticketPrice:Int16? = nil
    
    init(n:String, s:Int64, a:Int16) {
        self.title = n
        self.genre = s
        self.ticketPrice = a
    }
    
    func change_age(newAge:Int16)
    {
        self.age = newAge;
    }
    
}
