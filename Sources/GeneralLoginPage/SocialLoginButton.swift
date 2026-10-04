import SwiftUI

/// A full-width button for a single `SocialLoginProvider`.
public struct SocialLoginButton: View {

    private let provider: SocialLoginProvider
    private let action: () -> Void

    public init(provider: SocialLoginProvider, action: @escaping () -> Void) {
        self.provider = provider
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                icon
                    .frame(width: 22, height: 22)
                Text(provider.title)
                    .fontWeight(.medium)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 13)
            .foregroundColor(provider.foregroundColor)
            .background(provider.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        }
        .buttonStyle(.plain)
        .accessibilityIdentifier("socialLoginButton.\(provider.id)")
    }

    @ViewBuilder
    private var icon: some View {
        switch provider.icon {
        case .system(let name):
            Image(systemName: name)
                .resizable()
                .scaledToFit()
        case .asset(let name, let bundle):
            Image(name, bundle: bundle)
                .resizable()
                .scaledToFit()
        case .text(let text):
            Text(text)
                .font(.system(size: 18, weight: .bold, design: .rounded))
        }
    }
}
