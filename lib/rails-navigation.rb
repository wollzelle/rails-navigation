module Rails
  module Navigation

    class ActionController::Base

      protected

      def add_navigation(options = {})
        nav, title, url, options = { :nav => :default, :title => "", :url => "", :options => {} }.merge(options).values
        @navigation ||= {}
        url = send(url) if url.is_a?(Symbol)
        @navigation[nav] ||= []
        @navigation[nav] << [title, url, options]
      end

      def self.add_navigation(nav, title, url, options)
        before_filter options do |controller|
          controller.send(:add_navigation, nav, title, url, options)
        end
      end

    end

    module Helper

      def navigation?(nav)
        return false unless @navigation
        !(@navigation)[nav].nil?
      end
      
      def navigation(nav, tag = :li)
        (@navigation[nav] || []).map do |text, path, options|
          link = link_to_unless path.blank?, h(text), path, options
          content_tag(tag, link) if tag
        end.join.html_safe
      end

    end

  end
end

ActionController::Base.send(:include, Rails::Navigation)
ActionView::Base.send(:include, Rails::Navigation::Helper)