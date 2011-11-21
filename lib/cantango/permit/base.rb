# The permit base class for both Role Permits and Role Group Permits
# Should contain all common logic
module CanTango
  module Permit
    class Base
      include CanTango::Helpers::Debug

      # FIX !?
      include CanTango::Rules # also makes a Permit a subclass of CanCan::Ability
      include CanTango::Api::Attributes

      Helper.modules.each do |name|
        include "CanTango::Permit::Helper::#{name.to_s.camelize}".constantize
      end
      extend ClassMethods

      # strategy is used to control the owns strategy (see rules.rb)
      attr_reader :ability, :strategy, :disabled

      delegate :ability, :to => :executor
      delegate :cached?, :options, :subject, :user, :user_account, :to => :ability

      def name
        self.class.permit_name self.class
      end

      # creates the permit
      def initialize ability
        @ability  = ability
      end

      def permit_type
        self.class.type
      end

      def ability_rules
        ability.send :rules
      end

      def disable!
        @disabled = true
      end

      def disabled?
        @disabled || config_disabled?
      end

      def valid_for? subject
        raise NotImplementedError
      end

      def category label
        config.models.by_category label
      end

      def any reg_exp
        config.models.by_reg_exp reg_exp
      end

     CanTango::Api::Options.options_list.each do |obj|
       class_eval %{
          def #{obj}
            options[:#{obj}]
          end
        }
      end

      def localhost?
        config.localhost_list.include? request.host
      end

      def publichost?
        !localhost?
      end

      def ability_sync!
        ability_rules << (rules - ability_rules)
        ability_rules.flatten!
      end

      protected

      include CanTango::Permit::Helper::RoleMatcher

      def config_disabled?
        (CanTango.config.permits.disabled[permit_type] || []).include?(permit_name.to_s)
      end

      def strategy
        @strategy ||= options[:strategy] || CanTango::Ability.strategy || :default
      end

      def any_role_match?
        role_match?(subject) || role_group_match?(subject)
      end

      def config
        CanTango.config
      end
    end
  end
end