-- THIS IS A LOCALSCRIPT
-- Create an object value called "Target" and place that value as a child to this LocalScript for this to function correctly

workspace.CurrentCamera.CameraSubject = script:WaitForChild("Target").Value
wait()
script:Destroy()
script.Disabled = true
