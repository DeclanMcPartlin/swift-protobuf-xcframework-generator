describe Fastlane::Actions::BuildFrameworkAction do
  describe '#run' do
    it 'prints a message' do
      # expect(Fastlane::UI).to receive(:message).with("The build_framework plugin is working!")

      Fastlane::Actions::BuildFrameworkAction.run({
        type: 'framework',
        output_folder: 'your output folder',
        includeSimulator: true
      })
    end
  end
end
