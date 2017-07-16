-- THIS IS A LOCALSCRIPT AS A CHILD OF THE PLUGIN MODULE

workspace.CurrentCamera:Destroy()
wait()

repeat wait() until workspace.CurrentCamera ~= nil
workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
workspace.CurrentCamera.CameraType = "Custom"

script:Destroy()