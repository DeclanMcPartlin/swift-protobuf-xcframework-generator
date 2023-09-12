# build_framework plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-build_framework)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-build_framework`,add the following to the Pluginfile:
 Your users then need to 


```bash
gem 'fastlane-plugin-build_framework', git: 'https://github.com/Unity-Technologies/fastlane-plugin-build_framework.git'
```
or if you want to test your implementation in a particular branch

```bash
gem 'fastlane-plugin-build_framework', git: 'https://github.com/Unity-Technologies/fastlane-plugin-build_framework.git', :branch => 'implementation'
```

or if you want to test your implementation localy

```bash
gem 'fastlane-plugin-build_framework', path: 'your local path'
```


## About build_framework

The plugin that facilitates building all types of frameworks

**Note to author:** Add a more detailed description about this plugin here. If your plugin contains multiple actions, make sure to mention them here.

## Example

```ruby
    build_framework(type: 'xcframework')
```

```ruby
    build_framework(type: 'static', includeSimulator: true)
```
```ruby
    build_framework(type: 'framework', 
                    output_folder: 'your output folder',
                    workspace: 'workspace.workspace', // or
                    project: 'Project.xcproject',
                    scheme: 'Scheme',
                    dev_archs: ['desired archs'],
                    sim_archs: ['desired archs'],
                    includeSimulator: true)
```


**Note to author:** Please set up a sample project to make it easy for users to explore what your plugin does. Provide everything that is necessary to try out the plugin in this project (including a sample Xcode/Android project if necessary)


## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
