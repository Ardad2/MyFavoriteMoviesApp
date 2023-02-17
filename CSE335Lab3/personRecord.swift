//
//  ticketRecord.swift
//  CSE335Lab3
//
//  Created by Arjun Dadhwal on 2/14/23.
//

import Foundation
class personRecord
{
    var name:String? = nil
    var ssn:Int64? = nil
    var age:Int16? = nil
    
    init(n:String, s:Int64, a:Int16) {
        self.name = n
        self.ssn = s
        self.age = a
    }
    
    func change_age(newAge:Int16)
    {
        self.age = newAge;
    }
    
}
