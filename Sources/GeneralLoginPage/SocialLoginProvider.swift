import SwiftUI

/// A social media sign-in option shown as a button on `GeneralLoginView`.
///
/// Use one of the built-in presets (`.apple`, `.google`, `.facebook`, `.twitter`)
/// or create your own with a custom icon and colors.
public struct SocialLoginProvider: Identifiable, Hashable {

    public enum Icon: Hashable {
        /// An SF Symbol name.
        case system(String)
        /// An image from an asset catalog.
        case asset(String, bundle: Bundle? = nil)
        /// A short text monogram, e.g. "G".
        case text(String)
    }

    public let id: String
    public var title: String
    public var icon: Icon
    public var foregroundColor: Color
    public var backgroundColor: Color

    public init(
        id: String,
        title: String,
        icon: Icon,
        foregroundColor: Color = .white,
        backgroundColor: Color = .black
    ) {
        self.id = id
        self.title = title
        self.icon = icon
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
    }

    public static func == (lhs: SocialLoginProvider, rhs: SocialLoginProvider) -> Bool {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

public extension SocialLoginProvider {

    static let apple = SocialLoginProvider(
        id: "apple",
        title: "Continue with Apple",
        icon: .system("apple.logo"),
        foregroundColor: .white,
        backgroundColor: .black
    )

    static let google = SocialLoginProvider(
        id: "google",
        title: "Continue with Google",
        icon: .text("G"),
        foregroundColor: .white,
        backgroundColor: Color(red: 0.86, green: 0.27, blue: 0.22)
    )

    static let facebook = SocialLoginProvider(
        id: "facebook",
        title: "Continue with Facebook",
        icon: .text("f"),
        foregroundColor: .white,
        backgroundColor: Color(red: 0.09, green: 0.47, blue: 0.95)
    )

    static let twitter = SocialLoginProvider(
        id: "twitter",
        title: "Continue with X",
        icon: .text("X"),
        foregroundColor: .white,
        backgroundColor: .black
    )
}
