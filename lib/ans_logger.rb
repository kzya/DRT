# 評価結果出力ファイルの設定
#
# 現在の出力ファイル仕様は以下のとおり
# Name: 名前
# Gender: 性別({male|female})
# AgeGroup: 年齢グループ([1-4])
# ファイル名, 正答ID, 混入ID, 応答ID, 応答表示, 応答時刻(秒単位、24時間制)
class AnsLogger
  LOG_PATH = "utils/log/"

  def initialize(user_name, gender, age_group)
    #ファイルが存在しない場合(初回時)
    unless File.exist?("#{LOG_PATH}#{user_name}.txt")
      File.open("#{LOG_PATH}#{user_name}.txt","w") do |file|
        file.puts("Name: #{user_name}")
        file.puts("Gender: #{gender}")
        file.puts("AgeGroup: #{age_group}")
      end
    end
    @user_name = user_name
  end

  def write_ans(sound_name, correct, user_ans)
    File.open("#{LOG_PATH}#{@user_name}.txt","a") do |file|
      s = "#{sound_name}, #{correct}, #{user_ans}"
      file.puts(s)
    end
  end
end
