function varargout = Section71Group01App(varargin)
% SECTION71GROUP01APP MATLAB code for Section71Group01App.fig
%      SECTION71GROUP01APP, by itself, creates a new SECTION71GROUP01APP or raises the existing
%      singleton*.
%
%      H = SECTION71GROUP01APP returns the handle to a new SECTION71GROUP01APP or the handle to
%      the existing singleton*.
%
%      SECTION71GROUP01APP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SECTION71GROUP01APP.M with the given input arguments.
%
%      SECTION71GROUP01APP('Property','Value',...) creates a new SECTION71GROUP01APP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Section71Group01App_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Section71Group01App_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Section71Group01App

% Last Modified by GUIDE v2.5 30-Aug-2015 14:49:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Section71Group01App_OpeningFcn, ...
                   'gui_OutputFcn',  @Section71Group01App_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Section71Group01App is made visible.
function Section71Group01App_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Section71Group01App (see VARARGIN)

% Choose default command line output for Section71Group01App
handles.output = hObject;

handles.angle = 0;
handles.beta=0;
handles.xOffset=0;
handles.yOffset=0;
handles.alpha=0.3;
handles.gxFilt=0;
handles.gyFilt=0;
handles.gzFilt=0;
handles.xTarget=0;
handles.yTarget=0;
handles.shurikenX=0;
handles.shurikenY=0;
% Flag variables
handles.shuri1Visi=0;
handles.shuri2Visi=0;
handles.shuri3Visi=0;
handles.shuri4Visi=0;
handles.shuri5Visi=0;
handles.shuri6Visi=0;
handles.throwVisi=0;
handles.smokeVisi=0;
handles.targetVisi=1;
handles.targetNinjaMove=0;
% Default difficulty
handles.easydifficulty = 1;
% Determines if ninja is human or smoke
handles.ninjaState=0;
handles.targetCounter=0;
handles.smokeCounter=0;


% Background image
axes(handles.axes1)
handles.backgroundImage=image([.7 .7],[.7 .7],imread('ninja.png')); % Image from Tecmo's Ninja Gaiden

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Section71Group01App wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Section71Group01App_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in openSerial.
function openSerial_Callback(hObject, eventdata, handles)
% hObject    handle to openSerial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Connect accelerometer to the serial port, changes depending on port #
handles.comPort='/dev/tty.usbmodem1411';
[handles.accelerometer.s, handles.serialFlag]=setupSerial(handles.comPort);
% Calibrate the accelerometer
if(~exist('handles.calCo','var'))
handles.calCo=calibrate(handles.accelerometer.s);
end

guidata(hObject, handles);


% --- Executes on button press in Start.
function Start_Callback(hObject, eventdata, handles)
% hObject    handle to Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Toggles the start button's string when clicked
axes(handles.axes2)
if strcmp(get(handles.Start,'String'),'Start') %If string is 'Start'
    set(handles.Start,'String','Stop');%Change string to 'Stop'
elseif strcmp(get(handles.Start,'String'),'Stop')%If string is'Stop'
    set(handles.Start,'String','Start');%Change to 'Start'
