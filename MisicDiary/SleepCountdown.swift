import SwiftUI

struct SleepCountdown: View {
    
    @ObservedObject private var model: CountdownModel
    @State private var showSettings: Bool
    
    init(model: CountdownModel, showSettings: Bool = false) {
        self.model = model
        self.showSettings = showSettings
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    CircularProgressView(model: model)
                    ClockView(model: model)
                }
            
                HStack {
                    Button(action: { model.resetTimer() }) {
                        CircleButton(style: .reset)
                    }
                    Spacer()
                    Button(action: { model.playPauseAction() }) {
                       CircleButton(style: model.isRunning ? .pause : .start)
                    }.disabled(model.disabledAction())
                }
                .padding()
            }
            .onReceive(model.timer) { time in
                model.receiveTimerUpdate()
            }
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showSettings.toggle()
                        model.isRunning = false
                    }) {
                        Label("Settings", systemImage: "gearshape.fill")
                            .labelStyle(IconOnlyLabelStyle())
                    }
                    .sheet(isPresented: $showSettings, onDismiss: {
                        model.storedDuration = model.duration
                    }) {
                        SettingsView()
                            .environmentObject(model)
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

