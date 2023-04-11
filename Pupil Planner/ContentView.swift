//
//  ContentView.swift
//  Pupil Planner
//
//  Created by Pruett Fedorowicz on 4/10/23.
//

import SwiftUI

struct ContentView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var tasks: FetchedResults<Task>
    
    var body: some View {
        VStack {
            List(tasks) { task in
                Text(task.name ?? "Default")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
