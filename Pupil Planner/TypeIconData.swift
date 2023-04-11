//
//  TypeIconData.swift
//  Pupil-Planner
//
//  Created by Pruett Fedorowicz on 4/10/23.
//

import Foundation

// Defines all types of Tasks
// When requesting name use Task.type, when requesting icon use Task.type.rawValue()
enum TaskType: String, CaseIterable {
    case Task = "test.fill"
    case Quiz = "questionmark.circle.fill"
    case Test = "exclamationmark.triangle.fill"
    case Essay = "doc.on.doc.fill"
    case Project = "person.3.fill"
    case Presentation = "something.fill"
}

// Defines all types of Categories
// When requesting name use Category.type, when requesting icon use Category.type.rawValue()
enum CategoryType: String, CaseIterable {
    case Course = "schoolhat.fill"
    case Extracurricular = "running.fill"
    case Personal = "doc.on.doc.fill"
}
