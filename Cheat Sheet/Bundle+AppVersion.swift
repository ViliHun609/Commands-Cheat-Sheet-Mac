import Foundation

extension Bundle {
    var appVersion: String? {
        self.infoDictionary?["CFBundleShortVersionString"] as? String
    }

    var appBuildNumber: String? {
        self.infoDictionary?["CFBundleVersion"] as? String
    }

    var appVersionAndBuild: String? {
        guard let version = appVersion, let build = appBuildNumber else {
            return nil
        }
        return "v\(version) (\(build))"
    }
}
