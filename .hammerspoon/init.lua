hs.hotkey.bind({"shift", "cmd"}, "W", function()
  hs.notify.new({title="Hammerspoon", informativeText="Hello World"}):send()
end)
