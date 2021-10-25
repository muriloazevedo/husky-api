class InvoicesController < ApplicationController

  def index
    Invoice.all
  end
end