end


   % x and y coordinates for a ninja
    handles.Ninjiggerx=[0 .5 1.5 1.5 4 4 1 1.5 1 -1 -1.5 -1 -2 -4 -3.1 -1.5 -1.5 -.5 0];
    handles.Ninjiggery=[-2 -5 -5 1 1 2 2 3 4 4 3 2 2 -.5 -1 1 -5 -5 -2];
   % Scales the ninja to be slightly larger
    handles.Ninjiggerx=1.4*handles.Ninjiggerx;
    handles.Ninjiggery=1.4*handles.Ninjiggery;
   % Target ninja
    handles.ninjaTargetx=0.9*handles.Ninjiggerx+85;
    handles.ninjaTargety=0.9*handles.Ninjiggery+85;
   % x and y coordinates of the shuriken
    handles.x = [0 -1 -3 -1 0 1 3 1 0];
    handles.y = [3 1 0 -1 -3 -1 0 1 3];
   % Smoke coordinates
    handles.Smokex=[0 -1 -2.3 -4 -4 -3.2 -5 -5 -4.3 -4.3 -4.5 -4.5 -3.3 -3 -2 0 2 3 3.3 4.5 4.5 4.3 4.3 5 5 3.2 4 4 2.3 1 0];
    handles.Smokey=[7 7 6.5 5 3 2 0 -2 -2.5 -3.6 -4.2 -5.5 -6.3 -7 -8 -8 -8 -7 -6.3 -5.5 -4.2 -3.6 -2.5 -2 0 2 3 5 6.5 7 7];
    handles.Smokex=handles.Smokex+85;
    handles.Smokey=handles.Smokey+85;
   % First shuriken 
    handles.x1=(handles.x)+100;
    handles.y1=(handles.y)+90;
   % Second shuriken
    handles.x2=(handles.x);
    handles.y2=(handles.y)+70;
   % Third shuriken
    handles.x3=(handles.x)+100;
    handles.y3=(handles.y)+50;
   % Fourth shuriken
    handles.x4=(handles.x);
    handles.y4=(handles.y)+30;
   % Fifth shuriken
    handles.x5=(handles.x)+100;
    handles.y5=(handles.y)+10;
   % Throwable shuriken
    handles.xthrow=handles.x + 60;
    handles.ythrow=handles.y + 60;
    hold on
   % Plots the first shuriken
    handles.myNinjaStar1 = fill(handles.x1,handles.y1,[.353 .353 .353]); %2D plot using fill() commando
   set(handles.myNinjaStar1,'Visible','off'); % Turn off visibility of shuriken
   % Plots the second shuriken
    handles.myNinjaStar2 = fill(handles.x2,handles.y2,[.353 .353 .353]);
   set(handles.myNinjaStar2,'Visible','off');
   % Plots the third shuriken
    handles.myNinjaStar3 = fill(handles.x3,handles.y3,[.353 .353 .353]);
   set(handles.myNinjaStar3,'Visible','off');
   % Plots the fourth shuriken
   handles.myNinjaStar4 = fill(handles.x4,handles.y4,[.353 .353 .353]);
   set(handles.myNinjaStar4,'Visible','off');
   % Plots the fifth shuriken
   handles.myNinjaStar5 = fill(handles.x5,handles.y5,[.353 .353 .353]);
   set(handles.myNinjaStar5,'Visible','off');
   % Plots the thrown shuriken
   handles.throwShuriken = fill(handles.xthrow,handles.ythrow,[1,.2,0]);
   set(handles.throwShuriken,'Visible','off');
   
   % Plots the smoke
    handles.Smoke=fill(handles.Smokex,handles.Smokey,[.7568627451,.7568627451,.7568627451]);
    set(handles.Smoke,'Visible','off')
   % Plots the ninja
    handles.myNinja = fill(handles.Ninjiggerx+60, handles.Ninjiggery+60, 'k');
   % Translates the ninja
    handles.Ninjiggerx = handles.Ninjiggerx + 60;
    handles.Ninjiggery = handles.Ninjiggery + 60;
    
    % Plot the target ninja
    handles.targetNinja = fill(handles.ninjaTargetx,handles.ninjaTargety,[.5725 .035 .035]);

    % Play music
    if handles.easydifficulty == 1 % Checks if the game is on easy difficulty
[y,Fs] = audioread('Corneria8bit.wav'); % From Capcom's "MegaMan 9, Concrete Man theme."
sound(y,Fs);
    elseif handles.harddifficulty == 1 % Checks if the game is on hard difficulty
[x,Fx] = audioread('Corneria8bit.wav'); % 8 bit version from "Starfox's Corneria theme"
sound(x,Fx);
    end
[u,Ps]= audioread('Zed.wav');
    % Sets up playing field
    axis([0 100 0 100]);

    handles.throwVisi = 0; % Set visibility of thrown shuriken to 'off'
    
    [handles.SwordStrike, handles.Fs]=audioread('SwordStrike.wav'); % Load the sword strike sound

% Start/stop toggle
while (strcmp(get(handles.Start,'String'),'Stop')) %while button reads stop
    % Reads accelerometer    
    [handles.gx, handles.gy, handles.gz]=readAcc(handles.accelerometer, handles.calCo);
   % Filters the data
   handles.gxFilt = (1-handles.alpha)*handles.gxFilt + handles.alpha*handles.gx;
   handles.gyFilt = (1-handles.alpha)*handles.gyFilt + handles.alpha*handles.gy;
   handles.gzFilt = (1-handles.alpha)*handles.gzFilt + handles.alpha*handles.gz;
   % Calculate the resultant

    % Makes the accelerometer respond to directional tilt
      handles.xOffset=(-4.5*handles.gyFilt)+handles.xOffset;
      handles.yOffset=(-4.5*handles.gxFilt)+handles.yOffset;

% Checks if easy difficulty is selected
if handles.easydifficulty == 1
% Random number generators from 0 to 1 to see if shurikens should be plotted.
handles.randomShurikenGenerator1 = rand;
handles.randomShurikenGenerator2 = rand;
handles.randomShurikenGenerator3 = rand;
handles.randomShurikenGenerator4 = rand;
handles.randomShurikenGenerator5 = rand;
% Checks to see if the first shuriken should be generated
if handles.randomShurikenGenerator1 <= .11
    set(handles.myNinjaStar1,'Visible','on'); % Turn off visibility of shuriken
    % Sets a visibility flag for the first shuriken to be 1
    handles.shuri1Visi = 1;
end
% Checks to see if the second shuriken should be generated
if handles.randomShurikenGenerator2 <= .09
    set(handles.myNinjaStar2,'Visible','on');
    % Sets a visibility flag for the second shuriken to be 1
    handles.shuri2Visi = 1;
