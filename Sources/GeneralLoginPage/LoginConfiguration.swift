import Foundation

/// Controls the text and the optional sections of `GeneralLoginView`.
public struct LoginConfiguration {

    public var title: String
    public var usernamePlaceholder: String
    public var passwordPlaceholder: String
    public var loginButtonTitle: String
    public var forgotPasswordTitle: String
    public var socialDividerTitle: String

    /// Shows or hides the "Forgot password" button.
    public var showsForgotPassword: Bool

    /// Shows or hides the whole social login section.
    public var showsSocialLogin: Bool

    /// The social buttons to display, in order. Remove a provider to hide just that button.
    public var socialProviders: [SocialLoginProvider]

    public init(
        title: String = "Login",
        usernamePlaceholder: String = "Username",
        passwordPlaceholder: String = "Password",
        loginButtonTitle: String = "Log In",
        forgotPasswordTitle: String = "Forgot password?",
        socialDividerTitle: String = "or",
        showsForgotPassword: Bool = true,
        showsSocialLogin: Bool = true,
        socialProviders: [SocialLoginProvider] = [.apple, .google, .facebook]
    ) {
        self.title = title
        self.usernamePlaceholder = usernamePlaceholder
        self.passwordPlaceholder = passwordPlaceholder
        self.loginButtonTitle = loginButtonTitle
        self.forgotPasswordTitle = forgotPasswordTitle
        self.socialDividerTitle = socialDividerTitle
        self.showsForgotPassword = showsForgotPassword
        self.showsSocialLogin = showsSocialLogin
        self.socialProviders = socialProviders
    }

    /// The providers that are actually rendered, taking `showsSocialLogin` into account.
    public var visibleSocialProviders: [SocialLoginProvider] {
        showsSocialLogin ? socialProviders : []
    }
}
