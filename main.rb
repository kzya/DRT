require 'sinatra'
require 'sinatra/reloader'
load './lib/select_sound_data.rb'
load './lib/ans_logger.rb'

Experiment_times = 10
Experiment_times.freeze

Public_path = 'http://localhost:4567/'

get '/' do
  erb :index
end


post '/sign_in' do
  @name      = params[:name]
  @gender    = params[:gender]
  @age_group = params[:age_group] 

  $logger = AnsLogger.new(@name, @gender, @age_group)

  erb :confirm
end


#FIXME: グローバル変数辞めたい
#ホントはうまく保持できそうだが、インスタンス変数だとルーティング毎に
#変数が変わるため、初回のみインスタンス化したものがうまく共有されない

before "/experiment/#{Experiment_times}" do
  $sound_data = SelectSoundData.new('./utils/list.txt')
  $sound_data.split_data
end


# Experiment_timesから0までのルーティング作成
(0..Experiment_times).to_a.reverse.each do |n|
  get "/experiment/#{n}" do
    d = $sound_data.select_rand
    sound_name = d[0] 
    
    #再生する音源をhtml側に伝えるため
    #sound_nameはログでも使う
    sound_name       = 'fao/' + "#{sound_name}" + '.wav'
    @sound_file_path = Public_path + sound_name

    # 正答ID
    @correct_ans = d[1]
    
    #view表示用解答例
    @first_candidate_id  = d[2] 
    @first_candidate     = d[3] 
    @second_candidate_id = d[4]
    @second_candidate    = d[5]

    #応答ID取得
    @user_ans = request[:user_ans]

    $logger.write_ans(sound_name, @correct_ans, @user_ans)

    @times = n
    if n == 0
      redirect to('/thanks')
    end

    erb :experiment
  end
end


get '/thanks' do
  "thanks!!!"
end