end

% Checks to see if the third shuriken should be generated
if handles.randomShurikenGenerator3 <= .09
    set(handles.myNinjaStar3,'Visible','on');
    % Sets a visibility flag for the second shuriken to be 1
    handles.shuri3Visi = 1;
end

% Checks to see if the fourth shuriken should be generated
if handles.randomShurikenGenerator4 <= .1
    set(handles.myNinjaStar4,'Visible','on');
    % Sets a visibility flag for the second shuriken to be 1
    handles.shuri4Visi = 1;
end

% Checks to see if the fifth shuriken should be generated
if handles.randomShurikenGenerator5 <= .12
    set(handles.myNinjaStar5,'Visible','on');
    % Sets a visibility flag for the fifth shuriken to be 1
    handles.shuri5Visi = 1;
end

% Checks the visibility flag to see if the first shuriken should be plotted
if handles.shuri1Visi == 1
% Update shuriken 1 position
handles.x1=handles.x1-1.9;
% Set the first shuriken's data
set(handles.myNinjaStar1,'xdata',handles.x1,'ydata',handles.y1);
end

% Checks the visibility flag to see if the second shuriken should be plotted
if handles.shuri2Visi == 1
% Update shuriken 2 position
handles.x2=handles.x2+1.6;
% Set the second shuriken's data
set(handles.myNinjaStar2,'xdata',handles.x2,'ydata',handles.y2);
end   
    
% Checks the visibility flag to see if the third shuriken should be plotted
if handles.shuri3Visi == 1
% Update shuriken 3 position
handles.x3=handles.x3-1.9;
% Set thethird shuriken's data
set(handles.myNinjaStar3,'xdata',handles.x3,'ydata',handles.y3);
end   

% Checks the visibility flag to see if the fourth shuriken should be plotted
if handles.shuri4Visi == 1
% Update shuriken 4 position
handles.x4=handles.x4+1.8;
% Set the fourth shuriken's data
set(handles.myNinjaStar4,'xdata',handles.x4,'ydata',handles.y4);
end 

% Checks the visibility flag to see if the fifth shuriken should be plotted
if handles.shuri5Visi == 1
% Update shuriken 5's position
handles.x5=handles.x5-1.8;
% Set the fifth shuriken's data
set(handles.myNinjaStar5,'xdata',handles.x5,'ydata',handles.y5);
end 

% Checks if the shuriken has left the screen
if handles.x1 <= 0
    % Resets the flag to 0 once it leaves the screen
    handles.shuri1Visi = 0;
    set(handles.myNinjaStar1,'Visible','off') % Turn off visibility of rectangle
    % Resets the first shuriken's coordinates
    handles.x = [0 -1 -3 -1 0 1 3 1 0];
    handles.y = [3 1 0 -1 -3 -1 0 1 3];
    handles.x1=(handles.x)+100;
    handles.y1=(handles.y)+90;
end

if handles.x2 >= 100
    % Resets the flag to 0 once it leaves the screen
    handles.shuri2Visi = 0;
    set(handles.myNinjaStar2,'Visible','off') % Turn off visibility of rectangle
    % Resets the second shuriken's coordinates
    handles.x = [0 -1 -3 -1 0 1 3 1 0];
    handles.y = [3 1 0 -1 -3 -1 0 1 3];
    % Sets the offset
    handles.x2=(handles.x);
    handles.y2=(handles.y)+70;
end

if handles.x3 <= 0
    % Resets the flag to 0 once it leaves the screen
    handles.shuri3Visi = 0;
    set(handles.myNinjaStar3,'Visible','off') % Turn off visibility of rectangle
    % Resets the third shuriken's coordinates
    handles.x = [0 -1 -3 -1 0 1 3 1 0];
    handles.y = [3 1 0 -1 -3 -1 0 1 3];
    handles.x3=(handles.x)+100;
    handles.y3=(handles.y)+50;
end

if handles.x4 >= 100
    % Resets the flag to 0 once it leaves the screen
    handles.shuri4Visi = 0;
    set(handles.myNinjaStar4,'Visible','off') % Turn off visibility of rectangle
    % Resets the fourth shuriken's coordinates
    handles.x = [0 -1 -3 -1 0 1 3 1 0];
    handles.y = [3 1 0 -1 -3 -1 0 1 3];
    handles.x4=(handles.x);
    handles.y4=(handles.y)+30;
end

if handles.x5 <= 0
    % Resets the flag to 0 once it leaves the screen
    handles.shuri5Visi = 0;
    set(handles.myNinjaStar5,'Visible','off') % Turn off visibility of rectangle
    % Resets the fifth shuriken's coordinates
    handles.x = [0 -1 -3 -1 0 1 3 1 0];
    handles.y = [3 1 0 -1 -3 -1 0 1 3];
    handles.x5=(handles.x)+100;
    handles.y5=(handles.y)+10;
