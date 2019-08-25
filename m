Received: from mail-pg1-f195.google.com ([209.85.215.195]:40757 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728375AbfHYOoU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 25 Aug 2019 10:44:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so8814085pgj.7
        for <fstests@vger.kernel.org>; Sun, 25 Aug 2019 07:44:20 -0700 (PDT)
Message-ID: <5d629ec2.1c69fb81.f51d8.757a@mx.google.com>
Date: Sun, 25 Aug 2019 22:44:05 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to c9adaa192f17
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="DuT0aOrfAPNS"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--DuT0aOrfAPNS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. Only three minor bug fixes are included in this update.

Thanks,
Eryu

The new head of the master branch is commit:

c9adaa192f17 t_stripealign: Fix fibmap error handling

New commits:

Andreas Gruenbacher (1):
      [8bbd45ad5bad] generic/322: fix bad xfs_io sync_range command

Carlos Maiolino (1):
      [c9adaa192f17] t_stripealign: Fix fibmap error handling

Josef Bacik (1):
      [9cd2fe8a9357] generic/500: doesn't work for btrfs


Code Diffstat:

 src/t_stripealign.c | 7 +++++--
 tests/generic/322   | 4 ++--
 tests/generic/500   | 6 ++++++
 3 files changed, 13 insertions(+), 4 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--DuT0aOrfAPNS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl1inVMACgkQJlKqKVyP
52P58BAAqyDuYWe14+9RRjXm18oEjYCHyUZkzWxbRj6+sjr/VOVlUyuXqVz1v5tG
IIVNev26bY48t9iXx2r382BPKLxX5L9HSwRlPU7lLRNKv/PvnKDXfZjAlhkWlqxY
HZBXq1HQh7nCtalQPlh13L2tAt30BgCnImttTMAE7iUMieel+hckc6Mvj2KD5X+x
fl1f1yWMxaTlQjAILqEAV0g8rVrEPvJ2fb7pKnJDYepv7rV1Or2nQbmN2+a8WT9h
zv9fPCejnuHPAB9rlNXtd6PH+GIpQ9UjHnlqQYFVN9iWPHFoXjQ0z/Zy2CAx+pxb
egldDan8AajQOr0rl9phqZlEpcO9TT6PLnIbNfrLmXeE3Kqp+g0TD5UDuh8cqhkc
feXMBv2LPpKpC4Kg7pU4OGg0J6Cc2u4z1UxpsSOxBB3HiO0oxoayHdRXyqG2qCX5
S3rwaM7f4+j3das5InOkpkrbuN8sVhzc1Ahu4ZAdwSqLytXV/DKz7voFyzf4QCfM
wcIXzO5vpfOW/ZRxd1hqHPedSNOrcGNdn78sUSJlg+5yeH3L2/f0rnvhqHkKAtrN
TaF6XOy4bOSbroL5qvZz4Za7NtAqJSjIKtpZXC6CTyGzTJb3cnOKv24hd1rEsC8I
Yzrtg/7DSStJisIYp7QOcSygEtmCsReL7z+LptYfwSJeiZrASCQ=
=pegM
-----END PGP SIGNATURE-----

--DuT0aOrfAPNS--
