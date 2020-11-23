local ui = {}

-- ui.new_window() -> window
ui.new_window = function()
    local width, height = term.current().getSize()
    local new_window = window.create(term.current(), 0, 0, width, height)

    return new_window
end

-- ui.set_background_colour(
--     win: window
--     colour: number
-- ) -> nil
ui.set_background_colour = function(win, colour)
   win.setBackgroundColor(colour)
   win.redraw()
end

return ui