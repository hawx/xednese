class Batches < Array
  def self.generate(n)
    new (0...n).map { Batch.generate }
  end

  def startindex
    @startindex ||= Int.generate
  end

  def count
    @count ||= Int.generate
  end

  def totalcount
    @totalcount ||= Int.generate
  end

  def to_xml
    str = <<EOS
<?xml version="1.0" encoding="utf-8"?>
<messagebatches xmlns="http://api.esendex.com/ns/"
                startindex="#{startindex}"
                count="#{count}"
                totalcount="#{totalcount}">
EOS

    each do |batch|
      str += <<EOS
<messagebatch id="#{batch.id}" uri="#{batch.uri}">
  <createdat>#{batch.created_at}</createdat>
  <batchsize>#{batch.batch_size}</batchsize>
  <persistedbatchsize>#{batch.persisted_batch_size}</persistedbatchsize>
  #{batch.status.to_xml}
  <accountreference>#{batch.account_reference}</accountreference>
  <createdby>#{batch.created_by}</createdby>
  <name>#{batch.name}</name>
</messagebatch>
EOS
    end

    return str + "</messagebatches>"
  end
end
