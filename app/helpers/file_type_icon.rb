class FileTypeIcon
    def self.get_icon(filetype)
        return "file_icons.svg#svgView(viewBox(20, 0, 70, 150))"     if filetype.downcase=='video'
        return "file_icons.svg#svgView(viewBox(440, 0, 160, 150))"   if filetype.downcase=='audio'
        return "file_icons.svg#svgView(viewBox(280, 0, 160, 150))"   if filetype.downcase=='text'
        return "file_icons.svg#svgView(viewBox(20, 190, 70, 160))"   if filetype.downcase=='spreadsheet'
        return "file_icons.svg#svgView(viewBox(130, 0, 160, 150))"   if filetype.downcase=='image'
        return "file_icons.svg#svgView(viewBox(130, 390, 160, 150))" if filetype.downcase=='presentation'
    end
end