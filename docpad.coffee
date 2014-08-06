# DocPad Configuration File
# http://docpad.org/docs/config

# Define the DocPad Configuration
docpadConfig = {
  plugins:
    rss:
      default:
        collection: 'posts'
        url: '/rss.xml' # optional, this is the default
    ghpages:
      deployRemote: 'docpad'
      deployBranch: 'master'
  # enabled example for different environments
  environments:
    development: # change the name here if you have other environments
      plugins:
        livereload:
          enabled: false

    staging: # change the name here if you have other environments
      plugins:
        livereload:
          enabled: true

  collections:
      posts: ->
        @getCollection("html").findAllLive({relativeOutDirPath: 'posts'},[{date:-1}]).on "add", (model) ->
                model.setMetaDefaults({layout:"post"})

      pages: ->
          @getCollection("html").findAllLive({relativeOutDirPath: 'pages',isPage:true})

    templateData:
        site:
            title: "My Website"

        getPreparedTitle: -> if @document.title then "#{@document.title} | #{@site.title}" else @site.title
}

# Export the DocPad Configuration
module.exports = docpadConfig
