module PragmaticSegmenter
  module Languages
    class Arabic
      class Process < PragmaticSegmenter::Process
        private

        def sentence_boundary_punctuation(txt)
          PragmaticSegmenter::Languages::Arabic::SentenceBoundaryPunctuation.new(text: txt).split
        end

        def replace_abbreviations(txt)
          PragmaticSegmenter::Languages::Arabic::AbbreviationReplacer.new(text: txt).replace
        end

        def punctuation_array
          PragmaticSegmenter::Languages::Arabic::Punctuation.new.punct
        end
      end

      class Cleaner < PragmaticSegmenter::Cleaner
      end

      class SentenceBoundaryPunctuation < PragmaticSegmenter::SentenceBoundaryPunctuation
        SENTENCE_BOUNDARY = /.*?[:\.!\?؟،]|.*?\z|.*?$/

        # Rubular: http://rubular.com/r/RX5HpdDIyv
        ReplaceColonBetweenNumbersRule = Rule.new(/(?<=\d):(?=\d)/, '♭')

        # Rubular: http://rubular.com/r/kPRgApNHUg
        ReplaceNonSentenceBoundaryCommaRule = Rule.new(/،(?=\s\S+،)/, '♬')

        def split
          txt = replace_non_sentence_boundary_punctuation(text)
          txt.scan(SENTENCE_BOUNDARY)
        end

        private

        def replace_non_sentence_boundary_punctuation(txt)
          txt.apply(ReplaceColonBetweenNumbersRule).
              apply(ReplaceNonSentenceBoundaryCommaRule)
        end
      end

      class Abbreviation < PragmaticSegmenter::Abbreviation
        ABBREVIATIONS = ['ا', 'ا. د', 'ا.د', 'ا.ش.ا', 'ا.ش.ا', 'إلخ', 'ت.ب', 'ت.ب', 'ج.ب', 'جم', 'ج.ب', 'ج.م.ع', 'ج.م.ع', 'س.ت', 'س.ت', 'سم', 'ص.ب.', 'ص.ب', 'كج.', 'كلم.', 'م', 'م.ب', 'م.ب', 'ه', 'د‪']

        def all
          ABBREVIATIONS
        end

        def prepositive
          []
        end

        def number
          []
        end
      end

      class Punctuation < PragmaticSegmenter::Punctuation
        PUNCT = ['?', '!', ':', '.', '؟', '،']

        def punct
          PUNCT
        end
      end

      class AbbreviationReplacer  < PragmaticSegmenter::AbbreviationReplacer
        private

        def scan_for_replacements(txt, am, index, character_array, abbr)
          replace_abbr(txt, am)
        end

        def replace_abbr(txt, abbr)
          txt.gsub(/(?<=#{abbr})\./, '∯')
        end

        def abbreviations
          PragmaticSegmenter::Languages::Arabic::Abbreviation.new
        end
      end
    end
  end
end
