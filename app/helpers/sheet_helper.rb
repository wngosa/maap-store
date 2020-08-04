module SheetHelper
  class CSVHelper
    def initialize(sheet_file)
      @sheet_file = sheet_file
    end

    def read(row, col)
      @sheet_file[row][col]
    end

    def update_cell(row, col, content)
      @sheet_file[row][col] = content
    end
  end

  class XLSHelper
    def initialize(worksheet)
      @worksheet = worksheet
    end

    def read(row, col)
      @worksheet[row, col]
    end

    def update_cell(row, col, content)
      @worksheet[row, col] = content
    end
  end
end
