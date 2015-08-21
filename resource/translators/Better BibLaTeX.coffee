Translator.fieldMap = {
  # Zotero          BibTeX
  place:            { name: 'location', preserveCaps: true }
  chapter:          { name: 'chapter', preserveCaps: true }
  edition:          { name: 'edition', preserveCaps: true }
  title:            { name: 'title', preserveCaps: true }
  volume:           { name: 'volume', preserveCaps: true }
  rights:           { name: 'rights', preserveCaps: true }
  ISBN:             { name: 'isbn' }
  ISSN:             { name: 'issn' }
  url:              { name: 'url' }
  DOI:              { name: 'doi' }
  shortTitle:       { name: 'shorttitle', preserveCaps: true }
  abstractNote:     { name: 'abstract' }
  numberOfVolumes:  { name: 'volumes' }
  version:          { name: 'version' }
  conferenceName:   { name: 'eventtitle', preserveCaps: true }
  numPages:         { name: 'pagetotal' }
  type:             { name: 'type', preserveCaps: true }
}

Translator.typeMap = {
  # BibTeX                            Zotero
  'book booklet manual proceedings':  'book'
  'incollection inbook':              'bookSection'
  'article misc':                     'journalArticle magazineArticle newspaperArticle'
  thesis:                             'thesis'
  letter:                             'email letter'
  movie:                              'film'
  artwork:                            'artwork'
  # =online to fool the ridiculously stupid Mozilla code safety validator, as it thinks that any
  # object property starting with 'on' on any kind of object installs an event handler on a DOM
  # node
  '=online':                          'blogPost forumPost webpage'
  inproceedings:                      'conferencePaper'
  report:                             'report'
  legislation:                        'statute bill'
  jurisdiction:                       'case hearing'
  patent:                             'patent'
  audio:                              'audioRecording podcast'
  video:                              'videoRecording'
  software:                           'computerProgram'
  unpublished:                        'manuscript presentation'
  inreference:                        'encyclopediaArticle dictionaryEntry'
  misc:                               'interview map instantMessage tvBroadcast radioBroadcast document'
}

Translator.fieldEncoding = {
  url: 'verbatim'
  doi: 'verbatim'
  eprint: 'verbatim'
  eprintclass: 'verbatim'
  crossref: 'raw'
  xdata: 'raw'
  xref: 'raw'
  entrykey: 'raw'
  childentrykey: 'raw'
  verba: 'verbatim'
  verbb: 'verbatim'
  verbc: 'verbatim'
}

Language = new class
  constructor: ->
    @babelMap = {
      af: 'afrikaans'
      am: 'amharic'
      ar: 'arabic'
      ast: 'asturian'
      bg: 'bulgarian'
      bn: 'bengali'
      bo: 'tibetan'
      br: 'breton'
      ca: 'catalan'
      cop: 'coptic'
      cy: 'welsh'
      cz: 'czech'
      da: 'danish'
      de_1996: 'ngerman'
      de_at_1996: 'naustrian'
      de_at: 'austrian'
      de_de_1996: 'ngerman'
      de: ['german', 'germanb']
      dsb: ['lsorbian', 'lowersorbian']
      dv: 'divehi'
      el: 'greek'
      el_polyton: 'polutonikogreek'
      en_au: 'australian'
      en_ca: 'canadian'
      en: 'english'
      en_gb: ['british', 'ukenglish']
      en_nz: 'newzealand'
      en_us: ['american', 'usenglish']
      eo: 'esperanto'
      es: 'spanish'
      et: 'estonian'
      eu: 'basque'
      fa: 'farsi'
      fi: 'finnish'
      fr_ca: [
        'acadian'
        'canadian'
        'canadien'
      ]
      fr: ['french', 'francais']
      fur: 'friulan'
      ga: 'irish'
      gd: ['scottish', 'gaelic']
      gl: 'galician'
      he: 'hebrew'
      hi: 'hindi'
      hr: 'croatian'
      hsb: ['usorbian', 'uppersorbian']
      hu: 'magyar'
      hy: 'armenian'
      ia: 'interlingua'
      id: [
        'indonesian'
        'bahasa'
        'bahasai'
        'indon'
        'meyalu'
      ]
      is: 'icelandic'
      it$$: 'italian'
      ja: 'japanese'
      kn: 'kannada'
      la: 'latin'
      lo: 'lao'
      lt: 'lithuanian'
      lv: 'latvian'
      ml: 'malayalam'
      mn: 'mongolian'
      mr: 'marathi'
      nb: ['norsk', 'bokmal']
      nl: 'dutch'
      nn: 'nynorsk'
      no: ['norwegian', 'norsk']
      oc: 'occitan'
      pl: 'polish'
      pms: 'piedmontese'
      pt_br: ['brazil', 'brazilian']
      pt: ['portuguese', 'portuges']
      pt_pt: 'portuguese'
      rm: 'romansh'
      ro: 'romanian'
      ru: 'russian'
      sa: 'sanskrit'
      se: 'samin'
      sk: 'slovak'
      sl: ['slovenian', 'slovene']
      sq_al: 'albanian'
      sr_cyrl: 'serbianc'
      sr_latn: 'serbian'
      sr: 'serbian'
      sv: 'swedish'
      syr: 'syriac'
      ta: 'tamil'
      te: 'telugu'
      th: ['thai', 'thaicjk']
      tk: 'turkmen'
      tr: 'turkish'
      uk: 'ukrainian'
      ur: 'urdu'
      vi: 'vietnamese'
      zh_latn: 'pinyin'
      zh: 'pinyin'
      zlm: [
        'malay'
        'bahasam'
        'melayu'
      ]
    }
    for own key, value of @babelMap
      @babelMap[key] = [value] if typeof value == 'string'

    # list of unique languages
    @babelList = []
    for own k, v of @babelMap
      for lang in v
        @babelList.push(lang) if @babelList.indexOf(lang) < 0

    @cache = Object.create(null)

