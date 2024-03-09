import MenuBarExtraAccess
import os
import ServiceManagement
import SwiftUI

@main
struct ClickLockApp: App {
    @State private var isMenuPresented = false
    private let logger = Logger(subsystem: "jp.winebarrel.ClickLock", category: "Application")
    @State private var launchAtLogin = SMAppService.mainApp.status == .enabled
    @AppStorage("sleepInsteadOfLock") private var sleepInsteadOfLock = false

    var body: some Scene {
        MenuBarExtra {
            Button {
                sleepInsteadOfLock.toggle()
            } label: {
                if sleepInsteadOfLock {
                    Image(systemName: "checkmark")
                }
                Text("Use \"Sleep\" instead of \"Lock\"")
            }
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
                if launchAtLogin {
                    Image(systemName: "checkmark")
                }
                Text("Launch at loginx")
            }
            Divider()
            Button("Quit") {
                NSApplication.shared.terminate(self)
            }
        } label: {
            Image(systemName: "lock.display")
        }
        .menuBarExtraAccess(isPresented: $isMenuPresented) { statusItem in
            if let button = statusItem.button {
                let mouseHandlerView = MouseHandlerView(frame: button.frame)

                mouseHandlerView.onMouseDown = {
                    if sleepInsteadOfLock {
                        sleepMachine()
                    } else {
                        lockScreen()
                    }
                }

                button.addSubview(mouseHandlerView)
            }
        }
    }
}