end

% Updates ninja position
set(handles.myNinja,'xdata',handles.Ninjiggerx+handles.xOffset,'ydata',handles.Ninjiggery+handles.yOffset);
% moves the target ninja down until it reaches 15 units on the y axis
if handles.targetNinjaMove == 0 
    handles.ninjaTargety=handles.ninjaTargety-1;
    set(handles.targetNinja,'ydata',handles.ninjaTargety);
    if handles.ninjaTargety <= 15
        % Sets the flag to 1 to move the target ninja up
        handles.targetNinjaMove = 1;
    end
end
% Moves the target ninja up until it reaches 85 units on the y axis
if handles.targetNinjaMove == 1
    handles.ninjaTargety=handles.ninjaTargety+1;
    set(handles.targetNinja,'ydata',handles.ninjaTargety);
    if handles.ninjaTargety >= 85
        % Sets the flag to 0 to move the target ninja down
        handles.targetNinjaMove = 0;
    end
end

% Thresholding for throwing the shuriken
if handles.gyFilt >= .2 && handles.throwVisi == 0 
    % Reports that a shuriken is visible on the screen
    handles.throwVisi = 1;
    % Plots the shuriken at the ninja's current position
    handles.xthrow = handles.xthrow+handles.xOffset;
    handles.ythrow = handles.ythrow+handles.yOffset;
    % Turns on visibility
    set(handles.throwShuriken,'Visible','on')
    set(handles.throwShuriken,'xdata',handles.xthrow,'ydata',handles.ythrow);
end
% If there's a shuriken thrown
if handles.throwVisi == 1
    % Moves the thrown shuriken across the screen
    handles.xthrow=handles.xthrow+3.5;
       set(handles.throwShuriken,'xdata',handles.xthrow)
end

if handles.xthrow >= 100 % If the thrown shuriken goes off screen
        handles.throwVisi=0; % Turn flag to 0
        set(handles.throwShuriken,'Visible','off') % Make shuriken invisible
        % Reset coordinates
        handles.x = [0 -1 -3 -1 0 1 3 1 0];
        handles.y = [3 1 0 -1 -3 -1 0 1 3];
        handles.xthrow=handles.x + 60;
        handles.ythrow=handles.y + 60;
end

drawnow
% Pause for animation
pause(.001)

% Collision detection for ninja star 1
handles.XNinjiggercollision = handles.Ninjiggerx+handles.xOffset;
handles.YNinjiggercollision = handles.Ninjiggery+handles.yOffset;
 if max(inpolygon(handles.XNinjiggercollision,handles.YNinjiggercollision,handles.x1,handles.y1))==1 %If any point of the shuriken hits the target
    sound(u,Ps)
    pause(2)
        handles.mbox = msgbox('You Lose!'); uiwait(handles.mbox); %display message box and wait until user clicks
        set(handles.status,'String','Game Over');
        set(handles.Start,'String','Start');%Change to 'Start'
        set(handles.Scoreboard,'String','0');
        set(handles.status,'String',' ');
        sound(u,Ps);
        break
 end

% Collision detection for ninja star 2
 if max(inpolygon(handles.XNinjiggercollision,handles.YNinjiggercollision,handles.x2,handles.y2))==1 %If any point of the shuriken hits the target
    sound(u,Ps)
    pause(2)
        handles.mbox = msgbox('You Lose!'); uiwait(handles.mbox); %display message box and wait until user clicks
        set(handles.status,'String','Game Over');
        set(handles.Start,'String','Start');%Change to 'Start'
        set(handles.Scoreboard,'String','0');
        set(handles.status,'String',' ');
        break
 end
 % Collision detection for ninja star 3
  if max(inpolygon(handles.XNinjiggercollision,handles.YNinjiggercollision,handles.x3,handles.y3))==1 %If any point of the shuriken hits the target
      sound(u,Ps)
      pause(2)
        handles.mbox = msgbox('You Lose!'); uiwait(handles.mbox); %display message box and wait until user clicks
        set(handles.status,'String','Game Over');
        set(handles.Start,'String','Start');%Change to 'Start'
        set(handles.Scoreboard,'String','0');
        set(handles.status,'String',' ');
        break
  end
 
  % Collision detection for ninja star 4
  if max(inpolygon(handles.XNinjiggercollision,handles.YNinjiggercollision,handles.x4,handles.y4))==1 %If any point of the shuriken hits the target
      sound(u,Ps)
      pause(2)
        handles.mbox = msgbox('You Lose!'); uiwait(handles.mbox); %display message box and wait until user clicks
        set(handles.status,'String','Game Over');
        set(handles.Start,'String','Start');%Change to 'Start'
        set(handles.Scoreboard,'String','0');
        set(handles.status,'String',' ');
        break
  end
 
    % Collision detection for ninja star 5
  if max(inpolygon(handles.XNinjiggercollision,handles.YNinjiggercollision,handles.x5,handles.y5))==1 %If any point of the shuriken hits the target
      sound(u,Ps)
      pause(2)
        handles.mbox = msgbox('You Lose!'); uiwait(handles.mbox); %display message box and wait until user clicks
        set(handles.status,'String','Game Over');
        set(handles.Start,'String','Start');%Change to 'Start'
        set(handles.Scoreboard,'String','0');
        set(handles.status,'String',' ');
        break
  end
 

  
  % Updating the scoreboard
  handles.ScoreboardValue = get(handles.Scoreboard,'String');
  handles.ScoreboardValue = str2num(handles.ScoreboardValue);
   % Collision detection for hitting the target ninja
  if max(inpolygon(handles.ninjaTargetx,handles.ninjaTargety,handles.xthrow,handles.ythrow))==1 %If any point of the cursor is in the target
        handles.ScoreboardValue = handles.ScoreboardValue + 50;
        set(handles.Scoreboard,'String',num2str(handles.ScoreboardValue));
        sound(handles.SwordStrike, handles.Fs); % Makes sound on hit
  end
  
 % Checks to make sure the ninja does not stray outside of the boundaries
 % too far. Some wiggle room is accounted for for out of bounds.
 % Right boundary
