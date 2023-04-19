
public protocol CEFPreferenceManager {
    /// Returns true if a preference with the specified |name| exists. This method
    /// must be called on the browser process UI thread.
    /// CEF name: `HasPreference`

    func hasPreference(for name: String) -> Bool

    
    /// Returns the value for the preference with the specified |name|. Returns
    /// NULL if the preference does not exist. The returned object contains a copy
    /// of the underlying preference value and modifications to the returned object
    /// will not modify the underlying preference value. This method must be called
    /// on the browser process UI thread.
    /// CEF name: `GetPreference`

    func preferenceValue(for name: String) -> CEFValue?
    
    /// Returns all preferences as a dictionary. If |include_defaults| is true then
    /// preferences currently at their default value will be included. The returned
    /// object contains a copy of the underlying preference values and
    /// modifications to the returned object will not modify the underlying
    /// preference values. This method must be called on the browser process UI
    /// thread.
    /// CEF name: `GetAllPreferences`
    func allPreferences(includeDefaults: Bool) -> CEFDictionaryValue
    
    /// Returns true if the preference with the specified |name| can be modified
    /// using SetPreference. As one example preferences set via the command-line
    /// usually cannot be modified. This method must be called on the browser
    /// process UI thread.
    /// CEF name: `CanSetPreference`
    func canSetPreference(for name: String) -> Bool
    
    /// Set the |value| associated with preference |name|. Returns true if the
    /// value is set successfully and false otherwise. If |value| is NULL the
    /// preference will be restored to its default value. If setting the preference
    /// fails then |error| will be populated with a detailed description of the
    /// problem. This method must be called on the browser process UI thread.
    /// CEF name: `SetPreference`
    @discardableResult
    func setPreference(_ value: CEFValue?, for name: String) -> Bool
}
