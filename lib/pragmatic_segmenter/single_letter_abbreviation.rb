# -*- encoding : utf-8 -*-

module PragmaticSegmenter
  # This class searches for periods within an abbreviation and
  # replaces the periods.
  class SingleLetterAbbreviation
    # Rubular: http://rubular.com/r/e3H6kwnr6H
    SingleUpperCaseLetterAtStartOfLineRule = Rule.new(/(?<=^[A-Z])\.(?=\s)/, '∯')

    # Rubular: http://rubular.com/r/gitvf0YWH4
    SingleUpperCaseLetterRule = Rule.new(/(?<=\s[A-Z])\.(?=\s)/, '∯')

    attr_reader :text
    def initialize(text:)
      @text = text
    end

    def replace
      @formatted_text = replace_single_letter_abbreviations(text)
    end

    private

    def replace_single_letter_abbreviations(txt)
      new_text = replace_single_uppercase_letter_abbreviation_at_start_of_line(txt)
      replace_single_uppercase_letter_abbreviation(new_text)
    end

    def replace_single_uppercase_letter_abbreviation_at_start_of_line(txt)
      txt.apply(SingleUpperCaseLetterAtStartOfLineRule)
    end

    def replace_single_uppercase_letter_abbreviation(txt)
      txt.apply(SingleUpperCaseLetterRule)
    end
  end
end
