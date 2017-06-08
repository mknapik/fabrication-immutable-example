# frozen_string_literal: true

require 'fabrication/generator/base'

module Fabrication
  module Generator
    class ImmutableGenerator < Fabrication::Generator::Base
      def self.supports?(_klass)
        true
      end

      def build_instance
        self._instance = construct(build_parameters)
      end

      def set_attributes; end

      private

      Parameters = Struct.new(:args, :keys, :block)

      private_constant :Parameters

      def construct(parameters)
        if parameters.block.nil?
          _klass.new(*parameters.args, **parameters.keys)
        else
          _klass.new(*parameters.args, **parameters.keys, &parameters.block)
        end
      end

      def defined_parameters
        _klass.instance_method(:initialize).parameters
      end

      def build_parameters
        defined_parameters.each_with_object(Parameters.new([], {})) do |(type, name), parameters|
          process_parameter(type, name, parameters)
        end
      end

      def process_parameter(type, name, parameters)
        if argument?(type)
          process_argument(type, name, parameters)
        elsif option?(type)
          process_option(type, name, parameters)
        elsif block_argument?(type)
          process_block(name, parameters)
        else
          raise NotImplementedError, "What is #{type}?"
        end
      end

      def process_argument(type, name, parameters)
        if regular_argument?(type)
          parameters.args << _attributes[name]
        elsif rest_argument?(type)
          parameters.args.concat(_attributes.reject { |k, _v| used_parameters.include?(k) }.values)
        else
          raise NotImplementedError, "What is #{type}?"
        end
      end

      def process_option(type, name, parameters)
        if keyword_argument?(type)
          parameters.keys[name] = _attributes[name]
        elsif keyword_rest_argument?(type)
          parameters.keys.merge!(_attributes.reject { |k, _v| used_parameters.include?(k) })
        else
          raise NotImplementedError, "What is #{type}?"
        end
      end

      def process_block(name, parameters)
        parameters.block = _attributes[name]
      end

      def used_parameters
        @used_parameters ||= defined_parameters.lazy.select { |type, _| used?(type) }.map { |_, name| name }
      end

      def argument?(type)
        regular_argument?(type) || rest_argument?(type)
      end

      def regular_argument?(type)
        type == :req || type == :opt
      end

      def rest_argument?(type)
        type == :rest
      end

      def option?(type)
        keyword_argument?(type) || keyword_rest_argument?(type)
      end

      def keyword_rest_argument?(type)
        type == :keyrest
      end

      def keyword_argument?(type)
        type == :key || type == :keyreq
      end

      def block_argument?(type)
        type == :block
      end

      def used?(type)
        regular_argument?(type) || keyword_argument?(type) || block_argument?(type)
      end
    end
  end
end
