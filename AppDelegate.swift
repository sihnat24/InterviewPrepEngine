import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {

    static var shared: AppDelegate!

    var statusItem: NSStatusItem!
    var popover = NSPopover()

    func applicationDidFinishLaunching(_ notification: Notification) {

        AppDelegate.shared = self

        // Notifications
        NotificationManager.shared.requestPermission()
        NotificationManager.shared.scheduleDaily(hour: 11)

        // Menu bar item
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)

        if let button = statusItem.button {
            button.title = "🧠"
            button.target = self
            button.action = #selector(togglePopover)
        }

        // Popover
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(
            rootView: QuizView()
        )

        // Start compact
        resizePopover(height: 220)
    }

    @objc func togglePopover() {
        guard let button = statusItem.button else { return }

        if popover.isShown {
            popover.performClose(nil)
        } else {
            popover.show(
                relativeTo: button.bounds,
                of: button,
                preferredEdge: .minY
            )
        }
    }

    // MARK: - Dynamic resize ONLY (no close/reopen)

    func resizePopover(height: CGFloat) {
        popover.contentSize = NSSize(width: 320, height: height)
    }
}
