%
%
%  Create New Spots Object from Average Distance of Closest Spots
%  This XTension looks for spots closer than the given distances, removes
%  them and adds a single spot object in its place whose center is the
%  average distance of all spots that were found in that cluster
%
%
%  By Olivier Burri @ EPFL BioImaging & Optics Platform
%  License: GNU
%
%
%  Installation:
%  - Copy this file into the XTensions folder in the Imaris installation directory.
%  - You will find this function in the Image Processing Spots Functions menu
%
%    <CustomTools>
%      <Menu>
%       <Submenu name="Camera Functions">
%        <Item name="Views Manager" icon="Matlab">
%          <Command>MatlabXT::XTViewManager(%i)</Command>
%        </Item>
%       </Submenu>
%      </Menu>
%      <SurpassTab>
%        <SurpassComponent name="bpSpots">
%          <Item name="Average Spots By Distance" icon="Matlab">
%            <Command>MatlabXT::XTSpotsAverageByDistance(%i)</Command>
%          </Item>
%        </SurpassComponent>
%      </SurpassTab>
%    </CustomTools>
%

function XTViewManager(aImarisApplicationID, varargin)

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
