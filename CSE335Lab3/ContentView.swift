//
//  ContentView.swift
//  CSE335Lab3
//
//  Created by Arjun Dadhwal on 2/14/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var array:movieArray = movieArray();
    
    @State var title:String
    @State var genre:String
    @State var price:String
    
    @State var searchTitle:String
    @State var searchGenre:String
    @State var searchPrice:String
    
    @State var deleteTitle:String
    
    @State var statusMessage:String
    
    @State var searchMode:Bool
    
    //@State var
    
    
    var body: some View {
        NavigationView{
            VStack {
                Spacer()
                NaviView(titleN: $title,genreN:$genre, priceN:$price, statusMessage: $statusMessage, deleteTitle: $deleteTitle, movieModel: array, searchMode: $searchMode)
                
                //Text("Details of New Movie")
                
                dataEnterView( titleD: $title,genreD:$genre, priceD:$price, statusMessage: $statusMessage, searchMode: $searchMode)
                
                Spacer()
                VStack {
                    if (searchMode == true)
                    {
                        Text("Currently in search mode")
                    }
                    else
                    {
                        Text("Currently in navigation mode")
                    }
                    Text("\(statusMessage)");
                    
                    SearchView(titleS: $searchTitle, genreS: $searchGenre, priceS: $searchPrice, statusMessage: $statusMessage, searchMode: $searchMode)
                }
                Spacer()
                ToolView(searchTitle: "1",  newGenre: "", newPrice: "", sTitle: $searchTitle, sGenre: $searchGenre, sPrice: $searchPrice, statusMessage: $statusMessage, searchMode: $searchMode, movieModel: array)
               
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
        @Binding var priceN:String
        @Binding var statusMessage:String
        
        @State var showingDeleteAlert = false
        @Binding var deleteTitle: String
        @ObservedObject var movieModel : movieArray
        
        @Binding var searchMode:Bool;

        var body: some View
        {
                Text("")
                   .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action:
                        {
                            //print(movieModel.getCount())
                                                        
                            movieModel.add_movie(titleN, (genreN), Double(priceN) ?? 0.0)
                            searchMode = true
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
                       TextField("Enter Title", text: $deleteTitle)

                       Button("Delete", action: {

                           movieModel.delete_movie(deleteTitle);
                            
                           searchMode = true;
                           statusMessage = "The deleted moive's details:  "
                           
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
    
//Tool View
    
    struct ToolView: View
    {
        @State  var searchTitle: String
        @State  var showingSearchAlert = false
        @State var showingEditAlert = false
        
        @State var newGenre: String
        @State var newPrice: String
        
        @Binding var sTitle: String
        @Binding var sGenre: String
        @Binding var sPrice:String
        @Binding var statusMessage:String
        @Binding var searchMode:Bool
        @ObservedObject var movieModel : movieArray
        

        @State  var showingNoRecordsFoundDialog = false
        
        var body: some View
        {
            if (searchMode == true)
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
                                
                                showingEditAlert = true;
                                
                            },
                                   label: {
                                Text("Edit")
                            })
                            
                            Spacer()
                            Button(action:
                                    {
                                searchMode = false;
                            },
                                   label: {
                                Text("Navigation Mode")
                            })
                            Spacer()
                        } }.alert("Search Record", isPresented: $showingSearchAlert, actions: {
                        TextField("Enter Title", text: $searchTitle)
                        
                        Button("Search", action: {
                            
                            searchMode = true
                            
                            let m = movieModel.search_movie(searchTitle)
                            
                            if (m != nil)
                            {
                                sTitle = m!.get_title()
                                sGenre = m!.get_genre()
                                sPrice = String(m!.get_price())
                                
                                print("In search")
                            }
                            else {
                                sTitle = "Record Not found"
                                sGenre = " "
                                sPrice = "";
                                print("Record is not there");
                            }
                            showingSearchAlert = false
                            
                        })
                        
                        
                        
                        Button("Cancel", role: .cancel, action: {
                            showingSearchAlert = false
                        })
                    }, message: {
                        Text("Please enter Title to Search.")
                    }) .alert("Edit Record", isPresented: $showingEditAlert, actions: {

                        
                        TextField("Enter New Genre", text: $newGenre)
                        TextField("Enter New Price", text: $newPrice)
                        
                        
                        Button("Edit", action: {
                            
                            searchMode = true
                            
                            movieModel.edit_movie(changeIndex: (movieModel.getIndex(sTitle)), newGenre, Double(newPrice) ?? 0.0);


                            
                            showingEditAlert = false
                            
                        })
                        
                        
                        
                        Button("Cancel", role: .cancel, action: {
                            showingSearchAlert = false
                        })
                    }, message: {
                        Text("Please enter Title to Search.")
                    })
            }
            else {
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
                                
                                let m = movieModel.getNext(movieModel.getIndex(sTitle));
                                
                                if (m != nil)
                                {
                                    sTitle = m!.get_title()
                                    sGenre = m!.get_genre()
                                    sPrice = String(m!.get_price())
                                }
                                
                                else {
                                    if (movieModel.getIndex(sTitle) == -1)
                                    {
                                        statusMessage = "There are no Records present!";
                                    }
                                    else
                                    {
                                        statusMessage = "No more Records!";
                                    }
                                }
                                
                            },
                                   label: {
                                Text("Next")
                            })
                            
                            Spacer()
                            Button(action:
                                    {
                                // implement this as an activity
                                
                                let m = movieModel.getPrevious(movieModel.getIndex(sTitle));
                                
                                if (m != nil)
                                {
                                    sTitle = m!.get_title()
                                    sGenre = m!.get_genre()
                                    sPrice = String(m!.get_price())
                                }
                                else {
                                    if (movieModel.getIndex(sTitle) == 0)
                                    {
                                        statusMessage = "Showing the first Record";
                                    }
                                    else
                                    {
                                        statusMessage = "There are no Records present!";
                                    }
                                }
                            },
                                   label: {
                                Text("Prev")
                            })
                            
                            
                            
                            
                            Spacer()
                        }
                    }.alert("Search Record", isPresented: $showingSearchAlert, actions: {
                        TextField("Enter Title", text: $searchTitle)
                        
                        Button("Search", action: {
                            searchMode = true
                            
                            let m = movieModel.search_movie(searchTitle)
                            
                            if (m != nil)
                            {
                                sTitle = m!.get_title()
                                sGenre = m!.get_genre()
                                sPrice = String(m!.get_price())
                                
                                print("In search")
                            }
                            else {
                                sTitle = "Record Not found"
                                sGenre = " "
                                sPrice = "";
                                print("Record is not there");
                            }
                            showingSearchAlert = false
                            
                        })
                        
                        
                        
                        Button("Cancel", role: .cancel, action: {
                            showingSearchAlert = false
                        })
                    }, message: {
                        Text("Please enter Title to Search.")
                    })
                
            }
            
        }
        
        
        
    }

    
    
    
