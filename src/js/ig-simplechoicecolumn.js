--------------------------------------------------------------------------------
-- t_item_attr type definition
--------------------------------------------------------------------------------
type t_item_attr is record
( 
    c_name                  varchar2(30),
    c_choice_type           varchar2(30), 
    c_on_value              varchar2(30),
    c_on_label              varchar2(30),
    c_off_value             varchar2(30),
    c_off_label             varchar2(30),    
    c_value1                varchar2(30), 
    c_label1                varchar2(30),
    c_value2                varchar2(30),
    c_label2                varchar2(30),
    c_checked_value         varchar2(30),
    c_unchecked_value       varchar2(30),
    c_pill_button           varchar2(30),      
    c_display_null_value    varchar2(30),
    c_null_display_value    varchar2(30),
    c_null_return_value     varchar2(30),
    value0                  varchar2(30),
    label0                  varchar2(30),    
    value1                  varchar2(30),
    label1                  varchar2(30),
    value2                  varchar2(30),
    label2                  varchar2(30)
); 

--------------------------------------------------------------------------------
-- init_item_attr Procedure
--------------------------------------------------------------------------------
procedure init_item_attr(
    p_item    in  apex_plugin.t_item,
    item_attr out t_item_attr
)
is
begin
    item_attr.c_name                := apex_plugin.get_input_name_for_item;
    item_attr.c_choice_type         := p_item.attribute_01;     
    item_attr.c_on_value            := p_item.attribute_02;  
    item_attr.c_on_label            := p_item.attribute_03;
    item_attr.c_off_value           := p_item.attribute_04;
    item_attr.c_off_label           := p_item.attribute_05;    
    item_attr.c_value1              := p_item.attribute_06;  
    item_attr.c_label1              := p_item.attribute_07;
    item_attr.c_value2              := p_item.attribute_08;
    item_attr.c_label2              := p_item.attribute_09;
    item_attr.c_checked_value       := p_item.attribute_10;
    item_attr.c_unchecked_value     := p_item.attribute_11;  
    item_attr.c_pill_button         := p_item.attribute_12;   
    item_attr.c_display_null_value  := p_item.attribute_13;
    item_attr.c_null_display_value  := p_item.attribute_14;
    item_attr.c_null_return_value   := p_item.attribute_15;
    case item_attr.c_choice_type
        when 'RADIO_GROUP' then
            item_attr.value0 := item_attr.c_null_return_value;
            item_attr.label0 := item_attr.c_null_display_value;        
            item_attr.value1 := item_attr.c_value1;
            item_attr.label1 := item_attr.c_label1;
            item_attr.value2 := item_attr.c_value2;
            item_attr.label2 := item_attr.c_label2;
        when 'SWITCH_CB' then
            item_attr.value0 := null;
            item_attr.label0 := null;          
            item_attr.value1 := item_attr.c_on_value;
            item_attr.label1 := item_attr.c_on_label;
            item_attr.value2 := item_attr.c_off_value;
            item_attr.label2 := item_attr.c_off_label; 
        when 'CHECKBOX' then
            item_attr.value0 := null;
            item_attr.label0 := null;            
            item_attr.value1 := item_attr.c_checked_value;
            item_attr.label1 := 'Checked';
            item_attr.value2 := item_attr.c_unchecked_value;
            item_attr.label2 := 'Unchecked'; 
    end case;  
end init_item_attr;

--------------------------------------------------------------------------------
-- Render Procedure
-- Renders the hidden input element to maintain the item value
-- Adds on-load js as to init the item client-side
--------------------------------------------------------------------------------
procedure render_ig_simple_choice (
    p_item   in            apex_plugin.t_item,
    p_plugin in            apex_plugin.t_plugin,
    p_param  in            apex_plugin.t_item_render_param,
    p_result in out nocopy apex_plugin.t_item_render_result
)
is
    item_attr           t_item_attr; 
    c_escaped_value     constant varchar2(30) := apex_escape.html_attribute(p_param.value);   
