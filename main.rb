require 'sinatra'
require 'sinatra/reloader'

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
  erb :confirm
end


# Experiment_timesから0までのルーティング作成
(0..Experiment_times).to_a.reverse.each do |n|
  get "/experiment/#{n}" do
    # TODO: ランダムで音再生

    # ファイル名
    # どうせcsvに吐き出すのでフルパスにした
    # rand_soundには040などの数字が入る
    # とりま決め打ち
    rand_sound = "040"
    @sound_file_name = Public_path + 'fao/' + "#{rand_sound}" + '.wav'

    # 正答ID
    
    # 混入ID

    #応答ID取得
    @user_ans = request[:user_ans]

    #応答表示
    
    #応答時刻

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

