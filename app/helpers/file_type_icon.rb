class FileTypeIcon
    def self.get_icon(filetype)
        return "audio.png"        if filetype.downcase=='video'
        return "audio.png"        if filetype.downcase=='audio'
        return "text.png"         if filetype.downcase=='text'
        return "audio.png"        if filetype.downcase=='spreadsheet'
        return "audio.png"        if filetype.downcase=='image'
        return "audio.png"        if filetype.downcase=='presentation'
    end
end