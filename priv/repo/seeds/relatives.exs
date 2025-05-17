alias NimbleCSV.RFC4180, as: CSV

csv = """
anzai-kyoko,mihashi-tatsuya,spouse,0
chiaki-minoru,sasaki-katsuhiko,son,1
chiaki-minoru,sasaki-takamaru,father_in_law,2
dan-ikuma,dan-ino,father,1
dan-ikuma,dan-takuma,grandfather,2
dunham-robert,frost-emiko,daughter,0
echigo-ken,terasawa-hiroko,spouse,0
funato-jun,iwai-yumi,spouse,0
hirata-akihiko,kuga-yoshiko,spouse,0
ito-emi,sawada-kenji,spouse,0
ito-jerry,senda-koreya,uncle,0
kayama-yuzo,uehara-ken,father,0
koseki-yuji,uchiyama-kinko,spouse,0
kuga-yoshiko,hirata-akihiko,spouse,0
kurobe-susumu,yoshimoto-takami,daughter,0
kusabue-mitsuko,akutagawa-yasushi,spouse,0
mihashi-tatsuya,anzai-kyoko,spouse,0
mizuno-junichi,mizuno-kumi,mother,0
mizuno-kumi,mizuno-junichi,son,0
nakagawa-anna,senda-koreya,grandfather,0
nakajima-haruo,nakajima-sonoe,daughter,0
nakakita-chieko,tanaka-tomoyuki,spouse,0
otowa-nobuko,shindo-kaneto,spouse,0
sasaki-katsuhiko,chiaki-minoru,father,1
sasaki-katsuhiko,sasaki-takamaru,grandfather,2
sasaki-takamaru,chiaki-minoru,son_in_law,1
sasaki-takamaru,sasaki-katsuhiko,grandson,2
sato-shimako,yamazaki-takashi,spouse,0
senda-koreya,ito-jerry,nephew,1
senda-koreya,nakagawa-anna,granddaughter,2
shindo-kaneto,otowa-nobuko,spouse,0
shirakawa-yumi,nitani-hideaki,spouse,0
takarada-akira,kojima-akiko,spouse,0
takashima-masahiro,takashima-tadao,father,0
takashima-masanobu,takashima-tadao,father,0
takashima-tadao,takashima-michio,son,1
takashima-tadao,takashima-masahiro,son,2
takashima-tadao,takashima-masanobu,son,3
tanaka-tomoyuki,nakakita-chieko,spouse,0
taniguchi-senkichi,mizuki-yoko,spouse,1
taniguchi-senkichi,wakayama-setsuko,spouse,2
taniguchi-senkichi,yachigusa-kaoru,spouse,3
tsuburaya-eiji,tsuburaya-masano,spouse,0
uehara-ken,kozakura-yoko,spouse,1
uehara-ken,obayashi-masami,spouse,2
uehara-ken,kayama-yuzo,son,0
wakayama-setsuko,taniguchi-senkichi,spouse,0
yachigusa-kaoru,taniguchi-senkichi,spouse,0
yamazaki-takashi,sato-shimako,spouse,0
yoshimoto-takami,kurobe-susumu,father,0
adams-nick,nugent-carol,spouse,0
"""

csv
|> CSV.parse_string(skip_headers: false)
|> Enum.map(fn [self_slug, relative_slug, relationship, order] ->
  self = Cineaste.Library.get_person_by_slug!(self_slug)
  relative = Cineaste.Library.get_person_by_slug!(relative_slug)

  %{
    self_id: self.id,
    relative_id: relative.id,
    relationship: relationship,
    order: order
  }
end)
|> Ash.bulk_create!(Cineaste.Library.PersonRelative, :create, return_errors?: true)
