defmodule KeyValue.BucketTest do
  use ExUnit.Case, async: true

  setup do
    bucket = start_supervised!(KeyValue.Bucket)
    %{bucket: bucket}
  end

  test "are temporary workers" do
    assert Supervisor.child_spec(KeyValue.Bucket, []).restart == :temporary
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
