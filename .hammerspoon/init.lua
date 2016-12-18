hs.hotkey.bind({"shift", "cmd"}, "W", function()
  hs.notify.new({title="Hammerspoon", informativeText="Hello World"}):send()
end)

hs.urlevent.bind("meh", function(event_name, params)
  hs.notify.new({title="meh", informativeText="meh..."}):send()
end)
