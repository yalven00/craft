module Linkedin
  class Company
    USER_AGENTS = ['Windows IE 6', 'Windows IE 7', 'Windows Mozilla', 'Mac Safari', 'Mac FireFox', 'Mac Mozilla', 'Linux Mozilla', 'Linux Firefox', 'Linux Konqueror']
    ATTRIBUTES = %w(name employees)
    attr_reader :page, :linkedin_url

    def self.get_profile(url)
      begin
        Linkedin::Company.new(url)
      rescue => e
        puts e
      end
    end

    def initialize(url)
      @linkedin_url = url
      @page = http_client.get(url)
    end

    def employees
      link = @page.body.match /\<a class\=\"density\".*<\/a\>/
      match_data = link.to_s.match /(?<employees>\d+)\<\/a\>$/
      match_data['employees'] if match_data
    end

    def http_client
      client = Mechanize.new do |agent|
        agent.user_agent_alias = USER_AGENTS.sample
        agent.max_history = 0
        cookie = Mechanize::Cookie.new :domain => '.linkedin.com', :name => 'RT', :value => 's=1398145741813&r=https%3A%2F%2Fwww.linkedin.com%2Fcompany%2F16439', :path => '/', :expires => (Date.today + 1.year).to_s
        agent.cookie_jar << cookie
        cookie = Mechanize::Cookie.new :domain => 'www.linkedin.com', :name => 'L1e', :value => '4a2dae59', :path => '/', :expires => (Date.today + 1.year).to_s
        agent.cookie_jar << cookie
        cookie = Mechanize::Cookie.new :domain => '.linkedin.com', :name => '_lipt', :value => "0_RyWe7Doi84VRESZfVg2mQxqv6_iKlNgNRj7teLlnFvzKND1i6DelZfgZk9G8UlCKPJuAHycqb9IqgSS256_ZqT5Cpp268wrlTpwn0O2GuFSGDEAlzX2k7Lcj0Hgc8ONJ", :path => '/', :expires => (Date.today + 1.year).to_s
        agent.cookie_jar << cookie
        cookie = Mechanize::Cookie.new :domain => '.www.linkedin.com', :name => 'JSESSIONID', :value => "ajax:6942950878984090187", :path => '/', :expires => (Date.today + 1.year).to_s
        agent.cookie_jar << cookie
        cookie = Mechanize::Cookie.new :domain => '.www.linkedin.com', :name => 'li_at', :value => "AQECAQzeGdkALub1AAABRYhf-K4AAAFFiM3VrktYrFTEYkPCrvkY-2IRL4TmyUIn52drrCM_11yMj31u2SnwEyL0XuAdTnI052mKT550LDuLSyjofsdRlj2ftuPDKhbbk8r2J1C_563yr7w7EI_ZXXc", :path => '/', :expires => (Date.today + 1.year).to_s
        agent.cookie_jar << cookie
        cookie = Mechanize::Cookie.new :domain => '.linkedin.com', :name => 'lidc', :value => "b=LB01:g=40:u=11:i=1398152362:t=1398201165:s=1981948530", :path => '/', :expires => (Date.today + 1.year).to_s
        agent.cookie_jar << cookie
        cookie = Mechanize::Cookie.new :domain => '.linkedin.com', :name => '__qca', :value => "P0-324668314-1397882598404", :path => '/', :expires => (Date.today + 1.year).to_s
        agent.cookie_jar << cookie
        cookie = Mechanize::Cookie.new :domain => 'www.linkedin.com', :name => 'visit', :value => "v=1&M", :path => '/', :expires => (Date.today + 1.year).to_s
        agent.cookie_jar << cookie
        cookie = Mechanize::Cookie.new :domain => '.www.linkedin.com', :name => 'bscookie', :value => "v=1&201404190441531732bd7c-191e-4242-8ba9-cbbbb4ecd32dAQEhtlZhQJ3sTI9FMH6P5vluL7b2U-yF", :path => '/', :expires => (Date.today + 1.year).to_s
        agent.cookie_jar << cookie
        cookie = Mechanize::Cookie.new :domain => '.linkedin.com', :name => 'bcookie', :value => "v=2&7bc202b8-0a63-43ff-82aa-7a02a4fc5bb7", :path => '/', :expires => (Date.today + 1.year).to_s
        agent.cookie_jar << cookie
        cookie = Mechanize::Cookie.new :domain => '.linkedin.com', :name => '_cb_ls', :value => '1', :path => '/', :expires => (Date.today + 1.year).to_s
        agent.cookie_jar << cookie
      end
    end
  end
end
