//
//  ContentView.swift
//  CSE335Lab3
//
//  Created by Arjun Dadhwal on 2/14/23.
//

import SwiftUI


struct ContentView: View {
    @StateObject var personInfoDictionary:infoDictionary = infoDictionary()
    
    @State var genre:String
    @State var ticketPrice:String
    @State var title:String
    
    
    @State var searchTitle:String
    @State var searchGenre:String
    @State var searchTicketPrice:String
    
    @State var deleteS:String

    
    var body: some View {
        NavigationView{
            VStack {
                Spacer()
                NaviView(genreN: $genre,titleN:$title, ticketPriceN:$ticketPrice, deleteTitle: $deleteS, pModel: personInfoDictionary )
                
                dataEnterView( genreD: $genre,titleD:$title, ticketPriceD:$ticketPrice)
                Spacer()
                Text("Search Results")
                Spacer()
                SearchView(titleS: $searchTitle, genreS: $searchGenre, ticketPriceS: $searchTicketPrice)
                Spacer()
                ToolView(searchTitle: "1", sGenre: $searchGenre , sTicketPrice: $searchTicketPrice, pModel: personInfoDictionary)
               
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Person Info")
            
            
        }
    }
    
    
}
struct NaviView: View
{
    @Binding var genreN:String
    @Binding var titleN:String
    @Binding var ticketPriceN:String
    
    @State  var showingDeleteAlert = false
    @Binding  var deleteTitle: String
    @ObservedObject  var pModel : infoDictionary
    
    var body: some View
    {
            Text("")
               .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action:
                    {
                        print(pModel.getCount())
                        
                        pModel.add(genreN, Int64(titleN) ?? 0, Int16(ticketPriceN) ?? 0)
                    },
                    label: {
                        Image(systemName: "plus.app")
                    })
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action:
                    {
                        print(genreN)
                        showingDeleteAlert = true
                    },
                           label: {
                        Image(systemName: "trash")
                    })
                }
               }.alert("Delete Record", isPresented: $showingDeleteAlert, actions: {
                   TextField("Enter Title", text: $deleteTitle)

                   Button("Delete", action: {
                       
                       let title = Int64(deleteTitle)
                       pModel.deleteRec(s:title!)
                       showingDeleteAlert = false
                       
                   })
                   Button("Cancel", role: .cancel, action: {
                       showingDeleteAlert = false
                   })
               }, message: {
                   Text("Please enter Title to Search.")
               })
        
        }
    
}

struct ToolView: View
{
    @State  var searchTitle: String
    @State  var showingSearchAlert = false
    
    @Binding var sGenre: String
    @Binding var sTicketPrice:String
    @ObservedObject  var pModel : infoDictionary
    
   // @State  var showingNoRecordsFoundDialog = false
    
    var body: some View
    {
        Text("")
            .toolbar{
                ToolbarItem(placement: .bottomBar) {
                    Button(action:
                    {
                            showingSearchAlert = true
                        
                    },
                           label: {
                        Image(systemName:"eye")
                            .scaledToFit()
                    })
                }
                
                
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()
                    Button(action:
                    {
                        // implement this as an activity
                    },
                           label: {
                        Text("Next")
                    })
                    
                    Spacer()
                    Button(action:
                    {
                        // implement this as an activity
                    },
                           label: {
                        Text("Prev")
                    })
                    Spacer()
                }
            }.alert("Search Record", isPresented: $showingSearchAlert, actions: {
                TextField("Enter Title", text: $searchTitle)

                Button("Search", action: {
                    
                    let title = Int64(searchTitle)
                    let p =  pModel.search(s: title!)
                    if let x = p {
                        sGenre = x.genre!
                        sTicketPrice = String(x.ticketPrice!)
                        
                        print("In search")
                    }else{
                        sGenre = "No Record "
                        sTicketPrice =  " "
                        print("No Record")
                    }
                    showingSearchAlert = false
                    
                })
                Button("Cancel", role: .cancel, action: {
                    showingSearchAlert = false
                })
            }, message: {
                Text("Please enter SSN to Search.")
            })
    }
    
}


struct dataEnterView: View
{
    @Binding var genreD:String
    @Binding var titleD:String
    @Binding var ticketPriceD:String
    
    var body: some View
    {
        HStack{
           
            Text("Title:")
                .foregroundColor(.blue)
            Spacer()
            TextField("Enter Title", text: $titleD)
                .textFieldStyle(.roundedBorder)
                
        }
        
        HStack{
           
            Text("Genre:")
                .foregroundColor(.blue)
            Spacer()
            TextField("Enter Genre", text: $genreD)
                .textFieldStyle(.roundedBorder)
                
        }
        
        HStack{
           
            Text("Ticket Price:")
                .foregroundColor(.blue)
            Spacer()
            TextField("Enter Ticket Price", text: $ticketPriceD)
                .textFieldStyle(.roundedBorder)
                
        }
    }
    
}

struct SearchView: View
{
    @Binding var titleS:String
    @Binding var genreS:String
    @Binding var ticketPriceS:String
    
    var body: some View
    {
        HStack{
           
            Text("Title:")
                .foregroundColor(.blue)
            Spacer()
            TextField("", text: $titleS)
                .textFieldStyle(.roundedBorder)
                
        }
        
        HStack{
           
            Text("Name:")
                .foregroundColor(.blue)
            Spacer()
            TextField("", text: $genreS)
                .textFieldStyle(.roundedBorder)
                
        }
        
        
        HStack{
           
            Text("Ticket Price:")
                .foregroundColor(.blue)
            Spacer()
            TextField("", text: $ticketPriceS)
                .textFieldStyle(.roundedBorder)
                
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(genre: "janaka", ticketPrice: "10", title: "1",searchTitle: "", searchGenre: "", searchTicketPrice: "", deleteS: "")
    }
}

