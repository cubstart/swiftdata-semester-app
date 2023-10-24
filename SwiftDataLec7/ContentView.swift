//
//  ContentView.swift
//  SwiftDataLec7
//
//  Created by Justin Wong on 10/23/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    //TODO: Implement Model Context and Query Semesters
    @Environment(\.modelContext) private var modelContext
    @Query var semesters: [CSSemester]
    
    @State private var isPresentingCreateNewSemesterSheet = false
    @State private var isInEditMode = false
    
    var body: some View {
        NavigationStack {
            Group {
                if semesters.isEmpty {
                    Text("No Semesters")
                        .font(.title).bold()
                        .foregroundStyle(.gray)
                } else {
                    semestersList
                }
            }
            .navigationTitle("My Semesters")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button(action: {
                        withAnimation {
                            isInEditMode.toggle()
                        }
                    }) {
                        Text(isInEditMode ? "Done" : "Edit")
                    }
                    
                    Button(action: {
                        isPresentingCreateNewSemesterSheet.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isPresentingCreateNewSemesterSheet) {
                CreateNewSemesterView()
            }
        }
    }
    
    private var semestersList: some View {
        List(semesters) { semester in
            DisclosureGroup(
                content: {
                    ForEach(semester.classes) { semesterClass in
                        CSClassView(semesterClass: semesterClass)
                    }
                },
                label: {
                    HStack {
                        //TODO: Implement Edit Mode UI
                        if isInEditMode {
                            Button(action: {
                                modelContext.delete(semester)
                            }) {
                                Image(systemName: "minus.circle.fill")
                                    .foregroundStyle(.red)
                                    .font(.system(size: 25))
                            }
                        }
                        Text(semester.name)
                            .font(.title)
                            .bold()
                    }
                }
            )
        }
    }
}


#Preview {
    ContentView()
        .modelContainer(for: [CSClass.self, CSSemester.self])
}
