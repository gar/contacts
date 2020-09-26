class NamedContactsController < ApplicationController
  before_action :set_named_contact_from_case_id, only: [:show, :new, :edit, :update, :destroy]

  def show
    if !@named_contact.persisted?
      redirect_to new_named_contact_path(case_id: params[:case_id])
    end
    log_action(:read, @named_contact)
  end

  def new
  end

  def edit
    log_action(:read, @named_contact)
  end

  def create
    @named_contact = NamedContact.new(named_contact_params.merge(case_id: params.fetch(:case_id)))

    if @named_contact.save
      log_action(:created, @named_contact)
      redirect_to named_contact_path(case_id: @named_contact.case_id),
                  notice: 'Named contact was successfully created.'
    else
      render :new
    end
  end

  def update
    if @named_contact.update(named_contact_params)
      log_action(:updated, @named_contact)
      redirect_to named_contact_path(case_id: @named_contact.case_id),
                  notice: 'Named contact was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @named_contact.destroy
    log_action(:deleted, @named_contact)

    redirect_to new_named_contact_path(case_id: params[:case_id]),
                notice: 'Named contact was successfully destroyed.'
  end

  private

  def set_named_contact_from_case_id
    @named_contact = NamedContact.find_or_initialize_by(case_id: params[:case_id])
  end

  def named_contact_params
    params.require(:named_contact)
          .permit(:title, :first_name, :last_name, :mobile_number, :address)
  end

  def log_action(action, model)
    AuditLogJob.perform_later(current_user.id,
                              action,
                              model.case_id,
                              model.saved_changes.keys)
  end
end
