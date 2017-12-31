Received: from mail-pf0-f193.google.com ([209.85.192.193]:46591 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750762AbdLaOVi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 31 Dec 2017 09:21:38 -0500
Received: by mail-pf0-f193.google.com with SMTP id c204so23879218pfc.13
        for <fstests@vger.kernel.org>; Sun, 31 Dec 2017 06:21:38 -0800 (PST)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id 77sm83524686pfh.43.2017.12.31.06.21.35
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Dec 2017 06:21:36 -0800 (PST)
Message-ID: <5a48f270.d007620a.ade59.d04e@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 31 Dec 2017 22:21:30 +0800
Subject: [ANNOUNCE] fstests: master branch updated to e6f1dfa3e331
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TvoCxpYRz61y"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--TvoCxpYRz61y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is the last update in 2017, which only contains
three minor fixes.

As this is the last update in 2017, I went through the git history a bit and
took a very quick scan on it to get a rough idea on what happened in 2017, here
is what I've observed (the numbers may not be accurate, and I may miss some
important updates too).

We had 529 patches from 67 contributors merged in 2017, which is the biggest
update ever (444 patches in 2016 and 282 patches in 2015), around 224 new tests
were added. I also listed some notable changes in 2017 briefly:

- base filesystem support in overlayfs testing (Amir Goldstein)
- test result report generator & infrastructure (Dmitry Monakhov)
- support testing more filesystems:
  - glusterfs (Zorro Lang)
  - pvfs (or Orangefs) (Martin Brandenburg)
  - ubifs (David Oberhollenzer)
- cross-compilation support (Gwendal Grignou)
- remove IRIX support (Eric Biggers)
- dm-log-writes crash consistency test infrastructure (Josef Bacik, Amir Goldstein)
- fs-perf infrastructure (Josef Bacik)

Many many thanks to all the contributors and reviewers! Happy New Year!

Thanks,
Eryu

The new head of the master branch is commit:

e6f1dfa3e331 ext4: use a slightly bigger file system in ext4/021

New commits:

Ari Sundholm (1):
      [79a3bb053fec] common/encrypt: Create an encrypted equivalent of _scratch_mkfs_sized

Qu Wenruo (1):
      [5525ac522809] btrfs: Add new 'limit' test group for btrfs

Theodore Ts'o (1):
      [e6f1dfa3e331] ext4: use a slightly bigger file system in ext4/021


Code Diffstat:

 common/encrypt    | 12 ++++++++++++
 tests/btrfs/group | 12 ++++++------
 tests/ext4/021    |  4 ++--
 tests/generic/399 |  3 +--
 4 files changed, 21 insertions(+), 10 deletions(-)
--
Eryu Guan
eguan@redhat.com

--TvoCxpYRz61y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJaSPHXAAoJECZSqilcj+djEmEP/2TLntiAic30TKQL97wSloPE
/qK7qPPBsVhkLaKNJFg4V2/4y8CO1bGZNEbxfKLQhGINIHKkI2+Cycu1ndj5fvL3
J16rqMp5pR1AQuIlSLZQNMVmLI7GIDCIHz05mvElXmd2JpsV2rxgewGFahH53V+c
IkZ41FRZtf13iAASlAJYHvPW8mPZaSQeWFwA7fKlVphfA56qUdCKPPyT51e4+tmW
Yggk3bGSqNj3ES32OdMvdCOq7NpMFKWcaO0WYkQze6O2V6eoLGTsjLLU1rDvgGYH
jCTfXLdGiuEtL42d6RSewW0kgqnMroespMdct3ZZqSDkEwE6BbnlZRFCQt3XxMsD
Z/9+uFManuf9CJs5LrwfHIxPFQPK7qBPJIaal1gj4QNNMMuQpsBIeEMvtoVe4RZd
pCxfD52XUxlwHHJSRR2DTJ4vFIkTOg3WRkZ0el7cZyyQ9jrt/ef6jhUnpm3EeFXS
0hHCK0N3Bed/vQ3fyp+vpDyRcLyWHsC2zGfZ6OO5KktCOmcmO15lZXD9LH8WfQVi
//O9CCv1yXH7Wnher8fJIxduO/EoTqJEtnxH3FxQf/CmmLcxqGRD2EfALiVOocQ+
mZecynsPM6Qnz0LBHZ4KIjVuT7m9oI8cOuOgdfmKYGDewGkhnKXrmIAQ9LXEvzIH
ce6wrlG1Sg8t+YMruTLA
=b9HE
-----END PGP SIGNATURE-----

--TvoCxpYRz61y--
