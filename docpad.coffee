# DocPad Configuration File
# http://docpad.org/docs/config

# Define the DocPad Configuration
docpadConfig = {
  plugins:
    rss:
      default:
        collection: 'posts'
        url: 'http://andyj.github.io/rss.xml' # optional, this is the default
    ghpages:
      deployRemote: 'origin'
      deployBranch: 'master'


  # enabled example for different environments
  environments:
    development: # change the name here if you have other environments
      plugins:
        livereload:
          enabled: true

    development:
        templateData:
            site:
                url: 'http://andyj.github.io'

  collections:
      posts: ->
        @getCollection("html").findAllLive({relativeOutDirPath: 'posts'},[{date:-1}]).on "add", (model) ->
                model.setMetaDefaults({layout:"post"})

      projects: ->
        @getCollection("html").findAllLive({relativeOutDirPath: 'projects',isPage:true})

      frontpage: ->
        @getCollection("html").findAllLive({relativeOutDirPath: $in: ['posts','projects']},[{date: -1}])


    templateData:
        site:
            title: "My Website"

        getPreparedTitle: -> if @document.title then "#{@document.title} | #{@site.title}" else @site.title
}

# Export the DocPad Configuration
module.exports = docpadConfig
