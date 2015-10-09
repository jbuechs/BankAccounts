require './lib/account'

module Bank
  class MoneyMarketAccount < SavingsAccount
    MAX_TRANSACTIONS = 6
    MIN_BALANCE = 1000000
    FEE = 10000
    def initialize(id, balance, open_date = "today", owner = nil)
      super(id, balance, open_date, owner)
      if balance.to_i < MIN_BALANCE
        raise ArgumentError.new("You may not create an account below the minimum balance.")
      end
      @type = "Money Market"
      @transactions = 0
    end

    def withdraw(amount)
      # Too many transactions
      if @transactions >= 6
        puts "You have already made #{@transactions} transactions this month. Sorry!"
      elsif @balance >= MIN_BALANCE
        @transactions += 1
        if @balance - amount > MIN_BALANCE
          super(amount, false, false)
        else
          super(amount, false)
        end
      # Print error message for not having enough funds to withdraw
      else
        puts "You may not do any more withdrawals until your balance is above " + Money.new(MIN_BALANCE, "USD").format
      end
      return @balance
    end

    def reset_transactions
      puts "It's the dawn of a new month and your transactions are back to 0!"
      @transactions = 0
    end

    def deposit(amount)
      @transactions += 1 if @balance >= MIN_BALANCE
      super(amount)
      puts "Transactions: #{@transactions}"
    end

    def add_interest(rate)
      super(rate)
    end

  end
end
