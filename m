Received: from mail-pl1-f194.google.com ([209.85.214.194]:42069 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729949AbfIOQlc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 15 Sep 2019 12:41:32 -0400
Received: by mail-pl1-f194.google.com with SMTP id e5so4480221pls.9
        for <fstests@vger.kernel.org>; Sun, 15 Sep 2019 09:41:30 -0700 (PDT)
Message-ID: <5d7e69b8.1c69fb81.8fce8.2bfa@mx.google.com>
Date: Mon, 16 Sep 2019 00:41:22 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 82eda8820ddd
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="H6YDdM6Xftk2"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--H6YDdM6Xftk2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. Along with some random bugfixes, there're two new btrfs
tests and one generic test, which exercises mmap write v.s. punch_hole.

The only new failure you will see is btrfs/193, which tests qgroup space leak
on falloc over holes.

Many thanks to Filipe Manana and Brian Foster for reviewing patches!

Thanks,
Eryu

The new head of the master branch is commit:

82eda8820ddd btrfs: Verify falloc on multiple holes won't leak qgroup reserved data space

New commits:

Andreas Gruenbacher (1):
      [332232b37f4d] generic: test mmap write vs. hole punching

Eric Sandeen (1):
      [298319fd4a2c] generic/564: fix copy_range -f availability test

Filipe Manana (1):
      [4f7f6f1cf1b2] btrfs/079: fix failure to umount scratch fs due to running filefrag process

Qu Wenruo (2):
      [d0f42706da50] btrfs: Check snapshot creation and deletion with dm-logwrites
      [82eda8820ddd] btrfs: Verify falloc on multiple holes won't leak qgroup reserved data space

Yang Xu (1):
      [4bcf365a3f94] generic/566: use _require_xfs_quota_foreign and remove -f option


Code Diffstat:

 common/config         |   1 +
 common/dmlogwrites    |   2 +-
 common/rc             |   2 +-
 tests/btrfs/079       |   6 ++
 tests/btrfs/192       | 175 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/192.out   |   2 +
 tests/btrfs/193       |  69 ++++++++++++++++++++
 tests/btrfs/193.out   |   8 +++
 tests/btrfs/group     |   2 +
 tests/generic/564     |   2 +
 tests/generic/566     |   5 +-
 tests/generic/567     |  62 ++++++++++++++++++
 tests/generic/567.out |  19 ++++++
 tests/generic/group   |   1 +
 14 files changed, 352 insertions(+), 4 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--H6YDdM6Xftk2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl1+WocACgkQJlKqKVyP
52Ncxw//bxg0XGChsOeVHEtEGfRS2vzgNw4ZufPNQz5cJK9DD0ZI72rn6mz7yYDX
UJa9LjbGZMt46Zs1mO4P5ReDNp2pY/yuqUHOV8KHmRZNVitrMGZg6qCcio1GsCDj
dNNwBGR2CrOfXFuWjjN/ov21frcje6ivXCpLulMFAdXBRQr3tT4h3Jrw989IlrLo
nlvkaU7qI8X4Z0pWrAOXJpd4a+AjV4x/n4q6GZL0fR1vbKp5Ee6ZiJAZgGTIGBEs
gFGLIY58kF64fvEW+qBPtYPOiNniG9ZYjGJfi2VLDsgZ2LqcnqXagsK70su2BAHA
9HUYAAWwVJoylEr70rCmjr5pKx2AnHtez0pVQDe5HeBPobBL8DNcTzD+2OqovyKT
O3ERYTv+KLTh0gCOV7511581Xiu04kwsGiKolZr6IwV8b3rFD0LRAgWXdoilYrbn
OjIseWq414EtNONcB3Wicktuec1RYcfOv/NIH1x5jAMziWgg/Cm3GQq99P0scXSU
wjyaPahVon3wrxdWlPt30UpxsPyMRAd3eH5gbTT48IWP4wooPThaZeUt/IXATHWC
LyiD99G0qdYHCZKE1PzvQCKz0B4gfSZv4Ht1iJygHb6cMhmTT8ScTaR5TN+XKlG1
uHE4BdZzEEI/4trHbTIJrPMXqMbum3AGBtkDavWissz6TSpaxNQ=
=7zFY
-----END PGP SIGNATURE-----

--H6YDdM6Xftk2--
