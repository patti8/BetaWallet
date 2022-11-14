class DashboardController < UserController
  
  def activity
    
    @transaction = Transaction.where(
      source_wallet: current_user.id
    )
  
  end
  
end
