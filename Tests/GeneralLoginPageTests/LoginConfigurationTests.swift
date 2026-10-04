import XCTest
@testable import GeneralLoginPage

final class LoginConfigurationTests: XCTestCase {

    func testDefaultsShowSocialLoginAndForgotPassword() {
        let configuration = LoginConfiguration()

        XCTAssertTrue(configuration.showsForgotPassword)
        XCTAssertEqual(configuration.visibleSocialProviders, [.apple, .google, .facebook])
    }

    func testHidingSocialLoginRemovesAllProviders() {
        let configuration = LoginConfiguration(showsSocialLogin: false)

        XCTAssertTrue(configuration.visibleSocialProviders.isEmpty)
        XCTAssertEqual(configuration.socialProviders.count, 3)
    }

    func testOnlySelectedProvidersAreVisible() {
        let configuration = LoginConfiguration(socialProviders: [.google])

        XCTAssertEqual(configuration.visibleSocialProviders.map(\.id), ["google"])
    }

    func testCustomProvider() {
        let linkedIn = SocialLoginProvider(id: "linkedin", title: "Continue with LinkedIn", icon: .text("in"))
        let configuration = LoginConfiguration(socialProviders: [.apple, linkedIn])

        XCTAssertEqual(configuration.visibleSocialProviders.last?.title, "Continue with LinkedIn")
    }
}
