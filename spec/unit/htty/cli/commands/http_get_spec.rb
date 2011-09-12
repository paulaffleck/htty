require 'rspec'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/follow")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/http_delete")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/http_get")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/http_post")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/http_put")

describe HTTY::CLI::Commands::HttpGet do
  describe 'class' do
    let :klass do
      subject.class
    end

    it 'should be an alias_for the expected command' do
      klass.alias_for.should == nil
    end

    it 'should have the expected aliases' do
      klass.aliases.should == [HTTY::CLI::Commands::Get]
    end

    it 'should belong to the expected category' do
      klass.category.should == 'Issuing Requests'
    end

    it 'should have the expected command_line' do
      klass.command_line.should == 'http-g[et]'
    end

    it 'should have the expected command_line_arguments' do
      klass.command_line_arguments.should == nil
    end

    it 'should have the expected help' do
      klass.help.should == 'Issues an HTTP GET using the current request'
    end

    it 'should have the expected help_extended' do
      expected = <<-end_help_extended
Issues an HTTP GET using the current request.

Any request body you may set is ignored (i.e., it is not sent as part of the request).
      end_help_extended
      klass.help_extended.should == expected.chomp
    end

    it 'should have the expected see_also_commands' do
      klass.see_also_commands.should == [HTTY::CLI::Commands::Follow,
                                         HTTY::CLI::Commands::HttpPost,
                                         HTTY::CLI::Commands::HttpPut,
                                         HTTY::CLI::Commands::HttpDelete]
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('http-get', :session => :the_session)
        built.should be_instance_of(klass)
        built.arguments.should == []
        built.session.should   == :the_session
      end

      it 'should correctly handle a valid, abbreviated command line' do
        built = klass.build_for('http-g', :session => :a_session)
        built.should be_instance_of(klass)
        built.arguments.should == []
        built.session.should   == :a_session
      end

      it 'should correctly handle a command line with a bad command' do
        built = klass.build_for('x', :session => :another_session)
        built.should == nil
      end
    end
  end
end