//Data Enter View
    
struct dataEnterView: View
    {
        @Binding var titleD:String
        @Binding var genreD:String
        @Binding var priceD:String
        @Binding var statusMessage:String
        @Binding var searchMode:Bool;


        
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
               
                Text("Price:")
                    .foregroundColor(.blue)
                Spacer()
                TextField("Enter Price", text: $priceD)
                    .textFieldStyle(.roundedBorder)
                    
            }
        }
        
    
    
    
    
    }
    
//Search View
    
    struct SearchView: View
    {
        @Binding var titleS:String
        @Binding var genreS:String
        @Binding var priceS:String
        @Binding var statusMessage:String
        @Binding var searchMode:Bool;

        
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
               
                Text("Genre:")
                    .foregroundColor(.blue)
                Spacer()
                TextField("", text: $genreS)
                    .textFieldStyle(.roundedBorder)
                    
            }
            
            
            HStack{
               
                Text("Price:")
                    .foregroundColor(.blue)
                Spacer()
                TextField("", text: $priceS)
                    .textFieldStyle(.roundedBorder)
                    
            }
        }
        
    }
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(title: "Avatar", genre: "Sci-Fi", price: "10.150", searchTitle: "", searchGenre: "", searchPrice: " ", deleteTitle: "", statusMessage
                    : "", searchMode: false)
    }
}
