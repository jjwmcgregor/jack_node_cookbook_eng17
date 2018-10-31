# # encoding: utf-8

# Inspec test for recipe node::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

unless os.windows?
  # This is an example test, replace with your own test.
  describe user('root') do
    it { should exist }
  end
end

# This is an example test, replace it with your own test.
describe port(80) do
  it { should be_listening }
end

describe service "nginx" do
  it { should be_running }
  it { should be_enabled }
end

describe port(80) do
  it { should be_listening }
end

# Our testing is pretty basic at the moment. We know that Nginx is listening on port 80 but that doesn't fully describe what it's supposed to do. If our configuration is correct it should really forward us to port 3000. We saw previously that if there's nothing running on port 3000 we should get a 502 Bad Gateway status error returned. We can test for that

describe http('http://localhost', enable_remote_worker: true) do
  its('status') { should cmp 502 }
end

describe package ('nodejs') do
  it { should be_installed }
  its('version') { should cmp > '8.11.2*' }
end

describe npm ("pm2") do
  it { should be_installed }
end