if handles.Ninjiggerx+handles.xOffset >94
      set(handles.status,'String','Game Over');
      set(handles.Start,'String','Start');%Change to 'Start'
      set(handles.Scoreboard,'String','0');
      set(handles.status,'String',' ');
      break
 % Top boundary
  elseif handles.Ninjiggery+handles.yOffset >93
      set(handles.status,'String','Game Over');
      set(handles.Start,'String','Start');%Change to 'Start'
      set(handles.Scoreboard,'String','0');
      set(handles.status,'String',' ');
      break
 % Left boundary
  elseif handles.Ninjiggerx+handles.xOffset <6
      set(handles.status,'String','Game Over');
      set(handles.Start,'String','Start');%Change to 'Start'
      set(handles.Scoreboard,'String','0');
      set(handles.status,'String',' ');
      break
 % Bottom boundary
  elseif handles.Ninjiggery+handles.yOffset <6
      set(handles.status,'String','Game Over');
      set(handles.Start,'String','Start');%Change to 'Start'
      set(handles.Scoreboard,'String','0');
      set(handles.status,'String',' ');
      break
end
% Update the score by +1 for each loop iteration
handles.ScoreboardValue = handles.ScoreboardValue + 1;
set(handles.Scoreboard,'String',num2str(handles.ScoreboardValue));







%If easy difficulty is not selected...
elseif handles.harddifficulty == 1




    
    
    
    % Random number generators from 0 to 1 to see if shurikens should be plotted.
handles.randomShurikenGenerator1 = rand;
handles.randomShurikenGenerator2 = rand;
handles.randomShurikenGenerator3 = rand;
handles.randomShurikenGenerator4 = rand;
handles.randomShurikenGenerator5 = rand;
% Checks to see if the first shuriken should be generated
if handles.randomShurikenGenerator1 <= .13
    set(handles.myNinjaStar1,'Visible','on'); % Turn off visibility of shuriken
    % Sets a visibility flag for the first shuriken to be 1
    handles.shuri1Visi = 1;
end
% Checks to see if the second shuriken should be generated
if handles.randomShurikenGenerator2 <= .09
    set(handles.myNinjaStar2,'Visible','on');
    % Sets a visibility flag for the second shuriken to be 1
    handles.shuri2Visi = 1;
end

% Checks to see if the third shuriken should be generated
if handles.randomShurikenGenerator3 <= .1
    set(handles.myNinjaStar3,'Visible','on');
    % Sets a visibility flag for the third shuriken to be 1
    handles.shuri3Visi = 1;
end

% Checks to see if the fourth shuriken should be generated
if handles.randomShurikenGenerator4 <= .12
    set(handles.myNinjaStar4,'Visible','on');
    % Sets a visibility flag for the fourth shuriken to be 1
    handles.shuri4Visi = 1;
end

% Checks to see if the fifth shuriken should be generated
if handles.randomShurikenGenerator5 <= .14
    set(handles.myNinjaStar5,'Visible','on');
    % Sets a visibility flag for the fifth shuriken to be 1
    handles.shuri5Visi = 1;
end

% Checks the visibility flag to see if the first shuriken should be plotted
if handles.shuri1Visi == 1
% Update shuriken 1 position
handles.x1=handles.x1-2.5;
% Set the first shuriken's data
set(handles.myNinjaStar1,'xdata',handles.x1,'ydata',handles.y1);
end

% Checks the visibility flag to see if the second shuriken should be plotted
if handles.shuri2Visi == 1
% Update shuriken 2 position
handles.x2=handles.x2+3;
% Set the second shuriken's data
set(handles.myNinjaStar2,'xdata',handles.x2,'ydata',handles.y2);
end   
    
