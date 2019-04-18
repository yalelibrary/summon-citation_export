#These are the mappings from which
#refworks will draw its tags. On the left is the refworks tag
#on the right an expression which will yield that value given
#a summon document.

#This is an exhaustive list of standard and extended refer codes from:
#http://hcibib.org/refer.html
#so some mappings are inevitably going to be blank.

{
  '%0': ->() { content_type_to_endnote_type }, #Reference Type
  '%@': ->() { isbns },
  '%_@': ->() { issns },
  '%A': ->() { authors.map(&:name) }, #Primary Authors
  '%B': blank, # Book containing article
  '%C': ->() { publication_place }, #Place of Publication
  '%D': ->() { publication_date.to_s }, #Publication Year
  '%E': blank, # Editor of book containing article
  '%F': blank, # Footnote (useless?)
  '%G': blank, # Government ID, maybe ISSN/ISBN also?
  '%H': blank, # Header commentary (useless?) 
  '%I': ->() { publisher }, #Publisher
  '%J': ->() { publication_title }, #Periodical Full
  '%K': ->() { subject_terms.tag_per_value }, #Keyword
  '%L': blank, # label field used by -k option (keep clear)
  '%M': blank, # bell labs memo (id mnemonic?)
  '%N': ->() { issue }, #Issue
  '%O': blank, # Other commentary, field of last resort
  '%P': ->() { end_page }, # Last page = number of pages?
  '%Q': ->() { corporate_authors.map(&:name) }, # Corporate Authors
  '%R': blank, # Report/paper/thesis (unpublished)
  '%S': blank, # Series title
  '%T': ->() { subtitle ? "#{title}: #{subtitle}" : title},   #Primary Title
  '%U': ->() { link }, # Url
  '%V': ->() { volume }, #Volume
  '%X': ->() { abstract }, # Abstract
  '%Y': blank, # Table of Contents
  '%Z': blank, #References
}
