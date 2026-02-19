import SwiftUI
import AppKit

struct DragPreviewView: View {
    let thumbnail: NSImage?
    let displayName: String
    let itemCount: Int?

    init(thumbnail: NSImage?, displayName: String, itemCount: Int? = nil) {
        self.thumbnail = thumbnail
        self.displayName = displayName
        self.itemCount = itemCount
    }

    var body: some View {
        if let count = itemCount, count > 1 {
            stackedPreview(count: count)
        } else {
            singlePreview
        }
    }

    private var singlePreview: some View {
        VStack(alignment: .center, spacing: 4) {
            Image(nsImage: thumbnail ?? NSImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 56, height: 56)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            Text(displayName)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.white)
                .lineLimit(2)
                .truncationMode(.middle)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 8)
                .padding(.vertical, 2)
                .background(RoundedRectangle(cornerRadius: 4).fill(Color.accentColor))
                .frame(alignment: .top)
        }
        .frame(width: 105)
    }

    private func stackedPreview(count: Int) -> some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .center, spacing: 4) {
                ZStack {
                    // Stack effect - background layers
                    ForEach(0..<min(3, count), id: \.self) { index in
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white.opacity(0.3))
                            .frame(width: 56, height: 56)
                            .offset(x: CGFloat(index) * 3, y: CGFloat(index) * -3)
                            .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 1)
                    }

                    // Main thumbnail on top
                    Image(nsImage: thumbnail ?? NSImage())
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 56, height: 56)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
                        .offset(x: 6, y: -6)
                }
                .frame(width: 68, height: 62, alignment: .bottomLeading)

                Text("\(count) items")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(
                        Capsule()
                            .fill(Color.accentColor)
                            .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 1)
                    )
            }
            .frame(width: 115)

            // Count badge in top-right corner
            Text("\(count)")
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 22, height: 22)
                .background(
                    Circle()
                        .fill(Color.red)
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
                )
                .overlay(
                    Circle()
                        .strokeBorder(Color.white, lineWidth: 2)
                )
                .offset(x: 8, y: -4)
        }
    }
}
