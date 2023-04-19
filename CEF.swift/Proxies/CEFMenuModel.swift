//
//  CEFMenuModel.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 03..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFMenuModel {

    typealias CommandID = CEFMenuID
    typealias GroupID = Int32
    
    /// Create a new MenuModel with the specified |delegate|.
    /// CEF name: `CreateMenuModel`
    convenience init?(delegate: CEFMenuModelDelegate? = nil) {
        let cefDelegatePtr = delegate?.toCEF()
        self.init(ptr: cef_menu_model_create(cefDelegatePtr))
    }

    /// Returns true if this menu is a submenu.
    /// CEF name: `IsSubMenu`
    var isSubmenu: Bool {
        return cefObject.is_sub_menu(cefObjectPtr) != 0
    }

    /// Clears the menu. Returns true on success.
    /// CEF name: `Clear`
    @discardableResult
    func clear() -> Bool {
        return cefObject.clear(cefObjectPtr) != 0
    }
    
    /// Returns the number of items in this menu.
    /// CEF name: `GetCount`
    var count: Int {
        return Int(cefObject.get_count(cefObjectPtr))
    }

    /// Add a separator to the menu. Returns true on success.
    /// CEF name: `AddSeparator`
    @discardableResult
    func addSeparator() -> Bool {
        return cefObject.add_separator(cefObjectPtr) != 0
    }
    
    /// Add an item to the menu. Returns true on success.
    /// CEF name: `AddItem`
    @discardableResult
    func addItem(_ label: String, commandID: CommandID) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.add_item(cefObjectPtr, commandID.toCEF(), cefStrPtr) != 0
    }
    
    /// Add a check item to the menu. Returns true on success.
    /// CEF name: `AddCheckItem`
    @discardableResult
    func addCheckItem(_ label: String, commandID: CommandID) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.add_check_item(cefObjectPtr, commandID.toCEF(), cefStrPtr) != 0
    }

    /// Add a radio item to the menu. Only a single item with the specified
    /// |group_id| can be checked at a time. Returns true on success.
    /// CEF name: `AddRadioItem`
    @discardableResult
    func addRadioItem(_ label: String, commandID: CommandID, groupID: GroupID) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.add_radio_item(cefObjectPtr, commandID.toCEF(), cefStrPtr, groupID) != 0
    }
    
    /// Add a sub-menu to the menu. The new sub-menu is returned.
    /// CEF name: `AddSubMenu`
    func addSubmenu(_ label: String, commandID: CommandID) -> CEFMenuModel? {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        let cefMenu = cefObject.add_sub_menu(cefObjectPtr, commandID.toCEF(), cefStrPtr)
        return CEFMenuModel.fromCEF(cefMenu)
    }
    
    /// Insert a separator in the menu at the specified |index|. Returns true on
    /// success.
    /// CEF name: `InsertSeparatorAt`
    @discardableResult
    func insertSeparator(at index: Int) -> Bool {
        return cefObject.insert_separator_at(cefObjectPtr, index) != 0
    }

    /// Insert an item in the menu at the specified |index|. Returns true on
    /// success.
    /// CEF name: `InsertItemAt`
    @discardableResult
    func insertItem(_ label: String, at index: Int, commandID: CommandID) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.insert_item_at(cefObjectPtr, index, commandID.toCEF(), cefStrPtr) != 0
    }

    /// Insert a check item in the menu at the specified |index|. Returns true on
    /// success.
    /// CEF name: `InsertCheckItemAt`
    @discardableResult
    func insertCheckItem(_ label: String, at index: Int, commandID: CommandID) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.insert_check_item_at(cefObjectPtr, index, commandID.toCEF(), cefStrPtr) != 0
    }
    
    /// Insert a radio item in the menu at the specified |index|. Only a single
    /// item with the specified |group_id| can be checked at a time. Returns true
    /// on success.
    /// CEF name: `InsertRadioItemAt`
    @discardableResult
    func insertRadioItem(_ label: String, at index: Int, commandID: CommandID, groupID: GroupID) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.insert_radio_item_at(cefObjectPtr, index, commandID.toCEF(), cefStrPtr, groupID) != 0
    }
    
    /// Insert a sub-menu in the menu at the specified |index|. The new sub-menu
    /// is returned.
    /// CEF name: `InsertSubMenuAt`
    func insertSubmenu(_ label: String, at index: Int, commandID: CommandID) -> CEFMenuModel? {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        let cefMenu = cefObject.insert_sub_menu_at(cefObjectPtr, index, commandID.toCEF(), cefStrPtr)
        return CEFMenuModel.fromCEF(cefMenu)
    }
    
    /// Removes the item with the specified |command_id|. Returns true on success.
    /// CEF name: `Remove`
    @discardableResult
    func removeItem(commandID: CommandID) -> Bool {
        return cefObject.remove(cefObjectPtr, commandID.toCEF()) != 0
    }

    /// Removes the item at the specified |index|. Returns true on success.
    /// CEF name: `RemoveAt`
    @discardableResult
    func removeItem(at index: Int) -> Bool {
        return cefObject.remove_at(cefObjectPtr, index) != 0
    }
    
    /// Returns the index associated with the specified |command_id| or -1 if not
    /// found due to the command id not existing in the menu.
    /// CEF name: `GetIndexOf`
    func index(for commandID: CommandID) -> Int? {
        let index = cefObject.get_index_of(cefObjectPtr, commandID.toCEF())
        return index != -1 ? Int(index) : nil
    }
    
    /// Returns the command id at the specified |index| or -1 if not found due to
    /// invalid range or the index being a separator.
    /// CEF name: `GetCommandIdAt`
    func commandID(at index: Int) -> CommandID? {
        let cefID = cefObject.get_command_id_at(cefObjectPtr, index)
        return cefID != -1 ? CommandID.fromCEF(cefID) : nil
    }
    
    /// Sets the command id at the specified |index|. Returns true on success.
    /// CEF name: `SetCommandIdAt`
    @discardableResult
    func setCommandID(_ commandID: CommandID, at index: Int) -> Bool {
        return cefObject.set_command_id_at(cefObjectPtr, index, commandID.toCEF()) != 0
    }
    
    /// Returns the label for the specified |command_id| or empty if not found.
    /// CEF name: `GetLabel`
    func label(for commandID: CommandID) -> String? {
        let cefStrPtr = cefObject.get_label(cefObjectPtr, commandID.toCEF())
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringPtrToSwiftString(cefStrPtr)
    }
    
    /// Returns the label at the specified |index| or empty if not found due to
    /// invalid range or the index being a separator.
    /// CEF name: `GetLabelAt`
    func label(at index: Int) -> String? {
        let cefStrPtr = cefObject.get_label_at(cefObjectPtr, index)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringPtrToSwiftString(cefStrPtr)
    }
    
    /// Sets the label for the specified |command_id|. Returns true on success.
    /// CEF name: `SetLabel`
    @discardableResult
    func setLabel(_ label: String, for commandID: CommandID) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.set_label(cefObjectPtr, commandID.toCEF(), cefStrPtr) != 0
    }
    
    /// Set the label at the specified |index|. Returns true on success.
    /// CEF name: `SetLabelAt`
    @discardableResult
    func setLabel(_ label: String, at index: Int) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.set_label_at(cefObjectPtr, index, cefStrPtr) != 0
    }
    
    /// Returns the item type for the specified |command_id|.
    /// CEF name: `GetType`
    func type(for commandID: CommandID) -> CEFMenuItemType {
        let cefType = cefObject.get_type(cefObjectPtr, commandID.toCEF())
        return CEFMenuItemType.fromCEF(cefType)
    }

    /// Returns the item type at the specified |index|.
    /// CEF name: `GetTypeAt`
    func type(at index: Int) -> CEFMenuItemType {
        let cefType = cefObject.get_type_at(cefObjectPtr, index)
        return CEFMenuItemType.fromCEF(cefType)
    }
    
    /// Returns the group id for the specified |command_id| or -1 if invalid.
    /// CEF name: `GetGroupId`
    func groupID(for commandID: CommandID) -> GroupID? {
        let groupID = cefObject.get_group_id(cefObjectPtr, commandID.toCEF())
        return groupID != -1 ? groupID : nil
    }
    
    /// Returns the group id at the specified |index| or -1 if invalid.
    /// CEF name: `GetGroupIdAt`
    func groupID(at index: Int) -> GroupID? {
        let groupID = cefObject.get_group_id_at(cefObjectPtr, index)
        return groupID != -1 ? groupID : nil
    }
    
    /// Sets the group id for the specified |command_id|. Returns true on success.
    /// CEF name: `SetGroupId`
    @discardableResult
    func setGroupID(_ groupID: GroupID, for commandID: CommandID) -> Bool {
        return cefObject.set_group_id(cefObjectPtr, commandID.toCEF(), groupID) != 0
    }
    
    /// Sets the group id at the specified |index|. Returns true on success.
    /// CEF name: `SetGroupIdAt`
    @discardableResult
    func setGroupID(_ groupID: GroupID, at index: Int) -> Bool {
        return cefObject.set_group_id_at(cefObjectPtr, index, groupID) != 0
    }
    
    /// Returns the submenu for the specified |command_id| or empty if invalid.
    /// CEF name: `GetSubMenu`
    func submenu(for commandID: CommandID) -> CEFMenuModel? {
        let cefMenu = cefObject.get_sub_menu(cefObjectPtr, commandID.toCEF())
        return CEFMenuModel.fromCEF(cefMenu)
    }

    /// Returns the submenu at the specified |index| or empty if invalid.
    /// CEF name: `GetSubMenuAt`
    func submenu(at index: Int) -> CEFMenuModel? {
        let cefMenu = cefObject.get_sub_menu_at(cefObjectPtr, index)
        return CEFMenuModel.fromCEF(cefMenu)
    }
    
    /// Returns true if the specified |command_id| is visible.
    /// CEF name: `IsVisible`
    func isVisible(commandID: CommandID) -> Bool {
        return cefObject.is_visible(cefObjectPtr, commandID.toCEF()) != 0
    }

    /// Returns true if the specified |index| is visible.
    /// CEF name: `IsVisibleAt`
    func isVisible(at index: Int) -> Bool {
        return cefObject.is_visible_at(cefObjectPtr, index) != 0
    }

    /// Change the visibility of the specified |command_id|. Returns true on
    /// success.
    /// CEF name: `SetVisible`
    @discardableResult
    func setVisible(_ visible: Bool, for commandID: CommandID) -> Bool {
        return cefObject.set_visible(cefObjectPtr, commandID.toCEF(), visible ? 1 : 0) != 0
    }

    /// Change the visibility at the specified |index|. Returns true on success.
    /// CEF name: `SetVisibleAt`
    @discardableResult
    func setVisible(_ visible: Bool, at index: Int) -> Bool {
        return cefObject.set_visible_at(cefObjectPtr, index, visible ? 1 : 0) != 0
    }

    /// Returns true if the specified |command_id| is enabled.
    /// CEF name: `IsEnabled`
    func isEnabled(commandID: CommandID) -> Bool {
        return cefObject.is_enabled(cefObjectPtr, commandID.toCEF()) != 0
    }
    
    /// Returns true if the specified |index| is enabled.
    /// CEF name: `IsEnabledAt`
    func isEnabled(at index: Int) -> Bool {
        return cefObject.is_enabled_at(cefObjectPtr, index) != 0
    }

    /// Change the enabled status of the specified |command_id|. Returns true on
    /// success.
    /// CEF name: `SetEnabled`
    @discardableResult
    func setEnabled(_ enabled: Bool, for commandID: CommandID) -> Bool {
        return cefObject.set_enabled(cefObjectPtr, commandID.toCEF(), enabled ? 1 : 0) != 0
    }

    /// Change the enabled status at the specified |index|. Returns true on
    /// success.
    /// CEF name: `SetEnabledAt`
    @discardableResult
    func setEnabled(_ enabled: Bool, at index: Int) -> Bool {
        return cefObject.set_enabled_at(cefObjectPtr, index, enabled ? 1 : 0) != 0
    }
    
    /// Returns true if the specified |command_id| is checked. Only applies to
    /// check and radio items.
    /// CEF name: `IsChecked`
    func isChecked(commandID: CommandID) -> Bool {
        return cefObject.is_checked(cefObjectPtr, commandID.toCEF()) != 0
    }
    
    /// Returns true if the specified |index| is checked. Only applies to check
    /// and radio items.
    /// CEF name: `IsCheckedAt`
    func isChecked(at index: Int) -> Bool {
        return cefObject.is_checked_at(cefObjectPtr, index) != 0
    }
    
    /// Check the specified |command_id|. Only applies to check and radio items.
    /// Returns true on success.
    /// CEF name: `SetChecked`
    @discardableResult
    func setChecked(_ checked: Bool, for commandID: CommandID) -> Bool {
        return cefObject.set_checked(cefObjectPtr, commandID.toCEF(), checked ? 1 : 0) != 0
    }
    
    /// Check the specified |index|. Only applies to check and radio items. Returns
    /// true on success.
    /// CEF name: `SetCheckedAt`
    @discardableResult
    func setChecked(_ checked: Bool, at index: Int) -> Bool {
        return cefObject.set_checked_at(cefObjectPtr, index, checked ? 1 : 0) != 0
    }
    
    /// Returns true if the specified |command_id| has a keyboard accelerator
    /// assigned.
    /// CEF name: `HasAccelerator`
    func hasAccelerator(for commandID: CommandID) -> Bool {
        return cefObject.has_accelerator(cefObjectPtr, commandID.toCEF()) != 0
    }
    
    /// Returns true if the specified |index| has a keyboard accelerator assigned.
    /// CEF name: `HasAcceleratorAt`
    func hasAccelerator(at index: Int) -> Bool {
        return cefObject.has_accelerator_at(cefObjectPtr, index) != 0
    }
    
    /// Set the keyboard accelerator for the specified |command_id|. |key_code| can
    /// be any virtual key or character value. Returns true on success.
    /// CEF name: `SetAccelerator`
    @discardableResult
    func setAccelerator(_ accelerator: CEFMenuItemAccelerator, for commandID: CommandID) -> Bool {
        return cefObject.set_accelerator(cefObjectPtr,
                                         commandID.toCEF(),
                                         accelerator.keyCode,
                                         accelerator.shift ? 1 : 0,
                                         accelerator.control ? 1 : 0,
                                         accelerator.alt ? 1 : 0) != 0
    }

    /// Set the keyboard accelerator at the specified |index|. |key_code| can be
    /// any virtual key or character value. Returns true on success.
    /// CEF name: `SetAcceleratorAt`
    @discardableResult
    func setAccelerator(_ accelerator: CEFMenuItemAccelerator, at index: Int) -> Bool {
        return cefObject.set_accelerator_at(cefObjectPtr,
                                            index,
                                            accelerator.keyCode,
                                            accelerator.shift ? 1 : 0,
                                            accelerator.control ? 1 : 0,
                                            accelerator.alt ? 1 : 0) != 0
    }
    
    /// Remove the keyboard accelerator for the specified |command_id|. Returns
    /// true on success.
    /// CEF name: `RemoveAccelerator`
    @discardableResult
    func removeAccelerator(for commandID: CommandID) -> Bool {
        return cefObject.remove_accelerator(cefObjectPtr, commandID.toCEF()) != 0
    }

    /// Remove the keyboard accelerator at the specified |index|. Returns true on
    /// success.
    /// CEF name: `RemoveAcceleratorAt`
    @discardableResult
    func removeAccelerator(at index: Int) -> Bool {
        return cefObject.remove_accelerator_at(cefObjectPtr, index) != 0
    }
    
    /// Retrieves the keyboard accelerator for the specified |command_id|. Returns
    /// true on success.
    /// CEF name: `GetAccelerator`
    func accelerator(for commandID: CommandID) -> CEFMenuItemAccelerator? {
        var keyCode: Int32 = 0
        var shift: Int32 = 0
        var control: Int32 = 0
        var alt: Int32 = 0
        guard cefObject.get_accelerator(cefObjectPtr, commandID.toCEF(), &keyCode, &shift, &control, &alt) != 0 else {
            return nil
        }
        
        return CEFMenuItemAccelerator(keyCode: keyCode,
                                      shift: shift != 0,
                                      control: control != 0,
                                      alt: alt != 0)
    }

    /// Retrieves the keyboard accelerator for the specified |index|. Returns true
    /// on success.
    /// CEF name: `GetAcceleratorAt`
    func accelerator(at index: Int) -> CEFMenuItemAccelerator? {
        var keyCode: Int32 = 0
        var shift: Int32 = 0
        var control: Int32 = 0
        var alt: Int32 = 0
        guard cefObject.get_accelerator_at(cefObjectPtr, index, &keyCode, &shift, &control, &alt) != 0 else {
            return nil
        }
        
        return CEFMenuItemAccelerator(keyCode: keyCode,
                                      shift: shift != 0,
                                      control: control != 0,
                                      alt: alt != 0)
    }
    
    /// Set the explicit color for |command_id| and |color_type| to |color|.
    /// Specify a |color| value of 0 to remove the explicit color. If no explicit
    /// color or default color is set for |color_type| then the system color will
    /// be used. Returns true on success.
    /// CEF name: `SetColor`
    @discardableResult
    func setColor(_ color: CEFColor, for commandID: CommandID, colorType: CEFMenuColorType) -> Bool {
        return cefObject.set_color(cefObjectPtr, commandID.toCEF(), colorType.toCEF(), color.toCEF()) != 0
    }
    
    /// Set the explicit color for |command_id| and |index| to |color|. Specify a
    /// |color| value of 0 to remove the explicit color. Specify an |index| value
    /// of -1 to set the default color for items that do not have an explicit
    /// color set. If no explicit color or default color is set for |color_type|
    /// then the system color will be used. Returns true on success.
    /// CEF name: `SetColorAt`
    @discardableResult
    func setColor(_ color: CEFColor, at index: Int, colorType: CEFMenuColorType) -> Bool {
        return cefObject.set_color(cefObjectPtr, Int32(index), colorType.toCEF(), color.toCEF()) != 0
    }
    
    /// Returns in |color| the color that was explicitly set for |command_id| and
    /// |color_type|. If a color was not set then 0 will be returned in |color|.
    /// Returns true on success.
    /// CEF name: `GetColor`
    func color(for commandID: CommandID, colorType: CEFMenuColorType) -> CEFColor? {
        var cefColor = cef_color_t()
        let result = cefObject.get_color(cefObjectPtr, commandID.toCEF(), colorType.toCEF(), &cefColor)
        return result != 0 ? CEFColor.fromCEF(cefColor) : nil
    }
    
    /// Returns in |color| the color that was explicitly set for |command_id| and
    /// |color_type|. Specify an |index| value of -1 to return the default color
    /// in |color|. If a color was not set then 0 will be returned in |color|.
    /// Returns true on success.
    /// CEF name: `GetColorAt`
    func color(at index: Int, colorType: CEFMenuColorType) -> CEFColor? {
        var cefColor = cef_color_t()
        let result = cefObject.get_color(cefObjectPtr, Int32(index), colorType.toCEF(), &cefColor)
        return result != 0 ? CEFColor.fromCEF(cefColor) : nil
    }
    
    /// Sets the font list for the specified |command_id|. If |font_list| is empty
    /// the system font will be used. Returns true on success. The format is
    /// "<FONT_FAMILY_LIST>,[STYLES] <SIZE>", where:
    /// - FONT_FAMILY_LIST is a comma-separated list of font family names,
    /// - STYLES is an optional space-separated list of style names (case-sensitive
    ///   "Bold" and "Italic" are supported), and
    /// - SIZE is an integer font size in pixels with the suffix "px".
    ///
    /// Here are examples of valid font description strings:
    /// - "Arial, Helvetica, Bold Italic 14px"
    /// - "Arial, 14px"
    /// CEF name: `SetFontList`
    @discardableResult
    func setFontList(_ fontList: String, for commandID: CommandID) -> Bool {
        let cefStr = CEFStringPtrCreateFromSwiftString(fontList)
        defer { CEFStringPtrRelease(cefStr) }
        return cefObject.set_font_list(cefObjectPtr, commandID.toCEF(), cefStr) != 0
    }
    
    /// Sets the font list for the specified |index|. Specify an |index| value of
    /// -1 to set the default font. If |font_list| is empty the system font will
    /// be used. Returns true on success. The format is
    /// "<FONT_FAMILY_LIST>,[STYLES] <SIZE>", where:
    /// - FONT_FAMILY_LIST is a comma-separated list of font family names,
    /// - STYLES is an optional space-separated list of style names (case-sensitive
    ///   "Bold" and "Italic" are supported), and
    /// - SIZE is an integer font size in pixels with the suffix "px".
    ///
    /// Here are examples of valid font description strings:
    /// - "Arial, Helvetica, Bold Italic 14px"
    /// - "Arial, 14px"
    /// CEF name: `SetFontListAt`
    @discardableResult
    func setFontList(_ fontList: String, at index: Int) -> Bool {
        let cefStr = CEFStringPtrCreateFromSwiftString(fontList)
        defer { CEFStringPtrRelease(cefStr) }
        return cefObject.set_font_list(cefObjectPtr, Int32(index), cefStr) != 0
    }
}
