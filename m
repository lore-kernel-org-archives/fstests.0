Received: from mail-pf0-f176.google.com ([209.85.192.176]:44177 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbdJAMZU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 1 Oct 2017 08:25:20 -0400
Received: by mail-pf0-f176.google.com with SMTP id t62so536570pfd.1
        for <fstests@vger.kernel.org>; Sun, 01 Oct 2017 05:25:20 -0700 (PDT)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id d23sm13480408pfe.115.2017.10.01.05.25.18
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Oct 2017 05:25:19 -0700 (PDT)
Message-ID: <59d0deaf.1799620a.447ef.2be4@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 01 Oct 2017 20:25:13 +0800
Subject: [ANNOUNCE] fstests: master branch updated to 1021cf17bced
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="QwcINFV8jcdq"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--QwcINFV8jcdq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a normal weekly update with new tests and bug
fixes. A new 'dax' group is added to tag all dax-specific tests, you may find
it useful.

New failures I've noticed in this update:
- xfs/432 tests xfs_metadump large dir with 1000+ extents and currently fails
- btrfs/150 would crash kernel if you have CONFIG_FAIL_MAKE_REQUEST enabled

Thanks,
Eryu

The new head of the master branch is commit:

1021cf17bced src/nsexec: fix stack pointer alignment exception

New commits:

Amir Goldstein (1):
      [2d583495c5a4] generic/447: not a quick test

Darrick J. Wong (2):
      [c114000c9712] generic/45[34]: fix the xfs_scrub probe test
      [8443ff29f23d] xfs: test increased overlong directory extent discard threshold

Eryu Guan (1):
      [a44ee35b6282] common/xfs: add iomap_dio_complete() to the dmesg filter

Khazhismel Kumykov (1):
      [4f768f3bb42a] generic: Add nocheck shutdown stress test

Liu Bo (1):
      [43f4f6fe0092] btrfs: regression test for reading compressed data

Xiong Zhou (3):
      [712bfebcc8ce] tests: add new group dax
      [594a841079d3] gitignore: sort src/ binaries name
      [52991325936c] generic: mmap write readonly DAX file

Zorro Lang (1):
      [1021cf17bced] src/nsexec: fix stack pointer alignment exception


Code Diffstat:

 .gitignore            |  25 +++++------
 common/xfs            |   4 +-
 src/Makefile          |   2 +-
 src/nsexec.c          |   3 +-
 src/t_mmap_write_ro.c |  79 ++++++++++++++++++++++++++++++++++
 tests/btrfs/150       | 105 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/150.out   |   3 ++
 tests/btrfs/group     |   1 +
 tests/generic/453     |   2 +-
 tests/generic/454     |   2 +-
 tests/generic/461     |  83 +++++++++++++++++++++++++++++++++++
 tests/generic/461.out |   2 +
 tests/generic/462     |  95 ++++++++++++++++++++++++++++++++++++++++
 tests/generic/462.out |   2 +
 tests/generic/group   |  12 +++---
 tests/xfs/432         | 117 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/432.out     |   6 +++
 tests/xfs/group       |   3 +-
 18 files changed, 523 insertions(+), 23 deletions(-)
--
Eryu Guan
eguan@redhat.com

--QwcINFV8jcdq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJZ0NqgAAoJECZSqilcj+dj0NMQALepv1dgw69+nP5x2h1gXjO1
MDgb/pGHTpmD6OU0kjN5Zd7UaGZec2nLqBAZZY+xVE64XQhO/L4umoB6Qu584WuK
6dU5h8VKYXs5krsFhtgPlyxSytK60huW2nfNFYCto0InZ1H+HbASjErLabnPrMw/
6r8oBfYTUdT5uIdec8Won4RnWdL72YrY8RZsSDAqphmh7dixay0qDYjXNg6iCDMo
HQ3e4JRUU7KmQqpFD6tB2kpuj2I+h1IKbXJ6InXC7n32uD3Eo34DnzA7XFMH94dy
OzL+1b17Gm+kTgI8bTIdWRRSit1UccOU2e4KA5x1uqj5/I0K5GjCPiea5s9MnLVA
cAis3VquCKPzlH8aAU8J5NsaS+Mweuv/YMQknQc6Y5ofB/DEZnwldW5pZvN1XDhA
V0ONnkDLqQXDDwehSd7ywi8JFyzNlJJt7tbiFLPYi89U4C6PguKe3wUrDMs2eFOD
YB5Md+n1sVpYEUl56CzKUfol4pDhiPuEanPuPBF6cvd3dCeY3PDauvWzbv2PiiCD
F742bp2L9Vwes/8uHfpysk0XhwsLy3nTqu1CK+SdYI8atSnVtJeeIfnMqOFWYqA0
riPzhezt22pwzJpRKovYZkyYpQghyD740Hhnt9pS02XBYsuLBLulNvfLMJTQQ3cf
bb9okQXCZ2NiGSSVQ5Pp
=bf3z
-----END PGP SIGNATURE-----

--QwcINFV8jcdq--
