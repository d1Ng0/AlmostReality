//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by mac_sys1 on 9/6/22.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: DailyScrum.sampleData)
            }
        }
    }
}
