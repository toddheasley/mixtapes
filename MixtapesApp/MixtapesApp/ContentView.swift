import SwiftUI

struct ContentView: View {
    
    // MARK: View
    var body: some View {
        List(0..<25) { index in
            Text("CONTENT")
        }
    }
}
