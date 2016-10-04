class QuestionsSwaggerController < Api::QuestionsController

swagger_path '/questions/{id}.json' do
    operation :get do
      key :description, "Returns a single question by ID." \
                        "</br> **question**:" \
                        "</br> #{"&nbsp;"*4} **id**: Question ID" \
                        "</br> #{"&nbsp;"*4} **body**: Jeopardy! clue" \
                        "</br> #{"&nbsp;"*4} **response**: Jeopardy! answer" \
                        "</br> #{"&nbsp;"*4} **value**: Question dollar value; Final Jeopardy questions have 0 value" \
                        "</br> #{"&nbsp;"*4} **category**: Category of question" \
                        "</br> #{"&nbsp;"*8} **id**: Category ID" \
                        "</br> #{"&nbsp;"*8} **name**: Category name" \
                        "</br> #{"&nbsp;"*8} **url**: link to category" \
                        "</br> #{"&nbsp;"*4} **from_round**: Information on round in which question appeared" \
                        "</br> #{"&nbsp;"*8} **id**: Round ID" \
                        "</br> #{"&nbsp;"*8} **name**: Jeopardy!, Double Jeopardy! or Final Jeopardy!" \
                        "</br> #{"&nbsp;"*8} **url**: link to round" \
                        "</br> #{"&nbsp;"*8} **from_show**: Information on show in which round appeared" \
                        "</br> #{"&nbsp;"*12} **id**: Show ID" \
                        "</br> #{"&nbsp;"*12} **show_number**: Jeopardy! show number" \
                        "</br> #{"&nbsp;"*12} **air_date**: Date the show aired YYYY-DD-MM" \
                        "</br> #{"&nbsp;"*12} **url**: link to show"
      key :operationId, 'findQuestionById'
      key :tags, [
        'question'
      ]
      parameter do
        key :name, :id
        key :in, :path
        key :description, 'ID of question to fetch'
        key :required, true
        key :type, :integer
        key :format, :int64
      end
      response 200 do
        key :description, 'question response'
        schema do
          key :'$ref', :Question_response
        end
      end
      response :default do
        key :description, 'unexpected error'
        schema do
          key :'$ref', :ErrorModel
        end
      end
    end
  end

  swagger_path '/questions/random.json' do
    operation :get do
      key :description, 'Returns a random question.'
      key :operationId, 'findRandomQuestion'
      key :tags, [
        'question'
      ]
      parameter do
        key :name, :newer_than
        key :in, :query
        key :description, "Lower bound to search from (YYYY-DD-MM), starting from #{Show.order(:air_date).first.air_date}"
        key :required, false
        key :type, :string
      end
      parameter do
        key :name, :older_than
        key :in, :query
        key :description, "Upper bound to search to (YYYY-DD-MM), up to #{Show.order(air_date: :desc).first.air_date}"
        key :required, false
        key :type, :string
      end
      response 200 do
        key :description, 'question response'
        schema do
          key :'$ref', :Question
        end
      end
      response :default do
        key :description, 'unexpected error'
        schema do
          key :'$ref', :ErrorModel
        end
      end
    end
  end
end