//
//  ContentView.swift
//  BCRS
//
//  Created by Varun Singh on 12/2/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @State var searchForm: SearchForm = FormManager.sharedForm.form //form is already initialized by class SearchForm
    //search form shouldn't be private. Other views need ACCESS to it
    
    
    
    //Need to initalize selectedLocation, not passed in
    @State private var selectedLocation: String = "Select One"
    
    //Initialize options for form fields
    let locations = ["Select One", "oncampus", "offcampus"]
    
    //Not going to implement Select One for these options yet
    let classYears = [ 28, 27, 26, 25]
    let groupSizes = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    let numSeeks = [1, 2, 3, 4, 5, 6, 7, 8]
    
    let dorms = ["Ninety St. Thomas More", "Vanderslice Hall", "Thomas More Apartments", "Rubenstein Hall", "Voute Hall", "Walsh Hall"]
    
    //Boolean var for fullscreen cover
    @State private var showFullScreenCover: Bool = false //Binding not required here because parent view owns the state. State is owned in the view in which @State is declared.
    @State private var myPostingsFullScreenCover: Bool = false
    
    var body: some View {
        
        ZStack {
            Color(.white) // Sets background Color
                .edgesIgnoringSafeArea(.all) //Extend to all edges
            VStack(spacing: 0) {
                //Top Navigation Bar
                HStack {
                    Text("BCRS")
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(Color("Color2"))
                }
                .padding()
                
                //Main Content
                VStack (spacing: 10) {                //Find a Housing Group Stack
                    // Tab Buttons
                    Text("Find a Housing Group:")
                        .font(.title)
                        .padding(.top, 10)
                        .foregroundStyle(.black)
                        .fontWeight(.bold)
                    
                    //Dropdowns for Form Fields
                    // Listing Location Dropdown
                    VStack(alignment: .center, spacing: 15) {
                        
                        Group {
                            //Location Dropdown
                            
                            Text("Listing Location:")
                                .font(.headline)
                            
                            Picker(selection: $selectedLocation, label: Text(selectedLocation)) {
                                ForEach(locations, id: \.self) { location in
                                    Text(location)
                                    //These are the picker options
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .padding(8) //Add padding inside border
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.clear) //Background Color (transparent here)
                                    .shadow(color: .black.opacity(0.2), radius: 5, x: 5, y: 5) // Shadow for the picker
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 1)  //white border for the picker
                            )
                            .onChange(of: selectedLocation) { newValue in
                                print("selectedLocation updated with new value: \(newValue)")
                                print("New value of selectedLocation var is: \(selectedLocation) ")
                            }
                        }
                        .foregroundStyle(.black)
                        Group {
                            if selectedLocation != "Select One" {
                                // Dynamic Content Based on Location
                                
                                // Class Year Dropdown
                                Text("Class Year:")
                                    .font(.headline)
                                Picker("Select One", selection: $searchForm.classYear) {
                                    Text("Select One").tag(nil as Int?)
                                    ForEach(classYears, id: \.self) { year in
                                        Text("\(year)").tag(year as Int?)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.clear) //Background Color (transparent here)
                                        .shadow(color: .black.opacity(0.2), radius: 5, x: 5, y: 5) // Shadow for the picker
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black, lineWidth: 1)  //white border for the picker
                                )
                                .onChange(of: searchForm.classYear) { newValue in
                                    print("Class Year updated with new value: \(newValue)")
                                    print("New value of class year property from form is: \(searchForm.classYear) ")
                                    
                                }
                                
                                // Size of Group Dropdown
                                Text("Size of Group:")
                                    .font(.headline)
                                Picker("Select One", selection: $searchForm.numGroup) {
                                    Text("Select One").tag(nil as Int?)
                                    ForEach(groupSizes, id: \.self) { size in
                                        Text("\(size)").tag(size as Int?)
                                    }
                                }
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.clear) //Background Color (transparent here)
                                        .shadow(color: .black.opacity(0.2), radius: 5, x: 5, y: 5) // Shadow for the picker
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black, lineWidth: 1)  //white border for the picker
                                )
                                .pickerStyle(MenuPickerStyle())
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.clear) //Background Color (transparent here)
                                        .shadow(color: .black.opacity(0.2), radius: 5, x: 5, y: 5) // Shadow for the picker
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black, lineWidth: 1)  //white border for the picker
                                )
                                .onChange(of: searchForm.numGroup) { newValue in
                                    print("numGroup updated with new value: \(newValue)")
                                    print("New value of numGroup property from form is: \(searchForm.numGroup) ")
                                    
                                }
                                
                                // Number of Roommates Dropdown
                                Text("Desired Number of Roommates:")
                                    .font(.headline)
                                Picker("Select One", selection: $searchForm.numSeek) {
                                    Text("Select One").tag(nil as Int?)
                                    ForEach(numSeeks, id: \.self) { seek in
                                        Text("\(seek)").tag(seek as Int?)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.clear) //Background Color (transparent here)
                                        .shadow(color: .black.opacity(0.2), radius: 5, x: 5, y: 5) // Shadow for the picker
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black, lineWidth: 1)  //white border for the picker
                                )
                                .onChange(of: searchForm.numSeek) { newValue in
                                    print("numSeek updated with new value: \(newValue)")
                                    print("New value of numSeek property from form is: \(searchForm.numSeek) ")
                                    
                                }
                                
                                //If listing location == "oncampus"
                                //Add preferred dorm dropdown
                                if (selectedLocation == "oncampus") {
                                    Text("Preferred Dorm:")
                                        .font(.headline)
                                    Picker("Select One", selection: $searchForm.dorm) {
                                        Text("Select One").tag(nil as String?)
                                        ForEach(dorms, id: \.self) { dorm in
                                            Text("\(dorm)").tag(dorm as String?)
                                        }
                                    }
                                    .pickerStyle(MenuPickerStyle())
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.clear) //Background Color (transparent here)
                                            .shadow(color: .black.opacity(0.2), radius: 5, x: 5, y: 5) // Shadow for the picker
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.black, lineWidth: 1)  //white border for the picker
                                    )
                                    .onChange(of: searchForm.dorm) { newValue in
                                        print("dorm updated with new value: \(newValue)")
                                        print("New value of dorm property from form is: \(searchForm.dorm) ")
                                        
                                    }
                                }
                                
                                // Search Button
                                Button(action: {
                                    showFullScreenCover = true
                                }) {
                                    HStack {
                                        Image(systemName: "magnifyingglass")
                                        Text("Search")
                                            .font(.headline)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color("Color1"))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .shadow(color: .black.opacity(0.7), radius: 5, x: 5, y: 5) // Add shadow here
                                }
                                .padding()
                            }
                        }
                        .foregroundStyle(.black)
                        .fontWeight(.bold)
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    Spacer()
                    
                   
                    
                    // Post a Listing Button
                    VStack {
                        Button {
                            myPostingsFullScreenCover = true
                        } label: {
                            Text("Post a Listing:")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color("Color1"))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(color: .black.opacity(0.7), radius: 5, x: 5, y: 5) // Add shadow here
                        }
                    }
                    .padding()
                    
                }
                .edgesIgnoringSafeArea(.top)
                .fullScreenCover(isPresented: $showFullScreenCover) {
                    if selectedLocation == "offcampus" {
                        OffCampusListingsView(searchForm: searchForm)
                    } else if selectedLocation == "oncampus" {
                        OnCampusListingsView(searchForm: searchForm)
                    }
                }
                .fullScreenCover(isPresented: $myPostingsFullScreenCover) {
                    MyPostingsView()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}







