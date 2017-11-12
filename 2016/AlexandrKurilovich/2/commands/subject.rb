class Subject < Command #:nodoc:
  def message
    reset_status
    @data["subject"] = 1
    @redis.set(@message.chat.id.to_s, @data.to_json)
    @bot.api.sendMessage(chat_id: @message.chat.id, text: "Какой предмет учим?", reply_markup: hide_clav)
  end

  def handler
    unless @data.nil?
      case @data["subject"]
      when 1
        message_labs
      when 2
        message_end_of_input
      end
    end
  end

  private

  def message_labs
    @subjects[@message.text] = nil
    @data["last_subject"] = @message.text
    @data["subject"] = 2
    @redis.set(@message.chat.id.to_s, @data.to_json)
    @bot.api.sendMessage(chat_id: @message.chat.id, text: "Сколько лаб надо сдать?")
  end

  def message_end_of_input
    return unless data_valid?(@message.text)
    @data["subject"] = 0
    @subjects[@data["last_subject"]] = array_lab(@message.text)
    @data["subjects"] = @subjects
    @redis.set(@message.chat.id.to_s, @data.to_json)
    @bot.api.sendMessage(chat_id: @message.chat.id, text: "Красава! Записал.")
  end

  def data_valid?(data)
    if (data =~ /^\d+$/).nil?
      @bot.api.sendMessage(chat_id: @message.chat.id, text: "Лабы надо вводить циферками")
      false
    else
      true
    end
  end

  def array_lab(labs)
    (1..labs.to_i).to_a
  end
end
