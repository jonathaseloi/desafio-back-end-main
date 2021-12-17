module Api
  module V1
    class RegistrationsQueueController < ApplicationController
      def create
        NewRegistrationWorker.perform_async("", create_params.to_h)
      end

      private

      def create_params
        params.require(:account)
              .permit(:name, :from_partner, :many_partners, :entities, entities: [:name, :users, users: %i[email first_name last_name phone]])
      end
    end
  end
end
