.PHONY:
.SILENT:

default:
	cat Makefile


build:
	docker build -t baa .


run:
	docker run -it baa
