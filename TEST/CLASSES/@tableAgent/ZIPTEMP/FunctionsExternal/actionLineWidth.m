function actionLineWidth(src,event)
% This callback causes the line to "blink"

% for id = 1:3                        % Repeat 3 times
%     event.Peer.LineWidth = 3;       % Set line width to 3
%     pause(0.2)                      % Pause 0.2 seconds
%     event.Peer.LineWidth = 0.5;     % Set line width to 0.5
%     pause(0.2)                      % Pause 0.2 seconds
% end

if event.Peer.LineWidth <2   % If current line is visible
    event.Peer.LineWidth = 2;      %   Set the visibility to 'off'
else                                 % Else
    event.Peer.LineWidth = 0.5;       %   Set the visibility to 'on'
end