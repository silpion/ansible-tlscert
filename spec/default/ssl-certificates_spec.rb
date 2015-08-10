require 'spec_helper'

# write up RSpec integration tests here
describe package('openssl') do
  it { should be_installed }
end

describe file('/etc/ansible/facts.d') do
  it { should be_directory }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 755 }
end

describe file('/etc/ansible/facts.d/ssl-certificates.fact') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }
  %w{
    ssl_certificates_cnf_path=/etc/ssl/cnf
    ssl_certificates_crt_path=/etc/ssl/certs
    ssl_certificates_key_path=/etc/ssl/private
  }.each do |line|
    its(:content) { should match line }
  end
end