begin
    apex_plugin_util.debug_page_item(p_plugin => p_plugin, p_page_item => p_item);
    init_item_attr(p_item, item_attr);
    if p_param.is_readonly or p_param.is_printer_friendly then
        null;
        -- do nothing - APEX will create a hidden input element with id as p_item.name
    else
        -- render hidden input element which will hold the value
        -- client side, using apex.item.create, the interface will be implemented and
        -- the specific choice item html will be rendered for user interaction
        sys.htp.prn(
            apex_string.format(
                '<input type="hidden" %s id="%s" value="%s"/>'
                , apex_plugin_util.get_element_attributes(p_item, item_attr.c_name)
                , p_item.name
                , case when p_param.value is null then '' else ltrim( rtrim ( c_escaped_value ) ) end
            )
        );
    end if;     

    -- When specifying the library declaratively, it fails to load the minified version. So using the API:
    apex_javascript.add_library(
          p_name      => 'ig-simplechoicecolumn',
          p_check_to_add_minified => true,
          p_directory => p_plugin.file_prefix || 'js/',
          p_version   => NULL
    );                

    -- page on load: init simpleChoiceColumn
    apex_javascript.add_onload_code(
        p_code => apex_string.format(
            'lib4x.axt.ig.simpleChoiceColumn.init("%s", {readOnly: %s, isRequired: %s, choiceType: "%s", displayNullValue: %s, displayAsPillButton: %s, value0: "%s", label0: "%s", value1: "%s", label1: "%s", value2: "%s", label2: "%s"});'
            , p_item.name
            , case when p_param.is_readonly then 'true' else 'false' end
            , case when p_item.is_required then 'true' else 'false' end            
            , item_attr.c_choice_type
            , case when item_attr.c_display_null_value = 'Y' then 'true' else 'false' end            
            , case when item_attr.c_pill_button = 'Y' then 'true' else 'false' end
            , item_attr.value0            
            , item_attr.label0            
            , item_attr.value1            
            , item_attr.label1
            , item_attr.value2              
            , item_attr.label2        
        )
    );

    p_result.is_navigable := true;
end render_ig_simple_choice;

--------------------------------------------------------------------------------
-- Meta Data Procedure
-- Returns a LOV as will be used in Filter and in Export Report
--------------------------------------------------------------------------------
procedure metadata_ig_simple_choice (
    p_item   in            apex_plugin.t_item,
    p_plugin in            apex_plugin.t_plugin,
    p_param  in            apex_plugin.t_item_meta_data_param,
    p_result in out nocopy apex_plugin.t_item_meta_data_result )
is
    item_attr   t_item_attr;     
begin
    init_item_attr(p_item, item_attr);
    -- define query getting return/display values
    -- as used by APEX in places like column filter and export report to pdf/excel/etc
    -- no need to include null value (it would be filtered out by APEX anyway in the end query)
    -- instead, the user can use 'is empty' filter
    p_result.display_lov_definition := q'!select '!' || item_attr.label1 || q'!' as d, '!' || item_attr.value1 || q'!' as r !' ||
                                       q'!from dual !' ||
                                       q'!union all !' ||
                                       q'!select '!' || item_attr.label2 || q'!' as d, '!' || item_attr.value2 || q'!' as r !' ||
                                       q'!from dual!';
    p_result.return_display_value := false;  -- return 'return' value only for regular item display                                  
    p_result.escape_output := false;
end metadata_ig_simple_choice;

--------------------------------------------------------------------------------
-- Validation Procedure
-- Executed before user defined validations
--------------------------------------------------------------------------------
procedure validate_ig_simple_choice (
    p_item   in            apex_plugin.t_item,
    p_plugin in            apex_plugin.t_plugin,
    p_param  in            apex_plugin.t_item_validation_param,
    p_result in out nocopy apex_plugin.t_item_validation_result )
is
    item_attr   t_item_attr;     
begin
    init_item_attr(p_item, item_attr);
    if (item_attr.c_choice_type = 'RADIO_GROUP') then
        if (((p_param.value is not null)) and (not(p_param.value in (item_attr.c_null_return_value, item_attr.c_value1, item_attr.c_value2)))) then
            p_result.message := 'Radio Group contains invalid value (' || p_param.value || ')';
        end if;
    end if;
end validate_ig_simple_choice;
