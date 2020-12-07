module Cypress
  class Engine < ::Rails::Engine
    isolate_namespace Cypress
  end
end
