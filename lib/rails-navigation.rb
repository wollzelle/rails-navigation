module Rails
  module Navigation

    class ActionController::Base

      protected

      def add_navigation(name, url = '', options = {})
        @navigation ||= []
        url = send(url) if url.is_a?(Symbol)
        @navigation << [name, url, options]
      end

      def self.add_navigation(name, url, options = {})
        before_filter options do |controller|
          controller.send(:add_navigation, name, url)
        end
      end

    end

    module Helper

      def navigation(tag = :li)
        (@navigation || []).map do |txt, path, options|
          link = link_to_unless path.blank?, h(txt), path, options
          content_tag(tag, link) if tag
        end.join.html_safe
      end

    end

  end
end

ActionController::Base.send(:include, Rails::Navigation)
ActionView::Base.send(:include, Rails::Navigation::Helper)