#  @polyglossia = [
#    'albanian'
#    'amharic'
#    'arabic'
#    'armenian'
#    'asturian'
#    'bahasai'
#    'bahasam'
#    'basque'
#    'bengali'
#    'brazilian'
#    'brazil'
#    'breton'
#    'bulgarian'
#    'catalan'
#    'coptic'
#    'croatian'
#    'czech'
#    'danish'
#    'divehi'
#    'dutch'
#    'english'
#    'british'
#    'ukenglish'
#    'esperanto'
#    'estonian'
#    'farsi'
#    'finnish'
#    'french'
#    'friulan'
#    'galician'
#    'german'
#    'austrian'
#    'naustrian'
#    'greek'
#    'hebrew'
#    'hindi'
#    'icelandic'
#    'interlingua'
#    'irish'
#    'italian'
#    'kannada'
#    'lao'
#    'latin'
#    'latvian'
#    'lithuanian'
#    'lsorbian'
#    'magyar'
#    'malayalam'
#    'marathi'
#    'nko'
#    'norsk'
#    'nynorsk'
#    'occitan'
#    'piedmontese'
#    'polish'
#    'portuges'
#    'romanian'
#    'romansh'
#    'russian'
#    'samin'
#    'sanskrit'
#    'scottish'
#    'serbian'
#    'slovak'
#    'slovenian'
#    'spanish'
#    'swedish'
#    'syriac'
#    'tamil'
#    'telugu'
#    'thai'
#    'tibetan'
#    'turkish'
#    'turkmen'
#    'ukrainian'
#    'urdu'
#    'usorbian'
#    'vietnamese'
#    'welsh'
#  ]

Language.get_bigrams = (string) ->
  s = string.toLowerCase()
  s = (s.slice(i, i + 2) for i in [0 ... s.length])
  s.sort()
  return s

Language.string_similarity = (str1, str2) ->
  pairs1 = @get_bigrams(str1)
  pairs2 = @get_bigrams(str2)
  union = pairs1.length + pairs2.length
  hit_count = 0

  while pairs1.length > 0 && pairs2.length > 0
    if pairs1[0] == pairs2[0]
      hit_count++
      pairs1.shift()
      pairs2.shift()
      continue

    if pairs1[0] < pairs2[0]
      pairs1.shift()
    else
      pairs2.shift()

  return (2 * hit_count) / union

Language.lookup = (langcode) ->
  if not @cache[langcode]
    @cache[langcode] = []
    for lc in Language.babelList
      @cache[langcode].push({ lang: lc, sim: @string_similarity(langcode, lc) })
    @cache[langcode].sort((a, b) -> b.sim - a.sim)

  return @cache[langcode]

Reference::hasCreator = (type) -> (@item.creators || []).some((creator) -> creator.creatorType == type)

