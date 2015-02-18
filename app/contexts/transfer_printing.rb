class TransferPrinting
  extend Surrounded::Context

  attr_reader :printer

  def initialize(account, params = {})

    map_roles([[:printer, account]])
    super()
  end

  trigger :print do
    printer.print_transfer_result
  end

  private

  Printer = TransferPrinting::Printer
end
