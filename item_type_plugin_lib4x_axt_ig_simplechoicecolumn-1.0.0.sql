prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- Oracle APEX export file
--
-- You should run this script using a SQL client connected to the database as
-- the owner (parsing schema) of the application or as a database user with the
-- APEX_ADMINISTRATOR_ROLE role.
--
-- This export file has been automatically generated. Modifying this file is not
-- supported by Oracle and can lead to unexpected application and/or instance
-- behavior now or in the future.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_imp.import_begin (
 p_version_yyyy_mm_dd=>'2024.05.31'
,p_release=>'24.1.0'
,p_default_workspace_id=>1700466440038362
,p_default_application_id=>149
,p_default_id_offset=>0
,p_default_owner=>'HR'
);
end;
/
 
prompt APPLICATION 149 - Inspector
--
-- Application Export:
--   Application:     149
--   Name:            Inspector
--   Date and Time:   09:49 Monday October 21, 2024
--   Exported By:     DEVELOPER
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 50169277718860562866
--   Manifest End
--   Version:         24.1.0
--   Instance ID:     800104173856312
--

begin
  -- replace components
  wwv_flow_imp.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/item_type/lib4x_axt_ig_simplechoicecolumn
begin
wwv_flow_imp_shared.create_plugin(
 p_id=>wwv_flow_imp.id(50169277718860562866)
,p_plugin_type=>'ITEM TYPE'
,p_name=>'LIB4X.AXT.IG.SIMPLECHOICECOLUMN'
,p_display_name=>'LIB4X - IG Simple Choice Column'
,p_supported_component_types=>'APEX_APPL_PAGE_IG_COLUMNS'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'--------------------------------------------------------------------------------',
'-- t_item_attr type definition',
'--------------------------------------------------------------------------------',
'type t_item_attr is record',
'( ',
'    c_name                  varchar2(30),',
'    c_choice_type           varchar2(30), ',
'    c_on_value              varchar2(30),',
'    c_on_label              varchar2(30),',
'    c_off_value             varchar2(30),',
'    c_off_label             varchar2(30),    ',
'    c_value1                varchar2(30), ',
'    c_label1                varchar2(30),',
'    c_value2                varchar2(30),',
'    c_label2                varchar2(30),',
'    c_checked_value         varchar2(30),',
'    c_unchecked_value       varchar2(30),',
'    c_pill_button           varchar2(30),      ',
'    c_display_null_value    varchar2(30),',
'    c_null_display_value    varchar2(30),',
'    c_null_return_value     varchar2(30),',
'    value0                  varchar2(30),',
'    label0                  varchar2(30),    ',
'    value1                  varchar2(30),',
'    label1                  varchar2(30),',
'    value2                  varchar2(30),',
'    label2                  varchar2(30)',
'); ',
'',
'--------------------------------------------------------------------------------',
'-- init_item_attr Procedure',
'--------------------------------------------------------------------------------',
'procedure init_item_attr(',
'    p_item    in  apex_plugin.t_item,',
'    item_attr out t_item_attr',
')',
'is',
'begin',
'    item_attr.c_name                := apex_plugin.get_input_name_for_item;',
'    item_attr.c_choice_type         := p_item.attribute_01;     ',
'    item_attr.c_on_value            := p_item.attribute_02;  ',
'    item_attr.c_on_label            := p_item.attribute_03;',
'    item_attr.c_off_value           := p_item.attribute_04;',
'    item_attr.c_off_label           := p_item.attribute_05;    ',
'    item_attr.c_value1              := p_item.attribute_06;  ',
'    item_attr.c_label1              := p_item.attribute_07;',
'    item_attr.c_value2              := p_item.attribute_08;',
'    item_attr.c_label2              := p_item.attribute_09;',
'    item_attr.c_checked_value       := p_item.attribute_10;',
'    item_attr.c_unchecked_value     := p_item.attribute_11;  ',
'    item_attr.c_pill_button         := p_item.attribute_12;   ',
'    item_attr.c_display_null_value  := p_item.attribute_13;',
'    item_attr.c_null_display_value  := p_item.attribute_14;',
'    item_attr.c_null_return_value   := p_item.attribute_15;',
'    case item_attr.c_choice_type',
'        when ''RADIO_GROUP'' then',
'            item_attr.value0 := item_attr.c_null_return_value;',
'            item_attr.label0 := item_attr.c_null_display_value;        ',
'            item_attr.value1 := item_attr.c_value1;',
'            item_attr.label1 := item_attr.c_label1;',
'            item_attr.value2 := item_attr.c_value2;',
'            item_attr.label2 := item_attr.c_label2;',
'        when ''SWITCH_CB'' then',
'            item_attr.value0 := null;',
'            item_attr.label0 := null;          ',
'            item_attr.value1 := item_attr.c_on_value;',
'            item_attr.label1 := item_attr.c_on_label;',
'            item_attr.value2 := item_attr.c_off_value;',
'            item_attr.label2 := item_attr.c_off_label; ',
'        when ''CHECKBOX'' then',
'            item_attr.value0 := null;',
'            item_attr.label0 := null;            ',
'            item_attr.value1 := item_attr.c_checked_value;',
'            item_attr.label1 := ''Checked'';',
'            item_attr.value2 := item_attr.c_unchecked_value;',
'            item_attr.label2 := ''Unchecked''; ',
'    end case;  ',
'end init_item_attr;',
'',
'--------------------------------------------------------------------------------',
'-- Render Procedure',
'-- Renders the hidden input element to maintain the item value',
'-- Adds on-load js as to init the item client-side',
'--------------------------------------------------------------------------------',
'procedure render_ig_simple_choice (',
'    p_item   in            apex_plugin.t_item,',
'    p_plugin in            apex_plugin.t_plugin,',
'    p_param  in            apex_plugin.t_item_render_param,',
'    p_result in out nocopy apex_plugin.t_item_render_result',
')',
'is',
'    item_attr           t_item_attr; ',
'    c_escaped_value     constant varchar2(30) := apex_escape.html_attribute(p_param.value);   ',
'begin',
'    apex_plugin_util.debug_page_item(p_plugin => p_plugin, p_page_item => p_item);',
'    init_item_attr(p_item, item_attr);',
'    if p_param.is_readonly or p_param.is_printer_friendly then',
'        null;',
'        -- do nothing - APEX will create a hidden input element with id as p_item.name',
'    else',
'        -- render hidden input element which will hold the value',
'        -- client side, using apex.item.create, the interface will be implemented and',
'        -- the specific choice item html will be rendered for user interaction',
'        sys.htp.prn(',
'            apex_string.format(',
'                ''<input type="hidden" %s id="%s" value="%s"/>''',
'                , apex_plugin_util.get_element_attributes(p_item, item_attr.c_name)',
'                , p_item.name',
'                , case when p_param.value is null then '''' else ltrim( rtrim ( c_escaped_value ) ) end',
'            )',
'        );',
'    end if;     ',
'',
'    -- When specifying the library declaratively, it fails to load the minified version. So using the API:',
'    apex_javascript.add_library(',
'          p_name      => ''ig-simplechoicecolumn'',',
'          p_check_to_add_minified => true,',
'          p_directory => p_plugin.file_prefix || ''js/'',',
'          p_version   => NULL',
'    );                ',
'',
'    -- page on load: init simpleChoiceColumn',
'    apex_javascript.add_onload_code(',
'        p_code => apex_string.format(',
'            ''lib4x.axt.ig.simpleChoiceColumn.init("%s", {readOnly: %s, isRequired: %s, choiceType: "%s", displayNullValue: %s, displayAsPillButton: %s, value0: "%s", label0: "%s", value1: "%s", label1: "%s", value2: "%s", label2: "%s"});''',
'            , p_item.name',
'            , case when p_param.is_readonly then ''true'' else ''false'' end',
'            , case when p_item.is_required then ''true'' else ''false'' end            ',
'            , item_attr.c_choice_type',
'            , case when item_attr.c_display_null_value = ''Y'' then ''true'' else ''false'' end            ',
'            , case when item_attr.c_pill_button = ''Y'' then ''true'' else ''false'' end',
'            , item_attr.value0            ',
'            , item_attr.label0            ',
'            , item_attr.value1            ',
'            , item_attr.label1',
'            , item_attr.value2              ',
'            , item_attr.label2        ',
'        )',
'    );',
'',
'    p_result.is_navigable := true;',
'end render_ig_simple_choice;',
'',
'--------------------------------------------------------------------------------',
'-- Meta Data Procedure',
'-- Returns a LOV as will be used in Filter and in Export Report',
'--------------------------------------------------------------------------------',
'procedure metadata_ig_simple_choice (',
'    p_item   in            apex_plugin.t_item,',
'    p_plugin in            apex_plugin.t_plugin,',
'    p_param  in            apex_plugin.t_item_meta_data_param,',
'    p_result in out nocopy apex_plugin.t_item_meta_data_result )',
'is',
'    item_attr   t_item_attr;     ',
'begin',
'    init_item_attr(p_item, item_attr);',
'    -- define query getting return/display values',
'    -- as used by APEX in places like column filter and export report to pdf/excel/etc',
'    -- no need to include null value (it would be filtered out by APEX anyway in the end query)',
'    -- instead, the user can use ''is empty'' filter',
'    p_result.display_lov_definition := q''!select ''!'' || item_attr.label1 || q''!'' as d, ''!'' || item_attr.value1 || q''!'' as r !'' ||',
'                                       q''!from dual !'' ||',
'                                       q''!union all !'' ||',
'                                       q''!select ''!'' || item_attr.label2 || q''!'' as d, ''!'' || item_attr.value2 || q''!'' as r !'' ||',
'                                       q''!from dual!'';',
'    p_result.return_display_value := false;  -- return ''return'' value only for regular item display                                  ',
'    p_result.escape_output := false;',
'end metadata_ig_simple_choice;',
'',
'--------------------------------------------------------------------------------',
'-- Validation Procedure',
'-- Executed before user defined validations',
'--------------------------------------------------------------------------------',
'procedure validate_ig_simple_choice (',
'    p_item   in            apex_plugin.t_item,',
'    p_plugin in            apex_plugin.t_plugin,',
'    p_param  in            apex_plugin.t_item_validation_param,',
'    p_result in out nocopy apex_plugin.t_item_validation_result )',
'is',
'    item_attr   t_item_attr;     ',
'begin',
'    init_item_attr(p_item, item_attr);',
'    if (item_attr.c_choice_type = ''RADIO_GROUP'') then',
'        if (((p_param.value is not null)) and (not(p_param.value in (item_attr.c_null_return_value, item_attr.c_value1, item_attr.c_value2)))) then',
'            p_result.message := ''Radio Group contains invalid value ('' || p_param.value || '')'';',
'        end if;',
'    end if;',
'end validate_ig_simple_choice;',
''))
,p_api_version=>2
,p_render_function=>'render_ig_simple_choice'
,p_meta_data_function=>'metadata_ig_simple_choice'
,p_validation_function=>'validate_ig_simple_choice'
,p_standard_attributes=>'VISIBLE:SESSION_STATE:READONLY:SOURCE:ENCRYPT:FILTER'
,p_substitute_attributes=>true
,p_version_scn=>266051366
,p_subscribe_plugin_settings=>true
,p_help_text=>'Enables the user to instantly select between two choices on multiple rows of the Interactive Grid without need to first click on the cell to get the input item visible. The type of Choice Item can be a Radio Group, Checkbox or Switch. Radio buttons c'
||'an also be displayed as Pill buttons. The behavior is similar to the native APEX Interactive Grid Checkbox. A difference though is, using the plugin, the Interactive Grid will automatically be put in Edit Mode in case it isn''t yet. From this, change '
||'events will always be fired also, and any related Dynamic Action triggered.'
,p_version_identifier=>'1.1.0'
,p_about_url=>'https://github.com/kekema/apex-ig-simple-choice-column'
,p_files_version=>514
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(27349019314361734)
,p_plugin_id=>wwv_flow_imp.id(50169277718860562866)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Choice Type'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'RADIO_GROUP'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Select the type of choice item you want to use. In case of ''Radio Group'', you will be given the option whether you want to use Pill Buttons.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(27350065232364174)
,p_plugin_attribute_id=>wwv_flow_imp.id(27349019314361734)
,p_display_sequence=>10
,p_display_value=>'Radio Group'
,p_return_value=>'RADIO_GROUP'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(27351198029365481)
,p_plugin_attribute_id=>wwv_flow_imp.id(27349019314361734)
,p_display_sequence=>20
,p_display_value=>'Switch'
,p_return_value=>'SWITCH_CB'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(27436750480940909)
,p_plugin_attribute_id=>wwv_flow_imp.id(27349019314361734)
,p_display_sequence=>30
,p_display_value=>'Checkbox'
,p_return_value=>'CHECKBOX'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(27352403485372812)
,p_plugin_id=>wwv_flow_imp.id(50169277718860562866)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'On Value'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(27349019314361734)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'SWITCH_CB'
,p_help_text=>'Specify the value of the item as related to the ''On'' state of the switch.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(27353468023375606)
,p_plugin_id=>wwv_flow_imp.id(50169277718860562866)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'On Label'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(27349019314361734)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'SWITCH_CB'
,p_help_text=>'Specify the label of the item as related to the ''On'' state of the switch.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(27354619152377932)
,p_plugin_id=>wwv_flow_imp.id(50169277718860562866)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Off Value'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(27349019314361734)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'SWITCH_CB'
,p_help_text=>'Specify the value of the item as related to the ''Off'' state of the switch.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(27355704575381926)
,p_plugin_id=>wwv_flow_imp.id(50169277718860562866)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_prompt=>'Off Label'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(27349019314361734)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'SWITCH_CB'
,p_help_text=>'Specify the label of the item as related to the ''Off'' state of the switch.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(27357148422393838)
,p_plugin_id=>wwv_flow_imp.id(50169277718860562866)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_prompt=>'Left Value'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(27349019314361734)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'RADIO_GROUP'
,p_help_text=>'Specify the value of the item as related to the ''Checked'' state of the left radio button.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(27358277436396602)
,p_plugin_id=>wwv_flow_imp.id(50169277718860562866)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>70
,p_prompt=>'Left Label'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(27349019314361734)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'RADIO_GROUP'
,p_help_text=>'Specify the label of the left radio button.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(27359329385398390)
,p_plugin_id=>wwv_flow_imp.id(50169277718860562866)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>8
,p_display_sequence=>80
,p_prompt=>'Right Value'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(27349019314361734)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'RADIO_GROUP'
,p_help_text=>'Specify the value of the item as related to the ''Checked'' state of the right radio button.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(27360479154401009)
,p_plugin_id=>wwv_flow_imp.id(50169277718860562866)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>9
,p_display_sequence=>90
,p_prompt=>'Right Label'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(27349019314361734)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'RADIO_GROUP'
,p_help_text=>'Specify the label of the right radio button.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(27433786625930620)
,p_plugin_id=>wwv_flow_imp.id(50169277718860562866)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>10
,p_display_sequence=>100
,p_prompt=>'Checked Value'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(27349019314361734)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'CHECKBOX'
,p_help_text=>'Specify the value of the item as related to the ''Checked'' state of the checkbox.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(27434921465933142)
,p_plugin_id=>wwv_flow_imp.id(50169277718860562866)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>11
,p_display_sequence=>110
,p_prompt=>'Unchecked Value'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(27349019314361734)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'CHECKBOX'
,p_help_text=>'Specify the value of the item as related to the ''Unchecked'' state of the checkbox.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(27495972070423274)
,p_plugin_id=>wwv_flow_imp.id(50169277718860562866)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>12
,p_display_sequence=>150
,p_prompt=>'Display as Pill Button'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>true
,p_default_value=>'N'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(27349019314361734)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'RADIO_GROUP'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(17785180779225667)
,p_plugin_id=>wwv_flow_imp.id(50169277718860562866)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>13
,p_display_sequence=>120
,p_prompt=>'Display Null Value'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_show_in_wizard=>false
,p_default_value=>'N'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(27349019314361734)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'RADIO_GROUP'
,p_help_text=>'Specify whether the Radio Group has a NULL option.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(17786294345232278)
,p_plugin_id=>wwv_flow_imp.id(50169277718860562866)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>14
,p_display_sequence=>130
,p_prompt=>'Null Display Value'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_show_in_wizard=>false
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(17785180779225667)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_help_text=>'Enter the text to be displayed for the NULL option within the Radio Group.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(17787325213235248)
,p_plugin_id=>wwv_flow_imp.id(50169277718860562866)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>15
,p_display_sequence=>140
,p_prompt=>'Null Return Value'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_show_in_wizard=>false
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(17785180779225667)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_help_text=>'Enter the value to be returned for the NULL option within the Radio Group. If you do not provide a value, the item value is left as null when the NULL option is selected.'
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '2F2A2A0A202A2040617574686F72204B6172656C20456B656D610A202A20406C6963656E7365204D4954206C6963656E73650A202A20436F70797269676874202863292032303234204B6172656C20456B656D610A202A0A202A205065726D697373696F';
wwv_flow_imp.g_varchar2_table(2) := '6E20697320686572656279206772616E7465642C2066726565206F66206368617267652C20746F20616E7920706572736F6E206F627461696E696E67206120636F70790A202A206F66207468697320736F66747761726520616E64206173736F63696174';
wwv_flow_imp.g_varchar2_table(3) := '656420646F63756D656E746174696F6E2066696C657320287468652027536F66747761726527292C20746F206465616C0A202A20696E2074686520536F66747761726520776974686F7574207265737472696374696F6E2C20696E636C7564696E672077';
wwv_flow_imp.g_varchar2_table(4) := '6974686F7574206C696D69746174696F6E20746865207269676874730A202A20746F207573652C20636F70792C206D6F646966792C206D657267652C207075626C6973682C20646973747269627574652C207375626C6963656E73652C20616E642F6F72';
wwv_flow_imp.g_varchar2_table(5) := '2073656C6C0A202A20636F70696573206F662074686520536F6674776172652C20616E6420746F207065726D697420706572736F6E7320746F2077686F6D2074686520536F6674776172652069730A202A206675726E697368656420746F20646F20736F';
wwv_flow_imp.g_varchar2_table(6) := '2C207375626A65637420746F2074686520666F6C6C6F77696E6720636F6E646974696F6E733A0A202A0A202A205468652061626F766520636F70797269676874206E6F7469636520616E642074686973207065726D697373696F6E206E6F746963652073';
wwv_flow_imp.g_varchar2_table(7) := '68616C6C20626520696E636C7564656420696E20616C6C0A202A20636F70696573206F72207375627374616E7469616C20706F7274696F6E73206F662074686520536F6674776172652E0A202A0A202A2054484520534F4654574152452049532050524F';
wwv_flow_imp.g_varchar2_table(8) := '564944454420274153204953272C20574954484F55542057415252414E5459204F4620414E59204B494E442C2045585052455353204F520A202A20494D504C4945442C20494E434C5544494E4720425554204E4F54204C494D4954454420544F20544845';
wwv_flow_imp.g_varchar2_table(9) := '2057415252414E54494553204F46204D45524348414E544142494C4954592C0A202A204649544E45535320464F52204120504152544943554C415220505552504F534520414E44204E4F4E494E4652494E47454D454E542E20494E204E4F204556454E54';
wwv_flow_imp.g_varchar2_table(10) := '205348414C4C205448450A202A20415554484F5253204F5220434F5059524947485420484F4C44455253204245204C4941424C4520464F5220414E5920434C41494D2C2044414D41474553204F52204F544845520A202A204C494142494C4954592C2057';
wwv_flow_imp.g_varchar2_table(11) := '48455448455220494E20414E20414354494F4E204F4620434F4E54524143542C20544F5254204F52204F54484552574953452C2041524953494E472046524F4D2C0A202A204F5554204F46204F5220494E20434F4E4E454354494F4E2057495448205448';
wwv_flow_imp.g_varchar2_table(12) := '4520534F465457415245204F522054484520555345204F52204F54484552204445414C494E475320494E205448450A202A20534F4654574152452E0A202A2F0A77696E646F772E6C696234783D77696E646F772E6C696234787C7C7B7D2C77696E646F77';
wwv_flow_imp.g_varchar2_table(13) := '2E6C696234782E6178743D77696E646F772E6C696234782E6178747C7C7B7D2C77696E646F772E6C696234782E6178742E69673D77696E646F772E6C696234782E6178742E69677C7C7B7D2C6C696234782E6178742E69672E73696D706C6543686F6963';
wwv_flow_imp.g_varchar2_table(14) := '65436F6C756D6E3D66756E6374696F6E28652C74297B72657475726E7B696E69743A66756E6374696F6E28612C69297B6C6574206C2C722C6E3D692E63686F696365547970652C6F3D21313B286E3D22524144494F5F47524F555022292626692E646973';
wwv_flow_imp.g_varchar2_table(15) := '706C61794E756C6C56616C75652626286F3D692E646973706C61794E756C6C56616C75652C6C3D692E76616C7565302C723D692E6C6162656C30293B6C657420633D692E76616C7565312C643D692E6C6162656C313B22434845434B424F58223D3D6E26';
wwv_flow_imp.g_varchar2_table(16) := '2628643D617065782E6C616E672E6765744D6573736167652822415045582E4954454D5F545950452E434845434B424F582E434845434B45442229293B6C657420702C732C753D692E76616C7565322C673D692E6C6162656C323B22434845434B424F58';
wwv_flow_imp.g_varchar2_table(17) := '223D3D6E262628673D617065782E6C616E672E6765744D6573736167652822415045582E4954454D5F545950452E434845434B424F582E554E434845434B45442229292C286E3D22524144494F5F47524F555022292626692E646973706C61794E756C6C';
wwv_flow_imp.g_varchar2_table(18) := '56616C75653F28703D5B722C642C675D2C733D5B6C2C632C755D293A28703D5B642C675D2C733D5B632C755D293B6C657420683D302C6B3D21312C623D692E726561644F6E6C792C6D3D28692E697352657175697265642C692E646973706C6179417350';
wwv_flow_imp.g_varchar2_table(19) := '696C6C427574746F6E293B636F6E737420783D65286023247B617D60293B6C657420433D22617065782D6974656D2D73696E676C652D636865636B626F78222B286D3F2220742D466F726D2D6669656C64436F6E7461696E65722D2D726164696F427574';
wwv_flow_imp.g_varchar2_table(20) := '746F6E47726F7570223A2222293B636F6E737420763D782E7772617028273C64697620636C6173733D22272B432B27223E3C2F6469763E27292E706172656E7428292C5F3D28652C742C61293D3E7B6C657420693D6E756C6C3B72657475726E22524144';
wwv_flow_imp.g_varchar2_table(21) := '494F5F47524F5550223D3D6E3F693D6628652C742C61293A225357495443485F4342223D3D6E3F693D7928652C742C61293A22434845434B424F58223D3D6E262628693D4F28652C742C6129292C697D2C663D28652C692C6C293D3E7B636F6E73742072';
wwv_flow_imp.g_varchar2_table(22) := '3D742E68746D6C4275696C64657228293B6D2626722E6D61726B757028223C64697622292E617474722822636C617373222C22742D466F726D2D6669656C64436F6E7461696E65722D2D726164696F427574746F6E47726F757022292E6D61726B757028';
wwv_flow_imp.g_varchar2_table(23) := '222F3E22292C722E6D61726B757028223C64697622292E6174747228226964222C60247B617D5F247B687D60292E617474722822636C617373222C22617065782D6974656D2D73696E676C652D636865636B626F7820726164696F5F67726F7570206170';
wwv_flow_imp.g_varchar2_table(24) := '65782D6974656D2D67726F757020617065782D6974656D2D67726F75702D2D726320617065782D6974656D2D726164696F206A732D69676E6F72654368616E676522292E617474722822726F6C65222C22726164696F67726F757022292E6D61726B7570';
wwv_flow_imp.g_varchar2_table(25) := '28223E3C64697622292E617474722822726F6C65222C226E6F6E6522292E617474722822636C617373222C22617065782D6974656D2D6772696420726164696F5F67726F757022292E6D61726B757028223E3C64697622292E617474722822726F6C6522';
wwv_flow_imp.g_varchar2_table(26) := '2C226E6F6E6522292E617474722822636C617373222C22617065782D6974656D2D677269642D726F772022292E6D61726B757028223E22293B666F72286C657420743D303B743C702E6C656E6774683B742B2B29722E6D61726B757028223C6469762229';
wwv_flow_imp.g_varchar2_table(27) := '2E617474722822636C617373222C22617065782D6974656D2D6F7074696F6E22292E6D61726B757028223E3C696E70757422292E6F7074696F6E616C41747472282264697361626C6564222C69292E61747472282274797065222C22726164696F22292E';
wwv_flow_imp.g_varchar2_table(28) := '6174747228226964222C60247B617D5F247B687D5F247B747D60292E6174747228226E616D65222C60247B617D5F247B687D5F524760292E617474722822646174612D646973706C6179222C60247B705B745D7D60292E61747472282276616C7565222C';
wwv_flow_imp.g_varchar2_table(29) := '60247B735B745D7D60292E617474722822617269612D6C6162656C222C60247B705B745D7D60292E6F7074696F6E616C417474722822636865636B6564222C653D3D3D735B745D292E6D61726B757028223E3C6C6162656C22292E617474722822636C61';
wwv_flow_imp.g_varchar2_table(30) := '7373222C22752D726164696F22292E617474722822666F72222C60247B617D5F247B687D5F247B747D60292E617474722822617269612D68696464656E222C2130292E6D61726B757028223E22292E636F6E74656E7428705B745D292E6D61726B757028';
wwv_flow_imp.g_varchar2_table(31) := '223C2F6C6162656C3E3C2F6469763E22293B72657475726E20722E6D61726B757028223C2F6469763E22292E6D61726B757028223C2F6469763E22292E6D61726B757028223C2F6469763E22292C6D2626722E6D61726B757028223C2F6469763E22292C';
wwv_flow_imp.g_varchar2_table(32) := '682B3D312C722E746F537472696E6728297D2C793D28652C692C6C293D3E7B636F6E737420723D742E68746D6C4275696C64657228293B72657475726E20722E6D61726B757028223C7370616E22292E617474722822636C617373222C22612D53776974';
wwv_flow_imp.g_varchar2_table(33) := '636822292E6D61726B757028223E3C696E70757422292E6F7074696F6E616C426F6F6C41747472282264697361626C6564222C69292E61747472282274797065222C22636865636B626F7822292E617474722822726F6C65222C2273776974636822292E';
wwv_flow_imp.g_varchar2_table(34) := '6174747228226964222C60247B617D5F247B687D5F3060292E6174747228226E616D65222C60247B617D5F247B687D5F535760292E617474722822636C617373222C226A732D69676E6F72654368616E6765206A732D7461626261626C6522292E617474';
wwv_flow_imp.g_varchar2_table(35) := '72282276616C7565222C735B305D292E617474722822646174612D6F6E2D6C6162656C222C705B305D292E617474722822646174612D6F66662D76616C7565222C735B315D292E617474722822646174612D6F66662D6C6162656C222C705B315D292E6F';
wwv_flow_imp.g_varchar2_table(36) := '7074696F6E616C426F6F6C417474722822636865636B6564222C653D3D3D735B305D292E6F7074696F6E616C417474722822617269612D6C6162656C6C65646279222C6C3F742E65736361706548544D4C41747472286C293A2222292E6D61726B757028';
wwv_flow_imp.g_varchar2_table(37) := '223E3C7370616E22292E617474722822636C617373222C22612D5377697463682D746F67676C6522292E6D61726B757028223E3C2F7370616E3E3C2F7370616E3E22292C682B3D312C722E746F537472696E6728297D2C4F3D28652C692C6C293D3E7B63';
wwv_flow_imp.g_varchar2_table(38) := '6F6E737420723D742E68746D6C4275696C64657228293B72657475726E20722E6D61726B757028223C64697622292E617474722822636C617373222C22617065782D6974656D2D73696E676C652D636865636B626F7822292E6D61726B757028223E3C69';
wwv_flow_imp.g_varchar2_table(39) := '6E70757422292E6F7074696F6E616C426F6F6C41747472282264697361626C6564222C69292E61747472282274797065222C22636865636B626F7822292E6174747228226964222C60247B617D5F247B687D5F3060292E6174747228226E616D65222C60';
wwv_flow_imp.g_varchar2_table(40) := '247B617D5F247B687D5F434260292E617474722822636C617373222C226A732D69676E6F72654368616E6765206A732D7461626261626C6522292E61747472282276616C7565222C735B305D292E6F7074696F6E616C426F6F6C41747472282263686563';
wwv_flow_imp.g_varchar2_table(41) := '6B6564222C653D3D3D735B305D292E6F7074696F6E616C417474722822617269612D6C6162656C6C65646279222C6C3F742E65736361706548544D4C41747472286C293A2222292E6D61726B757028223E3C7370616E22292E617474722822636C617373';
wwv_flow_imp.g_varchar2_table(42) := '222C22752D636865636B626F7822292E617474722822617269612D68696464656E222C2130292E6D61726B757028223E3C2F7370616E3E3C7370616E22292E617474722822636C617373222C22752D766822292E617474722822617269612D6869646465';
wwv_flow_imp.g_varchar2_table(43) := '6E222C2130292E6D61726B757028223E22292E636F6E74656E742842286529292E6D61726B757028223C2F7370616E3E3C2F6469763E22292C682B3D312C722E746F537472696E6728297D2C423D653D3E7B6C657420743D705B732E696E6465784F6628';
wwv_flow_imp.g_varchar2_table(44) := '65295D3B72657475726E20747C7C22227D2C453D28293D3E7B22524144494F5F47524F5550223D3D6E3F4928293A225357495443485F4342223D3D6E3F7728293A22434845434B424F58223D3D6E26264128297D2C493D28293D3E7B6C657420653D6E75';
wwv_flow_imp.g_varchar2_table(45) := '6C6C2C743D782E76616C28293B747C7C6F3F28653D762E66696E642827696E7075745B747970653D22726164696F225D5B76616C75653D22272B742B27225D27292C652E6C656E677468262628655B305D2E636865636B65643D213029293A762E66696E';
wwv_flow_imp.g_varchar2_table(46) := '642827696E7075745B747970653D22726164696F225D27292E65616368282866756E6374696F6E2865297B746869732E636865636B65643D21317D29297D2C773D28293D3E7B6C657420653D782E76616C28292C743D762E66696E642827696E7075745B';
wwv_flow_imp.g_varchar2_table(47) := '747970653D22636865636B626F78225D5B726F6C653D22737769746368225D27293B742E6C656E677468262628745B305D2E636865636B65643D653D3D735B305D297D2C413D28293D3E7B6C657420653D782E76616C28292C743D762E66696E64282769';
wwv_flow_imp.g_varchar2_table(48) := '6E7075745B747970653D22636865636B626F78225D27293B742E6C656E677468262628745B305D2E636865636B65643D653D3D735B305D297D2C483D28293D3E782E636C6F7365737428222E612D494722292E696E746572616374697665477269642822';
wwv_flow_imp.g_varchar2_table(49) := '676574566965777322292E677269642C523D653D3E7B652E70726F702822636865636B6564222C21652E70726F702822636865636B65642229292E7472696767657228226368616E676522292C655B305D2E696E64657465726D696E6174653D21317D2C';
wwv_flow_imp.g_varchar2_table(50) := '243D28293D3E7B4828292E76696577242E677269642822696E456469744D6F646522297C7C73657454696D656F7574282828293D3E7B782E636C6F7365737428222E612D494722292E696E746572616374697665477269642822676574416374696F6E73';
wwv_flow_imp.g_varchar2_table(51) := '22292E736574282265646974222C2130292C617065782E6576656E742E74726967676572282223222B612C226368616E6765222C6E756C6C297D292C3130297D3B696628627C7C762E617070656E64285F286E756C6C2C21312C6E756C6C29292C225241';
wwv_flow_imp.g_varchar2_table(52) := '44494F5F47524F5550223D3D6E29762E66696E642827696E7075745B747970653D22726164696F225D27292E6F6E28226368616E6765222C28743D3E7B636F6E737420613D6528742E63757272656E74546172676574293B615B305D2E636865636B6564';
wwv_flow_imp.g_varchar2_table(53) := '2626782E76616C28612E76616C2829292E6368616E676528297D29293B656C736520696628225357495443485F4342223D3D6E297B6C657420743D762E66696E642827696E7075745B747970653D22636865636B626F78225D5B726F6C653D2273776974';
wwv_flow_imp.g_varchar2_table(54) := '6368225D27293B742E636C6F7365737428227370616E2E612D53776974636822292E6F6E2822636C69636B222C2866756E6374696F6E2861297B6528612E746172676574292E697328223A636865636B626F7822297C7C742E697328223A64697361626C';
wwv_flow_imp.g_varchar2_table(55) := '656422297C7C522874297D29292C742E6F6E28226368616E6765222C28743D3E7B636F6E737420613D6528742E63757272656E74546172676574293B782E76616C28615B305D2E636865636B65643F735B305D3A735B315D292E6368616E676528297D29';
wwv_flow_imp.g_varchar2_table(56) := '297D656C73652069662822434845434B424F58223D3D6E297B762E66696E642827696E7075745B747970653D22636865636B626F78225D27292E6F6E28226368616E6765222C28743D3E7B636F6E737420613D6528742E63757272656E74546172676574';
wwv_flow_imp.g_varchar2_table(57) := '293B782E76616C28615B305D2E636865636B65643F735B305D3A735B315D292E6368616E676528297D29297D4528292C617065782E6974656D2E63726561746528612C7B6974656D5F747970653A2249475F53494D504C455F43484F494345222C676574';
wwv_flow_imp.g_varchar2_table(58) := '56616C756528297B72657475726E20746869732E6E6F64652E76616C75657D2C73657456616C75652865297B782E76616C2865292C4528297D2C64697361626C6528297B22524144494F5F47524F5550223D3D6E3F6528223A726164696F222C76292E70';
wwv_flow_imp.g_varchar2_table(59) := '726F70282264697361626C6564222C2130292E616464436C6173732822617065785F64697361626C65645F6D756C746922293A225357495443485F434222213D6E262622434845434B424F5822213D6E7C7C6528223A636865636B626F78222C76292E70';
wwv_flow_imp.g_varchar2_table(60) := '726F70282264697361626C6564222C2130292C6B3D21307D2C656E61626C6528297B22524144494F5F47524F5550223D3D6E3F6528223A726164696F222C76292E70726F70282264697361626C6564222C2131292E72656D6F7665436C61737328226170';
wwv_flow_imp.g_varchar2_table(61) := '65785F64697361626C65645F6D756C746922293A225357495443485F434222213D6E262622434845434B424F5822213D6E7C7C6528223A636865636B626F78222C76292E70726F70282264697361626C6564222C2131292C6B3D21317D2C697344697361';
wwv_flow_imp.g_varchar2_table(62) := '626C65643A28293D3E6B2C736574466F637573546F28297B6C657420743D6528223A636865636B6564222C76293B72657475726E20303D3D3D742E6C656E677468262628743D652822524144494F5F47524F5550223D3D6E3F223A726164696F223A223A';
wwv_flow_imp.g_varchar2_table(63) := '636865636B626F78222C7629292C742E666972737428297D2C646973706C617956616C7565466F7228652C74297B6C657420613D4828292E73696E676C65526F774D6F64652C693D743F2E726561646F6E6C797C7C743F2E64697361626C65643B726574';
wwv_flow_imp.g_varchar2_table(64) := '75726E20613F422865293A5F28652C692C743F2E6C6162656C4279297D2C67657456616C69646974793A66756E6374696F6E28297B636F6E737420653D782E70726F702822726571756972656422293B72657475726E20766F69642030213D3D65262621';
wwv_flow_imp.g_varchar2_table(65) := '31213D3D652626746869732E6973456D70747928293F7B76616C69643A21312C76616C75654D697373696E673A21307D3A7B76616C69643A21307D7D2C676574496E746572616374696F6E53656C6563746F7228297B6C657420653D6E756C6C3B726574';
wwv_flow_imp.g_varchar2_table(66) := '75726E22524144494F5F47524F5550223D3D6E3F653D222E752D726164696F2C2E617065782D6974656D2D6F7074696F6E223A225357495443485F4342223D3D6E3F653D222E612D537769746368223A22434845434B424F58223D3D6E262628653D222E';
wwv_flow_imp.g_varchar2_table(67) := '752D636865636B626F782C2E617065782D6974656D2D73696E676C652D636865636B626F7822292C657D2C6F6E496E746572616374696F6E28742C692C6C2C72297B69662822524144494F5F47524F5550223D3D6E297B69662822636C69636B223D3D74';
wwv_flow_imp.g_varchar2_table(68) := '2E747970657C7C226163746976617465223D3D742E74797065297B6C6574206E3D6E756C6C3B6966286528742E746172676574292E697328222E752D726164696F22297C7C6528742E746172676574292E697328222E617065782D6974656D2D6F707469';
wwv_flow_imp.g_varchar2_table(69) := '6F6E22293F286528742E746172676574292E697328222E752D726164696F22293F6E3D6528742E7461726765742E706172656E74456C656D656E74292E66696E642827696E7075745B747970653D22726164696F225D27293A6528742E74617267657429';
wwv_flow_imp.g_varchar2_table(70) := '2E697328222E617065782D6974656D2D6F7074696F6E22292626286E3D6528742E746172676574292E66696E642827696E7075745B747970653D22726164696F225D2729292C6E5B305D2E636865636B65647C7C6E2E70726F702822636865636B656422';
wwv_flow_imp.g_varchar2_table(71) := '2C2130292E7472696767657228226368616E67652229293A6E3D6528742E746172676574292C22636C69636B223D3D742E74797065297B6C657420653D692E67657456616C7565286C2C72292C743D6E5B305D2E76616C75653B74213D65262628692E73';
wwv_flow_imp.g_varchar2_table(72) := '657456616C7565286C2C722C74292C242829297D656C736520696628226163746976617465223D3D742E74797065262621617065782E6974656D2861292E697344697361626C65642829297B6C657420653D782E76616C28292C743D6E5B305D2E76616C';
wwv_flow_imp.g_varchar2_table(73) := '75653B74213D652626746869732E73657456616C75652874297D7D7D656C736520696628225357495443485F4342223D3D6E7C7C22434845434B424F58223D3D6E297B6C6574206F3D6528742E7461726765742E706172656E74456C656D656E74292E66';
wwv_flow_imp.g_varchar2_table(74) := '696E642827696E7075745B747970653D22636865636B626F78225D272B28225357495443485F4342223D3D6E3F275B726F6C653D22737769746368225D273A222229293B69662822636C69636B223D3D742E74797065297B6528742E746172676574292E';
wwv_flow_imp.g_varchar2_table(75) := '697328223A636865636B626F7822297C7C6F2E697328223A64697361626C656422297C7C52286F293B6C657420613D692E67657456616C7565286C2C72292C6E3D6F2E70726F702822636865636B656422293F735B305D3A735B315D3B6E213D61262628';
wwv_flow_imp.g_varchar2_table(76) := '692E73657456616C7565286C2C722C6E292C242829297D656C736520696628226163746976617465223D3D742E74797065262621617065782E6974656D2861292E697344697361626C65642829297B6F2E697328223A64697361626C656422297C7C5228';
wwv_flow_imp.g_varchar2_table(77) := '6F293B6C657420653D782E76616C28292C743D6F2E70726F702822636865636B656422293F735B305D3A735B315D3B74213D652626746869732E73657456616C75652874297D7D7D7D297D7D7D28617065782E6A51756572792C617065782E7574696C29';
wwv_flow_imp.g_varchar2_table(78) := '3B';
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(17805605606214562)
,p_plugin_id=>wwv_flow_imp.id(50169277718860562866)
,p_file_name=>'js/ig-simplechoicecolumn.min.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '2F2A2A0A202A2040617574686F72204B6172656C20456B656D610A202A20406C6963656E7365204D4954206C6963656E73650A202A20436F70797269676874202863292032303234204B6172656C20456B656D610A202A0A202A205065726D697373696F';
wwv_flow_imp.g_varchar2_table(2) := '6E20697320686572656279206772616E7465642C2066726565206F66206368617267652C20746F20616E7920706572736F6E206F627461696E696E67206120636F70790A202A206F66207468697320736F66747761726520616E64206173736F63696174';
wwv_flow_imp.g_varchar2_table(3) := '656420646F63756D656E746174696F6E2066696C657320287468652027536F66747761726527292C20746F206465616C0A202A20696E2074686520536F66747761726520776974686F7574207265737472696374696F6E2C20696E636C7564696E672077';
wwv_flow_imp.g_varchar2_table(4) := '6974686F7574206C696D69746174696F6E20746865207269676874730A202A20746F207573652C20636F70792C206D6F646966792C206D657267652C207075626C6973682C20646973747269627574652C207375626C6963656E73652C20616E642F6F72';
wwv_flow_imp.g_varchar2_table(5) := '2073656C6C0A202A20636F70696573206F662074686520536F6674776172652C20616E6420746F207065726D697420706572736F6E7320746F2077686F6D2074686520536F6674776172652069730A202A206675726E697368656420746F20646F20736F';
wwv_flow_imp.g_varchar2_table(6) := '2C207375626A65637420746F2074686520666F6C6C6F77696E6720636F6E646974696F6E733A0A202A0A202A205468652061626F766520636F70797269676874206E6F7469636520616E642074686973207065726D697373696F6E206E6F746963652073';
wwv_flow_imp.g_varchar2_table(7) := '68616C6C20626520696E636C7564656420696E20616C6C0A202A20636F70696573206F72207375627374616E7469616C20706F7274696F6E73206F662074686520536F6674776172652E0A202A0A202A2054484520534F4654574152452049532050524F';
wwv_flow_imp.g_varchar2_table(8) := '564944454420274153204953272C20574954484F55542057415252414E5459204F4620414E59204B494E442C2045585052455353204F520A202A20494D504C4945442C20494E434C5544494E4720425554204E4F54204C494D4954454420544F20544845';
wwv_flow_imp.g_varchar2_table(9) := '2057415252414E54494553204F46204D45524348414E544142494C4954592C0A202A204649544E45535320464F52204120504152544943554C415220505552504F534520414E44204E4F4E494E4652494E47454D454E542E20494E204E4F204556454E54';
wwv_flow_imp.g_varchar2_table(10) := '205348414C4C205448450A202A20415554484F5253204F5220434F5059524947485420484F4C44455253204245204C4941424C4520464F5220414E5920434C41494D2C2044414D41474553204F52204F544845520A202A204C494142494C4954592C2057';
wwv_flow_imp.g_varchar2_table(11) := '48455448455220494E20414E20414354494F4E204F4620434F4E54524143542C20544F5254204F52204F54484552574953452C2041524953494E472046524F4D2C0A202A204F5554204F46204F5220494E20434F4E4E454354494F4E2057495448205448';
wwv_flow_imp.g_varchar2_table(12) := '4520534F465457415245204F522054484520555345204F52204F54484552204445414C494E475320494E205448450A202A20534F4654574152452E0A202A2F0A0A77696E646F772E6C69623478203D2077696E646F772E6C69623478207C7C207B7D3B0A';
wwv_flow_imp.g_varchar2_table(13) := '77696E646F772E6C696234782E617874203D2077696E646F772E6C696234782E617874207C7C207B7D3B0A77696E646F772E6C696234782E6178742E6967203D2077696E646F772E6C696234782E6178742E6967207C7C207B7D3B0A0A2F2A2053696D70';
wwv_flow_imp.g_varchar2_table(14) := '6C6543686F696365436F6C756D6E0A202A20456E61626C65732073696D706C6520726164696F2067726F75702C20636865636B626F78206F72207377697463682C206D756C74692D726F772C20696E20616E20496E74657261637469766520477269640A';
wwv_flow_imp.g_varchar2_table(15) := '202A20617320746F20666173742073656C656374206265747765656E20322063686F696365732E0A202A20417070726F6163682063616E20626520636F6D706172656420746F20746865206E617469766520494720636865636B626F78202D2077697468';
wwv_flow_imp.g_varchar2_table(16) := '206120646966666572656E6365207768656E2074686520757365720A202A2073746172747320636C69636B696E67207768656E20746865204947206973206E6F7420696E2065646974206D6F6465207965743A2075706F6E20666972737420636C69636B';
wwv_flow_imp.g_varchar2_table(17) := '2C207468652049470A202A206973206175746F6D61746963616C6C792073657420696E2065646974206D6F64652E2046726F6D20746869732C20616C736F20696D6D6564696174656C7920746865206368616E6765206576656E74730A202A2077696C6C';
wwv_flow_imp.g_varchar2_table(18) := '2062652066697265642C20736F20616E792044412067657473207472696767657265642E0A2A2F0A6C696234782E6178742E69672E73696D706C6543686F696365436F6C756D6E203D202866756E6374696F6E28242C207574696C29207B0A0A20202020';
wwv_flow_imp.g_varchar2_table(19) := '2F2F20496E697420746865206974656D202D2077696C6C2062652063616C6C6564206F6E2070616765206C6F61640A202020202F2F205468652076616C75652077696C6C206265206B657074206F6E20746865207365727665722D736964652067656E65';
wwv_flow_imp.g_varchar2_table(20) := '72617465642068696464656E20696E70757420656C656D656E742E0A202020202F2F20496E2074686520696E697420686572652C20746865207370656369666963206974656D20696E7465726661636520697320736574207570206279206170706C7969';
wwv_flow_imp.g_varchar2_table(21) := '6E6720617065782E6974656D2E6372656174652E0A202020202F2F20436C69656E742D736964652C207468652068746D6C20666F72207468652073706563696669632074797065206F662063686F696365206974656D2069732067656E6572617465642E';
wwv_flow_imp.g_varchar2_table(22) := '0A202020206C657420696E6974203D2066756E6374696F6E286974656D49642C206F7074696F6E73290A202020207B0A20202020202020202F2F2073657420757020636F6E74657874207661726961626C657320696E636C7564696E672073696D706C65';
wwv_flow_imp.g_varchar2_table(23) := '20617272617973206F6E206C6162656C732F76616C7565732E0A20202020202020206C65742063686F69636554797065203D206F7074696F6E732E63686F696365547970653B0A20202020202020206C657420646973706C61794E756C6C56616C756520';
wwv_flow_imp.g_varchar2_table(24) := '3D2066616C73653B202020200A20202020202020206C65742076616C7565303B0A20202020202020206C6574206C6162656C303B202020202020202020202020200A2020202020202020696620282863686F69636554797065203D2027524144494F5F47';
wwv_flow_imp.g_varchar2_table(25) := '524F55502729202626206F7074696F6E732E646973706C61794E756C6C56616C7565290A20202020202020207B0A202020202020202020202020646973706C61794E756C6C56616C7565203D206F7074696F6E732E646973706C61794E756C6C56616C75';
wwv_flow_imp.g_varchar2_table(26) := '653B200A20202020202020202020202076616C756530203D206F7074696F6E732E76616C7565303B0A2020202020202020202020206C6162656C30203D206F7074696F6E732E6C6162656C303B20200A20202020202020207D200A20202020202020206C';
wwv_flow_imp.g_varchar2_table(27) := '65742076616C756531203D206F7074696F6E732E76616C7565313B0A20202020202020206C6574206C6162656C31203D206F7074696F6E732E6C6162656C313B2020200A20202020202020206966202863686F69636554797065203D3D2027434845434B';
wwv_flow_imp.g_varchar2_table(28) := '424F5827290A20202020202020207B0A2020202020202020202020206C6162656C31203D20617065782E6C616E672E6765744D657373616765282022415045582E4954454D5F545950452E434845434B424F582E434845434B454422293B0A2020202020';
wwv_flow_imp.g_varchar2_table(29) := '2020207D20202020200A20202020202020206C65742076616C756532203D206F7074696F6E732E76616C7565323B0A20202020202020206C6574206C6162656C32203D206F7074696F6E732E6C6162656C323B0A20202020202020206966202863686F69';
wwv_flow_imp.g_varchar2_table(30) := '636554797065203D3D2027434845434B424F5827290A20202020202020207B0A2020202020202020202020206C6162656C32203D20617065782E6C616E672E6765744D657373616765282022415045582E4954454D5F545950452E434845434B424F582E';
wwv_flow_imp.g_varchar2_table(31) := '554E434845434B454422293B0A20202020202020207D202020202020202020200A20202020202020206C65742063686F6963654C6162656C3B0A20202020202020206C65742063686F69636556616C75653B0A2020202020202020696620282863686F69';
wwv_flow_imp.g_varchar2_table(32) := '636554797065203D2027524144494F5F47524F55502729202626206F7074696F6E732E646973706C61794E756C6C56616C7565290A20202020202020207B0A20202020202020202020202063686F6963654C6162656C203D205B6C6162656C302C206C61';
wwv_flow_imp.g_varchar2_table(33) := '62656C312C206C6162656C325D3B0A20202020202020202020202063686F69636556616C7565203D205B76616C7565302C2076616C7565312C2076616C7565325D3B2020202020202020202020200A20202020202020207D2020200A2020202020202020';
wwv_flow_imp.g_varchar2_table(34) := '656C73650A20202020202020207B0A20202020202020202020202063686F6963654C6162656C203D205B6C6162656C312C206C6162656C325D3B0A20202020202020202020202063686F69636556616C7565203D205B76616C7565312C2076616C756532';
wwv_flow_imp.g_varchar2_table(35) := '5D3B0A20202020202020207D20202020200A20202020202020206C657420696E646578203D20303B0A20202020202020206C6574206974656D497344697361626C6564203D2066616C73653B0A20202020202020206C6574206974656D4973526561644F';
wwv_flow_imp.g_varchar2_table(36) := '6E6C79203D206F7074696F6E732E726561644F6E6C793B200A20202020202020206C6574206974656D49735265717569726564203D206F7074696F6E732E697352657175697265643B0A20202020202020206C657420646973706C6179417350696C6C42';
wwv_flow_imp.g_varchar2_table(37) := '7574746F6E203D206F7074696F6E732E646973706C6179417350696C6C427574746F6E3B0A0A20202020202020202F2F207772617020746865207365727665722D736964652067656E65726174656420696E70757420656C656D656E740A202020202020';
wwv_flow_imp.g_varchar2_table(38) := '20202F2F206C617465726F6E2C20776520616464207468652073706563696669632068746D6C20666F72207468652063686F696365206974656D207479706520746F2074686973206469762C206E65787420746F207468652068696464656E200A202020';
wwv_flow_imp.g_varchar2_table(39) := '20202020202F2F20696E70757420656C656D656E740A2020202020202020636F6E7374206974656D24203D2024286023247B6974656D49647D60293B0A20202020202020206C65742077726170436C6173736573203D2027617065782D6974656D2D7369';
wwv_flow_imp.g_varchar2_table(40) := '6E676C652D636865636B626F7827202B2028646973706C6179417350696C6C427574746F6E203F202720742D466F726D2D6669656C64436F6E7461696E65722D2D726164696F427574746F6E47726F757027203A202727293B0A2020202020202020636F';
wwv_flow_imp.g_varchar2_table(41) := '6E737420697724203D206974656D242E7772617028273C64697620636C6173733D2227202B2077726170436C6173736573202B2027223E3C2F6469763E27292E706172656E7428293B0A0A20202020202020202F2F2072656E6465722074686520737065';
wwv_flow_imp.g_varchar2_table(42) := '63696669632063686F696365206974656D0A20202020202020202F2F20746869732063616E2062652061732070617274206F66207468652061626F766520646976206E65787420746F207468652068696464656E20696E70757420656C656D656E740A20';
wwv_flow_imp.g_varchar2_table(43) := '202020202020202F2F206F72207468652072656E646572696E672069732066726F6D20646973706C617956616C7565466F7220696E20746865206974656D20696E746572666163650A20202020202020202F2F20617320746F2072656E64657220666F72';
wwv_flow_imp.g_varchar2_table(44) := '206561636820616E6420657665727920726F770A2020202020202020636F6E73742072656E646572203D202876616C75652C2072656E64657244697361626C65642C206C6162656C427929203D3E207B0A2020202020202020202020206C657420726573';
wwv_flow_imp.g_varchar2_table(45) := '756C74203D206E756C6C3B0A2020202020202020202020206966202863686F69636554797065203D3D2027524144494F5F47524F555027290A2020202020202020202020207B0A20202020202020202020202020202020726573756C74203D2072656E64';
wwv_flow_imp.g_varchar2_table(46) := '6572526164696F47726F75702876616C75652C2072656E64657244697361626C65642C206C6162656C4279293B0A2020202020202020202020207D0A202020202020202020202020656C7365206966202863686F69636554797065203D3D202753574954';
wwv_flow_imp.g_varchar2_table(47) := '43485F434227290A2020202020202020202020207B0A20202020202020202020202020202020726573756C74203D2072656E6465725377697463682876616C75652C2072656E64657244697361626C65642C206C6162656C4279293B0A20202020202020';
wwv_flow_imp.g_varchar2_table(48) := '20202020207D0A202020202020202020202020656C7365206966202863686F69636554797065203D3D2027434845434B424F5827290A2020202020202020202020207B0A20202020202020202020202020202020726573756C74203D2072656E64657243';
wwv_flow_imp.g_varchar2_table(49) := '6865636B626F782876616C75652C2072656E64657244697361626C65642C206C6162656C4279293B0A2020202020202020202020207D2020202020202020202020200A20202020202020202020202072657475726E20726573756C743B0A202020202020';
wwv_flow_imp.g_varchar2_table(50) := '20207D0A0A2020202020202020636F6E73742072656E646572526164696F47726F7570203D202876616C75652C2072656E64657244697361626C65642C206C6162656C427929203D3E207B0A202020202020202020202020636F6E7374206F7574203D20';
wwv_flow_imp.g_varchar2_table(51) := '7574696C2E68746D6C4275696C64657228293B0A20202020202020202020202069662028646973706C6179417350696C6C427574746F6E290A2020202020202020202020207B0A202020202020202020202020202020206F75742E6D61726B757028273C';
wwv_flow_imp.g_varchar2_table(52) := '64697627290A20202020202020202020202020202020202020202E617474722827636C617373272C2027742D466F726D2D6669656C64436F6E7461696E65722D2D726164696F427574746F6E47726F757027290A20202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(53) := '202020202E6D61726B757028272F3E27290A2020202020202020202020207D0A2020202020202020202020206F75742E6D61726B757028273C64697627290A202020202020202020202020202020202E6174747228276964272C2060247B6974656D4964';
wwv_flow_imp.g_varchar2_table(54) := '7D5F247B696E6465787D60290A202020202020202020202020202020202E617474722827636C617373272C27617065782D6974656D2D73696E676C652D636865636B626F7820726164696F5F67726F757020617065782D6974656D2D67726F7570206170';
wwv_flow_imp.g_varchar2_table(55) := '65782D6974656D2D67726F75702D2D726320617065782D6974656D2D726164696F206A732D69676E6F72654368616E676527290A202020202020202020202020202020202E617474722827726F6C65272C27726164696F67726F757027290A2020202020';
wwv_flow_imp.g_varchar2_table(56) := '20202020202020202020202E6D61726B757028273E3C64697627290A202020202020202020202020202020202E617474722827726F6C65272C20276E6F6E6527290A202020202020202020202020202020202E617474722827636C617373272C20276170';
wwv_flow_imp.g_varchar2_table(57) := '65782D6974656D2D6772696420726164696F5F67726F7570272920202020200A202020202020202020202020202020202E6D61726B757028273E3C64697627290A202020202020202020202020202020202E617474722827726F6C65272C20276E6F6E65';
wwv_flow_imp.g_varchar2_table(58) := '27290A202020202020202020202020202020202E617474722827636C617373272C2027617065782D6974656D2D677269642D726F7720272920202020202020202020200A202020202020202020202020202020202E6D61726B757028273E27293B0A2020';
wwv_flow_imp.g_varchar2_table(59) := '20202020202020202020666F7220286C6574206F7074696F6E536571203D20303B206F7074696F6E536571203C2063686F6963654C6162656C2E6C656E6774683B206F7074696F6E5365712B2B29207B0A202020202020202020202020202020206F7574';
wwv_flow_imp.g_varchar2_table(60) := '2E6D61726B757028273C64697627290A20202020202020202020202020202020202020202E617474722827636C617373272C27617065782D6974656D2D6F7074696F6E27290A20202020202020202020202020202020202020202E6D61726B757028273E';
wwv_flow_imp.g_varchar2_table(61) := '3C696E70757427290A20202020202020202020202020202020202020202E6F7074696F6E616C41747472282764697361626C6564272C2072656E64657244697361626C6564290A20202020202020202020202020202020202020202E6174747228277479';
wwv_flow_imp.g_varchar2_table(62) := '7065272C27726164696F27290A20202020202020202020202020202020202020202E6174747228276964272C2060247B6974656D49647D5F247B696E6465787D5F247B6F7074696F6E5365717D60290A2020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(63) := '2E6174747228276E616D65272C2060247B6974656D49647D5F247B696E6465787D5F524760290A20202020202020202020202020202020202020202E617474722827646174612D646973706C6179272C2060247B63686F6963654C6162656C5B6F707469';
wwv_flow_imp.g_varchar2_table(64) := '6F6E5365715D7D60290A20202020202020202020202020202020202020202E61747472282776616C7565272C2060247B63686F69636556616C75655B6F7074696F6E5365715D7D60290A20202020202020202020202020202020202020202E6174747228';
wwv_flow_imp.g_varchar2_table(65) := '27617269612D6C6162656C272C2060247B63686F6963654C6162656C5B6F7074696F6E5365715D7D60290A20202020202020202020202020202020202020202E6F7074696F6E616C417474722827636865636B6564272C2076616C75653D3D3D63686F69';
wwv_flow_imp.g_varchar2_table(66) := '636556616C75655B6F7074696F6E5365715D290A20202020202020202020202020202020202020202E6D61726B757028273E3C6C6162656C27290A20202020202020202020202020202020202020202E617474722827636C617373272C2027752D726164';
wwv_flow_imp.g_varchar2_table(67) := '696F27290A20202020202020202020202020202020202020202E617474722827666F72272C2060247B6974656D49647D5F247B696E6465787D5F247B6F7074696F6E5365717D60290A20202020202020202020202020202020202020202E617474722827';
wwv_flow_imp.g_varchar2_table(68) := '617269612D68696464656E272C2074727565290A20202020202020202020202020202020202020202E6D61726B757028273E27290A20202020202020202020202020202020202020202E636F6E74656E742863686F6963654C6162656C5B6F7074696F6E';
wwv_flow_imp.g_varchar2_table(69) := '5365715D290A20202020202020202020202020202020202020202E6D61726B757028273C2F6C6162656C3E3C2F6469763E27290A2020202020202020202020207D0A2020202020202020202020206F75742E6D61726B757028273C2F6469763E27290A20';
wwv_flow_imp.g_varchar2_table(70) := '2020202020202020202020202020202E6D61726B757028273C2F6469763E27290A202020202020202020202020202020202E6D61726B757028273C2F6469763E27293B0A20202020202020202020202069662028646973706C6179417350696C6C427574';
wwv_flow_imp.g_varchar2_table(71) := '746F6E290A2020202020202020202020207B202020202020202020202020202020200A202020202020202020202020202020206F75742E6D61726B757028273C2F6469763E27293B0A2020202020202020202020207D0A0A202020202020202020202020';
wwv_flow_imp.g_varchar2_table(72) := '696E646578202B3D20313B0A20202020202020202020202072657475726E206F75742E746F537472696E6728293B0A20202020202020207D3B0A0A2020202020202020636F6E73742072656E646572537769746368203D202876616C75652C2072656E64';
wwv_flow_imp.g_varchar2_table(73) := '657244697361626C65642C206C6162656C427929203D3E207B0A202020202020202020202020636F6E7374206F7574203D207574696C2E68746D6C4275696C64657228293B20202020200A2020202020202020202020206F75742E6D61726B757028273C';
wwv_flow_imp.g_varchar2_table(74) := '7370616E27290A202020202020202020202020202020202E617474722827636C617373272C2027612D53776974636827292020200A202020202020202020202020202020202E6D61726B757028273E3C696E70757427290A202020202020202020202020';
wwv_flow_imp.g_varchar2_table(75) := '202020202E6F7074696F6E616C426F6F6C41747472282764697361626C6564272C2072656E64657244697361626C656429202020202020202020202020202020200A202020202020202020202020202020202E61747472282774797065272C2027636865';
wwv_flow_imp.g_varchar2_table(76) := '636B626F7827290A202020202020202020202020202020202E617474722827726F6C65272C202773776974636827290A202020202020202020202020202020202E6174747228276964272C2060247B6974656D49647D5F247B696E6465787D5F3060290A';
wwv_flow_imp.g_varchar2_table(77) := '202020202020202020202020202020202E6174747228276E616D65272C2060247B6974656D49647D5F247B696E6465787D5F535760292020200A202020202020202020202020202020202E617474722827636C617373272C20276A732D69676E6F726543';
wwv_flow_imp.g_varchar2_table(78) := '68616E6765206A732D7461626261626C6527290A202020202020202020202020202020202E61747472282776616C7565272C2063686F69636556616C75655B305D292020202020202020202020200A202020202020202020202020202020202E61747472';
wwv_flow_imp.g_varchar2_table(79) := '2827646174612D6F6E2D6C6162656C272C2063686F6963654C6162656C5B305D290A202020202020202020202020202020202E617474722827646174612D6F66662D76616C7565272C2063686F69636556616C75655B315D290A20202020202020202020';
wwv_flow_imp.g_varchar2_table(80) := '2020202020202E617474722827646174612D6F66662D6C6162656C272C2063686F6963654C6162656C5B315D290A202020202020202020202020202020202E6F7074696F6E616C426F6F6C417474722827636865636B6564272C2076616C75653D3D3D63';
wwv_flow_imp.g_varchar2_table(81) := '686F69636556616C75655B305D290A202020202020202020202020202020202E6F7074696F6E616C417474722827617269612D6C6162656C6C65646279272C206C6162656C4279203F207574696C2E65736361706548544D4C41747472286C6162656C42';
wwv_flow_imp.g_varchar2_table(82) := '7929203A202727290A202020202020202020202020202020202E6D61726B757028273E3C7370616E27290A202020202020202020202020202020202E617474722827636C617373272C2027612D5377697463682D746F67676C6527290A20202020202020';
wwv_flow_imp.g_varchar2_table(83) := '2020202020202020202E6D61726B757028273E3C2F7370616E3E3C2F7370616E3E27293B0A0A202020202020202020202020696E646578202B3D20313B202020200A20202020202020202020202072657475726E206F75742E746F537472696E6728293B';
wwv_flow_imp.g_varchar2_table(84) := '0A20202020202020207D2020200A0A2020202020202020636F6E73742072656E646572436865636B626F78203D202876616C75652C2072656E64657244697361626C65642C206C6162656C427929203D3E207B0A202020202020202020202020636F6E73';
wwv_flow_imp.g_varchar2_table(85) := '74206F7574203D207574696C2E68746D6C4275696C64657228293B20202020200A2020202020202020202020206F75742E6D61726B757028273C64697627290A202020202020202020202020202020202E617474722827636C617373272C202761706578';
wwv_flow_imp.g_varchar2_table(86) := '2D6974656D2D73696E676C652D636865636B626F7827290A202020202020202020202020202020202E6D61726B757028273E3C696E70757427290A202020202020202020202020202020202E6F7074696F6E616C426F6F6C41747472282764697361626C';
wwv_flow_imp.g_varchar2_table(87) := '6564272C2072656E64657244697361626C656429202020202020202020202020202020200A202020202020202020202020202020202E61747472282774797065272C2027636865636B626F7827290A202020202020202020202020202020202E61747472';
wwv_flow_imp.g_varchar2_table(88) := '28276964272C2060247B6974656D49647D5F247B696E6465787D5F3060290A202020202020202020202020202020202E6174747228276E616D65272C2060247B6974656D49647D5F247B696E6465787D5F434260292020200A2020202020202020202020';
wwv_flow_imp.g_varchar2_table(89) := '20202020202E617474722827636C617373272C20276A732D69676E6F72654368616E6765206A732D7461626261626C6527290A202020202020202020202020202020202E61747472282776616C7565272C2063686F69636556616C75655B305D29202020';
wwv_flow_imp.g_varchar2_table(90) := '2020202020202020200A202020202020202020202020202020202E6F7074696F6E616C426F6F6C417474722827636865636B6564272C2076616C75653D3D3D63686F69636556616C75655B305D290A202020202020202020202020202020202E6F707469';
wwv_flow_imp.g_varchar2_table(91) := '6F6E616C417474722827617269612D6C6162656C6C65646279272C206C6162656C4279203F207574696C2E65736361706548544D4C41747472286C6162656C427929203A202727290A202020202020202020202020202020202E6D61726B757028273E3C';
wwv_flow_imp.g_varchar2_table(92) := '7370616E27290A202020202020202020202020202020202E617474722827636C617373272C2027752D636865636B626F7827290A202020202020202020202020202020202E617474722827617269612D68696464656E272C2074727565290A2020202020';
wwv_flow_imp.g_varchar2_table(93) := '20202020202020202020202E6D61726B757028273E3C2F7370616E3E3C7370616E27290A202020202020202020202020202020202E617474722827636C617373272C2027752D766827290A202020202020202020202020202020202E6174747228276172';
wwv_flow_imp.g_varchar2_table(94) := '69612D68696464656E272C2074727565290A202020202020202020202020202020202E6D61726B757028273E27290A202020202020202020202020202020202E636F6E74656E742867657456616C75654C6162656C2876616C756529290A202020202020';
wwv_flow_imp.g_varchar2_table(95) := '202020202020202020202E6D61726B757028273C2F7370616E3E3C2F6469763E27293B0A0A202020202020202020202020696E646578202B3D20313B202020200A20202020202020202020202072657475726E206F75742E746F537472696E6728293B0A';
wwv_flow_imp.g_varchar2_table(96) := '20202020202020207D202020202020202020200A0A2020202020202020636F6E73742067657456616C75654C6162656C203D20286974656D56616C756529203D3E207B0A2020202020202020202020206C6574206C6162656C203D2063686F6963654C61';
wwv_flow_imp.g_varchar2_table(97) := '62656C5B63686F69636556616C75652E696E6465784F66286974656D56616C7565295D3B0A20202020202020202020202072657475726E206C6162656C203F206C6162656C203A2027273B0A20202020202020207D0A0A20202020202020202F2F207570';
wwv_flow_imp.g_varchar2_table(98) := '64617465446973706C61792070726F63657373657320616E792076616C7565206368616E6765206F6E207468652068696464656E20696E707574206974656D0A20202020202020202F2F20696E746F207468652073706563696669632063686F69636520';
wwv_flow_imp.g_varchar2_table(99) := '6974656D200A2020202020202020636F6E737420757064617465446973706C6179203D202829203D3E207B0A2020202020202020202020206966202863686F69636554797065203D3D2027524144494F5F47524F555027290A2020202020202020202020';
wwv_flow_imp.g_varchar2_table(100) := '207B0A20202020202020202020202020202020757064617465526164696F47726F7570446973706C617928293B0A2020202020202020202020207D0A202020202020202020202020656C7365206966202863686F69636554797065203D3D202753574954';
wwv_flow_imp.g_varchar2_table(101) := '43485F434227290A2020202020202020202020207B0A20202020202020202020202020202020757064617465537769746368446973706C617928293B0A2020202020202020202020207D0A202020202020202020202020656C7365206966202863686F69';
wwv_flow_imp.g_varchar2_table(102) := '636554797065203D3D2027434845434B424F5827290A2020202020202020202020207B0A20202020202020202020202020202020757064617465436865636B626F78446973706C617928293B0A2020202020202020202020207D20202020202020202020';
wwv_flow_imp.g_varchar2_table(103) := '20200A20202020202020207D0A0A2020202020202020636F6E737420757064617465526164696F47726F7570446973706C6179203D202829203D3E207B0A2020202020202020202020206C657420726164696F427574746F6E24203D206E756C6C3B0A20';
wwv_flow_imp.g_varchar2_table(104) := '20202020202020202020206C6574206974656D56616C7565203D206974656D242E76616C28293B0A202020202020202020202020696620286974656D56616C7565207C7C20646973706C61794E756C6C56616C7565290A2020202020202020202020207B';
wwv_flow_imp.g_varchar2_table(105) := '0A20202020202020202020202020202020726164696F427574746F6E24203D206977242E66696E642827696E7075745B747970653D22726164696F225D5B76616C75653D22272B6974656D56616C75652B27225D27293B0A202020202020202020202020';
wwv_flow_imp.g_varchar2_table(106) := '2020202069662028726164696F427574746F6E242E6C656E677468290A202020202020202020202020202020207B0A2020202020202020202020202020202020202020726164696F427574746F6E245B305D2E636865636B6564203D20747275653B0A20';
wwv_flow_imp.g_varchar2_table(107) := '2020202020202020202020202020207D0A2020202020202020202020207D0A202020202020202020202020656C73650A2020202020202020202020207B0A202020202020202020202020202020206977242E66696E642827696E7075745B747970653D22';
wwv_flow_imp.g_varchar2_table(108) := '726164696F225D27292E656163682866756E6374696F6E28696E646578297B0A2020202020202020202020202020202020202020746869732E636865636B6564203D2066616C73653B0A202020202020202020202020202020207D293B0A202020202020';
wwv_flow_imp.g_varchar2_table(109) := '2020202020207D0A20202020202020207D3B0A0A2020202020202020636F6E737420757064617465537769746368446973706C6179203D202829203D3E207B0A2020202020202020202020206C6574206974656D56616C7565203D206974656D242E7661';
wwv_flow_imp.g_varchar2_table(110) := '6C28293B0A2020202020202020202020206C65742073776974636824203D206977242E66696E642827696E7075745B747970653D22636865636B626F78225D5B726F6C653D22737769746368225D27293B0A202020202020202020202020696620287377';
wwv_flow_imp.g_varchar2_table(111) := '69746368242E6C656E677468290A2020202020202020202020207B0A20202020202020202020202020202020737769746368245B305D2E636865636B6564203D20286974656D56616C7565203D3D2063686F69636556616C75655B305D293B0A20202020';
wwv_flow_imp.g_varchar2_table(112) := '20202020202020207D0A20202020202020207D3B20202020200A0A2020202020202020636F6E737420757064617465436865636B626F78446973706C6179203D202829203D3E207B0A2020202020202020202020206C6574206974656D56616C7565203D';
wwv_flow_imp.g_varchar2_table(113) := '206974656D242E76616C28293B0A2020202020202020202020206C6574206362496E70757424203D206977242E66696E642827696E7075745B747970653D22636865636B626F78225D27293B0A202020202020202020202020696620286362496E707574';
wwv_flow_imp.g_varchar2_table(114) := '242E6C656E677468290A2020202020202020202020207B0A202020202020202020202020202020206362496E707574245B305D2E636865636B6564203D20286974656D56616C7565203D3D2063686F69636556616C75655B305D293B0A20202020202020';
wwv_flow_imp.g_varchar2_table(115) := '20202020207D0A20202020202020207D3B2020202020202020202020200A0A2020202020202020636F6E7374206765744772696456696577203D202829203D3E207B0A20202020202020202020202072657475726E206974656D242E636C6F7365737428';
wwv_flow_imp.g_varchar2_table(116) := '272E612D494727292E696E746572616374697665477269642827676574566965777327292E677269643B0A20202020202020207D0A0A2020202020202020636F6E737420696E76657274436865636B626F78203D20286362496E7075742429203D3E207B';
wwv_flow_imp.g_varchar2_table(117) := '0A2020202020202020202020206362496E707574242E70726F702827636865636B6564272C20216362496E707574242E70726F702827636865636B65642729292E7472696767657228276368616E676527293B200A202020202020202020202020636249';
wwv_flow_imp.g_varchar2_table(118) := '6E707574245B305D2E696E64657465726D696E617465203D2066616C73653B2020202020202020202020200A20202020202020207D202020200A0A20202020202020202F2F2070757420494720696E2065646974206D6F64650A20202020202020202F2F';
wwv_flow_imp.g_varchar2_table(119) := '20616E642066697265206368616E6765206576656E7420666F7220746865206974656D0A2020202020202020636F6E737420737769746368546F456469744D6F6465203D202829203D3E207B0A2020202020202020202020202F2F20746F206265207375';
wwv_flow_imp.g_varchar2_table(120) := '72652C20636865636B206966206E6F7420696E2065646974206D6F64650A202020202020202020202020696620282128676574477269645669657728292E76696577242E677269642827696E456469744D6F6465272929290A2020202020202020202020';
wwv_flow_imp.g_varchar2_table(121) := '207B0A2020202020202020202020202020202073657454696D656F75742828293D3E7B0A20202020202020202020202020202020202020206974656D242E636C6F7365737428272E612D494727292E696E74657261637469766547726964282767657441';
wwv_flow_imp.g_varchar2_table(122) := '6374696F6E7327292E736574282765646974272C2074727565293B200A2020202020202020202020202020202020202020617065782E6576656E742E74726967676572282723272B6974656D49642C20276368616E6765272C206E756C6C293B200A2020';
wwv_flow_imp.g_varchar2_table(123) := '20202020202020202020202020207D2C203130293B0A2020202020202020202020207D2020202020202020202020200A20202020202020207D202020200A0A202020202020202069662028216974656D4973526561644F6E6C79290A2020202020202020';
wwv_flow_imp.g_varchar2_table(124) := '7B0A2020202020202020202020202F2F20657874656E64207468652064697620777261707065642068696464656E206974656D2077697468207468652063686F696365206974656D2073706563696669632068746D6C0A20202020202020202020202069';
wwv_flow_imp.g_varchar2_table(125) := '77242E617070656E642872656E646572286E756C6C2C2066616C73652C206E756C6C29293B20202020202020202F2F2061732070657220696E64657820300A20202020202020207D0A0A20202020202020206966202863686F69636554797065203D3D20';
wwv_flow_imp.g_varchar2_table(126) := '22524144494F5F47524F555022290A20202020202020207B0A2020202020202020202020202F2F2075706F6E20636865636B696E67206120726164696F20627574746F6E2C2075706461746520746865206974656D2076616C7565206173206B65707420';
wwv_flow_imp.g_varchar2_table(127) := '6F6E207468652068696464656E20696E70757420656C656D656E740A2020202020202020202020206977242E66696E642827696E7075745B747970653D22726164696F225D27292E6F6E28276368616E6765272C20286529203D3E207B0A202020202020';
wwv_flow_imp.g_varchar2_table(128) := '20202020202020202020636F6E737420726164696F427574746F6E24203D202428652E63757272656E74546172676574293B0A2020202020202020202020202020202069662028726164696F427574746F6E245B305D2E636865636B6564290A20202020';
wwv_flow_imp.g_varchar2_table(129) := '2020202020202020202020207B0A20202020202020202020202020202020202020206974656D242E76616C28726164696F427574746F6E242E76616C2829292E6368616E676528293B0A202020202020202020202020202020207D0A2020202020202020';
wwv_flow_imp.g_varchar2_table(130) := '202020207D293B0A20202020202020207D0A2020202020202020656C7365206966202863686F69636554797065203D3D20225357495443485F434222290A20202020202020207B0A2020202020202020202020206C6574206362496E70757424203D2069';
wwv_flow_imp.g_varchar2_table(131) := '77242E66696E642827696E7075745B747970653D22636865636B626F78225D5B726F6C653D22737769746368225D27290A2020202020202020202020206362496E707574242E636C6F736573742820227370616E2E612D5377697463682220292E6F6E28';
wwv_flow_imp.g_varchar2_table(132) := '2022636C69636B222C2066756E6374696F6E2820652029200A2020202020202020202020207B0A202020202020202020202020202020202F2F2054686520737769746368206973206261736963616C6C79206120636865636B626F782E205768656E2063';
wwv_flow_imp.g_varchar2_table(133) := '6C69636B696E67206F6E20746865207377697463682C2074686520636C69636B206D696768742062650A202020202020202020202020202020202F2F206F6E207468652028696E76697369626C652920636865636B626F782C206F72206F757473696465';
wwv_flow_imp.g_varchar2_table(134) := '206F66206974206F6E2074686520737769746368206373732067726170682E2049662074686520636C69636B206973200A202020202020202020202020202020202F2F206F6E2074686520636865636B626F782C207468652027636865636B6564272066';
wwv_flow_imp.g_varchar2_table(135) := '6C6167206973206175746F6D61746963616C6C79207365742E20496620636C69636B6564206F7574736974652C207468656E0A202020202020202020202020202020202F2F207765206E6565642074686520736574207468697320666C6167206F757273';
wwv_flow_imp.g_varchar2_table(136) := '656C7665732E0A202020202020202020202020202020202F2F2054686520736974756174696F6E2068657265206973207468652049472063656C6C2069732061637469766174656420616E64207468652073776974636820686173206265656E20636C69';
wwv_flow_imp.g_varchar2_table(137) := '636B65642E20536F20746865200A202020202020202020202020202020202F2F206974656D2E6F6E496E746572616374696F6E286576656E742E74797065203D2061637469766174652920776F6E27742062652063616C6C65642E0A2020202020202020';
wwv_flow_imp.g_varchar2_table(138) := '20202020202020202F2F2054616B656E2066726F6D207769646765742E7965734E6F2E6A730A2020202020202020202020202020202069662028212428652E746172676574292E697328273A636865636B626F78272920262620216362496E707574242E';
wwv_flow_imp.g_varchar2_table(139) := '697328273A64697361626C65642729290A202020202020202020202020202020207B0A2020202020202020202020202020202020202020696E76657274436865636B626F78286362496E70757424293B0A202020202020202020202020202020207D0A20';
wwv_flow_imp.g_varchar2_table(140) := '20202020202020202020207D293B0A2020202020202020202020202F2F2075706F6E206120737769746368206368616E67652C2075706461746520746865206974656D2076616C7565206173206B657074206F6E207468652068696464656E20696E7075';
wwv_flow_imp.g_varchar2_table(141) := '7420656C656D656E740A2020202020202020202020206362496E707574242E6F6E28276368616E6765272C20286529203D3E207B0A20202020202020202020202020202020636F6E73742073776974636824203D202428652E63757272656E7454617267';
wwv_flow_imp.g_varchar2_table(142) := '6574293B0A202020202020202020202020202020206974656D242E76616C28737769746368245B305D2E636865636B6564203F2063686F69636556616C75655B305D203A2063686F69636556616C75655B315D292E6368616E676528293B0A2020202020';
wwv_flow_imp.g_varchar2_table(143) := '202020202020207D293B2020202020202020202020200A20202020202020207D0A2020202020202020656C7365206966202863686F69636554797065203D3D2022434845434B424F5822290A20202020202020207B0A2020202020202020202020206C65';
wwv_flow_imp.g_varchar2_table(144) := '74206362496E70757424203D206977242E66696E642827696E7075745B747970653D22636865636B626F78225D27290A2020202020202020202020202F2F2075706F6E20636865636B2F756E636865636B2C2075706461746520746865206974656D2076';
wwv_flow_imp.g_varchar2_table(145) := '616C7565206173206B657074206F6E207468652068696464656E20696E70757420656C656D656E740A2020202020202020202020206362496E707574242E6F6E28276368616E6765272C20286529203D3E207B0A20202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(146) := '636F6E737420636224203D202428652E63757272656E74546172676574293B0A202020202020202020202020202020206974656D242E76616C286362245B305D2E636865636B6564203F2063686F69636556616C75655B305D203A2063686F6963655661';
wwv_flow_imp.g_varchar2_table(147) := '6C75655B315D292E6368616E676528293B0A2020202020202020202020207D293B2020202020202020202020200A20202020202020207D20202020202020200A0A20202020202020202F2F20736574207468652073706563696669632063686F69636520';
wwv_flow_imp.g_varchar2_table(148) := '6974656D20636865636B65642061747472696275746520617320706572207468652068696464656E206974656D2076616C75650A2020202020202020757064617465446973706C617928293B0A0A20202020202020202F2F20696D706C656D656E742074';
wwv_flow_imp.g_varchar2_table(149) := '6865206974656D20696E74657266616365207370656369666963730A2020202020202020617065782E6974656D2E637265617465286974656D49642C207B0A2020202020202020202020206974656D5F747970653A202249475F53494D504C455F43484F';
wwv_flow_imp.g_varchar2_table(150) := '494345222C2020200A20202020202020202020202067657456616C756528297B0A2020202020202020202020202020202072657475726E20746869732E6E6F64652E76616C75653B0A2020202020202020202020207D2C0A202020202020202020202020';
wwv_flow_imp.g_varchar2_table(151) := '73657456616C75652876616C7565297B0A202020202020202020202020202020206974656D242E76616C2876616C7565293B0A20202020202020202020202020202020757064617465446973706C617928293B0A2020202020202020202020207D2C0A20';
wwv_flow_imp.g_varchar2_table(152) := '202020202020202020202064697361626C6528297B0A202020202020202020202020202020206966202863686F69636554797065203D3D2027524144494F5F47524F555027290A202020202020202020202020202020207B0A2020202020202020202020';
wwv_flow_imp.g_varchar2_table(153) := '2020202020202020202428273A726164696F272C20697724292E70726F70282764697361626C6564272C2074727565292E616464436C6173732827617065785F64697361626C65645F6D756C746927293B0A202020202020202020202020202020207D0A';
wwv_flow_imp.g_varchar2_table(154) := '20202020202020202020202020202020656C736520696620282863686F69636554797065203D3D20275357495443485F43422729207C7C202863686F69636554797065203D3D2027434845434B424F582729290A20202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(155) := '7B0A20202020202020202020202020202020202020202428273A636865636B626F78272C20697724292E70726F70282764697361626C6564272C2074727565293B0A202020202020202020202020202020207D0A20202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(156) := '6974656D497344697361626C6564203D20747275653B0A2020202020202020202020207D2C0A202020202020202020202020656E61626C6528297B0A202020202020202020202020202020206966202863686F69636554797065203D3D2027524144494F';
wwv_flow_imp.g_varchar2_table(157) := '5F47524F555027290A202020202020202020202020202020207B202020202020202020202020202020200A20202020202020202020202020202020202020202428273A726164696F272C20697724292E70726F70282764697361626C6564272C2066616C';
wwv_flow_imp.g_varchar2_table(158) := '7365292E72656D6F7665436C6173732827617065785F64697361626C65645F6D756C746927293B0A202020202020202020202020202020207D0A20202020202020202020202020202020656C736520696620282863686F69636554797065203D3D202753';
wwv_flow_imp.g_varchar2_table(159) := '57495443485F43422729207C7C202863686F69636554797065203D3D2027434845434B424F582729290A202020202020202020202020202020207B200A20202020202020202020202020202020202020202428273A636865636B626F78272C2069772429';
wwv_flow_imp.g_varchar2_table(160) := '2E70726F70282764697361626C6564272C2066616C7365293B0A202020202020202020202020202020207D20202020202020202020202020202020202020202020202020202020202020202020200A202020202020202020202020202020206974656D49';
wwv_flow_imp.g_varchar2_table(161) := '7344697361626C6564203D2066616C73653B0A2020202020202020202020207D2C0A202020202020202020202020697344697361626C656428297B0A2020202020202020202020202020202072657475726E206974656D497344697361626C65643B0A20';
wwv_flow_imp.g_varchar2_table(162) := '20202020202020202020207D2C0A202020202020202020202020736574466F637573546F2829207B0A202020202020202020202020202020202F2F2073657420666F63757320746F20666972737420696E707574206F722063757272656E746C79207365';
wwv_flow_imp.g_varchar2_table(163) := '6C656374656420726164696F2069662065786973747320696E20746865206669656C647365740A202020202020202020202020202020202F2F2068617320746F20626520612066756E6374696F6E20746F206765742063757272656E746C792063686563';
wwv_flow_imp.g_varchar2_table(164) := '6B65642076616C75650A202020202020202020202020202020206C6574206C52657475726E24203D20242820223A636865636B6564222C2069772420293B0A20202020202020202020202020202020696620286C52657475726E242E6C656E677468203D';
wwv_flow_imp.g_varchar2_table(165) := '3D3D20302029207B0A20202020202020202020202020202020202020206C52657475726E24203D2024282063686F69636554797065203D3D2027524144494F5F47524F555027203F20223A726164696F22203A20223A636865636B626F78222C20697724';
wwv_flow_imp.g_varchar2_table(166) := '20293B0A202020202020202020202020202020207D0A2020202020202020202020202020202072657475726E206C52657475726E242E666972737428293B0A2020202020202020202020207D2C2020202020202020202020200A20202020202020202020';
wwv_flow_imp.g_varchar2_table(167) := '2020646973706C617956616C7565466F722876616C75652C20737461746529207B0A202020202020202020202020202020202F2F2072657475726E207468652063686F696365206974656D2073706563696669632068746D6C0A20202020202020202020';
wwv_flow_imp.g_varchar2_table(168) := '2020202020202F2F20666F722073696E676C6520726F7720766965772C206A7573742072657475726E20746865206C6162656C0A202020202020202020202020202020206C65742073696E676C65526F774D6F6465203D20676574477269645669657728';
wwv_flow_imp.g_varchar2_table(169) := '292E73696E676C65526F774D6F64653B0A202020202020202020202020202020206C65742072656E64657244697361626C6564203D2073746174653F2E726561646F6E6C79207C7C2073746174653F2E64697361626C65643B0A20202020202020202020';
wwv_flow_imp.g_varchar2_table(170) := '20202020202072657475726E2073696E676C65526F774D6F6465203F2067657456616C75654C6162656C2876616C756529203A2072656E6465722876616C75652C2072656E64657244697361626C65642C2073746174653F2E6C6162656C4279293B0A20';
wwv_flow_imp.g_varchar2_table(171) := '20202020202020202020207D2C0A20202020202020202020202067657456616C69646974793A2066756E6374696F6E202829207B0A20202020202020202020202020202020636F6E737420726571756972656441747472203D206974656D242E70726F70';
wwv_flow_imp.g_varchar2_table(172) := '28202272657175697265642220293B0A20202020202020202020202020202020696620282072657175697265644174747220213D3D20756E646566696E65642026262072657175697265644174747220213D3D2066616C73652029207B0A202020202020';
wwv_flow_imp.g_varchar2_table(173) := '20202020202020202020202020206966202820746869732E6973456D70747928292029207B0A20202020202020202020202020202020202020202020202072657475726E207B2076616C69643A2066616C73652C2076616C75654D697373696E673A2074';
wwv_flow_imp.g_varchar2_table(174) := '727565207D3B0A20202020202020202020202020202020202020207D0A202020202020202020202020202020207D0A2020202020202020202020202020202072657475726E207B2076616C69643A2074727565207D3B0A2020202020202020202020207D';
wwv_flow_imp.g_varchar2_table(175) := '2C20200A202020202020202020202020676574496E746572616374696F6E53656C6563746F722829207B0A202020202020202020202020202020202F2F2073706563696679207468652073656C6563746F7220617320746F207768696368207061727420';
wwv_flow_imp.g_varchar2_table(176) := '696E2074686520444F4D200A202020202020202020202020202020202F2F20636C69636B732077696C6C20626520666F72776172646564206279204150455820746F20746865206F6E496E746572616374696F6E206D6574686F640A2020202020202020';
wwv_flow_imp.g_varchar2_table(177) := '20202020202020206C657420726573756C74203D206E756C6C3B0A202020202020202020202020202020206966202863686F69636554797065203D3D2027524144494F5F47524F555027290A202020202020202020202020202020207B0A202020202020';
wwv_flow_imp.g_varchar2_table(178) := '2020202020202020202020202020726573756C74203D20222E752D726164696F2C2E617065782D6974656D2D6F7074696F6E223B0A202020202020202020202020202020207D0A20202020202020202020202020202020656C7365206966202863686F69';
wwv_flow_imp.g_varchar2_table(179) := '636554797065203D3D20275357495443485F434227290A202020202020202020202020202020207B0A2020202020202020202020202020202020202020726573756C74203D20222E612D537769746368223B0A202020202020202020202020202020207D';
wwv_flow_imp.g_varchar2_table(180) := '0A20202020202020202020202020202020656C7365206966202863686F69636554797065203D3D2027434845434B424F5827290A202020202020202020202020202020207B0A2020202020202020202020202020202020202020726573756C74203D2022';
wwv_flow_imp.g_varchar2_table(181) := '2E752D636865636B626F782C2E617065782D6974656D2D73696E676C652D636865636B626F78223B0A202020202020202020202020202020207D0A2020202020202020202020202020202072657475726E20726573756C743B0A20202020202020202020';
wwv_flow_imp.g_varchar2_table(182) := '20207D2C2020202020202020202020200A2020202020202020202020206F6E496E746572616374696F6E286576656E742C206D6F64656C2C207265636F72642C206669656C64297B0A202020202020202020202020202020202F2F20636C69636B732067';
wwv_flow_imp.g_varchar2_table(183) := '65747320666F72776172646564206F6E20666972737420636C69636B206F72206F6E2061637469766174696E6720612063656C6C0A202020202020202020202020202020206966202863686F69636554797065203D3D2027524144494F5F47524F555027';
wwv_flow_imp.g_varchar2_table(184) := '290A202020202020202020202020202020207B0A202020202020202020202020202020202020202069662028286576656E742E74797065203D3D2027636C69636B2729207C7C20286576656E742E74797065203D3D202761637469766174652729290A20';
wwv_flow_imp.g_varchar2_table(185) := '202020202020202020202020202020202020207B0A2020202020202020202020202020202020202020202020202F2F20696620636C69636B696E67206F6E20746865206C6162656C2C207765206E65656420746F20737769746368207468652072616469';
wwv_flow_imp.g_varchar2_table(186) := '6F20627574746F6E206F757273656C7665730A2020202020202020202020202020202020202020202020206C657420726164696F427574746F6E24203D206E756C6C3B0A2020202020202020202020202020202020202020202020206966202824286576';
wwv_flow_imp.g_varchar2_table(187) := '656E742E746172676574292E697328272E752D726164696F2729207C7C2024286576656E742E746172676574292E697328272E617065782D6974656D2D6F7074696F6E2729290A2020202020202020202020202020202020202020202020207B0A202020';
wwv_flow_imp.g_varchar2_table(188) := '202020202020202020202020202020202020202020202020206966202824286576656E742E746172676574292E697328272E752D726164696F2729290A202020202020202020202020202020202020202020202020202020207B0A202020202020202020';
wwv_flow_imp.g_varchar2_table(189) := '2020202020202020202020202020202020202020202020726164696F427574746F6E24203D2024286576656E742E7461726765742E706172656E74456C656D656E74292E66696E642827696E7075745B747970653D22726164696F225D27293B0A202020';
wwv_flow_imp.g_varchar2_table(190) := '202020202020202020202020202020202020202020202020207D0A20202020202020202020202020202020202020202020202020202020656C7365206966202824286576656E742E746172676574292E697328272E617065782D6974656D2D6F7074696F';
wwv_flow_imp.g_varchar2_table(191) := '6E2729290A202020202020202020202020202020202020202020202020202020207B0A2020202020202020202020202020202020202020202020202020202020202020726164696F427574746F6E24203D2024286576656E742E746172676574292E6669';
wwv_flow_imp.g_varchar2_table(192) := '6E642827696E7075745B747970653D22726164696F225D27293B0A202020202020202020202020202020202020202020202020202020207D0A202020202020202020202020202020202020202020202020202020206966202821726164696F427574746F';
wwv_flow_imp.g_varchar2_table(193) := '6E245B305D2E636865636B6564290A202020202020202020202020202020202020202020202020202020207B0A2020202020202020202020202020202020202020202020202020202020202020726164696F427574746F6E242E70726F70282763686563';
wwv_flow_imp.g_varchar2_table(194) := '6B6564272C2074727565292E7472696767657228276368616E676527293B200A202020202020202020202020202020202020202020202020202020207D0A2020202020202020202020202020202020202020202020207D0A202020202020202020202020';
wwv_flow_imp.g_varchar2_table(195) := '202020202020202020202020656C73650A2020202020202020202020202020202020202020202020207B0A20202020202020202020202020202020202020202020202020202020726164696F427574746F6E24203D2024286576656E742E746172676574';
wwv_flow_imp.g_varchar2_table(196) := '293B0A2020202020202020202020202020202020202020202020207D2020202020202020202020202020202020202020202020200A202020202020202020202020202020202020202020202020696620286576656E742E74797065203D3D2027636C6963';
wwv_flow_imp.g_varchar2_table(197) := '6B27290A2020202020202020202020202020202020202020202020207B0A202020202020202020202020202020202020202020202020202020202F2F20636C69636B206576656E743A20736F206174207468697320706F696E742C20776520617265206E';
wwv_flow_imp.g_varchar2_table(198) := '6F7420696E2065646974206D6F6465200A202020202020202020202020202020202020202020202020202020202F2F2075706461746520746865206D6F64656C20616E642070757420494720696E2065646974206D6F64650A2020202020202020202020';
wwv_flow_imp.g_varchar2_table(199) := '20202020202020202020202020202020206C6574206F6C6456616C7565203D206D6F64656C2E67657456616C7565287265636F72642C206669656C64293B0A202020202020202020202020202020202020202020202020202020206C6574206E65775661';
wwv_flow_imp.g_varchar2_table(200) := '6C7565203D20726164696F427574746F6E245B305D2E76616C75653B0A20202020202020202020202020202020202020202020202020202020696620286E657756616C756520213D206F6C6456616C7565290A2020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(201) := '20202020202020202020207B0A20202020202020202020202020202020202020202020202020202020202020206D6F64656C2E73657456616C7565287265636F72642C206669656C642C206E657756616C7565293B0A2020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(202) := '2020202020202020202020202020202020202F2F2073776974636820746F2065646974206D6F646520616E642066697265206368616E6765206576656E740A20202020202020202020202020202020202020202020202020202020202020207377697463';
wwv_flow_imp.g_varchar2_table(203) := '68546F456469744D6F646528293B0A202020202020202020202020202020202020202020202020202020207D0A2020202020202020202020202020202020202020202020207D0A202020202020202020202020202020202020202020202020656C736520';
wwv_flow_imp.g_varchar2_table(204) := '696620286576656E742E74797065203D3D2027616374697661746527290A2020202020202020202020202020202020202020202020207B0A202020202020202020202020202020202020202020202020202020206966202821617065782E6974656D2869';
wwv_flow_imp.g_varchar2_table(205) := '74656D4964292E697344697361626C65642829290A202020202020202020202020202020202020202020202020202020207B0A20202020202020202020202020202020202020202020202020202020202020202F2F206163746976617465206576656E74';
wwv_flow_imp.g_varchar2_table(206) := '3A206174207468697320706F696E742C2077652061726520696E2065646974206D6F64650A20202020202020202020202020202020202020202020202020202020202020202F2F20736574207468652076616C7565206F6E207468652068696464656E20';
wwv_flow_imp.g_varchar2_table(207) := '696E707574206974656D0A20202020202020202020202020202020202020202020202020202020202020206C6574206F6C6456616C7565203D206974656D242E76616C28293B0A2020202020202020202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(208) := '2020206C6574206E657756616C7565203D20726164696F427574746F6E245B305D2E76616C75653B0A2020202020202020202020202020202020202020202020202020202020202020696620286E657756616C756520213D206F6C6456616C7565290A20';
wwv_flow_imp.g_varchar2_table(209) := '202020202020202020202020202020202020202020202020202020202020207B0A202020202020202020202020202020202020202020202020202020202020202020202020746869732E73657456616C7565286E657756616C7565293B0A202020202020';
wwv_flow_imp.g_varchar2_table(210) := '20202020202020202020202020202020202020202020202020207D0A202020202020202020202020202020202020202020202020202020207D0A2020202020202020202020202020202020202020202020207D200A202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(211) := '20202020207D0A202020202020202020202020202020207D0A20202020202020202020202020202020656C736520696620282863686F69636554797065203D3D20275357495443485F43422729207C7C202863686F69636554797065203D3D2027434845';
wwv_flow_imp.g_varchar2_table(212) := '434B424F582729290A202020202020202020202020202020207B0A20202020202020202020202020202020202020202F2F2066696E6420636865636B626F7820696E70757420656C656D656E740A20202020202020202020202020202020202020206C65';
wwv_flow_imp.g_varchar2_table(213) := '74206362496E70757424203D2024286576656E742E7461726765742E706172656E74456C656D656E74292E66696E642827696E7075745B747970653D22636865636B626F78225D27202B202863686F69636554797065203D3D20275357495443485F4342';
wwv_flow_imp.g_varchar2_table(214) := '27203F20275B726F6C653D22737769746368225D27203A20272729293B0A2020202020202020202020202020202020202020696620286576656E742E74797065203D3D2027636C69636B27290A20202020202020202020202020202020202020207B0A20';
wwv_flow_imp.g_varchar2_table(215) := '20202020202020202020202020202020202020202020202F2F2074686973206973207768656E20746865204947206973206E6F7420696E2065646974206D6F64650A2020202020202020202020202020202020202020202020202F2F20696620636C6963';
wwv_flow_imp.g_varchar2_table(216) := '6B6564206F6E2074686520737769746368206F757473697465207468652028696E76697369626C652920636865636B626F782C20736574207468652027636865636B6564272070726F7065727479206F757273656C7665730A2020202020202020202020';
wwv_flow_imp.g_varchar2_table(217) := '20202020202020202020202020696620282124286576656E742E746172676574292E697328273A636865636B626F78272920262620216362496E707574242E697328273A64697361626C65642729290A2020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(218) := '202020207B0A20202020202020202020202020202020202020202020202020202020696E76657274436865636B626F78286362496E70757424293B0A2020202020202020202020202020202020202020202020207D20202020200A202020202020202020';
wwv_flow_imp.g_varchar2_table(219) := '2020202020202020202020202020206C6574206F6C6456616C7565203D206D6F64656C2E67657456616C7565287265636F72642C206669656C64293B0A2020202020202020202020202020202020202020202020206C6574206E657756616C7565203D20';
wwv_flow_imp.g_varchar2_table(220) := '6362496E707574242E70726F702827636865636B65642729203F2063686F69636556616C75655B305D203A2063686F69636556616C75655B315D3B0A202020202020202020202020202020202020202020202020696620286E657756616C756520213D20';
wwv_flow_imp.g_varchar2_table(221) := '6F6C6456616C7565290A2020202020202020202020202020202020202020202020207B0A202020202020202020202020202020202020202020202020202020206D6F64656C2E73657456616C7565287265636F72642C206669656C642C206E657756616C';
wwv_flow_imp.g_varchar2_table(222) := '7565293B0A202020202020202020202020202020202020202020202020202020202F2F2073776974636820746F2065646974206D6F646520616E642066697265206368616E6765206576656E740A20202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(223) := '202020202020737769746368546F456469744D6F646528293B0A2020202020202020202020202020202020202020202020207D202020202020202020202020202020202020202020202020202020202020202020202020202020202020200A2020202020';
wwv_flow_imp.g_varchar2_table(224) := '2020202020202020202020202020207D0A2020202020202020202020202020202020202020656C736520696620286576656E742E74797065203D3D2027616374697661746527290A20202020202020202020202020202020202020207B0A202020202020';
wwv_flow_imp.g_varchar2_table(225) := '2020202020202020202020202020202020202F2F2074686973206973207768656E207468652063656C6C2069732061637469766174656420616E642074686572652077617320696E746572616374696F6E206F6E2074686520496E746572616374696F6E';
wwv_flow_imp.g_varchar2_table(226) := '53656C6563746F7220706172740A2020202020202020202020202020202020202020202020202F2F2074686520612D537769746368206F6E20636C69636B206973206E6F742067657474696E672074726967676572656420696E20746869732073697475';
wwv_flow_imp.g_varchar2_table(227) := '6174696F6E2C20736F207765206E65656420746F200A2020202020202020202020202020202020202020202020202F2F206368616E67652074686520737769746368206865726520616E6420696E76657274207468652027636865636B6564272070726F';
wwv_flow_imp.g_varchar2_table(228) := '70657274790A2020202020202020202020202020202020202020202020206966202821617065782E6974656D286974656D4964292E697344697361626C65642829290A2020202020202020202020202020202020202020202020207B2020202020202020';
wwv_flow_imp.g_varchar2_table(229) := '202020202020202020202020202020200A2020202020202020202020202020202020202020202020202020202069662028216362496E707574242E697328273A64697361626C65642729290A202020202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(230) := '202020207B0A2020202020202020202020202020202020202020202020202020202020202020696E76657274436865636B626F78286362496E70757424293B0A202020202020202020202020202020202020202020202020202020207D20202020202020';
wwv_flow_imp.g_varchar2_table(231) := '2020202020202020202020202020202020200A202020202020202020202020202020202020202020202020202020206C6574206F6C6456616C7565203D206974656D242E76616C28293B0A20202020202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(232) := '2020206C6574206E657756616C7565203D206362496E707574242E70726F702827636865636B65642729203F2063686F69636556616C75655B305D203A2063686F69636556616C75655B315D3B0A20202020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(233) := '202020202020696620286E657756616C756520213D206F6C6456616C7565290A202020202020202020202020202020202020202020202020202020207B0A20202020202020202020202020202020202020202020202020202020202020202F2F20736574';
wwv_flow_imp.g_varchar2_table(234) := '20746865206974656D2076616C75653B20415045582077696C6C2061646A75737420746865206D6F64656C2061732077652061726520696E2065646974206D6F64650A202020202020202020202020202020202020202020202020202020202020202074';
wwv_flow_imp.g_varchar2_table(235) := '6869732E73657456616C7565286E657756616C7565293B0A202020202020202020202020202020202020202020202020202020207D0A2020202020202020202020202020202020202020202020207D0A2020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(236) := '7D2020202020202020202020202020202020202020200A202020202020202020202020202020207D200A2020202020202020202020207D0A20202020202020207D293B0A202020207D0A0A2020202072657475726E7B0A2020202020202020696E69743A';
wwv_flow_imp.g_varchar2_table(237) := '20696E69740A202020207D0A7D2928617065782E6A51756572792C20617065782E7574696C293B';
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(25511957932636415)
,p_plugin_id=>wwv_flow_imp.id(50169277718860562866)
,p_file_name=>'js/ig-simplechoicecolumn.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
prompt --application/end_environment
begin
wwv_flow_imp.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false)
);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
