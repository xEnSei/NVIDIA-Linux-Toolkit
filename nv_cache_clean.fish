#!/usr/bin/fish

# NVIDIA Shader Cache Cleanup for CachyOS
set -l cache_dirs \
    $HOME/.nv/ \
    $HOME/.cache/nvidia/ \
    /tmp/nvidia-compute-cache/

echo "Starting cleanup of NVIDIA caches..."

for dir in $cache_dirs
    if test -d $dir
        set -l file_count (find $dir -type f 2>/dev/null | count)
        sudo rm -rf $dir/*
        echo "Cleaned: $dir ($file_count files removed)"
    else
        echo "Skipped: $dir (directory does not exist)"
    end
end

echo "Cache cleanup completed."