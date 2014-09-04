require 'spec_helper'

# write up RSpec integration tests here
describe package('openssl') do
  it { should be_installed }
end

describe file('/etc/ssl/cnf') do
  it { should be_directory }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 700 }
end

describe file('/etc/ssl/certs') do
  it { should be_directory }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 755 }
end

describe file('/etc/ssl/private') do
  it { should be_directory }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 700 }
end

describe file('/etc/ssl/cnf/foo.example.com-openssl.cnf') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }
  %w{
    default_bits = 1024
    default_keyfile = /etc/ssl/private/foo.example.com.key
    distinguished_name = req_distinguished_name
    attributes = req_attributes
    prompt = no
    output_password = SILPION!
    C = DE
    ST = Hamburg
    L = Hamburg
    O = Silpion IT Solutions
    OU = Development SSL
    CN = ansiblesslcertificatestest
    emailAddress = webmaster@ansiblesslcertificatestest
    challengePassword = SILPION!
  }.each do |line|
    its(:content) { should match line }
  end
end
