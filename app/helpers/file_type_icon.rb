class FileTypeIcon
    def self.get_icon(filetype)
        return "video.png"        if filetype.downcase=='video'
        return "audio.png"        if filetype.downcase=='audio'
        return "text.png"         if filetype.downcase=='text'
        return "spreadsheet.png"  if filetype.downcase=='spreadsheet'
        return "image.png"        if filetype.downcase=='image'
        return "presentation.png" if filetype.downcase=='presentation'
    end
end