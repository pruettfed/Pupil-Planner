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

        // Categories
        let cat1 = Category(context: controller.container.viewContext)
        cat1.name = "AP Physics C"
        cat1.icon = "🏎️"
        cat1.color = "Green"
        cat1.type = "Course"
        
        let cat2 = Category(context: controller.container.viewContext)
        cat2.name = "AP Calculus BC"
        cat2.icon = "📈"
        cat2.color = "Red"
        cat2.type = "Course"
        
        let cat3 = Category(context: controller.container.viewContext)
        cat3.name = "History 11"
        cat3.icon = "⏳"
        cat3.color = "Orange"
        cat3.type = "Course"

        let cat4 = Category(context: controller.container.viewContext)
        cat4.name = "Student Senate"
        cat4.icon = "👨‍⚖️"
        cat4.color = "Blue"
        cat4.type = "Extracurricular"

        let cat5 = Category(context: controller.container.viewContext)
        cat5.name = "College Applications"
        cat5.icon = "📝"
        cat5.color = "Yellow"
        cat5.type = "Personal"

        
        
        // Tasks
        let task1 = Task(context: controller.container.viewContext)
        task1.name = "Electrostatics Quiz"
        task1.dueDate = stringToDate(dateString: "4/14/2023")
        task1.isCompleted = false
        task1.type = "Quiz"
        task1.priority = 1
        task1.category = cat1
        task1.completionTime = 45
        
        let task2 = Task(context: controller.container.viewContext)
        task2.name = "Electric Flux Video"
        task2.dueDate = stringToDate(dateString: "4/16/2023")
        task2.isCompleted = false
        task2.type = "Quiz"
        task2.priority = 1
        task2.category = cat1
        task2.completionTime = 20
        
        let task3 = Task(context: controller.container.viewContext)
        task3.name = "Taylor Polynomial Review"
        task3.dueDate = stringToDate(dateString: "4/18/2023")
        task3.isCompleted = false
        task3.type = "Task"
        task3.priority = 1
        task3.category = cat2
        task3.completionTime = 30

        let task4 = Task(context: controller.container.viewContext)
        task4.name = "Parking Proposal"
        task4.dueDate = stringToDate(dateString: "4/21/2023")
        task4.isCompleted = false
        task4.type = "Presentation"
        task4.priority = 2
        task4.category = cat4
        task4.completionTime = 60

        let task5 = Task(context: controller.container.viewContext)
        task5.name = "Data Project Research"
        task5.dueDate = stringToDate(dateString: "4/21/2023")
        task5.isCompleted = false
        task5.type = "Essay"
        task5.priority = 3
        task5.category = cat3
        task5.completionTime = 75

        let task6 = Task(context: controller.container.viewContext)
        task6.name = "Vanderbilt Essay"
        task6.dueDate = stringToDate(dateString: "6/1/2023")
        task6.isCompleted = false
        task6.type = "Essay"
        task6.priority = 3
        task6.category = cat5
        task6.completionTime = 180
        
        let task7 = Task(context: controller.container.viewContext)
        task7.name = "Cold War Video"
        task7.dueDate = stringToDate(dateString: "4/18/2023")
        task7.isCompleted = false
        task7.type = "Task"
        task7.priority = 1
        task7.category = cat3
        task7.completionTime = 15

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
