//
//  TestLineChartApp.swift
//  TestLineChart
//
//  Created by 민성홍 on 2021/12/21.
//

import SwiftUI

@main
struct TestLineChartApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
