module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    # とあるユーザーが接続したときに呼ばれる
    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      # 別の場所で cookies.signed[:user_id]が入っている前提
      if verified_user = User.find_by(id: cookies.signed[:user_id])
        verified_user
      else
        # ActionCableの接続を切るメソッド
        reject_unauthorized_connection
      end
    end
  end
end
