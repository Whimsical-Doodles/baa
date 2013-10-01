class BAA
  module Hooks
    @@_baa_hooks = {before: [], after: [], around: []}

    def before(*names)
      names.each do |name|
        rename_method(name)
        define_method(name) do |*args, &block|
          yield
          send(old_name(name), args, &block)
        end
        @@_baa_hooks[:before] << name
      end
      @@_baa_hooks
    end

    def after(*names)
      names.each do |name|
        rename_method(name)
        define_method(name) do |*args, &block|
          send(old_name(name), args, &block)
          yield
        end
        @@_baa_hooks[:after] << name
      end
      @@_baa_hooks
    end

    def around(*names, pre_method_name)
      names.each do |name|
        rename_method(name)
        define_method(name) do |*args, &block|
          send(pre_method_name)
          yield
          send(old_name(name), args, &block)
        end
        @@_baa_hooks[:around] << name
      end
      @@_baa_hooks
    end

    private

    def rename_method(name)
      alias_method name, old_name(name)
    end

    def old_name(name)
      "_baa_#{name}"
    end
  end
end

