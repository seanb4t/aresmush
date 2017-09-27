module AresMUSH
  module Website
    class PageListMarkdownExtension
      def self.regex
        /\[\[pagelist ([^\]]*)\]\]/i
      end
      
      def self.parse(matches, sinatra)
        input = matches[1]
        tags = (input || "").split(" ")

        or_tags = tags.select { |tag| !tag.start_with?("-") && !tag.start_with?("+")}

        required_tags = tags.select { |tag| tag.start_with?("+") }
        .map { |tag| tag.after("+") }

        exclude_tags = tags.select { |tag| tag.start_with?("-") }
        .map { |tag| tag.after("-") }

        matches = WikiPage.all.select { |p| 
          ((p.tags & or_tags).any? && 
          (p.tags & exclude_tags).empty?) &&
          (required_tags & p.tags == required_tags) 
        }

        sinatra.erb :"wiki/page_list", :locals => {
          pages: matches
        }
      end
    end
  end
end