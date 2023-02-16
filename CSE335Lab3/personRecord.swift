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
    
    init(title:String, genre:String, ticketPrice:Int16) {
        self.title = title;
        self.genre = genre;
        self.ticketPrice = ticketPrice;
    }
    
    func change_ticket_price(newTicketPrice:Int16)
    {
        self.ticketPrice = newTicketPrice;
    }
    func change_genre(newGenre:String)
    {
        self.genre = newGenre;
    }
    
}
