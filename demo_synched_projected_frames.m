% The directory where you extracted the raw dataset.
datasetDir = '/data/cafe';

% The name of the scene to demo.
sceneName = 'cafe_0001a';

% The absolute directory of the 
sceneDir = sprintf('%s/%s', datasetDir, sceneName);

% Reads the list of frames.
frameList = get_synched_frames(sceneDir);

%create the video writer with 20 fps
writerObj=VideoWriter('/data/cafe/scene1_video.avi');
writerObj.FrameRate=20;
open(writerObj);

% Displays each pair of synchronized RGB and Depth frames.
for ii = 1 : numel(frameList)
  imgRgb = imread([sceneDir '/' frameList(ii).rawRgbFilename]);
  imgDepthRaw = swapbytes(imread([sceneDir '/' frameList(ii).rawDepthFilename]));
  
  % Show the projected depth image.
  imgDepthProj = project_depth_map(imgDepthRaw, imgRgb);
  frame=im2frame(imgDepthProj);
  writeVideo(writerObj, frame);
end

%close the writer object
close(writerObj)
