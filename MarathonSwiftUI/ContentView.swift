import SwiftUI

struct ContentView: View {
    @State private var togle = true
    @State private var layout: AnyLayout = AnyLayout(HStackLayout())
    
    var body: some View {
            layout {
                ForEach(0..<12) {index in
                    RoundedRectangle(cornerRadius: 6)
                        .aspectRatio(1, contentMode: .fit)
                        .foregroundStyle( .blue)
 
                }
            }
            .onTapGesture {
                withAnimation {
                    togle = !togle
                    layout = togle ? AnyLayout(HStackLayout()) : AnyLayout(CustomLayout())
                }
            }
    }
}

#Preview {
    ContentView()
}

struct CustomLayout: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        proposal.replacingUnspecifiedDimensions()
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let height = bounds.height / CGFloat(subviews.count)
        
        for (index, subview) in subviews.enumerated() {
            subview.place(at: CGPoint(x: CGFloat(index) * (bounds.width - height) / CGFloat(subviews.count - 1) + bounds.minX, y: (bounds.maxY - height) - (height * CGFloat(index))),
                          proposal: ProposedViewSize(width: height, height: height))
        }
    }
}
