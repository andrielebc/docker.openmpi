#! /usr/bin/env bash
exec docker ps | gawk '/mpihead/ { print gensub(/.*\.0:(.*)->22.*/, "\\1", "g", $0) }'
