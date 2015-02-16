module Awareness
  def self.included(base)
    base.class_eval {
      include Surrounded
      include Casting::Client
      delegate_missing_methods
    }
  end
end
