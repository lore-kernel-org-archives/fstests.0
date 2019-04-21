Received: from mail-pl1-f194.google.com ([209.85.214.194]:39226 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfDUQCB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 21 Apr 2019 12:02:01 -0400
Received: by mail-pl1-f194.google.com with SMTP id e92so2909486plb.6
        for <fstests@vger.kernel.org>; Sun, 21 Apr 2019 09:02:01 -0700 (PDT)
Message-ID: <5cbc93f7.1c69fb81.d1e11.9ab1@mx.google.com>
Date: Mon, 22 Apr 2019 00:01:50 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 872050db3cac
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KVFzX3AX9QYw"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--KVFzX3AX9QYw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update mainly pulls in the patches from Filipe
Manana that add xattr operations to fsstress (many thanks to Filipe!). Be noted
that these new operations may bring new failures in tests. Also, scratch devs
are cleared before test, so we don't use scratch devs from previous tests by
accident.

The new btrfs test (btrfs/186) fails with latest Linus tree.

Thanks,
Eryu

The new head of the master branch is commit:

872050db3cac check: filter lockdep bugs when scanning dmesg

New commits:

Darrick J. Wong (3):
      [5bb196119dff] check: remove require_{test,scratch}* after a test fails
      [d0e484ac699f] check: wipe scratch devices between tests
      [872050db3cac] check: filter lockdep bugs when scanning dmesg

Filipe Manana (8):
      [2c492c4d166b] fsstress: allow fsync on directories too
      [e1a9b1db892e] fsstress: allow afsync on directories too
      [fc4b0a55b932] fsstress: add operation for setting xattrs on files and directories
      [e9ffa8daec5e] fsstress: add operation for reading xattrs from files and directories
      [0babbf160408] fsstress: add operation for deleting xattrs from files and directories
      [378722046a7b] fsstress: add operation for listing xattrs from files and directories
      [c7d96baf9ccf] fssum: add support for checking xattrs
      [18562c4228ed] btrfs: test send on subvolume with delalloc after setting it to RO mode


Code Diffstat:

 check               |   8 +-
 common/rc           |  21 +++-
 common/xfs          |   1 +
 ltp/fsstress.c      | 353 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 src/fssum.c         | 143 ++++++++++++++++++---
 tests/btrfs/186     |  73 +++++++++++
 tests/btrfs/186.out |  14 +++
 tests/btrfs/group   |   1 +
 8 files changed, 584 insertions(+), 30 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--KVFzX3AX9QYw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJcvJN+AAoJECZSqilcj+dj/k4QAIK3VsD35VgWp6aJJed2dPJv
8eReNqIr6ESgeYN3KfgNpRexckqlTUxnvtQj/MLsgmvVxz0aEbgOPoKtl8jRYghk
pLKJTcI9rIWiDFmMuhTKfW+cCN+KI2ZEZvW2u4bqxU9b5n8Sbkde7U7MHco6YUH4
R9NEE8RAUbZLfyuVCWcU6V1BHEE5tS+8jEXgzr4QCpxRv+qp9OqeAzHn3vngGiXq
FUoJLnxCGxc7RcIngaPYp89eO7Zcvvf6TqFiOcGpS5Iwqn6xutNa99IW5xjRPByj
+rimsL8pp+UCs6fB5ckYK0FsXPb9VGaVtL/9n1NFybZ7WyBi7uCmvEpq/oQ+7YnQ
v6axXwhBzSxpBXJnUIFOjxJ8FaSvSQVt72IuzfSgSCQTPXpXPzNZr+T9ot+bVRME
pbZ+r3UmyQZjm3hSKNNUoVJlQpvs7Vn2VPJog4by5Yd1pONDji9wkT74MA0Pl1UJ
04DcfkjPL7O6tFu7JOogkfOKdAUdtR/12t1CfAfsMmzt0ZcaUvyD8cpeJmk5rNFi
+cnfs0s/bcy8O8PL3BQQTRjNAKGU2+WUZHmhpJB9YignFLfRd4vrVYtO3LCLnhdi
LA3T+w1fyOE0biKEXG5zyz/2ikoIN5YCjpJ3qR3LWVSbKyicBxeGpU6aESROp3kM
qPOpVCZ6y/PPmRi1MUcy
=jgrG
-----END PGP SIGNATURE-----

--KVFzX3AX9QYw--
