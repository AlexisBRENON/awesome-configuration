-- run a command only if the client does not already exist

local xrun_now = 
function(name, cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
     findme = cmd:sub(0, firstspace-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end

-- Run a command if not already running.
xrun = function(name, cmd)
  -- We need to wait for awesome to be ready. Hence the timer.
  local stimer = timer { timeout = 0 }
  local run = function()
    stimer:stop()
    xrun_now(name, cmd)
  end
  stimer:connect_signal("timeout", run)
  stimer:start()
end
