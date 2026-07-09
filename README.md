# UNFS3 container image

Reproducible container build for [UNFS3](https://github.com/unfs3/unfs3), a
user-space NFSv3 server.

The image is published as `ghcr.io/cyrahs/unfs3:0.11.0`. Production users
should pin the image digest.

The build currently pins UNFS3 0.11.0 to upstream commit
`ec1660ba33c80d5c67131e163e68834c1a10e243`. To upgrade, update both the commit
argument and the image version labels/tags, then verify the published digest.
