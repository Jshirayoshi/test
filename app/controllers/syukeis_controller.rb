class SyukeisController < ApplicationController
  def office
   str =
   [
    ["送信先", "メールアドレスを入力:例 a@a.com,b@b.com"],
    ["報告者氏名", "名字", "名前"],
    ["稼働店舗", "メールに記載されている店舗名を入力。例:アピタ稲沢"]
   ];

   name =
   [
    "send[]",
    "name[]",
    "tenpo[]"
   ];

   val =
   [
    "0",
    "0",
    "0"
   ];


   val.append("0")
   name.append("p0[]")
   str.append(["SB","新規","新規内スマホ","MNP","MNP内スマホ","機変","機変内スマホ"])
   val.append("0")
   name.append("p1[]")
   str.append(["au","新規","新規内スマホ","MNP","MNP内スマホ","機変","機変内スマホ"])
   val.append("0")
   name.append("p2[]")
   str.append(["docomo","タブ","新規","新規内スマホ","MNP","MNP内スマホ","機変","機変内スマホ"])
   val.append("0")
   name.append("p3[]")
   str.append(["稼働形態","DRもしくはASと入力"])
   val.append("1")
   name.append("p4[]")
   str.append(["感想","良いこと","悪いこと","一言"])

   @str = str;
   @val = val;
   @name = name;
  end

  def calc
   send  = params[:send]
   name  = params[:name]
   tenpo = params[:tenpo]
   p0 = params[:p0]
   p1 = params[:p1]
   p2 = params[:p2]
   p3 = params[:p3]
   p4 = params[:p4]

   dt = Date.today
   week = ['日', '月','火','水','木','金','土']

   system("mkdir ./report")
   file_name = "./report/#{dt}-#{name[0]}#{name[1]}.csv"
   subject   = "#{dt.month}/#{dt.day} #{week[dt.wday]}曜日 #{tenpo[0]}店 #{name[0]}"

   File.open(file_name, 'w') do |f|
     res = "#{dt},#{name[0]}#{name[1]},#{tenpo[0]},"
     p0.size.times do |i|
        res = res + p0[i] + ","
     end
     p1.size.times do |i|
        res = res + p1[i] + ","
     end
     p2.size.times do |i|
        res = res + p2[i] + ","
     end
     p3.size.times do |i|
        res = res + p3[i] + ","
     end
     p4.size.times do |i|
        res = res + p4[i] + ","
     end
     f.puts("日付,報告者,稼働店舗,SB@新規,SB@新規内スマホ,SB@MNP,SB@MNP内スマホ,SB@機変,SB@機変内スマホ,au@新規,au@新規内スマホ,au@MNP,au@MNP内スマホ,au@機変,au@機変内スマホ,docomo@タブ,docomo@新規,docomo@新規内スマホ,docomo@MNP,docomo@MNP内スマホ,docomo@機変,docomo@機変内スマホ,稼働形態@DRもしくはASと入力,感想@良いこと,感想@悪いこと,感想@一言")
     res.slice!(-1, 1)
     f.puts(res)
   end

   if send[0] == "hazime"
      send[0] = "h.yokoi@hazime.biz,d.chosa@hazime.biz"
   end

   mail_from = 'shiyoshic@gmail.com'
   mail_pass = 'etgrsumnkjewlkzs'
   mail_to   = "#{send[0]}"
   mail_subject = subject

   Mail.defaults do
    delivery_method :smtp, {
        :address => 'smtp.gmail.com',
        :port => 587,
        :domain => 'example.com',
        :user_name => "#{mail_from}",
        :password => "#{mail_pass}",
        :authnetication => :login,
        :enable_starttls_auto => true
    }
   end

   mail = Mail.new do
     from       "#{mail_from}"
     to         "#{mail_to}"
     subject    "#{mail_subject}"
     body       "お疲れ様です。
本日の個人活動報告になります。
ご確認宜しくお願い致します。

報告者：#{name[0]} #{name[1]}"
   end

   mail.charset = "UTF-8"
   mail.content_transfer_encoding = "8bit"
   mail.add_file(file_name)
   mail.deliver

   system("rm #{file_name}")

  end
end
