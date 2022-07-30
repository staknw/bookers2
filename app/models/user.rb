class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
# database_authenticatable（パスワードの正確性を検証）
# registerable（ユーザ登録や編集、削除）
# recoverable（パスワードをリセット)　デフォルト
# rememberable（ログイン情報を保存）　デフォルト
# validatable（email のフォーマットなどのバリデーション）

validates :name, length: { in: 2..20 }


# 0文字だとフラッシュメッセージが表示されてしまう
# validates :introduction, length: { in: 1..50 }


# 0文字でも15文字以下ならフラッシュメッセージは表示されない
validates :introduction, length: { maximum: 50 }



# nameが存在しているかを確認するバリデーション
  validates :name, presence: true
  # 一意性
  validates :name, uniqueness: true

  has_one_attached :profile_image

# Userモデルに対してbookモデルが1:Nになるよう関連付ける
# has_manyメソッド↓直訳「たくさんbookを持っている」
# dependent::destroyは「1:Nの1側が削除されたときN側を全て削除する」という機能が追加される.
# 「Userが削除された時に、そのUserが投稿したbookが全て削除される」
  has_many :books, dependent: :destroy

# 下の(width,height)を記述さないとエラーが出る
  # def get_profile_image(width,height)
  # unless profile_image.attached?
  #   file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
  #   profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  # end
  # profile_image.variant(resize_to_limit: [width, height]).processed
  # end

   def get_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image
  end













end