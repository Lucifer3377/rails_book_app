# Mongoid::AutoIncrementId.cache_store = ActiveSupport::Cache::MemoryStore.new
# First call will generate 200 ids and caching in cache_store
# Then the next 199 ids will return from cache_store
# Until 200 ids used, it will generate next 200 ids again.
Mongoid::AutoIncrementId.seq_cache_size = 200