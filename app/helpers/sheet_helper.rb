module SheetHelper
  class CSV
    attr_reader :sheet_file

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

  class XLS
    attr_reader :sheet_file

    def initialize(sheet_file)
      @sheet_file = sheet_file
    end

    def read(row, col)
      @sheet_file[row, col]
    end

    def update_cell(row, col, content)
      @sheet_file[row, col] = content
    end
  end
end
