class BAA
  module Hooks
    @@_baa_hooks = {before: [], after: [], around: []}

    def before(*names)
      names.each do |name|
        m = instance_method(name)
        define_method(name) do |*args, &block|
          yield
          m.bind(self).(*args, &block)
        end
        @@_baa_hooks[:before] << name
      end
      @@_baa_hooks
    end

    def after(*names)
      names.each do |name|
        m = instance_method(name)
        define_method(name) do |*args, &block|
          m.bind(self).(*args, &block)
          yield
        end
        @@_baa_hooks[:after] << name
      end
      @@_baa_hooks
    end

    def around(*names, pre_method_name)
      names.each do |name|
        m = instance_method(name)
        define_method(name) do |*args, &block|
          self.send(pre_method_name)
          m.bind(self).(*args, &block)
          yield
        end
        @@_baa_hooks[:around] << name
      end
      @@_baa_hooks
    end
  end
end

