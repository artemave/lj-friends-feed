require 'key_struct'

class Entry < KeyStruct[:author, :title, :pub_date, :content, :link]
end
