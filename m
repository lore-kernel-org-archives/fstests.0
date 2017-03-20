Received: from mail-pf0-f196.google.com ([209.85.192.196]:35763 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752862AbdCTDkt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 19 Mar 2017 23:40:49 -0400
Received: by mail-pf0-f196.google.com with SMTP id n11so3954030pfg.2
        for <fstests@vger.kernel.org>; Sun, 19 Mar 2017 20:40:48 -0700 (PDT)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id i124sm29748613pgd.22.2017.03.19.20.40.47
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Mar 2017 20:40:47 -0700 (PDT)
Message-ID: <58cf4f3f.829d630a.94f54.f2f4@mx.google.com>
Date: Mon, 20 Mar 2017 11:40:43 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE RESEND] fstests: master branch updated to 780dd1eaffaf
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="nHqpCfRngK1X"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--nHqpCfRngK1X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. We have glusterfs support in this update, thanks to
Zorro! Besides that, this is mainly a bug-fix update, along with a new btrfs
test.

New failures I've noticed:
- btrfs/139 is a new test and fails on current linus tree

Thanks,
Eryu

The new head of the master branch is commit:

780dd1eaffaf generic/417: reduce extend attribute size

New commits:

Eric Biggers (4):
      [4ff270110015] generic/361: add _require_loop
      [fe5461d6e370] btrfs/020: add _require_loop
      [b4d26d40527a] common/quota: remove redundant SELinux detection code
      [de88e28a1d33] common/config: don't hard-code SELinux context

Eryu Guan (1):
      [780dd1eaffaf] generic/417: reduce extend attribute size

Goldwyn Rodrigues (2):
      [c26958bc5d67] btrfs/139: creation/deletion within qgroup limits
      [a913637bd706] common/rc: Use -v option with findmnt

Harish (1):
      [516a24b96586] common/dmthin: Fix grep command for finding exact value

Xiao Yang (1):
      [643c6850277a] common/config: honor NFS_MOUNT_OPTIONS in _test_mount_opts

Zorro Lang (1):
      [4cbc0a0fa8bc] fstests: add GlusterFS support


Code Diffstat:

 README.config-sections |  7 +++++
 check                  |  2 ++
 common/config          | 21 ++++++++++++--
 common/dmthin          | 12 ++++----
 common/quota           |  7 -----
 common/rc              | 36 +++++++++++++++++++++--
 tests/btrfs/020        |  1 +
 tests/btrfs/139        | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/139.out    | 16 ++++++++++
 tests/btrfs/group      |  1 +
 tests/generic/361      |  1 +
 tests/generic/417      |  2 +-
 12 files changed, 165 insertions(+), 20 deletions(-)
--
Eryu Guan
eguan@redhat.com

--nHqpCfRngK1X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJYzk+cAAoJECZSqilcj+djAnUQAOTPlDC2tnYIEgYEjmpM8Myu
1nvOWl309aTQHe1ehKsw+gMmircUNLcpw9nkuCZwCJW+eMsThIAfeXRJjym9qio0
JqkW57Khv9nsIrsO8RXSVzdl2jWqvOME+jRkq3gO59G+dNwNVtgaG8isptRY6BJK
rKMnsnva31ngQaLPzMZwyBxjq6R7BkBYQHPrHL/6CntgCyqhhirbDWg5bfwqEWBb
kTtQ+wfc5Olk1YmHIzv+YsAoRZXjf5hfCGF4FyAwb4wK4o0DPslLUvB7zG8Ah8Hy
O8TpgPiW49ojQCKltN2j5Lrb/F1W1nKh9MWKfwS+yxttmO5UDfHaKKlD/X5cxys7
JFYm9Oz61OJ7wDCXIniVr/bAL/wupuODiipil9u3V+8eS2NUC+dM6uqKHVKkyTDh
zECCPmakV661+H+KWlKedjtQ01LGWy6ym7y4b3K01t1dsmXMXqpIHTGvPyunIr2E
BFrnUGUSGWdwesNhH8zArHNrJ95OiXNn0+9qIarWjMIua6rdvy0q35qw28xO3kql
Cth/IEB0xKU71b+63JSbzMj7JmKALwyJiZowCdf4JWpGTox3n42IA7Y/Qlg3ICzT
dpdxvxpMLtHFUlFeNqJNGz8oBkOLjwtm0+wn3GHBbcoDKJX6QiTqcpP1Ms+0RJLm
9ylT4BtCPLA3t5pE9Hoe
=Q5rZ
-----END PGP SIGNATURE-----

--nHqpCfRngK1X--
