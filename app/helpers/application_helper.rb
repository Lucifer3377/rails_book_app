module ApplicationHelper
    def error_messages_for(object)
        render(:partial => "application/error_messages", :locals => {:object => object})
    end

    def active_class(link_path)
        current_page?(link_path) ? "active" : ""
       end
end
