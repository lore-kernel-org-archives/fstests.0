Received: from mail-pf1-f182.google.com ([209.85.210.182]:36409 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfBJNVX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 10 Feb 2019 08:21:23 -0500
Received: by mail-pf1-f182.google.com with SMTP id n22so1202772pfa.3
        for <fstests@vger.kernel.org>; Sun, 10 Feb 2019 05:21:22 -0800 (PST)
Message-ID: <5c602551.1c69fb81.ed126.e86a@mx.google.com>
Date: Sun, 10 Feb 2019 21:21:16 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to a70fb7335cc4
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Bb5tVM8hAKoX"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--Bb5tVM8hAKoX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. I applied the xfs/068 fix from Amir Goldstein in this
update, hopefully we could stop blacklisting new fsstress operations. There're
also one new generic test to test huge file offset (derived from generic/466)
and some random bug fixes. There should be no new failures after this update.

There're still some patches pending there waiting for review, notably the
squashfs support patches. Hopefully I could look at them next week.

Thanks,
Eryu

The new head of the master branch is commit:

a70fb7335cc4 xfs/068: Verify actual file count instead of reported file count

New commits:

Amir Goldstein (2):
      [53566fac8c06] fstests: Check that high-offset reads and writes work on non-blockdev fs
      [a70fb7335cc4] xfs/068: Verify actual file count instead of reported file count

Christoph Hellwig (1):
      [0738f66318b4] xfs/252: requires fallocate support for preallocation

Vivek Goyal (1):
      [3e3fa955fb2e] overlay/060: Use falloc to make sure a meta copy file got copied up

Zorro Lang (1):
      [e37418a58863] fsstress: avoid splice_f generating too large sparse file


Code Diffstat:

 common/dump           | 20 ++++++++++++++++
 ltp/fsstress.c        |  5 ++--
 tests/generic/525     | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/525.out |  2 ++
 tests/generic/group   |  1 +
 tests/overlay/060     |  3 ++-
 tests/xfs/068         | 14 +++++++++++-
 tests/xfs/068.out     |  2 +-
 tests/xfs/252         |  1 +
 9 files changed, 106 insertions(+), 5 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--Bb5tVM8hAKoX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJcYAlAAAoJECZSqilcj+djAFIQANU/9GE9RDX6Q76fOw66iZl0
lPCp3d+IVGocqh16TafUA/b3GFflpEdcz3yfNWq3ZBpr6chC3MoTIB/bXOqH26D9
3G6/9G8jqz+9w5wk9J2fNHkY+gKfOv64RzN4Cu9EyU3e9P9GuDq13LU3XlP2xOrL
vmTsT9Y0VkSXDNrHCujNQMfaZIwab4YfgqtsMOC1pEd86uiSYbxGK//hUoU4w8ON
tIq/DtkXqYadhDaFGgFj3fa0Lqp7PNOOBpPJzixUtLujcwP/2K6ocTROXRz0eIXf
JBfZssBfL5zMmOuVHuv6RgC0/IRgxHdDQ8KqC/zidV6Z8kRzm88hccQK14g0NtBr
7apg2yd1uWS8pLhOCiJf2a+1l+h76/YSOr0sGpPWGsyFHxq3qOHHD2peM3QJmaFp
o52+gg7eRX0LLcB7AacW6GvIZHt9r6MKCQnVqVEkJJ7SxD7c6zzNrMasNjwM1UPn
W2NecuWsmkG1p0bqogV3sSRnriKL7L7/jZgJJhREUFwCvFPsB7DsB88dYXHvXdpg
FyNqkiQwmoDv0BjpVBCtPoefLCvIlJOZaOXCyZaVGVW0VeXIjYo6hjMPxui5sXqf
VbKcBKkIiyuNM9kmUFOV6J6CzX7LP8Z+KN+k7OSe8z7jgkJV7ccARYeeHWhVKwJm
Ob7EJbLlmfGl2cS/acXJ
=N0gP
-----END PGP SIGNATURE-----

--Bb5tVM8hAKoX--
