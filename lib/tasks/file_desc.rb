# File description class for file report rake task
class FileDesc
    attr_accessor :collection_id, :collection_title, :resource_id, :resource_date, :resource_title, :fileset_id, :fileset_title, :fileset_date, :depositor

    def initialize(collection_id,
                   collection_title,
                   resource_id,
                   resource_title,
                   resource_date,
                   fileset_id,
                   fileset_title,
                   fileset_date,
                   depositor)
        @collection_id    = collection_id
        @collection_title = collection_title
        @resource_id      = resource_id
        @resource_date    = resource_date
        @resource_title   = resource_title
        @fileset_id       = fileset_id
        @fileset_title    = fileset_title
        @fileset_date     = fileset_date
        @depositor        = depositor
    end

    def <=>(other)
        if @collection_title != other.collection_title
            return @collection_title <=> other.collection_title
        elsif @resource_date != other.resource_date
            return -(@resource_date <=> other.resource_date)
        elsif @resource_title != other.resource_title
            return @resource_title <=> other.resource_title
        elsif @fileset_date != other.fileset_date
            return -(@fileset_date <=> other.fileset_date)
        elsif @fileset_title != other.fileset_title
            return @fileset_title <=> other.fileset_title
        else
            return @depositor <=> other.depositor
        end
    end
end