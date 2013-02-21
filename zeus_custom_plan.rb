require 'zeus/rails'

class CustomPlan < Zeus::Rails
    def rspec
      RSpec::Core::Runner.disable_autorun!
      exit RSpec::Core::Runner.run(ARGV)
    end
end

Zeus.plan = CustomPlan.new
