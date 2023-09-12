require 'fastlane/action'
require_relative '../helper/build_framework_helper'
require_relative './path_builder'
require_relative './lipo_runner'
require_relative './build_utils'
require_relative './xconfig_builder'
require_relative './xcframework_builder'

module Fastlane
  module Actions
    class BuildFrameworkAction < Action
      def self.build_framework(params)
        UI.message("Started building #{XconfigBuilder.paths_components[:project_name]}.#{params[:type]} for #{params[:sdk]} support")
        Actions::XcodebuildAction.run(params)
        UI.message("Finished building #{XconfigBuilder.paths_components[:project_name]}.#{params[:type]}  for #{params[:sdk]} support")
      end

      def self.run(params)
        if params[:type] != 'framework' && params[:type] != 'xcframework'
          UI.error("Unsupported framework type of: #{params[:type]}")
          return
        end

        UI.message('Building paths components')
        paths_components = get_paths_components(params)
        if paths_components.nil?
          return
        end

        Actions::BuildUtils.prepare(paths_components)
        UI.message('Building paths components finished')

        XconfigBuilder.params = params
        XconfigBuilder.paths_components = paths_components

        build_for_sim_if_required(params)

        UI.success("Building for device")
        build_for_device

        if params[:type] == 'framework'
          lipo_config = Helper::Object.copy(paths_components)
          lipo_config[:includeSimulator] = params[:includeSimulator]
          Actions::LipoRunner.run(lipo_config)
        else
          Actions::XCFrameworkBuilder.run(paths_components)
        end
        Actions::BuildUtils.clean_temp_folder(paths_components)
        UI.success("Build succeed")
      end

      def self.build_for_device
        xcodebuild_configs = XconfigBuilder.device_config
        build_framework(xcodebuild_configs)
      end

      def self.build_for_sim_if_required(params)
        if params[:includeSimulator] || params[:type] == 'xcframework'
          UI.message("Building for sim")
          xcodebuild_configs = XconfigBuilder.simulator_config
          build_framework(xcodebuild_configs)
        end
      end

      def self.get_paths_components(params)
        builder_config = {}
        builder_config[:project] = params[:project]
        builder_config[:workspace] = params[:workspace]
        PathBuilder.build_paths(params)
      end

      def self.description
        "The plugin that facilitates building all types of frameworks"
      end

      def self.authors
        ["Unity"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        ""
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :project,
                               description: "Project name",
                                  optional: true,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :output_folder,
                               description: "Output folder",
                             default_value: "./fastlane_build",
                                  optional: true,
                                      type: String),

          FastlaneCore::ConfigItem.new(key: :workspace,
                               description: "Workspace name",
                                  optional: true,
                                      type: String),

          FastlaneCore::ConfigItem.new(key: :scheme,
                               description: "Scheme name",
                                  optional: true,
                                      type: String),

          FastlaneCore::ConfigItem.new(key: :configuration,
                               description: "Build Configuration",
                             default_value: 'Release',
                                  optional: true,
                                      type: String),

          FastlaneCore::ConfigItem.new(key: :sim_configuration,
                               description: "Sim Build Configuration",
                             default_value: 'Release',
                                  optional: true,
                                      type: String),

          FastlaneCore::ConfigItem.new(key: :type,
                               description: "Framework type",
                                  optional: true,
                             default_value: 'xcframework',
                                      type: String),

          FastlaneCore::ConfigItem.new(key: :includeSimulator,
                               description: "Include simulator support",
                                  optional: true,
                             default_value: false,
                                 is_string: false),

          FastlaneCore::ConfigItem.new(key: :dev_archs,
                               description: "Build for device architectures",
                                  optional: true,
                                      type: Array),

          FastlaneCore::ConfigItem.new(key: :sim_archs,
                               description: "Build for sim architectures",
                                  optional: true,
                                      type: Array)
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
