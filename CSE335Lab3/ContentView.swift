//
//  ContentView.swift
//  CSE335Lab3
//
//  Created by Arjun Dadhwal on 2/14/23.
//

import SwiftUI


struct ContentView: View {
    @StateObject var personInfoDictionary:infoDictionary = infoDictionary()
    
    @State var name:String
    @State var age:String
    @State var ssn:String
    
    
    @State var searchName:String
    @State var searchAge:String
    
    @State var deleteS:String

    
    var body: some View {
        NavigationView{
            VStack {
                Spacer()
                NaviView(nameN: $name,ssnN:$ssn, ageN:$age, deleteSSN: $deleteS, pModel: personInfoDictionary )
                
                dataEnterView( nameD: $name,ssnD:$ssn, ageD:$age)
                Spacer()
                Text("Search Results")
                Spacer()
                SearchView(nameS: $searchName, ageS: $searchAge)
                Spacer()
                ToolView(searchSSN: "1", sName: $searchName , sAge: $searchAge, pModel: personInfoDictionary)
               
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Person Info")
            
            
        }
    }
    
    
}
struct NaviView: View
{
    @Binding var nameN:String
    @Binding var ssnN:String
    @Binding var ageN:String
    
    @State  var showingDeleteAlert = false
    @Binding  var deleteSSN: String
    @ObservedObject  var pModel : infoDictionary
    
    var body: some View
    {
            Text("")
               .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action:
                    {
                        print(pModel.getCount())
                        
                        pModel.add(nameN, Int64(ssnN) ?? 0, Int16(ageN) ?? 0)
                    },
                    label: {
                        Image(systemName: "plus.app")
                    })
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action:
                    {
                        print(nameN)
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
                       pModel.deleteRec(s:ssn!)
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
    
    @Binding var sName: String
    @Binding var sAge:String
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
                TextField("Enter SSN", text: $searchSSN)

                Button("Search", action: {
                    
                    let ssn = Int64(searchSSN)
                    let p =  pModel.search(s: ssn!)
                    if let x = p {
                        sName = x.name!
                        sAge = String(x.age!)
                        
                        print("In search")
                    }else{
                        sName = "No Record "
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
