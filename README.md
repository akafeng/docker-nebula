<h1 align="center">Nebula</h1>

<p align="center">A scalable overlay networking tool with a focus on performance, simplicity and security.</p>

<p align="center">
    <a href="https://hub.docker.com/r/akafeng/nebula">Docker Hub</a> ·
    <a href="https://github.com/slackhq/nebula">Project Source</a>
</p>

<p align="center">
    <img src="https://img.shields.io/docker/v/akafeng/nebula?sort=semver" />
    <img src="https://img.shields.io/docker/pulls/akafeng/nebula" />
    <img src="https://img.shields.io/microbadger/layers/akafeng/nebula" />
    <img src="https://img.shields.io/docker/image-size/akafeng/nebula??sort=semver" />
</p>

---

### Pull The Image

```bash
$ docker pull akafeng/nebula
```

### Start Container

```bash
$ docker run -d \
  -v /etc/nebula/:/etc/nebula/ \
  --device=/dev/net/tun \
  --cap-add=NET_ADMIN \
  --network host\
  --restart always \
  --name=nebula \
  akafeng/nebula
```
