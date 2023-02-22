//
//  ContentView.swift
//  CSE335Lab3
//
//  Created by Arjun Dadhwal on 2/14/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var array:movieArray = movieArray();
    
    var body: some  View {
        
    }
    
    struct NaviView: View
    {
        @Binding var titleN:String
        @Binding var genreN:String
        @Binding var priceN:String
        
        @State var showingDeleteAlert = false
        @Binding var deleteTitle: String
        @ObservedObject var movieModel : movieArray

        var body: some View
        {
                Text("")
                   .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action:
                        {
                            print(movieModel.getCount())
                                                        
                            movieModel.add_movie(titleN, (genreN), Int16(priceN) ?? 0)
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
                           
                           movieModel.delete_movie(title: deleteTitle);
                           
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
    
}
