//
//  Pupil_PlannerApp.swift
//  Pupil Planner
//
//  Created by Pruett Fedorowicz on 4/10/23.
//

import SwiftUI

@main
struct Pupil_PlannerApp: App {
    @Environment(\.scenePhase) var scenePhase // Save on scene change
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { _ in
            persistenceController.save()
        }
    }
}
