module Rails
  module Navigation

    class ActionController::Base

      protected

      def add_navigation(name, url = '')
        @navigation ||= []
        url = send(url) if url.is_a?(Symbol)
        @navigation << [name, url]
      end

      def self.add_navigation(name, url, options = {})
        before_filter options do |controller|
          controller.send(:add_navigation, name, url)
        end
      end

    end

    module Helper

      def navigation(tag = :li)
        @navigation.map do |txt, path|
          link = link_to_unless (path.blank? || current_page?(path)), h(txt), path
          content_tag(tag, link) if tag
        end.join.html_safe
      end

    end

  end
end

ActionController::Base.send(:include, Rails::Navigation)
ActionView::Base.send(:include, Rails::Navigation::Helper)