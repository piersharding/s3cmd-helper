s3cmd helper
============

This container is a helper that wraps s3cmd so that it can be used as a tool to access S3 compatible object stores such as Minio, eg:
```
docker run --rm --net=host -ti -e AWS_ACCESS_KEY=AKIAIOSFODNN7EXAMPLE -e AWS_SECRET_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY piersharding/s3cmd:latest  --host=localhost:9000 --host-bucket=localhost:9000 --no-ssl ls s3://test/abc123/
```

