#!/usr/bin/ruby
# -*- encoding : utf-8 -*-
# Script convert OSMO PIM contacts records (contacts_records.xml) to simple html format, using names as headers
# Using: ./osmoconv.rb dir
# Where dir  - directory whith osmo contacts_records.xml ~/.osmo usually

require 'rubygems'
require 'xmlsimple'
require 'awesome_print'

def html_header(site='Contact book.')
  return <<END_OF_HTML
<html>
  <head>
  <meta charset="utf-8" />
    <title>#{site}</title>
  </head>
  <body>
END_OF_HTML
end

def html_footer()
  return <<END_OF_HTML
    </div>
  </body>
</html>
END_OF_HTML
end

def main(dir)
	xml = XmlSimple.xml_in("#{dir}/contacts_records.xml", { 'KeyAttr' => 'record' })

	contacts = {}
	output = ""

	#ap xml['contacts_records'][0]

	xml['contacts_records'][0]['record'].each do |contact|

		contact.keys.each do |key|
			cont = contact[key][0]
			contact[key] = cont
			contact.delete(key) if cont == "0" || cont == "(None)" || cont == "None"
		end

		output << "<h1>"
		output << contact['last_name'] + " " if contact['last_name']
		output << contact['first_name'] + " " if contact['first_name']
		output << contact['second_name'] if contact['second_name']
		output << "</h1>"
		output << contact['birthday_date'] + "<br> \n" if contact['birthday_date']
		output << contact['home_phone_1'] + "<br> \n" if contact['home_phone_1']
		output << contact['cell_phone_1'] + "<br> \n" if contact['cell_phone_1']
		output << contact['work_phone_1'] + "<br> \n" if contact['work_phone_1']
		output << contact['work_fax'] + "<br> \n" if contact['work_fax']
		output << contact['home_postcode'] + " " if contact['home_postcode']
		output << contact['home_city'] + " " if contact['home_city']
		output << contact['home_address'] + "<br> \n" if contact['home_address']
		output << contact['home_state'] + "<br> \n" if contact['home_state']
		output << contact['work_postcode'] + "<br> \n" if contact['work_postcode']
		output << contact['work_city'] + " " if contact['work_city']
		output << contact['work_address'] + "<br> \n" if contact['work_address']
		output << contact['work_state'] + "<br> \n" if contact['work_state']
		output << contact['nickname'] + "<br> \n" if contact['nickname']
		output << contact['organization'] + "<br> \n" if contact['organization']
		output << contact['department'] + "<br> \n" if contact['department']
		output << contact['email_1'] + "<br> \n" if contact['email_1']
		output << contact['www_1'] + "<br> \n" if contact['www_1']
		output << contact['tags'] + "<br> \n" if contact['tags']
		output << contact['additional_info'] + "<br> \n" if contact['additional_info'] 
	end

	return output
end

puts html_header()
puts main(ARGV[0])
puts html_footer()
