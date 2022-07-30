class Book < ApplicationRecord
  # 従属する側のモデルにbelongs_toを記述し、
# 従属させる側のモデルにhas_oneを記述する
# ここではpetと飼い主の関係で記述


# bookモデルにはActiveStoreageを使って画像を持たせるため以下追記
# userがimageを所有している関係
  # has_one_attached :imageいらない、userモデルに移った

 # petはuserによって所有されている(飼われている)
  belongs_to :user

  validates :body, length: { in: 1..200 }


 # titleが存在しているかを確認するバリデーション
  validates :title, presence: true
  # bodyが存在しているかを確認するバリデーション
  validates :body, presence: true



end