% Checks the visibility flag to see if the third shuriken should be plotted
if handles.shuri3Visi == 1
% Update shuriken 3 position
handles.x3=handles.x3-2.6;
% Set the third shuriken's data
set(handles.myNinjaStar3,'xdata',handles.x3,'ydata',handles.y3);
end   

% Checks the visibility flag to see if the fourth shuriken should be plotted
if handles.shuri4Visi == 1
% Update shuriken 4 position
handles.x4=handles.x4+2.5;
% Set the fourth shuriken's data
set(handles.myNinjaStar4,'xdata',handles.x4,'ydata',handles.y4);
end 

% Checks the visibility flag to see if the fifth shuriken should be plotted
if handles.shuri5Visi == 1
% Update shuriken 5's position
handles.x5=handles.x5-2.6;
% Set the fifth shuriken's data
set(handles.myNinjaStar5,'xdata',handles.x5,'ydata',handles.y5);
end 

% Checks if the shuriken has left the screen
if handles.x1 <= 0
    % Resets the flag to 0 once it leaves the screen
    handles.shuri1Visi = 0;
    set(handles.myNinjaStar1,'Visible','off') % Turn off visibility of rectangle
    % Resets the first shuriken's coordinates
    handles.x = [0 -1 -3 -1 0 1 3 1 0];
    handles.y = [3 1 0 -1 -3 -1 0 1 3];
    handles.x1=(handles.x)+100;
    handles.y1=(handles.y)+90;
end
% Checks if the second shuriken has left the screen
if handles.x2 >= 100
    % Resets the flag to 0 once it leaves the screen
    handles.shuri2Visi = 0;
    set(handles.myNinjaStar2,'Visible','off') % Turn off visibility of rectangle
    % Resets the second shuriken's coordinates
    handles.x = [0 -1 -3 -1 0 1 3 1 0];
    handles.y = [3 1 0 -1 -3 -1 0 1 3];
    handles.x2=(handles.x);
    handles.y2=(handles.y)+70;
end
% Checks if the third shuriken has left the screen
if handles.x3 <= 0
    % Resets the flag to 0 once it leaves the screen
    handles.shuri3Visi = 0;
    set(handles.myNinjaStar3,'Visible','off') % Turn off visibility of rectangle
    % Resets the third shuriken's coordinates
    handles.x = [0 -1 -3 -1 0 1 3 1 0];
    handles.y = [3 1 0 -1 -3 -1 0 1 3];
    handles.x3=(handles.x)+100;
    handles.y3=(handles.y)+50;
end
% Checks if the fourth shuriken has left the screen
if handles.x4 >= 100
    % Resets the flag to 0 once it leaves the screen
    handles.shuri4Visi = 0;
    set(handles.myNinjaStar4,'Visible','off') % Turn off visibility of rectangle
    % Resets the fourth shuriken's coordinates
    handles.x = [0 -1 -3 -1 0 1 3 1 0];
    handles.y = [3 1 0 -1 -3 -1 0 1 3];
    handles.x4=(handles.x);
    handles.y4=(handles.y)+30;
end
% Checks if the fifth shuriken has left the screen
if handles.x5 <= 0
    % Resets the flag to 0 once it leaves the screen
    handles.shuri5Visi = 0;
    set(handles.myNinjaStar5,'Visible','off') % Turn off visibility of rectangle
    % Resets the fifth shuriken's coordinates
    handles.x = [0 -1 -3 -1 0 1 3 1 0];
    handles.y = [3 1 0 -1 -3 -1 0 1 3];
    handles.x5=(handles.x)+100;
    handles.y5=(handles.y)+10;
end

% Updates ninja position
set(handles.myNinja,'xdata',handles.Ninjiggerx+handles.xOffset,'ydata',handles.Ninjiggery+handles.yOffset);
% If statement to move the ninja down if the flag is 0
if handles.targetVisi==1
    handles.targetCounter=handles.targetCounter+1;
    set(handles.Smoke,'Visible','off')
    set(handles.targetNinja,'Visible','on')
    if handles.targetCounter>=80
        handles.targetVisi=0;
        handles.smokeVisi=1;
        handles.targetCounter=0;
    end
end
if handles.targetVisi==0
    handles.smokeCounter=handles.smokeCounter+1;
    set(handles.Smoke,'Visible','on')
    set(handles.targetNinja,'Visible','off')
    if handles.smokeCounter>=30
        handles.targetVisi=1;
        handles.smokeVisi=0;
        handles.smokeCounter=0;
    end
end

