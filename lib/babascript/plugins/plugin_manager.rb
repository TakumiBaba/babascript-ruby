module Babascript
  module Plugin
    class PluginManager
      def initialize(plugins=[])
        @plugins = {}
        @events = []
        plugins.each do |p|
          add(p)
        end
      end

      def add(plugin)
        @plugins[plugin.name] = plugin
      end

      def remove(name)
        @plugins[name] = nil
      end
    end
  end
end
