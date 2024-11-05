defmodule KeyValue.BucketTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, bucket} = KeyValue.Bucket.start_link([])
    %{bucket: bucket}
  end

  test "stores values by key", %{bucket: bucket} do
    assert KeyValue.Bucket.get(bucket, "milk") == nil

    KeyValue.Bucket.put(bucket, "milk", 3)
    assert KeyValue.Bucket.get(bucket, "milk") == 3
  end

  test "deletes and retrieves a key from the store", %{bucket: bucket} do
    assert KeyValue.Bucket.delete(bucket, "fudge") == nil

    KeyValue.Bucket.put(bucket, "fudge", 2)
    assert KeyValue.Bucket.delete(bucket, "fudge") == 2
    assert KeyValue.Bucket.delete(bucket, "fudge") == nil
  end
end
