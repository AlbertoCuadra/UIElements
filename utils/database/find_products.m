function [LS, ind_elements_DB] = find_products(self, species, varargin)
    % Find all the combinations of species from DB that can appear as
    % products for the given list of reactants
    %
    % Args:
    %     self (struct): Data of the mixture, conditions, and databases
    %     species (cell): List of reactants
    %
    % Optional Args:
    %     FLAG_BURCAT (bool): Flag to consider Burcat's database (Third millenium)
    %     ind_elements_DB (float): Matrix NS_DB x MAX_ELEMENTS with element indeces of the species contained in the database
    %
    % Returns:
    %     Tuple containing
    %
    %     * LS (cell): List of products
    %     * ind_elements_DB (float): Matrix NS_DB x MAX_ELEMENTS with element indeces of the species contained in the database
    %
    % Examples:
    %     [LS, ind_elements_DB] = find_products(self, {'O2', 'N', 'eminus'})
    %     [LS, ind_elements_DB] = find_products(self, {'O2', 'CO', 'N'}, DB, 'Flag', true)
    %     [LS, ind_elements_DB] = find_products(self, {'O2', 'CO', 'N'}, DB, 'Flag', true, 'ind', ind_elements_DB)
    
    % Definitions
    MAX_ELEMENTS = 5;
    [elements, ~] = set_elements(); % Elements list
    
    % Initialization
    FLAG_BURCAT = false; % Flag to consider Burcat's database (Third millenium)
    FLAG_IND = false;    % Flag indicating that ind_elements_DB is an input
    LS = [];             % Initialize list of products
    
    % Unpack
    for i = 1:2:nargin-2
        switch lower(varargin{i})
            case {'flag', 'flag_burcat'}
                FLAG_BURCAT = varargin{i + 1};
            case {'ind', 'ind_elements', 'ind_elements_db', 'ind_db'}
                ind_elements_DB = varargin{i + 1};
                FLAG_IND = true;
        end
        
    end

    % If FLAG_BURCAT == true, then remove the species from Third millenium database
    if ~FLAG_BURCAT
        self.LS_DB = find_species_LS(self.LS_DB, {}, 'any', {'_M'}, 'all');
    end

    % Remove incompatible species
    self.LS_DB(find_ind(self.LS_DB, 'Air')) = [];
    
    % Get element indeces of the reactants
    ind_elements_R = sort(get_ind_elements(species, self.DB, elements, MAX_ELEMENTS), 1);

    % Get element indeces of each species in the database
    if ~FLAG_IND
        ind_elements_DB = get_ind_elements(self.LS_DB, self.DB, elements, MAX_ELEMENTS);
    end
    
    % Remove common vectors
    ind_elements_R = unique(ind_elements_R, 'rows');
    
    % Get cross terms 
    temp = get_cross_termms(ind_elements_R, MAX_ELEMENTS);
    
    % Join vectors
    ind_elements_R = unique([ind_elements_R; temp], 'rows');
    
    % Get list of products
    for i = length(ind_elements_R(:, 1)):-1:1
        ind_species = all(ind_elements_DB - ind_elements_R(i, :) == 0, 2);
        LS = [LS, self.LS_DB(ind_species)'];
    end

end

% SUB-PASS FUNCTIONS
function temp = get_cross_termms(ind_elements_R, MAX_ELEMENTS)
    % Get cross terms 

    % Initialization
    temp = [];

    % Define vector to permute
    ind_perm = sort(unique(ind_elements_R), 1, 'descend')';
    try
        ind_perm = [ind_perm, zeros(1, MAX_ELEMENTS - 2)];
    catch
        ind_perm = [ind_perm', zeros(1, MAX_ELEMENTS - 2)];
    end

    % Get length
    N_elements = length(ind_perm);

    % Get permutations [element1, element2, element3, element4, element5]
    for i = 1:N_elements
        if ind_perm(i) == 0, continue; end
        
        for j = i + 1:N_elements

            for k = j + 1:N_elements

                for l = k + 1:N_elements-1
                    temp_add = [ind_perm(i), ind_perm(j), ind_perm(k), ind_perm(l), 0];
                    temp = [temp; temp_add];
                end

            end

        end

    end

end