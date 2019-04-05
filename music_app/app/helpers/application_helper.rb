module ApplicationHelper
    def auth_form
        "<input type=\"hidden\" name=\"authenticity_token\" value=\"<%= form_authenticity_token %>\">".html_safe
    end

    def print_flash
        unless flash.empty?
            flash.each do |k, v|
                "<li>#{flash[k]}</li>".html_safe
            end
        end
    end
end
