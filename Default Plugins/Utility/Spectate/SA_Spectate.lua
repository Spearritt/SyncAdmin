-- THIS IS A LOCALSCRIPT
-- Create an object value called "Target" and add it as a child to this localscript for it to function correctly.

workspace.CurrentCamera.CameraSubject = script:WaitForChild("Target").Value
wait()
script:Destroy()
script.Disabled = true
