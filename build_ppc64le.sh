docker build -t bird-build-ppc64le - < Dockerfile.ppc64le
mkdir -p dist
docker run --name bird-build -v `pwd`:/code bird-build-ppc64le ./create_binaries_ppc64le.sh
docker rm -f bird-build || true
