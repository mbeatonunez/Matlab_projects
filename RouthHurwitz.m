%% Initialization
clear ; close all; clc

% Introduction
fprintf('This program provides valuable information about your transfunction\n\n')
numer = input('input the numerator of your Transfer function in vector form: \n i.e. [an an-1 an-2 ... a0] = ');
denom = input('input the denominator of your Transfer function in vector form: \n i.e. [bn bn-1 bn-2 ... b0] = ');

T = tf(numer,denom)

% Menu
fprintf('Choose from the following: \n')
fprintf('\t1)Routh-Hurwitz Table   2)Impule/Step Response \n')
fprintf('\t3)Zero/Pole Plot        4)Root Locus Plot \n')

% Get user input
sel = input('Selection: ');

if sel == 1
    % Routh-Hurwitz
    % Taking coefficients vector and organizing the first two rows
    denomLength = length(denom);
    rhTableColumn = round(denomLength/2);

    %  Initialize Routh-Hurwitz table with empty zero array
    rhTable = zeros(denomLength,rhTableColumn);

    %  Compute first row of the table
    rhTable(1,:) = denom(1,1:2:denomLength);

    %  Check if length of coefficients vector is even or odd
    if (rem(denomLength,2) ~= 0)
        % if odd, second row of table will be
        rhTable(2,1:rhTableColumn - 1) = denom(1,2:2:denomLength);
    else
        % if even, second row of table will be
        rhTable(2,:) = denom(1,2:2:denomLength);
    end

    % Calculate Routh-Hurwitz table's rows
    %  Set epss as a small value
    epss = 0.01;

    %  Calculate other elements of the table
    for i = 3:denomLength

        %  special case: row of all zeros
        if rhTable(i-1,:) == 0
            order = (denomLength - i);
            cnt1 = 0;
            cnt2 = 1;
            for j = 1:rhTableColumn - 1
                rhTable(i-1,j) = (order - cnt1) * rhTable(i-2,cnt2);
                cnt2 = cnt2 + 1;
                cnt1 = cnt1 + 2;
            end
        end

        for j = 1:rhTableColumn - 1
            %  first element of upper row
            firstElemUpperRow = rhTable(i-1,1);

            %  compute each element of the table
            rhTable(i,j) = ((rhTable(i-1,1) * rhTable(i-2,j+1)) - ....
                (rhTable(i-2,1) * rhTable(i-1,j+1))) / firstElemUpperRow;
        end


        %  special case: zero in the first column
        if rhTable(i,1) == 0
            rhTable(i,1) = epss;
        end
    end

    %  Compute number of right hand side poles(unstable poles)
    %   Initialize unstable poles with zero
    unstablePoles = 0;

    %   Check change in signs
    for i = 1:denomLength - 1
        if sign(rhTable(i,1)) * sign(rhTable(i+1,1)) == -1
            unstablePoles = unstablePoles + 1;
        end
    end

    %   Print calculated data on screen
    fprintf('\n Routh-Hurwitz Table:\n')
    rhTable

    %   Print the stability result on screen
    if unstablePoles == 0
        fprintf('~~~~~> it is a stable system! <~~~~~\n')
    else
        fprintf('~~~~~> it is an unstable system! <~~~~~\n')
    end

    fprintf('\n Number of right hand side poles =%2.0f\n',unstablePoles)

    reply = input('Do you want roots of system be shown? Y/N ', 's');
    if reply == 'y' || reply == 'Y'
        sysRoots = roots(denom);
        fprintf('\n Given polynomial coefficients roots :\n')
        sysRoots
    end
elseif sel == 2
    clf
    subplot(2,1,1)
    impulse(T)
    grid on
    subplot(2,1,2)
    step(T)
elseif sel == 3
    clf
    fvtool(numer,denom,'polezero'),grid on;
    ax =gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    [b,a] = eqtflength(num,den);
    [Zeros,Poles,k] = tf2zp(b,a)
    text(real(Zeros)+.1,imag(Zeros),'Zero')
    text(real(Poles)+.1,imag(Poles),'Pole')
elseif sel == 4
    clf