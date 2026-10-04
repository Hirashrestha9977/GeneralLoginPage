import SwiftUI

/// A reusable login screen with username and password fields, a forgot password
/// button and optional social media login buttons.
///
/// ```swift
/// GeneralLoginView(
///     configuration: LoginConfiguration(socialProviders: [.apple, .google]),
///     onLogin: { username, password in },
///     onForgotPassword: { },
///     onSocialLogin: { provider in }
/// )
/// ```
public struct GeneralLoginView: View {

    @State private var username = ""
    @State private var password = ""

    private let configuration: LoginConfiguration
    private let onLogin: (_ username: String, _ password: String) -> Void
    private let onForgotPassword: () -> Void
    private let onSocialLogin: (SocialLoginProvider) -> Void

    public init(
        configuration: LoginConfiguration = LoginConfiguration(),
        onLogin: @escaping (_ username: String, _ password: String) -> Void,
        onForgotPassword: @escaping () -> Void = {},
        onSocialLogin: @escaping (SocialLoginProvider) -> Void = { _ in }
    ) {
        self.configuration = configuration
        self.onLogin = onLogin
        self.onForgotPassword = onForgotPassword
        self.onSocialLogin = onSocialLogin
    }

    private var canSubmit: Bool {
        !username.trimmingCharacters(in: .whitespaces).isEmpty && !password.isEmpty
    }

    public var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text(configuration.title)
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 8)

                usernameField
                passwordField

                if configuration.showsForgotPassword {
                    Button(configuration.forgotPasswordTitle, action: onForgotPassword)
                        .font(.footnote)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .accessibilityIdentifier("forgotPasswordButton")
                }

                loginButton

                if !configuration.visibleSocialProviders.isEmpty {
                    socialSection
                }
            }
            .padding(24)
            .frame(maxWidth: 480)
            .frame(maxWidth: .infinity)
        }
    }

    private var usernameField: some View {
        TextField(configuration.usernamePlaceholder, text: $username)
            #if os(iOS)
            .textContentType(.username)
            .textInputAutocapitalization(.never)
            .keyboardType(.emailAddress)
            #endif
            .disableAutocorrection(true)
            .modifier(LoginFieldStyle())
            .accessibilityIdentifier("usernameField")
    }

    private var passwordField: some View {
        SecureField(configuration.passwordPlaceholder, text: $password)
            #if os(iOS)
            .textContentType(.password)
            #endif
            .modifier(LoginFieldStyle())
            .onSubmit(submit)
            .accessibilityIdentifier("passwordField")
    }

    private var loginButton: some View {
        Button(action: submit) {
            Text(configuration.loginButtonTitle)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 13)
                .foregroundColor(.white)
                .background(Color.accentColor.opacity(canSubmit ? 1 : 0.5))
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        }
        .buttonStyle(.plain)
        .disabled(!canSubmit)
        .accessibilityIdentifier("loginButton")
    }

    private var socialSection: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                line
                Text(configuration.socialDividerTitle)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                line
            }
            .padding(.vertical, 8)

            ForEach(configuration.visibleSocialProviders) { provider in
                SocialLoginButton(provider: provider) {
                    onSocialLogin(provider)
                }
            }
        }
    }

    private var line: some View {
        Rectangle()
            .fill(Color.secondary.opacity(0.3))
            .frame(height: 1)
    }

    private func submit() {
        guard canSubmit else { return }
        onLogin(username.trimmingCharacters(in: .whitespaces), password)
    }
}

private struct LoginFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textFieldStyle(.plain)
            .padding(.horizontal, 14)
            .padding(.vertical, 13)
            .background(Color.secondary.opacity(0.12))
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

#if DEBUG
struct GeneralLoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GeneralLoginView(onLogin: { _, _ in })
                .previewDisplayName("With social login")

            GeneralLoginView(
                configuration: LoginConfiguration(showsSocialLogin: false),
                onLogin: { _, _ in }
            )
            .previewDisplayName("Without social login")
        }
    }
}
#endif
