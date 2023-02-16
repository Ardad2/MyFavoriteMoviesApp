//
//  ContentView.swift
//  CSE335Lab3
//
//  Created by Arjun Dadhwal on 2/14/23.
//

import SwiftUI


struct ContentView: View {
    @StateObject var ticketInfoDictionary:infoDictionary = infoDictionary()
    
    @State var title:String
    @State var genre:String
    @State var ticketPrice:String
    
    
    
    @State var searchTitle:String
    @State var searchGenre:String
    
    @State var deleteS:String

    
    var body: some View {
        NavigationView{
            VStack {
                Spacer()
                NaviView(titleN: $title,genreN:$genre, ticketPriceN:$ticketPrice, deleteSSN: $deleteS, tModel: ticketInfoDictionary )
                
                dataEnterView( titleD: $title,genreD:$genre, ticketPriceD:$ticketPrice)
                Spacer()
                Text("Search Results")
                Spacer()
                SearchView(nameS: $searchTitle, ageS: $searchGenre)
                Spacer()
                ToolView(searchSSN: "1", sTitle: $searchTitle , sGenre: $searchGenre, tModel: ticketInfoDictionary)
               
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Person Info")
            
            
        }
    }
    
    
}
struct NaviView: View
{
    @Binding var titleN:String
    @Binding var genreN:String
    @Binding var ticketPriceN:String
    
    @State  var showingDeleteAlert = false
    @Binding  var deleteSSN: String
    @ObservedObject  var tModel : infoDictionary
    
    var body: some View
    {
            Text("")
               .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action:
                    {
                        print(tModel.getCount())
                        
                        tModel.add(titleN, genreN, Int16(ticketPriceN) ?? 0)
                    },
                    label: {
                        Image(systemName: "plus.app")
                    })
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action:
                    {
                        print(titleN)
                        showingDeleteAlert = true
                    },
                           label: {
                        Image(systemName: "trash")
                    })
                }
               }.alert("Delete Record", isPresented: $showingDeleteAlert, actions: {
                   TextField("Enter SSN", text: $deleteSSN)

                   Button("Delete", action: {
                       
                       let ssn = Int64(deleteSSN)
                       tModel.deleteRec(t:ssn!)
                       showingDeleteAlert = false
                       
                   })
                   Button("Cancel", role: .cancel, action: {
                       showingDeleteAlert = false
                   })
               }, message: {
                   Text("Please enter SSN to Search.")
               })
        
        }
    
}

struct ToolView: View
{
    @State  var searchSSN: String
    @State  var showingSearchAlert = false
    
    @Binding var sTitle: String
    @Binding var sGenre:String
    @ObservedObject  var tModel : infoDictionary
    
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
                TextField("Enter SSN", text: $searchSSN)

                Button("Search", action: {
                    
                    let ssn = Int64(searchSSN)
                    let t =  tModel.search(t: ssn!)
                    if let x = t{
                        sTitle = x.title!
                        sGenre = x.genre!
                        
                        print("In search")
                    }else{
                        sTitle = "No Record "
                        sGenre =  " "
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
    @Binding var titleD:String
    @Binding var genreD:String
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
    }
    
}

struct SearchView: View
{
    
    @Binding var nameS:String
    @Binding var ageS:String
    
    var body: some View
    {
        HStack{
           
            Text("Name:")
                .foregroundColor(.blue)
            Spacer()
            TextField("", text: $nameS)
                .textFieldStyle(.roundedBorder)
                
        }
        
        
        HStack{
           
            Text("Age:")
                .foregroundColor(.blue)
            Spacer()
            TextField("", text: $ageS)
                .textFieldStyle(.roundedBorder)
                
        }
    }
    
}


//struct ContentView_Previews: PreviewProvider {
  //  static var previews: some View {
        //ContentView(title: "Avatar: The Way of Water", genre: "Sci-fi", ticketPrice: "16.00", searchName: "", searchAge: "", deleteS: "")
 //   }
//}
