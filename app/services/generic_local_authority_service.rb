module GenericLocalAuthorityService
  mattr_accessor :authority

  @@label_id_divider = '####'

  def self.label_id_divider
    @@label_id_divider
  end

  def self.select_all_options(key)
    self.authority = Qa::Authorities::Local.subauthority_for(key)

    authority.all.map do |element|
      [element[:label], element[:id]]
    end
  end

  def self.label(id)
    authority.find(id).fetch('term')
  end

  def self.id_to_label(key, id)
    return '' if id.nil? or id==''

    authority = Qa::Authorities::Local.subauthority_for(key)
    term = ''
    begin
      term = authority.find(id).fetch('term')
    rescue => error
      puts error.backtrace
      return ''
    end
    term
  end

  def self.ids_to_sorted_labels(key, ids)
    return [] if ids.nil? or ids.length==0

    labels = []

    begin
      authority = Qa::Authorities::Local.subauthority_for(key)
      ids.each do |id|
        labels << authority.find(id).fetch('term')
      end
    rescue => error
      puts error.backtrace
    end

    labels.sort
  end

  # return array of hashes, each element is <label,id>
  def self.ids_to_sorted_labels_and_ids(key, ids)
    return [] if ids.nil? or ids.length==0

    label_and_ids = []

    begin
      authority = Qa::Authorities::Local.subauthority_for(key)
      ids.each do |id|
        label_and_ids << "#{authority.find(id).fetch('term')}#{@@label_id_divider}#{id}"
      end
    rescue => error
      puts error.backtrace
    end

    label_and_ids.sort
  end
end