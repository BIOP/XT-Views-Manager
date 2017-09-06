%
%
%  A simple Imaris XTension to store and reload camera positions within Imaris
%
%
%  By Olivier Burri @ EPFL BioImaging & Optics Platform
%  License: GNU
%
%
%  Installation:
%  - Copy the following files into the XTensions folder in the Imaris installation directory.
%      - XTViewsManager.m
%      - saveView.m
%      - saveView.fig
%  - You will find this function in the Image Processing > Camera Functions menu
%
%    <CustomTools>
%      <Menu>
%       <Submenu name="Camera Functions">
%        <Item name="Views Manager" icon="Matlab">
%          <Command>MatlabXT::XTViewsManager(%i)</Command>
%        </Item>
%       </Submenu>
%      </Menu>
%    </CustomTools>
%

function XTViewsManager(aImarisApplicationID, varargin)

% connect to Imaris interface
if ~isa(aImarisApplicationID, 'Imaris.IApplicationPrxHelper')
    javaaddpath ImarisLib.jar
    vImarisLib = ImarisLib;
    if ischar(aImarisApplicationID)
        aImarisApplicationID = round(str2double(aImarisApplicationID));
    end
    vImarisApplication = vImarisLib.GetApplication(aImarisApplicationID);
else
    vImarisApplication = aImarisApplicationID;
end

% Launch the GUI with the reference to the Imaris APP
saveView(vImarisApplication);
