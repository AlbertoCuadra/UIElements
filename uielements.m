classdef uielements < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIElements             matlab.ui.Figure
        panel_all              matlab.ui.container.Panel
        grid_all               matlab.ui.container.GridLayout
        panel_close            matlab.ui.container.Panel
        button_close           matlab.ui.control.Button
        panel_export           matlab.ui.container.Panel
        button_export          matlab.ui.control.Button
        panel_data             matlab.ui.container.Panel
        grid_data              matlab.ui.container.GridLayout
        button_add             matlab.ui.control.Button
        button_remove          matlab.ui.control.Button
        button_copy            matlab.ui.control.Button
        listbox_LS             matlab.ui.control.ListBox
        listbox_LS_DB          matlab.ui.control.ListBox
        text_LS                matlab.ui.control.Label
        text_LS_DB             matlab.ui.control.Label
        text_list_species      matlab.ui.control.Label
        edit_seeker            matlab.ui.control.EditField
        panel_properties       matlab.ui.container.Panel
        grid_properties        matlab.ui.container.GridLayout
        text_comments          matlab.ui.control.TextArea
        CommentsTextAreaLabel  matlab.ui.control.Label
        text_ef                matlab.ui.control.NumericEditField
        text_ef_label          matlab.ui.control.Label
        text_hf                matlab.ui.control.NumericEditField
        text_hf_label          matlab.ui.control.Label
        text_W                 matlab.ui.control.NumericEditField
        text_W_label           matlab.ui.control.Label
        text_phase             matlab.ui.control.EditField
        text_phase_label       matlab.ui.control.Label
        text_codename          matlab.ui.control.EditField
        text_codename_label    matlab.ui.control.Label
        text_species           matlab.ui.control.EditField
        text_species_label     matlab.ui.control.Label
        Legend                 matlab.ui.control.Image
        element_92             matlab.ui.control.Image
        element_91             matlab.ui.control.Image
        element_90             matlab.ui.control.Image
        element_89             matlab.ui.control.Image
        element_88             matlab.ui.control.Image
        element_87             matlab.ui.control.Image
        element_86             matlab.ui.control.Image
        element_85             matlab.ui.control.Image
        element_84             matlab.ui.control.Image
        element_83             matlab.ui.control.Image
        element_82             matlab.ui.control.Image
        element_81             matlab.ui.control.Image
        element_80             matlab.ui.control.Image
        element_79             matlab.ui.control.Image
        element_78             matlab.ui.control.Image
        element_77             matlab.ui.control.Image
        element_76             matlab.ui.control.Image
        element_75             matlab.ui.control.Image
        element_74             matlab.ui.control.Image
        element_73             matlab.ui.control.Image
        element_72             matlab.ui.control.Image
        element_57_71          matlab.ui.control.Image
        element_56             matlab.ui.control.Image
        element_55             matlab.ui.control.Image
        element_54             matlab.ui.control.Image
        element_53             matlab.ui.control.Image
        element_52             matlab.ui.control.Image
        element_51             matlab.ui.control.Image
        element_50             matlab.ui.control.Image
        element_49             matlab.ui.control.Image
        element_48             matlab.ui.control.Image
        element_47             matlab.ui.control.Image
        element_46             matlab.ui.control.Image
        element_45             matlab.ui.control.Image
        element_44             matlab.ui.control.Image
        element_43             matlab.ui.control.Image
        element_42             matlab.ui.control.Image
        element_41             matlab.ui.control.Image
        element_40             matlab.ui.control.Image
        element_39             matlab.ui.control.Image
        element_38             matlab.ui.control.Image
        element_37             matlab.ui.control.Image
        element_36             matlab.ui.control.Image
        element_35             matlab.ui.control.Image
        element_34             matlab.ui.control.Image
        element_33             matlab.ui.control.Image
        element_32             matlab.ui.control.Image
        element_31             matlab.ui.control.Image
        element_30             matlab.ui.control.Image
        element_29             matlab.ui.control.Image
        element_28             matlab.ui.control.Image
        element_27             matlab.ui.control.Image
        element_26             matlab.ui.control.Image
        element_25             matlab.ui.control.Image
        element_24             matlab.ui.control.Image
        element_23             matlab.ui.control.Image
        element_22             matlab.ui.control.Image
        element_21             matlab.ui.control.Image
        element_20             matlab.ui.control.Image
        element_19             matlab.ui.control.Image
        element_18             matlab.ui.control.Image
        element_17             matlab.ui.control.Image
        element_16             matlab.ui.control.Image
        element_15             matlab.ui.control.Image
        element_14             matlab.ui.control.Image
        element_13             matlab.ui.control.Image
        element_12             matlab.ui.control.Image
        element_11             matlab.ui.control.Image
        element_10             matlab.ui.control.Image
        element_9              matlab.ui.control.Image
        element_8              matlab.ui.control.Image
        element_7              matlab.ui.control.Image
        element_6              matlab.ui.control.Image
        element_5              matlab.ui.control.Image
        element_4              matlab.ui.control.Image
        element_3              matlab.ui.control.Image
        element_2              matlab.ui.control.Image
        element_1_3            matlab.ui.control.Image
        element_1_2            matlab.ui.control.Image
        element_1              matlab.ui.control.Image
        context_menu           matlab.ui.container.ContextMenu
        enableremoveMenu       matlab.ui.container.Menu
    end

    
    properties (Access = public)
        DB_master   % Master DataBase
        DB          % Reduced DataBase
        LS_DB       % List species Database
        LE_selected % List of elements selected
        LE_omit     % List of elements to omit
    end

    properties (Dependent)
        NE
    end
    
    methods (Access = private)
        
        function FLAG_CLICKED = changes_image(app, event)
            try
                image_source = split(event.Source.ImageSource, '\');
                image_element = image_source{end};
                if contains(image_element, 'clicked')
                    FLAG_CLICKED = false;
                    event.Source.ImageSource = strrep(image_element, '_clicked', '');
                else
                    FLAG_CLICKED = true;
                    event.Source.ImageSource = strrep(image_element, '.svg', '_clicked.svg');
                end
            catch
                FLAG_CLICKED = false;
            end
        end
        
        function set_DB(app)
            % Generate Database with custom polynomials from DB_master
            
            % FLAG_REDUCED_DB:
            %   * False: complete Database
            %   * True:  reduced Database
            FLAG_REDUCED_DB = false;
            app.DB_master = generate_DB_master(FLAG_REDUCED_DB);
            % Reduced Database with tabulated data of selected species
            app.DB = generate_DB(app.DB_master);
        end

    end

    methods
        function value = get.NE(app)
            value = length(app.LE_selected);
        end
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            % Initialization
            app.LE_omit = [];
            % Set database
            set_DB(app);        
            % Save list of species contained in the database
            app.LS_DB = fieldnames(app.DB);
        end

        % Image clicked function: element_1, element_10, element_11, 
        % ...and 77 other components
        function element_1ImageClicked(app, event)
            % Change image
            FLAG_CLICKED = changes_image(app, event);
            if FLAG_CLICKED
                % Add element to the list of elements
                if app.NE
                    app.LE_selected{end + 1} = event.Source.Tag;
                else
                    app.LE_selected = {event.Source.Tag};
                end
            else
                % Remove element of the list of elements
                index_remove = find_ind(app.LE_selected, event.Source.Tag);
                app.LE_selected(index_remove) = [];
                if ~app.NE
                    app.listbox_LS_DB.Items = {};
                end
            end
            % Search species with the elements selected
            if app.NE
                try
                    LS = find_species_LS(app.LS_DB, app.LE_selected, 'all', app.LE_omit, 'all');
                catch
                    LS = {};
                end
                app.listbox_LS_DB.Items = LS;
            end
        end

        % Button pushed function: button_add
        function button_addPushed(app, event)
            app.listbox_LS.Items = gui_value2list(app, app.listbox_LS_DB.Value, app.listbox_LS.Items, 'add');
        end

        % Button pushed function: button_remove
        function button_removePushed(app, event)
            app.listbox_LS.Items = gui_value2list(app, app.listbox_LS.Value, app.listbox_LS.Items, 'remove');
        end

        % Value changed function: listbox_LS, listbox_LS_DB
        function listbox_LSValueChanged(app, event)
            species = event.Source.Value{1};
            % Get values
            phase = app.DB.(species).phase;
            W = app.DB.(species).mm; % [g/mol]
            % Update GUI
            app.text_species.Value = app.DB.(species).FullName;
            app.text_codename.Value = app.DB.(species).name;
            app.text_comments.Value = strtrim(app.DB.(species).comments);

            if phase
                app.text_phase.Value = 'condensed';
            else
                app.text_phase.Value = 'gas';
            end
            app.text_W.Value = W;
            app.text_hf.Value = app.DB.(species).hf * W * 1e-6;
            app.text_ef.Value = app.DB.(species).ef * W * 1e-6;
        end

        % Button pushed function: button_export
        function button_exportButtonPushed(app, event)
            button_copyButtonPushed(app, event);
        end

        % Button pushed function: button_copy
        function button_copyButtonPushed(app, event)
            % Generate cell
            LS_copy = '{';
            for i = 1:length(app.listbox_LS.Items)
                if i > 1
                    LS_copy = [LS_copy, ', '];
                end
                LS_copy = [LS_copy, '''', app.listbox_LS.Items{i}, ''''];
            end
            LS_copy = [LS_copy, '}'];
            % Copy to clipboard
            clipboard('copy', LS_copy);
        end

        % Menu selected function: enableremoveMenu
        function enableremoveMenuSelected(app, event)
            % Get current object
            current_fig = gcbf;
            current_obj = current_fig.CurrentObject;
            % Check state to enable/remove the element
            if strcmpi(current_obj.Enable, 'on')
                % Omit element to be searchable
                current_obj.Enable = 'off';
                % Add element to LE_omit
                app.LE_omit{end+1} = current_obj.Tag; 
            else
                % Allow element to be searchable
                current_obj.Enable = 'on';
                % Remove element from LE_omit
                ind = find_ind(app.LE_omit, current_obj.Tag);
                app.LE_omit(ind) = [];
            end
            % Update GUI
            element_1ImageClicked(app, event);
        end

        % Callback function: UIElements, button_close
        function UIElementsCloseRequest(app, event)
            delete(app)
        end

        % Value changing function: edit_seeker
        function edit_seekerValueChanging(app, event)
            seek_value = gui_seeker_value(app, event, app.LS_DB);
            % Update Listbox (inputs)
            if ~isempty(seek_value)
                app.listbox_LS_DB.Items = seek_value;
            else
                app.listbox_LS_DB.Items = {};
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIElements and hide until all components are created
            app.UIElements = uifigure('Visible', 'off');
            app.UIElements.Color = [0.9098 0.9098 0.8902];
            app.UIElements.Position = [150 150 1434 558];
            app.UIElements.Name = 'uielements';
            app.UIElements.Icon = 'logo_uielements.png';
            app.UIElements.CloseRequestFcn = createCallbackFcn(app, @UIElementsCloseRequest, true);
            app.UIElements.Scrollable = 'on';

            % Create panel_all
            app.panel_all = uipanel(app.UIElements);
            app.panel_all.BorderType = 'none';
            app.panel_all.BackgroundColor = [0.9098 0.9098 0.8902];
            app.panel_all.Position = [1 1 1434 558];

            % Create grid_all
            app.grid_all = uigridlayout(app.panel_all);
            app.grid_all.ColumnWidth = {'1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x'};
            app.grid_all.RowHeight = {'1x', '1x', '1x', '1x', '1x', '1x', '1x'};
            app.grid_all.Padding = [9.04736328125 8.19999186197917 9.04736328125 8.19999186197917];
            app.grid_all.BackgroundColor = [0.9098 0.9098 0.8902];

            % Create element_1
            app.element_1 = uiimage(app.grid_all);
            app.element_1.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_1.Tag = 'H';
            app.element_1.Layout.Row = 1;
            app.element_1.Layout.Column = 1;
            app.element_1.ImageSource = '1.svg';

            % Create element_1_2
            app.element_1_2 = uiimage(app.grid_all);
            app.element_1_2.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_1_2.Tag = 'D';
            app.element_1_2.Layout.Row = 1;
            app.element_1_2.Layout.Column = 2;
            app.element_1_2.ImageSource = '1_2.svg';

            % Create element_1_3
            app.element_1_3 = uiimage(app.grid_all);
            app.element_1_3.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_1_3.Tag = 'T';
            app.element_1_3.Layout.Row = 1;
            app.element_1_3.Layout.Column = 3;
            app.element_1_3.ImageSource = '1_3.svg';

            % Create element_2
            app.element_2 = uiimage(app.grid_all);
            app.element_2.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_2.Tag = 'He';
            app.element_2.Layout.Row = 1;
            app.element_2.Layout.Column = 18;
            app.element_2.ImageSource = '2.svg';

            % Create element_3
            app.element_3 = uiimage(app.grid_all);
            app.element_3.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_3.Tag = 'Li';
            app.element_3.Layout.Row = 2;
            app.element_3.Layout.Column = 1;
            app.element_3.ImageSource = '3.svg';

            % Create element_4
            app.element_4 = uiimage(app.grid_all);
            app.element_4.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_4.Tag = 'Be';
            app.element_4.Layout.Row = 2;
            app.element_4.Layout.Column = 2;
            app.element_4.ImageSource = '4.svg';

            % Create element_5
            app.element_5 = uiimage(app.grid_all);
            app.element_5.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_5.Tag = 'B';
            app.element_5.Layout.Row = 2;
            app.element_5.Layout.Column = 13;
            app.element_5.ImageSource = '5.svg';

            % Create element_6
            app.element_6 = uiimage(app.grid_all);
            app.element_6.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_6.Tag = 'C';
            app.element_6.Layout.Row = 2;
            app.element_6.Layout.Column = 14;
            app.element_6.ImageSource = '6.svg';

            % Create element_7
            app.element_7 = uiimage(app.grid_all);
            app.element_7.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_7.Tag = 'N';
            app.element_7.Layout.Row = 2;
            app.element_7.Layout.Column = 15;
            app.element_7.ImageSource = '7.svg';

            % Create element_8
            app.element_8 = uiimage(app.grid_all);
            app.element_8.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_8.Tag = 'O';
            app.element_8.Layout.Row = 2;
            app.element_8.Layout.Column = 16;
            app.element_8.ImageSource = '8.svg';

            % Create element_9
            app.element_9 = uiimage(app.grid_all);
            app.element_9.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_9.Tag = 'F';
            app.element_9.Layout.Row = 2;
            app.element_9.Layout.Column = 17;
            app.element_9.ImageSource = '9.svg';

            % Create element_10
            app.element_10 = uiimage(app.grid_all);
            app.element_10.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_10.Tag = 'Ne';
            app.element_10.Layout.Row = 2;
            app.element_10.Layout.Column = 18;
            app.element_10.ImageSource = '10.svg';

            % Create element_11
            app.element_11 = uiimage(app.grid_all);
            app.element_11.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_11.Tag = 'Na';
            app.element_11.Layout.Row = 3;
            app.element_11.Layout.Column = 1;
            app.element_11.ImageSource = '11.svg';

            % Create element_12
            app.element_12 = uiimage(app.grid_all);
            app.element_12.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_12.Tag = 'Mg';
            app.element_12.Layout.Row = 3;
            app.element_12.Layout.Column = 2;
            app.element_12.ImageSource = '12.svg';

            % Create element_13
            app.element_13 = uiimage(app.grid_all);
            app.element_13.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_13.Tag = 'AL';
            app.element_13.Layout.Row = 3;
            app.element_13.Layout.Column = 13;
            app.element_13.ImageSource = '13.svg';

            % Create element_14
            app.element_14 = uiimage(app.grid_all);
            app.element_14.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_14.Tag = 'Si';
            app.element_14.Layout.Row = 3;
            app.element_14.Layout.Column = 14;
            app.element_14.ImageSource = '14.svg';

            % Create element_15
            app.element_15 = uiimage(app.grid_all);
            app.element_15.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_15.Tag = 'P';
            app.element_15.Layout.Row = 3;
            app.element_15.Layout.Column = 15;
            app.element_15.ImageSource = '15.svg';

            % Create element_16
            app.element_16 = uiimage(app.grid_all);
            app.element_16.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_16.Tag = 'S';
            app.element_16.Layout.Row = 3;
            app.element_16.Layout.Column = 16;
            app.element_16.ImageSource = '16.svg';

            % Create element_17
            app.element_17 = uiimage(app.grid_all);
            app.element_17.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_17.Tag = 'CL';
            app.element_17.Layout.Row = 3;
            app.element_17.Layout.Column = 17;
            app.element_17.ImageSource = '17.svg';

            % Create element_18
            app.element_18 = uiimage(app.grid_all);
            app.element_18.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_18.Tag = 'Ar';
            app.element_18.Layout.Row = 3;
            app.element_18.Layout.Column = 18;
            app.element_18.ImageSource = '18.svg';

            % Create element_19
            app.element_19 = uiimage(app.grid_all);
            app.element_19.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_19.Tag = 'K';
            app.element_19.Layout.Row = 4;
            app.element_19.Layout.Column = 1;
            app.element_19.ImageSource = '19.svg';

            % Create element_20
            app.element_20 = uiimage(app.grid_all);
            app.element_20.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_20.Tag = 'Ca';
            app.element_20.Layout.Row = 4;
            app.element_20.Layout.Column = 2;
            app.element_20.ImageSource = '20.svg';

            % Create element_21
            app.element_21 = uiimage(app.grid_all);
            app.element_21.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_21.Tag = 'Sc';
            app.element_21.Layout.Row = 4;
            app.element_21.Layout.Column = 3;
            app.element_21.ImageSource = '21.svg';

            % Create element_22
            app.element_22 = uiimage(app.grid_all);
            app.element_22.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_22.Tag = 'Ti';
            app.element_22.Layout.Row = 4;
            app.element_22.Layout.Column = 4;
            app.element_22.ImageSource = '22.svg';

            % Create element_23
            app.element_23 = uiimage(app.grid_all);
            app.element_23.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_23.Tag = 'V';
            app.element_23.Layout.Row = 4;
            app.element_23.Layout.Column = 5;
            app.element_23.ImageSource = '23.svg';

            % Create element_24
            app.element_24 = uiimage(app.grid_all);
            app.element_24.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_24.Tag = 'Cr';
            app.element_24.Layout.Row = 4;
            app.element_24.Layout.Column = 6;
            app.element_24.ImageSource = '24.svg';

            % Create element_25
            app.element_25 = uiimage(app.grid_all);
            app.element_25.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_25.Tag = 'Mn';
            app.element_25.Layout.Row = 4;
            app.element_25.Layout.Column = 7;
            app.element_25.ImageSource = '25.svg';

            % Create element_26
            app.element_26 = uiimage(app.grid_all);
            app.element_26.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_26.Tag = 'Fe';
            app.element_26.Layout.Row = 4;
            app.element_26.Layout.Column = 8;
            app.element_26.ImageSource = '26.svg';

            % Create element_27
            app.element_27 = uiimage(app.grid_all);
            app.element_27.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_27.Tag = 'Co';
            app.element_27.Layout.Row = 4;
            app.element_27.Layout.Column = 9;
            app.element_27.ImageSource = '27.svg';

            % Create element_28
            app.element_28 = uiimage(app.grid_all);
            app.element_28.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_28.Tag = 'Ni';
            app.element_28.Layout.Row = 4;
            app.element_28.Layout.Column = 10;
            app.element_28.ImageSource = '28.svg';

            % Create element_29
            app.element_29 = uiimage(app.grid_all);
            app.element_29.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_29.Tag = 'Cu';
            app.element_29.Layout.Row = 4;
            app.element_29.Layout.Column = 11;
            app.element_29.ImageSource = '29.svg';

            % Create element_30
            app.element_30 = uiimage(app.grid_all);
            app.element_30.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_30.Tag = 'Zn';
            app.element_30.Layout.Row = 4;
            app.element_30.Layout.Column = 12;
            app.element_30.ImageSource = '30.svg';

            % Create element_31
            app.element_31 = uiimage(app.grid_all);
            app.element_31.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_31.Tag = 'Ga';
            app.element_31.Layout.Row = 4;
            app.element_31.Layout.Column = 13;
            app.element_31.ImageSource = '31.svg';

            % Create element_32
            app.element_32 = uiimage(app.grid_all);
            app.element_32.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_32.Tag = 'Ge';
            app.element_32.Layout.Row = 4;
            app.element_32.Layout.Column = 14;
            app.element_32.ImageSource = '32.svg';

            % Create element_33
            app.element_33 = uiimage(app.grid_all);
            app.element_33.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_33.Tag = 'As';
            app.element_33.Layout.Row = 4;
            app.element_33.Layout.Column = 15;
            app.element_33.ImageSource = '33.svg';

            % Create element_34
            app.element_34 = uiimage(app.grid_all);
            app.element_34.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_34.Tag = 'Se';
            app.element_34.Layout.Row = 4;
            app.element_34.Layout.Column = 16;
            app.element_34.ImageSource = '34.svg';

            % Create element_35
            app.element_35 = uiimage(app.grid_all);
            app.element_35.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_35.Tag = 'Br';
            app.element_35.Layout.Row = 4;
            app.element_35.Layout.Column = 17;
            app.element_35.ImageSource = '35.svg';

            % Create element_36
            app.element_36 = uiimage(app.grid_all);
            app.element_36.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_36.Tag = 'Kr';
            app.element_36.Layout.Row = 4;
            app.element_36.Layout.Column = 18;
            app.element_36.ImageSource = '36.svg';

            % Create element_37
            app.element_37 = uiimage(app.grid_all);
            app.element_37.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_37.Tag = 'Rb';
            app.element_37.Layout.Row = 5;
            app.element_37.Layout.Column = 1;
            app.element_37.ImageSource = '37.svg';

            % Create element_38
            app.element_38 = uiimage(app.grid_all);
            app.element_38.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_38.Tag = 'Sr';
            app.element_38.Layout.Row = 5;
            app.element_38.Layout.Column = 2;
            app.element_38.ImageSource = '38.svg';

            % Create element_39
            app.element_39 = uiimage(app.grid_all);
            app.element_39.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_39.Tag = 'Y';
            app.element_39.Layout.Row = 5;
            app.element_39.Layout.Column = 3;
            app.element_39.ImageSource = '39.svg';

            % Create element_40
            app.element_40 = uiimage(app.grid_all);
            app.element_40.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_40.Tag = 'Zr';
            app.element_40.Layout.Row = 5;
            app.element_40.Layout.Column = 4;
            app.element_40.ImageSource = '40.svg';

            % Create element_41
            app.element_41 = uiimage(app.grid_all);
            app.element_41.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_41.Tag = 'Nb';
            app.element_41.Layout.Row = 5;
            app.element_41.Layout.Column = 5;
            app.element_41.ImageSource = '41.svg';

            % Create element_42
            app.element_42 = uiimage(app.grid_all);
            app.element_42.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_42.Tag = 'Mo';
            app.element_42.Layout.Row = 5;
            app.element_42.Layout.Column = 6;
            app.element_42.ImageSource = '42.svg';

            % Create element_43
            app.element_43 = uiimage(app.grid_all);
            app.element_43.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_43.Tag = 'Tc';
            app.element_43.Layout.Row = 5;
            app.element_43.Layout.Column = 7;
            app.element_43.ImageSource = '43.svg';

            % Create element_44
            app.element_44 = uiimage(app.grid_all);
            app.element_44.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_44.Tag = 'Ru';
            app.element_44.Layout.Row = 5;
            app.element_44.Layout.Column = 8;
            app.element_44.ImageSource = '44.svg';

            % Create element_45
            app.element_45 = uiimage(app.grid_all);
            app.element_45.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_45.Tag = 'Rh';
            app.element_45.Layout.Row = 5;
            app.element_45.Layout.Column = 9;
            app.element_45.ImageSource = '45.svg';

            % Create element_46
            app.element_46 = uiimage(app.grid_all);
            app.element_46.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_46.Tag = 'Pd';
            app.element_46.Layout.Row = 5;
            app.element_46.Layout.Column = 10;
            app.element_46.ImageSource = '46.svg';

            % Create element_47
            app.element_47 = uiimage(app.grid_all);
            app.element_47.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_47.Tag = 'Ag';
            app.element_47.Layout.Row = 5;
            app.element_47.Layout.Column = 11;
            app.element_47.ImageSource = '47.svg';

            % Create element_48
            app.element_48 = uiimage(app.grid_all);
            app.element_48.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_48.Tag = 'CD';
            app.element_48.Layout.Row = 5;
            app.element_48.Layout.Column = 12;
            app.element_48.ImageSource = '48.svg';

            % Create element_49
            app.element_49 = uiimage(app.grid_all);
            app.element_49.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_49.Tag = 'In';
            app.element_49.Layout.Row = 5;
            app.element_49.Layout.Column = 13;
            app.element_49.ImageSource = '49.svg';

            % Create element_50
            app.element_50 = uiimage(app.grid_all);
            app.element_50.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_50.Tag = 'Sn';
            app.element_50.Layout.Row = 5;
            app.element_50.Layout.Column = 14;
            app.element_50.ImageSource = '50.svg';

            % Create element_51
            app.element_51 = uiimage(app.grid_all);
            app.element_51.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_51.Tag = 'Sb';
            app.element_51.Layout.Row = 5;
            app.element_51.Layout.Column = 15;
            app.element_51.ImageSource = '51.svg';

            % Create element_52
            app.element_52 = uiimage(app.grid_all);
            app.element_52.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_52.Tag = 'Te';
            app.element_52.Layout.Row = 5;
            app.element_52.Layout.Column = 16;
            app.element_52.ImageSource = '52.svg';

            % Create element_53
            app.element_53 = uiimage(app.grid_all);
            app.element_53.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_53.Tag = 'I';
            app.element_53.Layout.Row = 5;
            app.element_53.Layout.Column = 17;
            app.element_53.ImageSource = '53.svg';

            % Create element_54
            app.element_54 = uiimage(app.grid_all);
            app.element_54.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_54.Tag = 'Xe';
            app.element_54.Layout.Row = 5;
            app.element_54.Layout.Column = 18;
            app.element_54.ImageSource = '54.svg';

            % Create element_55
            app.element_55 = uiimage(app.grid_all);
            app.element_55.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_55.Tag = 'Cs';
            app.element_55.Layout.Row = 6;
            app.element_55.Layout.Column = 1;
            app.element_55.ImageSource = '55.svg';

            % Create element_56
            app.element_56 = uiimage(app.grid_all);
            app.element_56.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_56.Tag = 'Ba';
            app.element_56.Layout.Row = 6;
            app.element_56.Layout.Column = 2;
            app.element_56.ImageSource = '56.svg';

            % Create element_57_71
            app.element_57_71 = uiimage(app.grid_all);
            app.element_57_71.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_57_71.Enable = 'off';
            app.element_57_71.Layout.Row = 6;
            app.element_57_71.Layout.Column = 3;
            app.element_57_71.ImageSource = '57_71.svg';

            % Create element_72
            app.element_72 = uiimage(app.grid_all);
            app.element_72.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_72.Tag = 'Hf';
            app.element_72.Layout.Row = 6;
            app.element_72.Layout.Column = 4;
            app.element_72.ImageSource = '72.svg';

            % Create element_73
            app.element_73 = uiimage(app.grid_all);
            app.element_73.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_73.Tag = 'Ta';
            app.element_73.Layout.Row = 6;
            app.element_73.Layout.Column = 5;
            app.element_73.ImageSource = '73.svg';

            % Create element_74
            app.element_74 = uiimage(app.grid_all);
            app.element_74.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_74.Tag = 'W';
            app.element_74.Layout.Row = 6;
            app.element_74.Layout.Column = 6;
            app.element_74.ImageSource = '74.svg';

            % Create element_75
            app.element_75 = uiimage(app.grid_all);
            app.element_75.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_75.Tag = 'Re';
            app.element_75.Layout.Row = 6;
            app.element_75.Layout.Column = 7;
            app.element_75.ImageSource = '75.svg';

            % Create element_76
            app.element_76 = uiimage(app.grid_all);
            app.element_76.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_76.Tag = 'Os';
            app.element_76.Layout.Row = 6;
            app.element_76.Layout.Column = 8;
            app.element_76.ImageSource = '76.svg';

            % Create element_77
            app.element_77 = uiimage(app.grid_all);
            app.element_77.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_77.Tag = 'Ir';
            app.element_77.Layout.Row = 6;
            app.element_77.Layout.Column = 9;
            app.element_77.ImageSource = '77.svg';

            % Create element_78
            app.element_78 = uiimage(app.grid_all);
            app.element_78.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_78.Tag = 'Pt';
            app.element_78.Layout.Row = 6;
            app.element_78.Layout.Column = 10;
            app.element_78.ImageSource = '78.svg';

            % Create element_79
            app.element_79 = uiimage(app.grid_all);
            app.element_79.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_79.Tag = 'Au';
            app.element_79.Layout.Row = 6;
            app.element_79.Layout.Column = 11;
            app.element_79.ImageSource = '79.svg';

            % Create element_80
            app.element_80 = uiimage(app.grid_all);
            app.element_80.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_80.Tag = 'Hg';
            app.element_80.Layout.Row = 6;
            app.element_80.Layout.Column = 12;
            app.element_80.ImageSource = '80.svg';

            % Create element_81
            app.element_81 = uiimage(app.grid_all);
            app.element_81.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_81.Tag = 'Tl';
            app.element_81.Layout.Row = 6;
            app.element_81.Layout.Column = 13;
            app.element_81.ImageSource = '81.svg';

            % Create element_82
            app.element_82 = uiimage(app.grid_all);
            app.element_82.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_82.Tag = 'Pb';
            app.element_82.Layout.Row = 6;
            app.element_82.Layout.Column = 14;
            app.element_82.ImageSource = '82.svg';

            % Create element_83
            app.element_83 = uiimage(app.grid_all);
            app.element_83.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_83.Tag = 'Bi';
            app.element_83.Layout.Row = 6;
            app.element_83.Layout.Column = 15;
            app.element_83.ImageSource = '83.svg';

            % Create element_84
            app.element_84 = uiimage(app.grid_all);
            app.element_84.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_84.Tag = 'Po';
            app.element_84.Layout.Row = 6;
            app.element_84.Layout.Column = 16;
            app.element_84.ImageSource = '84.svg';

            % Create element_85
            app.element_85 = uiimage(app.grid_all);
            app.element_85.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_85.Tag = 'At';
            app.element_85.Layout.Row = 6;
            app.element_85.Layout.Column = 17;
            app.element_85.ImageSource = '85.svg';

            % Create element_86
            app.element_86 = uiimage(app.grid_all);
            app.element_86.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_86.Tag = 'Rn';
            app.element_86.Layout.Row = 6;
            app.element_86.Layout.Column = 18;
            app.element_86.ImageSource = '86.svg';

            % Create element_87
            app.element_87 = uiimage(app.grid_all);
            app.element_87.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_87.Tag = 'Fr';
            app.element_87.Layout.Row = 7;
            app.element_87.Layout.Column = 1;
            app.element_87.ImageSource = '87.svg';

            % Create element_88
            app.element_88 = uiimage(app.grid_all);
            app.element_88.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_88.Tag = 'Ra';
            app.element_88.Layout.Row = 7;
            app.element_88.Layout.Column = 2;
            app.element_88.ImageSource = '88.svg';

            % Create element_89
            app.element_89 = uiimage(app.grid_all);
            app.element_89.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_89.Tag = 'Ac';
            app.element_89.Layout.Row = 7;
            app.element_89.Layout.Column = 3;
            app.element_89.ImageSource = '89.svg';

            % Create element_90
            app.element_90 = uiimage(app.grid_all);
            app.element_90.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_90.Tag = 'Th';
            app.element_90.Layout.Row = 7;
            app.element_90.Layout.Column = 4;
            app.element_90.ImageSource = '90.svg';

            % Create element_91
            app.element_91 = uiimage(app.grid_all);
            app.element_91.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_91.Tag = 'Pa';
            app.element_91.Layout.Row = 7;
            app.element_91.Layout.Column = 5;
            app.element_91.ImageSource = '91.svg';

            % Create element_92
            app.element_92 = uiimage(app.grid_all);
            app.element_92.ImageClickedFcn = createCallbackFcn(app, @element_1ImageClicked, true);
            app.element_92.Tag = 'U';
            app.element_92.Layout.Row = 7;
            app.element_92.Layout.Column = 6;
            app.element_92.ImageSource = '92.svg';

            % Create Legend
            app.Legend = uiimage(app.grid_all);
            app.Legend.Layout.Row = 1;
            app.Legend.Layout.Column = [13 17];
            app.Legend.ImageSource = 'legend_uielements.svg';

            % Create panel_data
            app.panel_data = uipanel(app.grid_all);
            app.panel_data.BorderType = 'none';
            app.panel_data.BackgroundColor = [0.9098 0.9098 0.8902];
            app.panel_data.Layout.Row = [1 3];
            app.panel_data.Layout.Column = [4 12];

            % Create grid_data
            app.grid_data = uigridlayout(app.panel_data);
            app.grid_data.ColumnWidth = {'1.5x', 25, '1x', '1.5x', 25, '3.5x'};
            app.grid_data.RowHeight = {22, 26, 25, 23, 23, '3x'};
            app.grid_data.ColumnSpacing = 9.65625;
            app.grid_data.RowSpacing = 3.91294642857143;
            app.grid_data.Padding = [9.65625 3.91294642857143 9.65625 3.91294642857143];
            app.grid_data.BackgroundColor = [0.9098 0.9098 0.8902];

            % Create panel_properties
            app.panel_properties = uipanel(app.grid_data);
            app.panel_properties.BorderType = 'none';
            app.panel_properties.BackgroundColor = [0.9098 0.9098 0.8902];
            app.panel_properties.Layout.Row = [1 6];
            app.panel_properties.Layout.Column = 6;

            % Create grid_properties
            app.grid_properties = uigridlayout(app.panel_properties);
            app.grid_properties.ColumnWidth = {70, 71, '2.66x'};
            app.grid_properties.RowHeight = {19, 19, 19, 46, 19, 19, 19};
            app.grid_properties.RowSpacing = 8.0703125;
            app.grid_properties.Padding = [10 8.0703125 0 8.0703125];
            app.grid_properties.BackgroundColor = [0.9098 0.9098 0.8902];

            % Create text_species_label
            app.text_species_label = uilabel(app.grid_properties);
            app.text_species_label.HorizontalAlignment = 'center';
            app.text_species_label.Layout.Row = 1;
            app.text_species_label.Layout.Column = 1;
            app.text_species_label.Text = 'Species';

            % Create text_species
            app.text_species = uieditfield(app.grid_properties, 'text');
            app.text_species.Editable = 'off';
            app.text_species.HorizontalAlignment = 'center';
            app.text_species.Layout.Row = 1;
            app.text_species.Layout.Column = [2 3];

            % Create text_codename_label
            app.text_codename_label = uilabel(app.grid_properties);
            app.text_codename_label.HorizontalAlignment = 'center';
            app.text_codename_label.Layout.Row = 2;
            app.text_codename_label.Layout.Column = 1;
            app.text_codename_label.Text = 'Codename';

            % Create text_codename
            app.text_codename = uieditfield(app.grid_properties, 'text');
            app.text_codename.Editable = 'off';
            app.text_codename.HorizontalAlignment = 'center';
            app.text_codename.Layout.Row = 2;
            app.text_codename.Layout.Column = [2 3];

            % Create text_phase_label
            app.text_phase_label = uilabel(app.grid_properties);
            app.text_phase_label.HorizontalAlignment = 'center';
            app.text_phase_label.Layout.Row = 3;
            app.text_phase_label.Layout.Column = 1;
            app.text_phase_label.Text = 'Phase';

            % Create text_phase
            app.text_phase = uieditfield(app.grid_properties, 'text');
            app.text_phase.Editable = 'off';
            app.text_phase.HorizontalAlignment = 'center';
            app.text_phase.Layout.Row = 3;
            app.text_phase.Layout.Column = [2 3];

            % Create text_W_label
            app.text_W_label = uilabel(app.grid_properties);
            app.text_W_label.HorizontalAlignment = 'center';
            app.text_W_label.Layout.Row = 5;
            app.text_W_label.Layout.Column = [1 2];
            app.text_W_label.Text = 'Molecular Weight [g/mol]';

            % Create text_W
            app.text_W = uieditfield(app.grid_properties, 'numeric');
            app.text_W.ValueDisplayFormat = '%.6g';
            app.text_W.Editable = 'off';
            app.text_W.HorizontalAlignment = 'center';
            app.text_W.Layout.Row = 5;
            app.text_W.Layout.Column = 3;

            % Create text_hf_label
            app.text_hf_label = uilabel(app.grid_properties);
            app.text_hf_label.HorizontalAlignment = 'center';
            app.text_hf_label.Layout.Row = 6;
            app.text_hf_label.Layout.Column = [1 2];
            app.text_hf_label.Text = 'Enthalpy formation [kJ]';

            % Create text_hf
            app.text_hf = uieditfield(app.grid_properties, 'numeric');
            app.text_hf.ValueDisplayFormat = '%.6g';
            app.text_hf.Editable = 'off';
            app.text_hf.HorizontalAlignment = 'center';
            app.text_hf.Layout.Row = 6;
            app.text_hf.Layout.Column = 3;

            % Create text_ef_label
            app.text_ef_label = uilabel(app.grid_properties);
            app.text_ef_label.HorizontalAlignment = 'center';
            app.text_ef_label.Layout.Row = 7;
            app.text_ef_label.Layout.Column = [1 2];
            app.text_ef_label.Text = 'Int. energy formation [kJ]';

            % Create text_ef
            app.text_ef = uieditfield(app.grid_properties, 'numeric');
            app.text_ef.ValueDisplayFormat = '%.6g';
            app.text_ef.Editable = 'off';
            app.text_ef.HorizontalAlignment = 'center';
            app.text_ef.Layout.Row = 7;
            app.text_ef.Layout.Column = 3;

            % Create CommentsTextAreaLabel
            app.CommentsTextAreaLabel = uilabel(app.grid_properties);
            app.CommentsTextAreaLabel.HorizontalAlignment = 'center';
            app.CommentsTextAreaLabel.Layout.Row = 4;
            app.CommentsTextAreaLabel.Layout.Column = 1;
            app.CommentsTextAreaLabel.Text = 'Comments';

            % Create text_comments
            app.text_comments = uitextarea(app.grid_properties);
            app.text_comments.Layout.Row = 4;
            app.text_comments.Layout.Column = [2 3];

            % Create edit_seeker
            app.edit_seeker = uieditfield(app.grid_data, 'text');
            app.edit_seeker.ValueChangingFcn = createCallbackFcn(app, @edit_seekerValueChanging, true);
            app.edit_seeker.Layout.Row = 2;
            app.edit_seeker.Layout.Column = [1 2];

            % Create text_list_species
            app.text_list_species = uilabel(app.grid_data);
            app.text_list_species.Layout.Row = 1;
            app.text_list_species.Layout.Column = [1 2];
            app.text_list_species.Text = 'Search Species';

            % Create text_LS_DB
            app.text_LS_DB = uilabel(app.grid_data);
            app.text_LS_DB.Layout.Row = 3;
            app.text_LS_DB.Layout.Column = [1 2];
            app.text_LS_DB.Text = 'List of species DB';

            % Create text_LS
            app.text_LS = uilabel(app.grid_data);
            app.text_LS.Layout.Row = 3;
            app.text_LS.Layout.Column = [4 5];
            app.text_LS.Text = 'List of species (export)';

            % Create listbox_LS_DB
            app.listbox_LS_DB = uilistbox(app.grid_data);
            app.listbox_LS_DB.Items = {};
            app.listbox_LS_DB.Multiselect = 'on';
            app.listbox_LS_DB.ValueChangedFcn = createCallbackFcn(app, @listbox_LSValueChanged, true);
            app.listbox_LS_DB.Layout.Row = [4 6];
            app.listbox_LS_DB.Layout.Column = [1 2];
            app.listbox_LS_DB.Value = {};

            % Create listbox_LS
            app.listbox_LS = uilistbox(app.grid_data);
            app.listbox_LS.Items = {};
            app.listbox_LS.Multiselect = 'on';
            app.listbox_LS.ValueChangedFcn = createCallbackFcn(app, @listbox_LSValueChanged, true);
            app.listbox_LS.Layout.Row = [4 6];
            app.listbox_LS.Layout.Column = [4 5];
            app.listbox_LS.Value = {};

            % Create button_copy
            app.button_copy = uibutton(app.grid_data, 'push');
            app.button_copy.ButtonPushedFcn = createCallbackFcn(app, @button_copyButtonPushed, true);
            app.button_copy.Icon = 'icon_copy.svg';
            app.button_copy.IconAlignment = 'center';
            app.button_copy.Tooltip = {''};
            app.button_copy.Layout.Row = 3;
            app.button_copy.Layout.Column = 5;
            app.button_copy.Text = '';

            % Create button_remove
            app.button_remove = uibutton(app.grid_data, 'push');
            app.button_remove.ButtonPushedFcn = createCallbackFcn(app, @button_removePushed, true);
            app.button_remove.Layout.Row = 5;
            app.button_remove.Layout.Column = 3;
            app.button_remove.Text = 'Remove <<';

            % Create button_add
            app.button_add = uibutton(app.grid_data, 'push');
            app.button_add.ButtonPushedFcn = createCallbackFcn(app, @button_addPushed, true);
            app.button_add.Layout.Row = 4;
            app.button_add.Layout.Column = 3;
            app.button_add.Text = 'Add >>';

            % Create panel_export
            app.panel_export = uipanel(app.grid_all);
            app.panel_export.BorderType = 'none';
            app.panel_export.TitlePosition = 'centertop';
            app.panel_export.BackgroundColor = [0.9098 0.9098 0.8902];
            app.panel_export.Layout.Row = 7;
            app.panel_export.Layout.Column = 17;

            % Create button_export
            app.button_export = uibutton(app.panel_export, 'push');
            app.button_export.ButtonPushedFcn = createCallbackFcn(app, @button_exportButtonPushed, true);
            app.button_export.IconAlignment = 'center';
            app.button_export.Position = [1 2 69 25];
            app.button_export.Text = 'Export';

            % Create panel_close
            app.panel_close = uipanel(app.grid_all);
            app.panel_close.BorderType = 'none';
            app.panel_close.TitlePosition = 'centertop';
            app.panel_close.BackgroundColor = [0.9098 0.9098 0.8902];
            app.panel_close.Layout.Row = 7;
            app.panel_close.Layout.Column = 18;

            % Create button_close
            app.button_close = uibutton(app.panel_close, 'push');
            app.button_close.ButtonPushedFcn = createCallbackFcn(app, @UIElementsCloseRequest, true);
            app.button_close.IconAlignment = 'center';
            app.button_close.Position = [1 2 69 25];
            app.button_close.Text = 'Close';

            % Create context_menu
            app.context_menu = uicontextmenu(app.UIElements);

            % Create enableremoveMenu
            app.enableremoveMenu = uimenu(app.context_menu);
            app.enableremoveMenu.MenuSelectedFcn = createCallbackFcn(app, @enableremoveMenuSelected, true);
            app.enableremoveMenu.Text = 'enable/remove';
            
            % Assign app.context_menu
            app.element_1.ContextMenu = app.context_menu;
            app.element_1_2.ContextMenu = app.context_menu;
            app.element_1_3.ContextMenu = app.context_menu;
            app.element_2.ContextMenu = app.context_menu;
            app.element_3.ContextMenu = app.context_menu;
            app.element_4.ContextMenu = app.context_menu;
            app.element_5.ContextMenu = app.context_menu;
            app.element_6.ContextMenu = app.context_menu;
            app.element_7.ContextMenu = app.context_menu;
            app.element_8.ContextMenu = app.context_menu;
            app.element_9.ContextMenu = app.context_menu;
            app.element_10.ContextMenu = app.context_menu;
            app.element_11.ContextMenu = app.context_menu;
            app.element_12.ContextMenu = app.context_menu;
            app.element_13.ContextMenu = app.context_menu;
            app.element_14.ContextMenu = app.context_menu;
            app.element_15.ContextMenu = app.context_menu;
            app.element_16.ContextMenu = app.context_menu;
            app.element_17.ContextMenu = app.context_menu;
            app.element_18.ContextMenu = app.context_menu;
            app.element_19.ContextMenu = app.context_menu;
            app.element_20.ContextMenu = app.context_menu;
            app.element_21.ContextMenu = app.context_menu;
            app.element_22.ContextMenu = app.context_menu;
            app.element_23.ContextMenu = app.context_menu;
            app.element_24.ContextMenu = app.context_menu;
            app.element_25.ContextMenu = app.context_menu;
            app.element_26.ContextMenu = app.context_menu;
            app.element_27.ContextMenu = app.context_menu;
            app.element_28.ContextMenu = app.context_menu;
            app.element_29.ContextMenu = app.context_menu;
            app.element_30.ContextMenu = app.context_menu;
            app.element_31.ContextMenu = app.context_menu;
            app.element_32.ContextMenu = app.context_menu;
            app.element_33.ContextMenu = app.context_menu;
            app.element_34.ContextMenu = app.context_menu;
            app.element_35.ContextMenu = app.context_menu;
            app.element_36.ContextMenu = app.context_menu;
            app.element_37.ContextMenu = app.context_menu;
            app.element_38.ContextMenu = app.context_menu;
            app.element_39.ContextMenu = app.context_menu;
            app.element_40.ContextMenu = app.context_menu;
            app.element_41.ContextMenu = app.context_menu;
            app.element_42.ContextMenu = app.context_menu;
            app.element_43.ContextMenu = app.context_menu;
            app.element_44.ContextMenu = app.context_menu;
            app.element_45.ContextMenu = app.context_menu;
            app.element_46.ContextMenu = app.context_menu;
            app.element_47.ContextMenu = app.context_menu;
            app.element_48.ContextMenu = app.context_menu;
            app.element_49.ContextMenu = app.context_menu;
            app.element_50.ContextMenu = app.context_menu;
            app.element_51.ContextMenu = app.context_menu;
            app.element_52.ContextMenu = app.context_menu;
            app.element_53.ContextMenu = app.context_menu;
            app.element_54.ContextMenu = app.context_menu;
            app.element_55.ContextMenu = app.context_menu;
            app.element_56.ContextMenu = app.context_menu;
            app.element_72.ContextMenu = app.context_menu;
            app.element_73.ContextMenu = app.context_menu;
            app.element_74.ContextMenu = app.context_menu;
            app.element_75.ContextMenu = app.context_menu;
            app.element_76.ContextMenu = app.context_menu;
            app.element_77.ContextMenu = app.context_menu;
            app.element_78.ContextMenu = app.context_menu;
            app.element_79.ContextMenu = app.context_menu;
            app.element_80.ContextMenu = app.context_menu;
            app.element_81.ContextMenu = app.context_menu;
            app.element_82.ContextMenu = app.context_menu;
            app.element_83.ContextMenu = app.context_menu;
            app.element_84.ContextMenu = app.context_menu;
            app.element_85.ContextMenu = app.context_menu;
            app.element_86.ContextMenu = app.context_menu;
            app.element_87.ContextMenu = app.context_menu;
            app.element_88.ContextMenu = app.context_menu;
            app.element_89.ContextMenu = app.context_menu;
            app.element_90.ContextMenu = app.context_menu;
            app.element_91.ContextMenu = app.context_menu;
            app.element_92.ContextMenu = app.context_menu;

            % Show the figure after all components are created
            app.UIElements.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = uielements

            runningApp = getRunningApp(app);

            % Check for running singleton app
            if isempty(runningApp)

                % Create UIFigure and components
                createComponents(app)

                % Register the app with App Designer
                registerApp(app, app.UIElements)

                % Execute the startup function
                runStartupFcn(app, @startupFcn)
            else

                % Focus the running singleton app
                figure(runningApp.UIElements)

                app = runningApp;
            end

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIElements)
        end
    end
end