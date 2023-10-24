//
//  CreateNewSemesterView.swift
//  SwiftDataLec7
//
//  Created by Justin Wong on 10/23/23.
//

import SwiftUI

struct CreateNewSemesterView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var semesterName = ""
    @State private var startingDate = Date()
    @State private var endingDate = Date()
    @State private var classes = [CSClass]()
    
    @State private var isPresentingAddClassAlert = false
    @State private var newClassName = ""
    @State private var classDifficulty = ""
    
    var body: some View {
        NavigationStack {
            Form {
                semesterInfoSection
                classesSection
                saveSemesterButton
            }
            .navigationTitle("Add New Semester")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.gray)
                            .font(.system(size: 25))
                    }
                }
            }
            .alert("Add Class", isPresented: $isPresentingAddClassAlert) {
                TextField("Class Name", text: $newClassName)
                TextField("Class Difficulty", text: $classDifficulty)
                Button(action: {
                    //TODO: Add new class
                    let newClass = CSClass(name: newClassName, difficulty: Int(classDifficulty) ?? 1)
                    classes.append(newClass)
                    newClassName = ""
                    classDifficulty = ""
                }) {
                    Text("Add")
                }
            } message: {}
        }
    }
    
    @ViewBuilder private var semesterInfoSection: some View {
        Section("Semester Name") {
            TextField("", text: $semesterName)
        }
        
        Section("Semester Starting Date") {
            DatePicker("", selection: $startingDate)
                .datePickerStyle(.graphical)
        }
        
        Section("Semester Ending Date") {
            DatePicker("", selection: $endingDate)
                .datePickerStyle(.graphical)
        }
    }
    
    private var classesSection: some View {
        Section("Classes") {
            if classes.isEmpty {
                Text("No Classes")
                    
            } else {
                List(classes) { semesterClass in
                    CreateCSClassView(semesterClass: semesterClass, classes: $classes)
                }
            }
            
            HStack {
                Button(action: {
                    isPresentingAddClassAlert.toggle()
                }) {
                    Text("Add Class")
                        .foregroundStyle(.green)
                }
                Spacer()
            }
        }
    }
    
    private var saveSemesterButton: some View {
        Button(action: {
            //TODO: Add new semester to model context
            let newSemester = CSSemester(name: semesterName, startingDate: startingDate, endingDate: endingDate, classes: classes)
            modelContext.insert(newSemester)
            dismiss()
        }) {
            HStack {
                Spacer()
                Text("Save")
                    .font(.title2)
                Spacer()
            }
            .foregroundStyle(.white).bold()
            .frame(height: 40)
        }
        .listRowBackground(Color.green)
    }
}

#Preview {
    CreateNewSemesterView()
        .modelContainer(for: [CSClass.self, CSSemester.self])
}
