// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {

  internal enum GifView {
    /// Add to favourites
    internal static let addToFavourite = L10n.tr("Localizable", "gifView.addToFavourite")
    /// Remove from favourites
    internal static let removeFromFavourite = L10n.tr("Localizable", "gifView.removeFromFavourite")
  }

  internal enum GifsList {
    /// Trending GIFs
    internal static let trending = L10n.tr("Localizable", "gifsList.trending")
  }

  internal enum NetworkError {
    /// Check your internet connection and try again
    internal static let message = L10n.tr("Localizable", "networkError.message")
    /// Ok
    internal static let ok = L10n.tr("Localizable", "networkError.ok")
    /// Network error
    internal static let title = L10n.tr("Localizable", "networkError.title")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
