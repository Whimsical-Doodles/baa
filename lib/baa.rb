# Hooks
module Hooks
  def _baa_hooks
    @_baa_hooks ||= {
      before: [],
      after: [],
      around: []
    }
  end

  def before(*names)
    names.each do |name|
      _baa_rename_method(name)
      define_method(name) do |*args, &block|
        yield
        if args.any?
          send(self.class._baa_old_name(name), args, &block)
        else
          send(self.class._baa_old_name(name), &block)
        end
      end
      _baa_hooks[:before] << name
    end
    _baa_hooks
  end

  def after(*names)
    names.each do |name|
      _baa_rename_method(name)
      define_method(name) do |*args, &block|
        if args.any?
          send(self.class._baa_old_name(name), args, &block)
        else
          send(self.class._baa_old_name(name), &block)
        end
        yield
      end
      _baa_hooks[:after] << name
    end
    _baa_hooks
  end

  def around(*names, pre_method_name)
    names.each do |name|
      _baa_rename_method(name)
      define_method(name) do |*args, &block|
        send(pre_method_name)
        if args.any?
          send(self.class._baa_old_name(name), args, &block)
        else
          send(self.class._baa_old_name(name), &block)
        end
        yield
      end
      _baa_hooks[:around] << name
    end
    _baa_hooks
  end

  def _baa_rename_method(name)
    if _baa_hooks.values.flatten.include? name
      fail "Method (:#{name}) already has hooks applied\n#{_baa_hooks}"
    end
    alias_method _baa_old_name(name), name
  end

  def _baa_old_name(name)
    "_baa_#{name}".to_sym
  end
end
