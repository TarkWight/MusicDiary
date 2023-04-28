import SwiftUI

struct ClockView: View {
    
    @ObservedObject var model: CountdownModel
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    var body: some View {
        VStack {
            Text(model.timeFormatter)
                .font(font)
                .fontWeight(.black)
        }
    }
    
    private var font: Font {
        horizontalSizeClass == .compact ? .largeTitle : .system(size: 68, weight: .bold, design: .default)
    }
}
