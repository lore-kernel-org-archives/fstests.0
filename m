Received: from mail-pl0-f42.google.com ([209.85.160.42]:34692 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728395AbeGVQ0b (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 22 Jul 2018 12:26:31 -0400
Received: by mail-pl0-f42.google.com with SMTP id f6-v6so7164166plo.1
        for <fstests@vger.kernel.org>; Sun, 22 Jul 2018 08:29:28 -0700 (PDT)
Message-ID: <5b54a2d7.1c69fb81.8d5b0.99a3@mx.google.com>
Date: Sun, 22 Jul 2018 23:29:23 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to b19c44702761
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="L0INfUbmyPfl"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--L0INfUbmyPfl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. It's been a relatively quiet week last week that
there're only two commits in this update. One is a new generic test and another
is to fix make install failure with newer glibc.

New failures I've noticed in this update:
- generic/502 fails on btrfs, the patch referenced in the test should fix it

Thanks,
Eryu

The new head of the master branch is commit:

b19c44702761 generic: add test for fsync after renaming hard links of same file

New commits:

Filipe Manana (1):
      [b19c44702761] generic: add test for fsync after renaming hard links of same file

Zorro Lang (1):
      [b29b8b077e05] build: replace lowercase letters regex with POSIX character class in Makefile


Code Diffstat:

 tests/Makefile        |  2 +-
 tests/generic/502     | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/502.out | 11 +++++++
 tests/generic/group   |  1 +
 4 files changed, 92 insertions(+), 1 deletion(-)
--
Eryu Guan
guaneryu@gmail.com

--L0INfUbmyPfl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJbVKJ4AAoJECZSqilcj+djdpsP/AszMef3MGeOwyhlqYv0cTXP
s26QEmE8GkKxeDUwPO0KUPrczLecPc9uN6+uBRevJ/3JTeBN6XDN6trLFvstjgLh
eJ+PIdL5JUW3U5zLY29XIkGSRhpsNhw/N6tzCHFur79bTvCm5ur8biIO0xunSgVB
S1AIY1sGD58p6vXNxmrV8SkmjF+XWAs7boRhKx8qFRovU/Uj34WAt3lGe0rW0JOK
MxOjmx2HUdUbOjmSLGJjp100ovuRqbIfuoSFdVX7Y3J1UIY/jZp+GTEzhC+TIx7z
XiyEFlYZZ0xqUek9ponWMegeTLnxgDo5UCosrYofsNmUM9XptMKBoU9mcrPd10tq
ERSu+juv4J7x1f/+OoYgWDP/1RhEcTHe51Pcnm29bI6TwI/69+jHCeptk/eZfBXf
8wbbpBg/pBVNKmM7bRE8WO9j6VnN2M6c4Dvuo5Gcuc9m/ooJpeEPzK96IGkJ5VAl
93P1EUs9BbkXmrVYTCgoRq0TaQAP/gvrck8GKhvWlAR2qkxxy6f1JGpz4yxWQRma
+j5vY3RuVESJ7D8LRwzq3+X5Sszy0k3oHD7I9Rm3sMNiuArmcsOZGaMSuKVcrIAm
I7OSg011ksFaJCyGPXogvtOEeKQOt/QxBZ/EHXea2rjWMpZi6kLyETotuRszCo68
DjQtSG9zbzF3dSomcuK4
=4KuH
-----END PGP SIGNATURE-----

--L0INfUbmyPfl--
