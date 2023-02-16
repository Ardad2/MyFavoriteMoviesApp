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
    
    
    
    @State var searchName:String
    @State var searchAge:String
    
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
                SearchView(nameS: $searchName, ageS: $searchAge)
                Spacer()
                ToolView(searchSSN: "1", sTitle: $searchName , sAge: $searchAge, tModel: ticketInfoDictionary)
               
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
    @Binding var sAge:String
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
                    if let x = p {
                        sTitle = x.name!
                        sAge = String(x.age!)
                        
                        print("In search")
                    }else{
                        sTitle = "No Record "
                        sAge =  " "
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
    @Binding var nameD:String
    @Binding var ssnD:String
    @Binding var ageD:String
    
    var body: some View
    {
        HStack{
           
            Text("SSN:")
                .foregroundColor(.blue)
            Spacer()
            TextField("Enter SSN", text: $ssnD)
                .textFieldStyle(.roundedBorder)
                
        }
        
        HStack{
           
            Text("Name:")
                .foregroundColor(.blue)
            Spacer()
            TextField("Enter Name", text: $nameD)
                .textFieldStyle(.roundedBorder)
                
        }
        
        HStack{
           
            Text("Age:")
                .foregroundColor(.blue)
            Spacer()
            TextField("Enter Age", text: $ageD)
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(name: "Arjun", age: "20", ssn: "1", searchName: "", searchAge: "", deleteS: "")
    }
}
