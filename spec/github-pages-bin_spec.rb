require 'spec_helper'

describe(GitHubPages) do
  it 'lists the dependency versions' do
    output = `github-pages versions`
    expect(output).to include('Gem')
    expect(output).to include('Version')
    GitHubPages.gems.each do |name, version|
      expect(output).to include("| #{name}")
      expect(output).to include("| #{version}")
    end
  end

  it 'outputs the branch' do
    expected = "gem 'github-pages', :branch => 'master', "
    expected << ":git => 'git://github.com/github/pages-gem'\n"
    expect(`./bin/github-pages branch`).to eql(expected)
  end

  it 'detects the CNAME when running health check' do
    File.write('CNAME', 'foo.invalid')
    expected = 'Checking domain foo.invalid...'
    expect(`./bin/github-pages health-check`).to include(expected)
    File.delete('CNAME')
  end
end
