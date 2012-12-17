require 'spec_helper'
require 'xmlsimple'
# spam combination rules:
#a1b1c1d  <-- O
#a1b1c2d  <-- 1st
#a1b1c3d
#a1b2c1d
#a1b2c2d  <-- 4th
#....
#a3b2c3d  <-- 17th
#giasudientu.com a1b1c1d  <-- 18th
#....

describe SpamCombination do 
	before :each do
		@spamCom = SpamCombination.new "spec/spam_dictionary.xml"
	end
	describe "#new" do 
		it "takes one parameter and return a spam cobination object" do
			@spamCom.should be_an_instance_of SpamCombination
		end
		it "returns the right first name item in the collection" do
			@spamCom.spamXML['username'][0].should eql "Tue"
		end
	end
	describe "#getCombination" do
		it "returns the right first Content combination of the spam collection" do
			expected = {"name"=>"Tue","mail"=>'bomot114@yahoo.com',
						"web"=>"tienganhinfo.com","content"=>"a1b1c1d"}
			@spamCom.getCombination(0,0,0,0).should eql expected	
		end
		
		it "returns the right 4_th Content combination of the spam collection" do
			expected = {"name"=>"Tue","mail"=>'bomot114@yahoo.com',
						"web"=>"tienganhinfo.com","content"=>"a1b2c2d"}
			@spamCom.getCombination(0,0,0,4).should eql expected
		end
		it "returns the right 17_th Content combination of the spam collection" do
			expected = {"name"=>"Tue","mail"=>'bomot114@yahoo.com',
						"web"=>"tienganhinfo.com","content"=>"a3b2c3d"}
			@spamCom.getCombination(0,0,0,17).should eql expected
		end
		it "returns the right mixed combination of name, mail, website, content" do
			expected = {"name"=>"Phuong","mail"=>'thientai@xyz.com',
						"web"=>"giasudientu.com","content"=>"a3b2c2d"}
			@spamCom.getCombination(1,1,1,16).should eql expected
		end		


	end
	describe "#getCombinationByOneNumber" do
		it "take one parameter and returns the right mixed combination 
			of name, mail, website, content" do
			expected = {"name"=>"Phuong","mail"=>'thientai@xyz.com',
						"web"=>"giasudientu.com","content"=>"a3b2c3d"}
			@spamCom.getCombinationByOneNumber(143).should eql expected
		end
	end


end



