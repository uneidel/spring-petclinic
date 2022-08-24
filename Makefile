build-arm64:
	docker build -t uneidel.jfrog.io/tompetty:arm64 -f dockerfile.ms  .

run: 
	docker run -it --rm -p 8080:8080 uneidel.jfrog.io/tompetty:arm64