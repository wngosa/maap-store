module DateHelper
  FORMATS_DICTIONARY = {
    'DD/MM/YYYY': '%d/%m/%Y',
    'DD/MM/YY': '%d/%m/%y',
    'MM/DD/YYYY': '%m/%d/%Y',
    'MM/DD/YY': '%m/%d/%y',
    'DDMMMYYYY': '%d%b%Y',
    'DDMMMYY': '%d%b%y',
    'MM-DD-YYYY': '%m-%d-%Y',
    'MM-DD-YY': '%m-%d-%y',
    'DD-MM-YYYY': '%d-%m-%Y',
    'DD-MM-YY': '%d-%m-%y',
    'YYYY-MM-DD': '%Y-%m-%d'
  }.freeze

  def self.parse_date(date, format)
    return date if date.is_a?(DateTime) || date.is_a?(Date)

    Date.strptime(date, FORMATS_DICTIONARY[format.to_sym])
  rescue ArgumentError, TypeError
    nil
  end
end
