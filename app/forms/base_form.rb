class BaseForm < Reform::Form
  # feature Reform::Form::ActiveModel::FormBuilderMethods
  # feature Reform::Form::MultiParameterAttributes

  def initialize
    super(nil)
  end

  def self.properties(hash)
    hash.each_pair do |name, options|
      property name, options
    end
  end

  def self.property(name, options={})
    prepopulator = ->(options) { self.send("#{name}=", options[name.to_sym]) }
    super(name, options.merge(virtual: true, prepopulator: prepopulator)) # every property needs to be virtual.
  end
end
