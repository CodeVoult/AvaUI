local ButtonModule = {}

function ButtonModule.Add(Library, card, lbl, cb)
    local T = Library.T
    local row = Library.New("Frame", {
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = T.panel2,
        ZIndex = 5,
        Parent = card
    })
    Library.Cor(row, 20)
    local rowStroke = Library.Stk(row, T.border, 1)

    local btn = Library.New("TextButton", {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        Text = lbl,
        TextColor3 = T.text,
        Font = Enum.Font.GothamBold,
        TextSize = 13,
        ZIndex = 6,
        Parent = row
    })
    Library:BindTheme(row, "BackgroundColor3", "panel2")
    Library:BindTheme(rowStroke, "Color", "border")
    Library:BindTheme(btn, "TextColor3", "text")

    Library:Track(btn.MouseButton1Click:Connect(function()
        if cb then cb() end
    end))
    Library:Track(btn.MouseEnter:Connect(function()
        Library.Tween(row, 0.14, { BackgroundColor3 = T.panel })
    end))
    Library:Track(btn.MouseLeave:Connect(function()
        Library.Tween(row, 0.14, { BackgroundColor3 = T.panel2 })
    end))
end

return ButtonModule
