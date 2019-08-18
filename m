Received: from mail-pl1-f193.google.com ([209.85.214.193]:38514 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbfHRPst (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 18 Aug 2019 11:48:49 -0400
Received: by mail-pl1-f193.google.com with SMTP id m12so4583181plt.5
        for <fstests@vger.kernel.org>; Sun, 18 Aug 2019 08:48:48 -0700 (PDT)
Message-ID: <5d59735f.1c69fb81.877f8.dca6@mx.google.com>
Date: Sun, 18 Aug 2019 23:48:37 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 3b8ea0d760d4
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="N1Rr6vhTqc6W"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--N1Rr6vhTqc6W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is again, a bug-fix only update, you should not
see new failures after this update.

Thanks,
Eryu

The new head of the master branch is commit:

3b8ea0d760d4 common: filter aiodio dmesg after fs/iomap.c to fs/iomap/ move

New commits:

Darrick J. Wong (3):
      [84cc0f61a324] generic/081: fix lvm config not being cleaned up properly
      [23f99e864ee7] generic/561: kill duperemove directly
      [3b8ea0d760d4] common: filter aiodio dmesg after fs/iomap.c to fs/iomap/ move

Filipe Manana (1):
      [0d39941c0445] generic/517: make test work on filesystems with block size greater than 4Kb

Nikolay Borisov (1):
      [eba73e34fd7e] generic/519: Optimize overlap detection


Code Diffstat:

 common/filter         |  4 ++-
 tests/generic/081     | 29 +++++++++++++++++-----
 tests/generic/517     | 30 ++++++++++++-----------
 tests/generic/517.out | 42 ++++++++++++++++----------------
 tests/generic/519     | 67 +++++++++++++++++++++++++++------------------------
 tests/generic/561     |  4 +--
 6 files changed, 100 insertions(+), 76 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--N1Rr6vhTqc6W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl1Zcw0ACgkQJlKqKVyP
52NBlhAAwRzDwm6wsDfFNtKeHFZBpYDl945z7IIB7FiiZUbcr5glhwczZ1h2KSwl
VuNt6uMaErbojUtB0IpuEcHGTfMxgwZiDG4iknC6q5bPBcCbVHkX7PskZ5QNTh+U
g2Gywq2lGRWqS9dPaVmmNyfZHdMzIvid9i8ssjAQpt9nyjFC2/5jDpXK5jjqMbNG
dWztHcj+6UQqzXKthJJtko2cGQC4nbvK22wWewMYmbKxWM6Gfd4mS1CWyzwHs+To
cUrrybPb/kDoQVrWZ7phtYu51yXBOqamY85KAOpgyMjKaEk226LBTh7rLKiAupg1
cCbmmNS7ro2yOoAPkOaZTAxIyHxEnrdp5Tk5oLFdeGOJ5C3j6wga6X9DbrDogR1Z
+ll0sPbAEjW7jil0+YgxXdDOKg1ffmrP0G9TFaZfj7E4/XWWSGItW2CuE015+wRP
JFoh/Got6AH1rMmLSPL0PFU17Kv4LVwU8C4SKUTs0jaxdIAR1ftYKCxsm0DSF0mu
XMiKVeJP36enqymlRKFZgeOSwYlUmGkpP4YcUs+ARWU5ubbUpoPX+DFQzQeu5Q2k
GBjOh/1+HdlUh80w3oC9bmEfZJ94hYR7fhxYzsue1WGpL/CAjD8JrZXUxKSx+KOI
iVCxad9TjLO55ikbHH2b38P9vMkwssA180/vH41IEmzosn2BLIA=
=g2uT
-----END PGP SIGNATURE-----

--N1Rr6vhTqc6W--
