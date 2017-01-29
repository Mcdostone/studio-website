class UploadProgressChannel < ApplicationCable::Channel
  def subscribed
	stream_from 'uploadProgress'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