doExport = ->
  Zotero.write('\n')
  while item = Translator.nextItem()
    ref = new Reference(item)

    ref.referencetype = 'inbook' if item.itemType == 'bookSection' and ref.hasCreator('bookAuthor')
    ref.referencetype = 'collection' if item.itemType == 'book' and not ref.hasCreator('author') and ref.hasCreator('editor')
    ref.referencetype = 'mvbook' if ref.referencetype == 'book' and item.numberOfVolumes

    if m = item.publicationTitle?.match(/^arxiv:\s*([\S]+)/i)
      ref.add({ name: 'eprinttype', value: 'arxiv'})
      ref.add({ name: 'eprint', value: m[1] })
      delete item.publicationTitle

    if m = item.url?.match(/^http:\/\/www.jstor.org\/stable\/([\S]+)$/i)
      ref.add({ name: 'eprinttype', value: 'jstor'})
      ref.add({ name: 'eprint', value: m[1] })
      delete item.url
      ref.remove('url')

    if m = item.url?.match(/^http:\/\/books.google.com\/books?id=([\S]+)$/i)
      ref.add({ name: 'eprinttype', value: 'googlebooks'})
      ref.add({ name: 'eprint', value: m[1] })
      delete item.url
      ref.remove('url')

    if m = item.url?.match(/^http:\/\/www.ncbi.nlm.nih.gov\/pubmed\/([\S]+)$/i)
      ref.add({ name: 'eprinttype', value: 'pubmed'})
      ref.add({ name: 'eprint', value: m[1] })
      delete item.url
      ref.remove('url')

    for eprinttype in ['pmid', 'arxiv', 'jstor', 'hdl', 'googlebooks']
      if ref.has[eprinttype]
        if not ref.has.eprinttype
          ref.add({ name: 'eprinttype', value: eprinttype})
          ref.add({ name: 'eprint', value: ref.has[eprinttype].value })
        ref.remove(eprinttype)

    if item.archive and item.archiveLocation
      archive = true
      switch item.archive.toLowerCase()
        when 'arxiv'
          ref.add({ name: 'eprinttype', value: 'arxiv' })           unless ref.has.eprinttype
          ref.add({ name: 'eprintclass', value: item.callNumber })

        when 'jstor'
          ref.add({ name: 'eprinttype', value: 'jstor' })           unless ref.has.eprinttype

        when 'pubmed'
          ref.add({ name: 'eprinttype', value: 'pubmed' })          unless ref.has.eprinttype

        when 'hdl'
          ref.add({ name: 'eprinttype', value: 'hdl' })             unless ref.has.eprinttype

        when 'googlebooks', 'google books'
          ref.add({ name: 'eprinttype', value: 'googlebooks' })     unless ref.has.eprinttype

        else
          archive = false

      if archive
        ref.add({ name: 'eprint', value: item.archiveLocation })    unless ref.has.eprint

    ref.add({ name: 'options', value: 'useprefix' }) if Translator.usePrefix

    ref.add({ name: 'number', value: item.reportNumber || item.seriesNumber || item.patentNumber || item.billNumber || item.episodeNumber || item.number })
    ref.add({ name: (if isNaN(parseInt(item.issue)) then 'issue' else 'number'), value: item.issue })

    if item.itemType == 'case'
      ref.add({ name: 'journaltitle', value: item.reporter, preserveCaps: true, preserveBibTeXVariables: true })

    if item.publicationTitle
      switch item.itemType
        when 'bookSection', 'conferencePaper', 'dictionaryEntry', 'encyclopediaArticle'
          ref.add({ name: 'booktitle', value: item.publicationTitle, preserveBibTeXVariables: true, preserveCaps: true})

        when 'magazineArticle', 'newspaperArticle'
          ref.add({ name: 'journaltitle', value: item.publicationTitle, preserveCaps: true, preserveBibTeXVariables: true})
          ref.add({ name: 'journalsubtitle', value: item.section, preserveCaps: true }) if item.itemType == 'newspaperArticle'

        when 'journalArticle'
          if ref.isBibVar(item.publicationTitle)
            ref.add({ name: 'journaltitle', value: item.publicationTitle, preserveBibTeXVariables: true })
          else
            abbr = Zotero.BetterBibTeX.keymanager.journalAbbrev(item)
            if Translator.useJournalAbbreviation and abbr
              ref.add({ name: 'journal', value: abbr, preserveBibTeXVariables: true, preserveCaps: true })
            else
              ref.add({ name: 'journaltitle', value: item.publicationTitle, preserveCaps: true })
              ref.add({ name: 'shortjournal', value: abbr, preserveBibTeXVariables: true, preserveCaps: true })

    ref.add({ name: 'booktitle', value: item.encyclopediaTitle || item.dictionaryTitle || item.proceedingsTitle, preserveCaps: true }) if not ref.has.booktitle

    ref.add({ name: 'titleaddon', value: item.websiteTitle || item.forumTitle || item.blogTitle || item.programTitle, preserveCaps: true })
    ref.add({ name: 'series', value: item.seriesTitle || item.series, preserveCaps: true })

    switch item.itemType
      when 'report', 'thesis'
        ref.add({ name: 'institution', value: item.publisher, preserveCaps: true })

      else
        ref.add({ name: 'publisher', value: item.publisher, preserveCaps: true })

    switch item.itemType
      when 'letter' then ref.add({ name: 'type', value: item.letterType || 'Letter', replace: true })

      when 'email'  then ref.add({ name: 'type', value: 'E-mail', replace: true })

      when 'thesis'
        thesisType = (item.type || '').toLowerCase().trim()
        if thesisType in ['phdthesis', 'mastersthesis']
          ref.referencetype = thesisType
          ref.remove('type')
        else
          ref.add({ name: 'type', value: item.type, replace: true })

      when 'report'
        if (item.type || '').toLowerCase().trim() == 'techreport'
          ref.referencetype = 'techreport'
        else
          ref.add({ name: 'type', value: item.type, replace: true })

      else
        ref.add({ name: 'type', value: item.type, replace: true })

    ref.add({ name: 'howpublished', value: item.presentationType || item.manuscriptType })

    ref.add({ name: 'note', value: item.meetingName, allowDuplicates: true })

    if item.creators and item.creators.length
      creators = {
        author: []
        bookauthor: []
        commentator: []
        editor: []
        editora: []
        editorb: []
        holder: []
        translator: []
      }

      for creator in item.creators
        switch creator.creatorType
          when 'author', 'interviewer', 'director', 'programmer', 'artist', 'podcaster', 'presenter'
            creators.author.push(creator)
          when 'bookAuthor'
            creators.bookauthor.push(creator)
          when 'commenter'
            creators.commentator.push(creator)
          when 'editor'
            creators.editor.push(creator)
          when 'inventor'
            creators.holder.push(creator)
          when 'translator'
            creators.translator.push(creator)
          when 'seriesEditor'
            creators.editorb.push(creator)
          else
            creators.editora.push(creator)

      for own field, value of creators
        ref.add({ name: field, value: value, enc: 'creators', preserveCaps: true })

      ref.add({ name: 'editoratype', value: 'collaborator' }) if creators.editora.length > 0
      ref.add({ name: 'editorbtype', value: 'redactor' }) if creators.editorb.length > 0

    ref.add({ name: 'urldate', value: Zotero.Utilities.strToISO(item.accessDate) }) if item.accessDate && item.url

    if item.date
      if Translator.verbatimDate.test(item.date) || typeof Zotero.Utilities.strToDate(item.date).year == 'undefined'
        ref.add({ name: 'date', value: item.date, preserveCaps: true })
      else
        ref.add({ name: 'date', value: Zotero.Utilities.strToISO(item.date) })

    ref.add({ name: 'pages', value: item.pages.replace(/[-\u2012-\u2015\u2053]+/g, '--' )}) if item.pages

    if item.language
      langlc = item.language.toLowerCase()
      language = Language.babelMap[langlc.replace(/[^a-z0-9]/, '_')]
      if language
        language = language[0]
      else
        sim = Language.lookup(langlc)
        if sim[0].sim >= 0.9 then language = sim[0].lang else language = null

      ref.add({ name: 'langid', value: language })

    ref.add({ name: (if ref.has.note then 'annotation' else 'note'), value: item.extra, allowDuplicates: true })
    ref.add({ name: 'keywords', value: item.tags, enc: 'tags' })

    if item.notes and Translator.exportNotes
      for note in item.notes
        ref.add({ name: 'annotation', value: Zotero.Utilities.unescapeHTML(note.note), allowDuplicates: true })

    ref.add({ name: 'file', value: item.attachments, enc: 'attachments' })
    ref.complete()

  Translator.exportGroups()
  Zotero.write('\n')
  return