if handles.targetNinjaMove == 0 && handles.targetVisi==0
    handles.ninjaTargety=handles.ninjaTargety-2;
    handles.Smokey=handles.Smokey-2;
    set(handles.targetNinja,'ydata',handles.ninjaTargety);
    set(handles.targetNinja,'Visible','off')
    set(handles.Smoke,'ydata',handles.Smokey);
    set(handles.Smoke,'Visible','on')
    if handles.ninjaTargety <= 15
        % Sets the flag to 1
        handles.targetNinjaMove = 1;
    end
end
% If statement to move the ninja up if the flag is 1
if handles.targetNinjaMove == 1 && handles.targetVisi==0
    handles.ninjaTargety=handles.ninjaTargety+2;
    handles.Smokey=handles.Smokey+2;
    set(handles.targetNinja,'ydata',handles.ninjaTargety);
    set(handles.targetNinja,'Visible','off')
    set(handles.Smoke,'ydata',handles.Smokey);
    set(handles.Smoke,'Visible','on')
    if handles.ninjaTargety >= 85
        % Sets the flag to 0
        handles.targetNinjaMove = 0;
    end
end

if handles.targetNinjaMove == 0 && handles.targetVisi==1
    handles.ninjaTargety=handles.ninjaTargety-2;
    handles.Smokey=handles.Smokey-2;
    set(handles.targetNinja,'ydata',handles.ninjaTargety);
    set(handles.targetNinja,'Visible','on')
    set(handles.Smoke,'ydata',handles.Smokey);
    set(handles.Smoke,'Visible','off')
    if handles.ninjaTargety <= 15
        % Sets the flag to 1
        handles.targetNinjaMove = 1;
    end
end
% If statement to move the ninja up if the flag is 1
if handles.targetNinjaMove == 1 && handles.targetVisi==1
    handles.ninjaTargety=handles.ninjaTargety+2;
    handles.Smokey=handles.Smokey+2;
    set(handles.targetNinja,'ydata',handles.ninjaTargety);
    set(handles.targetNinja,'Visible','on')
    set(handles.Smoke,'ydata',handles.Smokey);
    set(handles.Smoke,'Visible','off')
    if handles.ninjaTargety >= 85
        % Sets the flag to 0
        handles.targetNinjaMove = 0;
    end
end

% thresholding to throw a shuriken at the target
if handles.gyFilt >= .2 && handles.throwVisi == 0 
    handles.throwVisi = 1; % Sets visibility flag to 1
    handles.xthrow = handles.xthrow+handles.xOffset;
    handles.ythrow = handles.ythrow+handles.yOffset;
    set(handles.throwShuriken,'Visible','on') % Makes the thrown shuriken visible
    set(handles.throwShuriken,'xdata',handles.xthrow,'ydata',handles.ythrow);
end
% If the shuriken is visible
if handles.throwVisi == 1
    % Moves the thrown shuriken across the screen
    handles.xthrow=handles.xthrow+3.5;
       set(handles.throwShuriken,'xdata',handles.xthrow)
end

if handles.xthrow >= 100 % If thrown shuriken goes off screen
        handles.throwVisi=0; % Turn shuriken flag to 0
        set(handles.throwShuriken,'Visible','off') % Make shuriken invisible
        % Reset coordinates
        handles.x = [0 -1 -3 -1 0 1 3 1 0];
        handles.y = [3 1 0 -1 -3 -1 0 1 3];
        handles.xthrow=handles.x + 60;
        handles.ythrow=handles.y + 60;
end

drawnow
% Pause for animation
pause(.001)

% Collision detection for ninja star 1
handles.XNinjiggercollision = handles.Ninjiggerx+handles.xOffset;
handles.YNinjiggercollision = handles.Ninjiggery+handles.yOffset;
 if max(inpolygon(handles.XNinjiggercollision,handles.YNinjiggercollision,handles.x1,handles.y1))==1 %If any point of the cursor is in the target
        handles.mbox = msgbox('You Lose!'); uiwait(handles.mbox); %display message box and wait until user clicks
        set(handles.status,'String','Game Over');
        set(handles.Start,'String','Start');%Change to 'Start'
        set(handles.Scoreboard,'String','0');
        set(handles.status,'String',' ');
         sound(u,Ps)
        break
 end

