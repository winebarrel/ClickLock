import MenuBarExtraAccess
import SwiftUI

@main
struct ClickLockApp: App {
    @State private var isMenuPresented = false

    var body: some Scene {
        MenuBarExtra {
            RightClickMenuView()
        } label: {
            Image(systemName: "lock.display")
        }
        .menuBarExtraAccess(isPresented: $isMenuPresented) { statusItem in
            if let button = statusItem.button {
                let mouseHandlerView = MouseHandlerView(frame: button.frame)

                mouseHandlerView.onMouseDown = {
                    lockScreen()
                }

                button.addSubview(mouseHandlerView)
            }
        }
    }
}
