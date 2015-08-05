class ContactSharesController < ApplicationController


  def create
    contact_shares = ContactShare.new(contact_shares_params)
    if contact_shares.save
      render json: contact_shares
    else
      render(
        json: contact_shares.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def destroy
    @contact_shares = ContactShare.find(params[:id])
    contact_shares = @contact_shares
    @contact_shares.destroy!
    render json: contact_shares
  end

  def contact_shares_params
    params.require(:contact_share).permit(:user_id, :contact_id)
  end
end
