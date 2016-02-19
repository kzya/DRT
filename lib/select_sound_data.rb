class SelectSoundData
  def initialize(sound_list_file_path)
    @sound_list_file = sound_list_file_path
    @data = []
  end

  def split_data
    # 二次元配列
    # @data[0] で一行目にアクセスできる
    # @data[0][0] で一行目のファイル名にアクセス
    begin
      File.open(@sound_list_file) do |file|
        file.each_line do |s|
          data = s.encode("UTF-8", "Shift_JIS").split
          @data.push(data) 
        end
      end
    rescue SystemCallError => e
      puts %Q(class=[#{e.class}] message=[#{e.message}])
    rescue IOError => e
      puts %Q(class=[#{e.class}] message=[#{e.message}])
    end
  end

  def select_rand
    #ランダムにsound_list_fileの一行分づつ返す(一つのデータのまとまり)
    @data.shuffle!
    @data.pop
  end
end
