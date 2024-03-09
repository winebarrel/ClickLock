import os
import ServiceManagement
import SwiftUI

struct RightClickMenuView: View {
    private let logger = Logger(subsystem: "jp.winebarrel.ClickLock", category: "Application")
    @State private var launchAtLogin = SMAppService.mainApp.status == .enabled

    var body: some View {
        Button {
            launchAtLogin.toggle()

            do {
                if launchAtLogin {
                    try SMAppService.mainApp.register()
                } else {
                    try SMAppService.mainApp.unregister()
                }
            } catch {
                logger.debug("failed to update 'Launch at login': \(error)")
            }
        } label: {
            let check = launchAtLogin ? "􀆅" : ""
            Text(check + "Launch at loginx")
        }
        Divider()
        Button("Quit") {
            NSApplication.shared.terminate(self)
        }
    }
}

#Preview {
    RightClickMenuView()
}
