module Rails
  module Navigation

    class ActionController::Base

      protected

      def add_navigation(options = {})
        nav_name, title, url, options = {:nav => :default, :title => "", :url => "", :options => {}}.merge(options).values
        @navigation ||= {}
        url = send(url) if url.is_a?(Symbol)
        @navigation[nav_name] ||= []
        @navigation[nav_name] << [name, url, options]
      end

      def self.add_navigation(nav_name, name, url, options)
        before_filter options do |controller|
          controller.send(:add_navigation, nav_name, name, url, options)
        end
      end

    end

    module Helper

      def navigation?(nav_name)
        return false unless @navigation
        !(@navigation)[nav_name].nil?
      end
      
      def navigation(nav_name, tag = :li)
        (@navigation[nav_name] || []).map do |txt, path, options|
          link = link_to_unless path.blank?, h(txt), path, options
          content_tag(tag, link) if tag
        end.join.html_safe
      end

    end

  end
end

ActionController::Base.send(:include, Rails::Navigation)
ActionView::Base.send(:include, Rails::Navigation::Helper)