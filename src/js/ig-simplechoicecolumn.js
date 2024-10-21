/**
 * @author Karel Ekema
 * @license MIT license
 * Copyright (c) 2024 Karel Ekema
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the 'Software'), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

window.lib4x = window.lib4x || {};
window.lib4x.axt = window.lib4x.axt || {};
window.lib4x.axt.ig = window.lib4x.axt.ig || {};

/* SimpleChoiceColumn
 * Enables simple radio group, checkbox or switch, multi-row, in an Interactive Grid
 * as to fast select between 2 choices.
 * Approach can be compared to the native IG checkbox - with a difference when the user
 * starts clicking when the IG is not in edit mode yet: upon first click, the IG
 * is automatically set in edit mode. From this, also immediately the change events
 * will be fired, so any DA gets triggered.
*/
lib4x.axt.ig.simpleChoiceColumn = (function($, util) {

    // Init the item - will be called on page load
    // The value will be kept on the server-side generated hidden input element.
    // In the init here, the specific item interface is set up by applying apex.item.create.
    // Client-side, the html for the specific type of choice item is generated.
    let init = function(itemId, options)
    {
        // set up context variables including simple arrays on labels/values.
        let choiceType = options.choiceType;
        let displayNullValue = false;    
        let value0;
        let label0;             
        if ((choiceType == 'RADIO_GROUP') && options.displayNullValue)
        {
            displayNullValue = options.displayNullValue; 
            value0 = options.value0;
            label0 = options.label0;  
        } 
        let value1 = options.value1;
        let label1 = options.label1;   
        if (choiceType == 'CHECKBOX')
        {
            label1 = apex.lang.getMessage( "APEX.ITEM_TYPE.CHECKBOX.CHECKED");
        }     
        let value2 = options.value2;
        let label2 = options.label2;
        if (choiceType == 'CHECKBOX')
        {
            label2 = apex.lang.getMessage( "APEX.ITEM_TYPE.CHECKBOX.UNCHECKED");
        }          
        let choiceLabel;
        let choiceValue;
        if ((choiceType == 'RADIO_GROUP') && options.displayNullValue)
        {
            choiceLabel = [label0, label1, label2];
            choiceValue = [value0, value1, value2];            
        }   
        else
        {
            choiceLabel = [label1, label2];
            choiceValue = [value1, value2];
        }     
        let index = 0;
        let itemIsDisabled = false;
        let itemIsReadOnly = options.readOnly; 
        let itemIsRequired = options.isRequired;
        let displayAsPillButton = options.displayAsPillButton;

        // wrap the server-side generated input element
        // lateron, we add the specific html for the choice item type to this div, next to the hidden 
        // input element
        const item$ = $(`#${itemId}`);
        let wrapClasses = 'apex-item-single-checkbox' + (displayAsPillButton ? ' t-Form-fieldContainer--radioButtonGroup' : '');
        const iw$ = item$.wrap('<div class="' + wrapClasses + '"></div>').parent();

        // render the specific choice item
        // this can be as part of the above div next to the hidden input element
        // or the rendering is from displayValueFor in the item interface
        // as to render for each and every row
        const render = (value, renderDisabled, labelBy) => {
            let result = null;
            if (choiceType == 'RADIO_GROUP')
            {
                result = renderRadioGroup(value, renderDisabled, labelBy);
            }
            else if (choiceType == 'SWITCH_CB')
            {
                result = renderSwitch(value, renderDisabled, labelBy);
            }
            else if (choiceType == 'CHECKBOX')
            {
                result = renderCheckbox(value, renderDisabled, labelBy);
            }            
            return result;
        }

        const renderRadioGroup = (value, renderDisabled, labelBy) => {
            const out = util.htmlBuilder();
            if (displayAsPillButton)
            {
                out.markup('<div')
                    .attr('class', 't-Form-fieldContainer--radioButtonGroup')
                    .markup('/>')
            }
            out.markup('<div')
                .attr('id', `${itemId}_${index}`)
                .attr('class','apex-item-single-checkbox radio_group apex-item-group apex-item-group--rc apex-item-radio js-ignoreChange')
                .attr('role','radiogroup')
                .markup('><div')
                .attr('role', 'none')
                .attr('class', 'apex-item-grid radio_group')     
                .markup('><div')
                .attr('role', 'none')
                .attr('class', 'apex-item-grid-row ')           
                .markup('>');
            for (let optionSeq = 0; optionSeq < choiceLabel.length; optionSeq++) {
                out.markup('<div')
                    .attr('class','apex-item-option')
                    .markup('><input')
                    .optionalAttr('disabled', renderDisabled)
                    .attr('type','radio')
                    .attr('id', `${itemId}_${index}_${optionSeq}`)
                    .attr('name', `${itemId}_${index}_RG`)
                    .attr('data-display', `${choiceLabel[optionSeq]}`)
                    .attr('value', `${choiceValue[optionSeq]}`)
                    .attr('aria-label', `${choiceLabel[optionSeq]}`)
                    .optionalAttr('checked', value===choiceValue[optionSeq])
                    .markup('><label')
                    .attr('class', 'u-radio')
                    .attr('for', `${itemId}_${index}_${optionSeq}`)
                    .attr('aria-hidden', true)
                    .markup('>')
                    .content(choiceLabel[optionSeq])
                    .markup('</label></div>')
            }
            out.markup('</div>')
                .markup('</div>')
                .markup('</div>');
            if (displayAsPillButton)
            {                
                out.markup('</div>');
            }

            index += 1;
            return out.toString();
        };

        const renderSwitch = (value, renderDisabled, labelBy) => {
            const out = util.htmlBuilder();     
            out.markup('<span')
                .attr('class', 'a-Switch')   
                .markup('><input')
                .optionalBoolAttr('disabled', renderDisabled)                
                .attr('type', 'checkbox')
                .attr('role', 'switch')
                .attr('id', `${itemId}_${index}_0`)
                .attr('name', `${itemId}_${index}_SW`)   
                .attr('class', 'js-ignoreChange js-tabbable')
                .attr('value', choiceValue[0])            
                .attr('data-on-label', choiceLabel[0])
                .attr('data-off-value', choiceValue[1])
                .attr('data-off-label', choiceLabel[1])
                .optionalBoolAttr('checked', value===choiceValue[0])
                .optionalAttr('aria-labelledby', labelBy ? util.escapeHTMLAttr(labelBy) : '')
                .markup('><span')
                .attr('class', 'a-Switch-toggle')
                .markup('></span></span>');

            index += 1;    
            return out.toString();
        }   

        const renderCheckbox = (value, renderDisabled, labelBy) => {
            const out = util.htmlBuilder();     
            out.markup('<div')
                .attr('class', 'apex-item-single-checkbox')
                .markup('><input')
                .optionalBoolAttr('disabled', renderDisabled)                
                .attr('type', 'checkbox')
                .attr('id', `${itemId}_${index}_0`)
                .attr('name', `${itemId}_${index}_CB`)   
                .attr('class', 'js-ignoreChange js-tabbable')
                .attr('value', choiceValue[0])            
                .optionalBoolAttr('checked', value===choiceValue[0])
                .optionalAttr('aria-labelledby', labelBy ? util.escapeHTMLAttr(labelBy) : '')
                .markup('><span')
                .attr('class', 'u-checkbox')
                .attr('aria-hidden', true)
                .markup('></span><span')
                .attr('class', 'u-vh')
                .attr('aria-hidden', true)
                .markup('>')
                .content(getValueLabel(value))
                .markup('</span></div>');

            index += 1;    
            return out.toString();
        }          

        const getValueLabel = (itemValue) => {
            let label = choiceLabel[choiceValue.indexOf(itemValue)];
            return label ? label : '';
        }

        // updateDisplay processes any value change on the hidden input item
        // into the specific choice item 
        const updateDisplay = () => {
            if (choiceType == 'RADIO_GROUP')
            {
                updateRadioGroupDisplay();
            }
            else if (choiceType == 'SWITCH_CB')
            {
                updateSwitchDisplay();
            }
            else if (choiceType == 'CHECKBOX')
            {
                updateCheckboxDisplay();
            }            
        }

        const updateRadioGroupDisplay = () => {
            let radioButton$ = null;
            let itemValue = item$.val();
            if (itemValue || displayNullValue)
            {
                radioButton$ = iw$.find('input[type="radio"][value="'+itemValue+'"]');
                if (radioButton$.length)
                {
                    radioButton$[0].checked = true;
                }
            }
            else
            {
                iw$.find('input[type="radio"]').each(function(index){
                    this.checked = false;
                });
            }
        };

        const updateSwitchDisplay = () => {
            let itemValue = item$.val();
            let switch$ = iw$.find('input[type="checkbox"][role="switch"]');
            if (switch$.length)
            {
                switch$[0].checked = (itemValue == choiceValue[0]);
            }
        };     

        const updateCheckboxDisplay = () => {
            let itemValue = item$.val();
            let cbInput$ = iw$.find('input[type="checkbox"]');
            if (cbInput$.length)
            {
                cbInput$[0].checked = (itemValue == choiceValue[0]);
            }
        };            

        const getGridView = () => {
            return item$.closest('.a-IG').interactiveGrid('getViews').grid;
        }

        const invertCheckbox = (cbInput$) => {
            cbInput$.prop('checked', !cbInput$.prop('checked')).trigger('change'); 
            cbInput$[0].indeterminate = false;            
        }    

        // put IG in edit mode
        // and fire change event for the item
        const switchToEditMode = () => {
            // to be sure, check if not in edit mode
            if (!(getGridView().view$.grid('inEditMode')))
            {
                setTimeout(()=>{
                    item$.closest('.a-IG').interactiveGrid('getActions').set('edit', true); 
                    apex.event.trigger('#'+itemId, 'change', null); 
                }, 10);
            }            
        }    

        if (!itemIsReadOnly)
        {
            // extend the div wrapped hidden item with the choice item specific html
            iw$.append(render(null, false, null));        // as per index 0
        }

        if (choiceType == "RADIO_GROUP")
        {
            // upon checking a radio button, update the item value as kept on the hidden input element
            iw$.find('input[type="radio"]').on('change', (e) => {
                const radioButton$ = $(e.currentTarget);
                if (radioButton$[0].checked)
                {
                    item$.val(radioButton$.val()).change();
                }
            });
        }
        else if (choiceType == "SWITCH_CB")
        {
            let cbInput$ = iw$.find('input[type="checkbox"][role="switch"]')
            cbInput$.closest( "span.a-Switch" ).on( "click", function( e ) 
            {
                // The switch is basically a checkbox. When clicking on the switch, the click might be
                // on the (invisible) checkbox, or outside of it on the switch css graph. If the click is 
                // on the checkbox, the 'checked' flag is automatically set. If clicked outsite, then
                // we need the set this flag ourselves.
                // The situation here is the IG cell is activated and the switch has been clicked. So the 
                // item.onInteraction(event.type = activate) won't be called.
                // Taken from widget.yesNo.js
                if (!$(e.target).is(':checkbox') && !cbInput$.is(':disabled'))
                {
                    invertCheckbox(cbInput$);
                }
            });
            // upon a switch change, update the item value as kept on the hidden input element
            cbInput$.on('change', (e) => {
                const switch$ = $(e.currentTarget);
                item$.val(switch$[0].checked ? choiceValue[0] : choiceValue[1]).change();
            });            
        }
        else if (choiceType == "CHECKBOX")
        {
            let cbInput$ = iw$.find('input[type="checkbox"]')
            // upon check/uncheck, update the item value as kept on the hidden input element
            cbInput$.on('change', (e) => {
                const cb$ = $(e.currentTarget);
                item$.val(cb$[0].checked ? choiceValue[0] : choiceValue[1]).change();
            });            
        }        

        // set the specific choice item checked attribute as per the hidden item value
        updateDisplay();

        // implement the item interface specifics
        apex.item.create(itemId, {
            item_type: "IG_SIMPLE_CHOICE",   
            getValue(){
                return this.node.value;
            },
            setValue(value){
                item$.val(value);
                updateDisplay();
            },
            disable(){
                if (choiceType == 'RADIO_GROUP')
                {
                    $(':radio', iw$).prop('disabled', true).addClass('apex_disabled_multi');
                }
                else if ((choiceType == 'SWITCH_CB') || (choiceType == 'CHECKBOX'))
                {
                    $(':checkbox', iw$).prop('disabled', true);
                }
                itemIsDisabled = true;
            },
            enable(){
                if (choiceType == 'RADIO_GROUP')
                {                
                    $(':radio', iw$).prop('disabled', false).removeClass('apex_disabled_multi');
                }
                else if ((choiceType == 'SWITCH_CB') || (choiceType == 'CHECKBOX'))
                { 
                    $(':checkbox', iw$).prop('disabled', false);
                }                                   
                itemIsDisabled = false;
            },
            isDisabled(){
                return itemIsDisabled;
            },
            setFocusTo() {
                // set focus to first input or currently selected radio if exists in the fieldset
                // has to be a function to get currently checked value
                let lReturn$ = $( ":checked", iw$ );
                if (lReturn$.length === 0 ) {
                    lReturn$ = $( choiceType == 'RADIO_GROUP' ? ":radio" : ":checkbox", iw$ );
                }
                return lReturn$.first();
            },            
            displayValueFor(value, state) {
                // return the choice item specific html
                // for single row view, just return the label
                let singleRowMode = getGridView().singleRowMode;
                let renderDisabled = state?.readonly || state?.disabled;
                return singleRowMode ? getValueLabel(value) : render(value, renderDisabled, state?.labelBy);
            },
            getValidity: function () {
                const requiredAttr = item$.prop( "required" );
                if ( requiredAttr !== undefined && requiredAttr !== false ) {
                    if ( this.isEmpty() ) {
                        return { valid: false, valueMissing: true };
                    }
                }
                return { valid: true };
            },  
            getInteractionSelector() {
                // specify the selector as to which part in the DOM 
                // clicks will be forwarded by APEX to the onInteraction method
                let result = null;
                if (choiceType == 'RADIO_GROUP')
                {
                    result = ".u-radio,.apex-item-option";
                }
                else if (choiceType == 'SWITCH_CB')
                {
                    result = ".a-Switch";
                }
                else if (choiceType == 'CHECKBOX')
                {
                    result = ".u-checkbox,.apex-item-single-checkbox";
                }
                return result;
            },            
            onInteraction(event, model, record, field){
                // clicks gets forwarded on first click or on activating a cell
                if (choiceType == 'RADIO_GROUP')
                {
                    if ((event.type == 'click') || (event.type == 'activate'))
                    {
                        // if clicking on the label, we need to switch the radio button ourselves
                        let radioButton$ = null;
                        if ($(event.target).is('.u-radio') || $(event.target).is('.apex-item-option'))
                        {
                            if ($(event.target).is('.u-radio'))
                            {
                                radioButton$ = $(event.target.parentElement).find('input[type="radio"]');
                            }
                            else if ($(event.target).is('.apex-item-option'))
                            {
                                radioButton$ = $(event.target).find('input[type="radio"]');
                            }
                            if (!radioButton$[0].checked)
                            {
                                radioButton$.prop('checked', true).trigger('change'); 
                            }
                        }
                        else
                        {
                            radioButton$ = $(event.target);
                        }                        
                        if (event.type == 'click')
                        {
                            // click event: so at this point, we are not in edit mode 
                            // update the model and put IG in edit mode
                            let oldValue = model.getValue(record, field);
                            let newValue = radioButton$[0].value;
                            if (newValue != oldValue)
                            {
                                model.setValue(record, field, newValue);
                                // switch to edit mode and fire change event
                                switchToEditMode();
                            }
                        }
                        else if (event.type == 'activate')
                        {
                            if (!apex.item(itemId).isDisabled())
                            {
                                // activate event: at this point, we are in edit mode
                                // set the value on the hidden input item
                                let oldValue = item$.val();
                                let newValue = radioButton$[0].value;
                                if (newValue != oldValue)
                                {
                                    this.setValue(newValue);
                                }
                            }
                        } 
                    }
                }
                else if ((choiceType == 'SWITCH_CB') || (choiceType == 'CHECKBOX'))
                {
                    // find checkbox input element
                    let cbInput$ = $(event.target.parentElement).find('input[type="checkbox"]' + (choiceType == 'SWITCH_CB' ? '[role="switch"]' : ''));
                    if (event.type == 'click')
                    {
                        // this is when the IG is not in edit mode
                        // if clicked on the switch outsite the (invisible) checkbox, set the 'checked' property ourselves
                        if (!$(event.target).is(':checkbox') && !cbInput$.is(':disabled'))
                        {
                            invertCheckbox(cbInput$);
                        }     
                        let oldValue = model.getValue(record, field);
                        let newValue = cbInput$.prop('checked') ? choiceValue[0] : choiceValue[1];
                        if (newValue != oldValue)
                        {
                            model.setValue(record, field, newValue);
                            // switch to edit mode and fire change event
                            switchToEditMode();
                        }                                           
                    }
                    else if (event.type == 'activate')
                    {
                        // this is when the cell is activated and there was interaction on the InteractionSelector part
                        // the a-Switch on click is not getting triggered in this situation, so we need to 
                        // change the switch here and invert the 'checked' property
                        if (!apex.item(itemId).isDisabled())
                        {                        
                            if (!cbInput$.is(':disabled'))
                            {
                                invertCheckbox(cbInput$);
                            }                         
                            let oldValue = item$.val();
                            let newValue = cbInput$.prop('checked') ? choiceValue[0] : choiceValue[1];
                            if (newValue != oldValue)
                            {
                                // set the item value; APEX will adjust the model as we are in edit mode
                                this.setValue(newValue);
                            }
                        }
                    }                     
                } 
            }
        });
    }

    return{
        init: init
    }
})(apex.jQuery, apex.util);
