module DCell
  # A proxy object for a mailbox that delivers messages to the real mailbox on
  # a remote node on a server far, far away...
  class MailboxProxy
    class InvalidNodeError < StandardError; end

    def initialize(node_id, mailbox_id)
      raise ArgumentError, "no mailbox_id given" unless mailbox_id

      @node_id = node_id
      @node = Node[node_id]
      raise ArgumentError, "invalid node_id given" unless @node

      @mailbox_id = mailbox_id
    end

    # name@host style address
    def address
      "#{@mailbox_id}@#{@node_id}"
    end

    def inspect
      "#<DCell::MailboxProxy:0x#{object_id.to_s(16)} #{address}>"
    end

    # Send a message to the mailbox
    def <<(message)
      @node.send_message! Packet.new(@mailbox_id, message)
    end

    # Is the remote mailbox still alive?
    def alive?
      true # FIXME: hax!
    end
  end
end