% test_pivot_table.m
% Unit tests for pivot_table.m
% Author: Matthew Jeppesen

% unit test boilerplate code
function tests = test_pivot_table
    % automatically test all the functions in this file
    tests = functiontests(localfunctions);
end


function test_can_make_simple_pivot_table(tc)
    x = table(...
        {'foo'; 'bar'; 'foo'}, ...
        [-1; 2; 4], ...
        'VariableNames', {'Name', 'Value'});

    % x =
    %
    %     Name     Value
    %     _____    _____
    %
    %     'foo'    -1
    %     'bar'     2
    %     'foo'     4

    p = pivot_table(x, 'Name', 'Value', @sum);
    verifyEqual(tc, p{strcmp(p.Name, 'foo'), 'sum_of_Value'}, 3)

    p = pivot_table(x, 'Name', 'Value', @min);
    verifyEqual(tc, p{strcmp(p.Name, 'foo'), 'min_of_Value'}, -1);

end


function test_can_aggregate_by_multiple_columns(tc)
    x = table(...
        {'foo'; 'bar'; 'foo'; 'foo'}, ...
        {'a'; 'b'; 'c'; 'a'}, ...
        [-1; 2; 4; 7], ...
        'VariableNames', {'Name', 'Letter', 'Value'});

    % x =
    %
    %     Name     Letter    Value
    %     _____    ______    _____
    %
    %     'foo'    'a'       -1
    %     'bar'    'b'        2
    %     'foo'    'c'        4
    %     'foo'    'a'        7

    p = pivot_table(x, {'Name', 'Letter'}, 'Value', @sum);
    verifyEqual(tc, p{strcmp(p.Name, 'foo') & strcmp(p.Letter, 'a'), ...
        'sum_of_Value'}, 6);

end


function test_can_aggregate_by_a_numerical_column(tc)
    x = table(...
        [1; 2; 1], ...
        [-1; 2; 4], ...
        'VariableNames', {'id', 'Value'});

    % x =
    %
    %     id    Value
    %     __    _____
    %
    %     1     -1
    %     2      2
    %     1      4

    p = pivot_table(x, 'id', 'Value', @sum);
    verifyEqual(tc, p{p.id == 1, 'sum_of_Value'}, 3)
end


function test_can_make_pivot_table_with_multiple_data_columns(tc)
    x = table(...
        {'foo'; 'bar'; 'foo'}, ...
        [-1; 2; 4], ...
        [1; 1; 1], ...
        'VariableNames', {'Name', 'value_1', 'value_2'});

        % x =
        %
        %     Name     value_1    value_2
        %     _____    _______    _______
        %
        %     'foo'    -1         1
        %     'bar'     2         1
        %     'foo'     4         1

    p = pivot_table(x, 'Name', {'value_2', 'value_1'}, @sum);

    verifyEqual(tc, p{strcmp(p.Name, 'foo'), 'sum_of_value_1'}, 3);
    verifyEqual(tc, p{strcmp(p.Name, 'foo'), 'sum_of_value_2'}, 2);
end


function test_handles_multiple_aggregatation_and_data_columns(tc)
    x = table(...
        {'foo'; 'bar'; 'foo'; 'foo'}, ...
        {'a'; 'a'; 'b'; 'b'}, ...
        [-1; 2; 4; 1], ...
        [1; 1; 1; 1], ...
        'VariableNames', {'Name', 'Letter', 'value_1', 'value_2'});

    % x =
    %
    %     Name     Letter    value_1    value_2
    %     _____    ______    _______    _______
    %
    %     'foo'    'a'       -1         1
    %     'bar'    'a'        2         1
    %     'foo'    'b'        4         1
    %     'foo'    'b'        1         1

    p = pivot_table(x, {'Name', 'Letter'}, {'value_2', 'value_1'}, @sum);

    verifyEqual(tc, p{strcmp(p.Name, 'foo') & strcmp(p.Letter, 'b'), 'sum_of_value_1'}, 5);
    verifyEqual(tc, p{strcmp(p.Name, 'foo') & strcmp(p.Letter, 'a'), 'sum_of_value_1'}, -1);
end

function test_aggregate_function_can_be_a_weighted_average(tc)
    x = table({'foo'; 'foo'; 'bar'}, ...
              [1; 2; 1], ...
              [0; 1; 0], ...
              'VariableNames', ...
              {'Name', 'value_1', 'value_2'});

    % x =

    %     Name     value_1    value_2
    %     _____    _______    _______

    %     'foo'    1          0
    %     'foo'    2          1
    %     'bar'    1          0

    p = pivot_table(x, 'Name', 'value_1', @mean, 'value_2');

    % unweighted mean would be 1.5, weighted is 2
    expect = sum([0*1 1*2 0*1]) / sum([0 1 0]); % 1.75
    verifyEqual(tc, p{strcmp(p.Name, 'foo'), 'w_mean_of_value_1'}, expect);
end


function test_handles_aggregate_function_with_no_valid_name(tc)
    x = table(...
        {'foo', 'foo'}', [1, 2]', ...
        'VariableNames', {'Name', 'value_1'});

    g = @(x) sum(x);
    p = pivot_table(x, 'Name', 'value_1', g);
    verifyEqual(tc, p.Properties.VariableNames{2}, 'f_1')
end
