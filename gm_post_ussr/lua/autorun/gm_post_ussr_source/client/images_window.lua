local Window = {}

function Window:SetImages(images) 
    local size = ScrH() * 0.55
    self:SetSize(size, size)
    self:Center()
    self:MakePopup()

    local page = 1
    local maxPage = math.floor(#images)

    local image = vgui.Create("DImage", self)
    image:SetImage(images[1])
    image:Dock(TOP)
    image:InvalidateParent()
    image:SetSize(size * 0.85, size * 0.85)

    local pagePanel = vgui.Create("gm_post_ussr.Panel", self)
    pagePanel:SetSize(size * 0.29, size * 0.04)
    pagePanel:SetPos(size * 0.35, size * 0.95)

    local pageText = vgui.Create("gm_post_ussr.Label", pagePanel)
    pageText:SetText(page .. "/" .. maxPage)
    pageText:SizeToContents()
    pageText:Center()
    local nextPage, previousPage

    nextPage = vgui.Create("gm_post_ussr.Button", pagePanel)
    nextPage:SetText(">")
    nextPage:Dock(RIGHT)
    nextPage:InvalidateLayout()
    nextPage:SetSize(select(2, nextPage:GetSize()), select(2, nextPage:GetSize()))
    function nextPage.DoClick() 
        if page < maxPage then
            page = page + 1
            image:SetImage(images[page])
            pageText:SetText(page .. "/" .. maxPage)
            pageText:SizeToContents()
            pageText:Center()
        end
    end

    previousPage = vgui.Create("gm_post_ussr.Button", pagePanel)
    previousPage:SetText("<")
    previousPage:Dock(LEFT)
    previousPage:InvalidateLayout()
    previousPage:SetSize(select(2, previousPage:GetSize()), select(2, previousPage:GetSize()))
    function previousPage.DoClick() 
        if page > 1 then
            page = page - 1
            image:SetImage(images[page])
            pageText:SetText(page .. "/" .. maxPage)
            pageText:SizeToContents()
            pageText:Center()
        end
    end
end

vgui.Register("gm_post_ussr.ImagesWindow", Window, "gm_post_ussr.Window")