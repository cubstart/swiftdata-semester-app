//
//  CSClassView.swift
//  SwiftDataLec7
//
//  Created by Justin Wong on 10/23/23.
//

import SwiftUI

struct CSClassView: View {
    var semesterClass: CSClass
    var body: some View {
        HStack {
            Text(semesterClass.name)
            Spacer()
            Text(String(repeating: "⭐️", count: semesterClass.difficulty))
        }
    }
}

struct CreateCSClassView: View {
    var semesterClass: CSClass
    @Binding var classes: [CSClass]
    
    var body: some View {
        HStack {
            CSClassView(semesterClass: semesterClass)
            
            Button(action: {
                if let removeIndex = classes.firstIndex(of: semesterClass) {
                    classes.remove(at: removeIndex)
                }
            }) {
                Image(systemName: "minus.circle.fill")
                    .foregroundStyle(.red)
            }
        }
    }
}