% Collision detection for ninja star 2
 if max(inpolygon(handles.XNinjiggercollision,handles.YNinjiggercollision,handles.x2,handles.y2))==1 %If any point of the shuriken hits the target
     sound(u,Ps)
    pause(2)
        handles.mbox = msgbox('You Lose!'); uiwait(handles.mbox); %display message box and wait until user clicks
        set(handles.status,'String','Game Over');
        set(handles.Start,'String','Start');%Change to 'Start'
        set(handles.Scoreboard,'String','0');
        set(handles.status,'String',' ');
        break
 end
 % Collision detection for ninja star 3
  if max(inpolygon(handles.XNinjiggercollision,handles.YNinjiggercollision,handles.x3,handles.y3))==1 %If any point of the shuriken hits the target
      sound(u,Ps)
    pause(2)
        handles.mbox = msgbox('You Lose!'); uiwait(handles.mbox); %display message box and wait until user clicks
        set(handles.status,'String','Game Over');
        set(handles.Start,'String','Start');%Change to 'Start'
        set(handles.Scoreboard,'String','0');
        set(handles.status,'String',' ');
        break
  end
 
  % Collision detection for ninja star 4
  if max(inpolygon(handles.XNinjiggercollision,handles.YNinjiggercollision,handles.x4,handles.y4))==1 %If any point of the shuriken hits the target
      sound(u,Ps)
    pause(2)
        handles.mbox = msgbox('You Lose!'); uiwait(handles.mbox); %display message box and wait until user clicks
        set(handles.status,'String','Game Over');
        set(handles.Start,'String','Start');%Change to 'Start'
        set(handles.Scoreboard,'String','0');
        set(handles.status,'String',' ');
        break
  end
 
    % Collision detection for ninja star 5
  if max(inpolygon(handles.XNinjiggercollision,handles.YNinjiggercollision,handles.x5,handles.y5))==1 %If any point of the shuriken hits the target
      sound(u,Ps)
    pause(2)
        handles.mbox = msgbox('You Lose!'); uiwait(handles.mbox); %display message box and wait until user clicks
        set(handles.status,'String','Game Over');
        set(handles.Start,'String','Start');%Change to 'Start'
        set(handles.Scoreboard,'String','0');
        set(handles.status,'String',' ');
        break
  end
 

  
  % Updating the score
  handles.ScoreboardValue = get(handles.Scoreboard,'String');
  handles.ScoreboardValue = str2num(handles.ScoreboardValue);
   % Collision detection for hitting the target ninja
  if handles.targetVisi == 1
    if max(inpolygon(handles.ninjaTargetx,handles.ninjaTargety,handles.xthrow,handles.ythrow))==1 %If any point of the shuriken hits the target
        handles.ScoreboardValue = handles.ScoreboardValue + 50;
        set(handles.Scoreboard,'String',num2str(handles.ScoreboardValue));
        sound(handles.SwordStrike, handles.Fs); % Makes sound on hit
    end
  end
  %If smoke is hit
  if handles.smokeVisi==1;
      if max(inpolygon(handles.Smokex,handles.Smokey,handles.xthrow,handles.ythrow))
           sound(u,Ps);
          handles.ScoreboardValue = handles.ScoreboardValue - 75;
          set(handles.Scoreboard,'String',num2str(handles.ScoreboardValue));
      end
  end

  
 % Checks to make sure the ninja does not stray outside of the boundaries
 % too far. Some wiggle room is accounted for for out of bounds.
 % Right boundary
if handles.Ninjiggerx+handles.xOffset >94
      set(handles.status,'String','Game Over');
      set(handles.Start,'String','Start');%Change to 'Start'
      set(handles.Scoreboard,'String','0');
      set(handles.status,'String',' ');
      break
 % Top boundary
  elseif handles.Ninjiggery+handles.yOffset >93
      set(handles.status,'String','Game Over');
      set(handles.Start,'String','Start');%Change to 'Start'
      set(handles.Scoreboard,'String','0');
      set(handles.status,'String',' ');
      break
 % Left boundary
  elseif handles.Ninjiggerx+handles.xOffset <6
      set(handles.status,'String','Game Over');
      set(handles.Start,'String','Start');%Change to 'Start'
      set(handles.Scoreboard,'String','0');
      set(handles.status,'String',' ');
      break
 % Bottom boundary
  elseif handles.Ninjiggery+handles.yOffset <6
      set(handles.status,'String','Game Over');
      set(handles.Start,'String','Start');%Change to 'Start'
      set(handles.Scoreboard,'String','0');
      set(handles.status,'String',' ');
      break
end
% Update the score by +1 for each loop iteration
handles.ScoreboardValue = handles.ScoreboardValue + 1;
set(handles.Scoreboard,'String',num2str(handles.ScoreboardValue));
end % End difficulty if statement
end % End while loop
cla;

clear all  
    
%guidata(hObject, handles);

% --- Executes on button press in closeSerial.
function closeSerial_Callback(hObject, eventdata, handles)
% hObject    handle to closeSerial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closeSerial

% --- Executes on button press in easydifficulty.
function easydifficulty_Callback(hObject, eventdata, handles)
% hObject    handle to easydifficulty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.easydifficulty = 1;
handles.harddifficulty = 0;
guidata(hObject, handles);


% --- Executes on button press in harddifficulty.
function harddifficulty_Callback(hObject, eventdata, handles)
% hObject    handle to harddifficulty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.easydifficulty = 0;
handles.harddifficulty = 1;
guidata(hObject, handles);


% --- Executes on button press in easydifficulty.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to easydifficulty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of easydifficulty


% --- Executes on button press in harddifficulty.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to harddifficulty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of harddifficulty


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end