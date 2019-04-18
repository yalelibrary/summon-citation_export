#These are the mappings from which
#refworks will draw its tags. On the left is the refworks tag
#on the right an expression which will yield that value given
#a summon document.

#This is an exhaustive list of refworks fields according to:
#http://www.refworks.com/rwathens/help/RefWorks_Tagged_Format.htm
#so some mappings are inevitably going to be blank.

{
  RT: ->() { content_type_to_reference_type }, #Reference Type
  SR: blank, #Source Type (field is either Print(0) or  Electronic(1) )
  ID: blank, #Reference Identifier
  A1: ->() { authors.map(&:name) + corporate_authors.map(&:name) }, #Primary Authors
  T1: ->() { subtitle ? "#{title}: #{subtitle}" : title},   #Primary Title
  JF: ->() { publication_title }, #Periodical Full
  JO: blank, #Periodical Abbrev
  YR: ->() { publication_date.year.to_s }, #Publication Year
  FD: blank, #Publication Data, Free Form
  VO: ->() { volume }, #Volume
  IS: ->() { issue }, #Issue
  SP: ->() { start_page }, #Start Page
  OP: ->() { end_page }, #Other Pages
  K1: ->() { subject_terms.tag_per_value }, #Keyword
  AB: ->() { abstract }, #Abstract
  NO: ->() { isi_cited_references_count ? uri : url }, #Notes
  A2: blank, #Secondary Authors
  T2: blank, #Secondary Title
  ED: blank, #Edition
  PB: ->() { publisher }, #Publisher
  PP: ->() { publication_place }, #Place of Publication
  A3: blank, #Tertiary Authors
  A4: blank, #Quaternary Authors
  A5: blank, #Quinary Authors
  T3: blank, #Tertiary Title
  SN: ->() { issns.empty? ? isbns : issns }, #ISSN/ISBN
  AV: blank, #Availability
  AD: blank, #Author Address
  AN: blank, #Accession Number
  LA: ->() { languages }, #Language
  CL: blank, #Classification
  SF: blank, #Subfile/Database
  OT: blank, #Original Foreign Title
  LK: blank, #Links
  DO: ->() { doi }, #Digital Object Identifier
  CN: blank, #Call Number
  DB: blank, #Database
  DS: blank, #Data Source
  IP: blank, #Identifying Phrase
  RD: blank, #Retrieved Date
  ST: blank, #Shortened Title
  U1: blank, #User 1
  U2: blank, #User 2
  U3: blank, #User 3
  U4: blank, #User 4
  U5: ->() { [thumbnail_small, thumbnail_medium, thumbnail_large] if thumbnail_large}, #User 5
  U6: ->() { open_url }, #User 6
  U7: ->() { content_type }, #User 7
  U8: blank, #User 8
  U9: blank, #User 9
  U10: blank, #User 10
  U11: blank, #User 11
  U12: blank, #User 12
  U13: blank, #User 13
  U14: blank, #User 14
  U15: blank, #User 15
  UL: ->() { link }, #URL
  SL: blank, #Sponsoring Library
  LL: blank, #Sponsoring Library Location
  CR: blank, #Cited References
  WT: blank, #Website Title
  A6: blank, #Website editors
  WV: blank, #Website version
  WP: blank, #Date of Electronic Publication
  OL: blank, #Output Language (see codes for specific languages below)
  PMID: blank, #PMID
  PMCID: blank, #PMCID
}
