require 'rails_helper'

RSpec.describe "DateHelper" do
  describe "FORMATS DICTIONARY" do
    it "maps DD/MM/YYYY" do
      expect(
        Date.strptime("05/08/2020", DateHelper::FORMATS_DICTIONARY["DD/MM/YYYY".to_sym])
      ).to eq(Date.new(2020, 8, 5))
    end

    it "maps DD/MM/YY" do
      expect(
        Date.strptime("05/08/20", DateHelper::FORMATS_DICTIONARY["DD/MM/YY".to_sym])
      ).to eq(Date.new(2020, 8, 5))
    end

    it "maps MM/DD/YYYY" do
      expect(
        Date.strptime("08/05/2020", DateHelper::FORMATS_DICTIONARY["MM/DD/YYYY".to_sym])
      ).to eq(Date.new(2020, 8, 5))
    end

    it "maps MM/DD/YY" do
      expect(
        Date.strptime("08/05/20", DateHelper::FORMATS_DICTIONARY["MM/DD/YY".to_sym])
      ).to eq(Date.new(2020, 8, 5))
    end

    it "maps DDMMMYYYY" do
      expect(
        Date.strptime("5Aug2020", DateHelper::FORMATS_DICTIONARY["DDMMMYYYY".to_sym])
      ).to eq(Date.new(2020, 8, 5))
    end

    it "maps DDMMMYY" do
      expect(
        Date.strptime("5Aug2020", DateHelper::FORMATS_DICTIONARY["DDMMMYY".to_sym])
      ).to eq(Date.new(2020, 8, 5))
    end

    it "maps MM-DD-YYYY" do
      expect(
        Date.strptime("08-05-2020", DateHelper::FORMATS_DICTIONARY["MM-DD-YYYY".to_sym])
      ).to eq(Date.new(2020, 8, 5))
    end

    it "maps MM-DD-YY" do
      expect(
        Date.strptime("08-05-20", DateHelper::FORMATS_DICTIONARY["MM-DD-YY".to_sym])
      ).to eq(Date.new(2020, 8, 5))
    end

    it "maps DD-MM-YYYY" do
      expect(
        Date.strptime("05-08-2020", DateHelper::FORMATS_DICTIONARY["DD-MM-YYYY".to_sym])
      ).to eq(Date.new(2020, 8, 5))
    end

    it "maps DD-MM-YY" do
      expect(
        Date.strptime("05-08-20", DateHelper::FORMATS_DICTIONARY["DD-MM-YY".to_sym])
      ).to eq(Date.new(2020, 8, 5))
    end

    it "maps YYYY-MM-DD" do
      expect(
        Date.strptime("2020-08-05", DateHelper::FORMATS_DICTIONARY["YYYY-MM-DD".to_sym])
      ).to eq(Date.new(2020, 8, 5))
    end
  end

  describe "parse_date" do
    it "parses date according to FORMATS_DICTIONARY" do
      expect(
        DateHelper.parse_date("2020-08-05", "YYYY-MM-DD")
      ).to eq(Date.new(2020, 8, 5))
    end

    it "returns nil on incorrect format" do
      expect(
        DateHelper.parse_date("2020-05-08", "DD/MM/YY")
      ).to be_nil
    end
  end
end
