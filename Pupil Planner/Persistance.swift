//
//  Persistance.swift
//  Pupil Planner
//
//  Created by Pruett Fedorowicz on 4/10/23.
//

import CoreData
import Foundation

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer
    
    // =>> LOAD COREDATA <<= //
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "PupilData")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("CoreData failed: \(error.localizedDescription)")
            }
        }
    }
    
    
    // ### TEST CONFIGURATION ### //
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)

        // Create 5 Categories
        for _ in 0..<5 {
            let course = Category(context: controller.container.viewContext)
            course.color = "Red"
            course.icon = "📈"
            course.name = "Calculus"
            course.type = "Course"
        }

        // Create 5 Tasks
        for _ in 0..<3 {
            let task = Task(context: controller.container.viewContext)
            task.name = "Task"
            task.type = "Task"
            task.dueDate = Date()
            task.completionTime = 60
        }

        
        // Create 2 Plans

        return controller
    }()
    // ### TEST CONFIGURATION ### //
    
    func save() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error)
                fatalError("CoreData Failed to save")
            }
        }
    }
}
