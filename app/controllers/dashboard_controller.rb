class DashboardController < UserController
  
  def activity
    
    @transaction = Transaction.where(
      source_wallet: current_user.id
    ).or(Transaction.where(target_wallet: current_user.id))
      .order(created_at: :desc)
  
  end
  
end
