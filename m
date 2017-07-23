Received: from mail-pf0-f196.google.com ([209.85.192.196]:33728 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbdGWGCW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 23 Jul 2017 02:02:22 -0400
Received: by mail-pf0-f196.google.com with SMTP id k72so4585008pfj.0
        for <fstests@vger.kernel.org>; Sat, 22 Jul 2017 23:02:22 -0700 (PDT)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id s123sm15164558pgs.2.2017.07.22.23.02.20
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jul 2017 23:02:20 -0700 (PDT)
Message-ID: <59743bec.812c630a.d4932.1307@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 23 Jul 2017 14:02:15 +0800
Subject: [ANNOUNCE] fstests: master branch updated to 22ea2f8c0a89
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wU9yvJqmWpAo"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--wU9yvJqmWpAo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is mainly a bug-fix update with only one new test
added. One test to note is that generic/441 is improved to run basic test if
there's no external log device configured, it was a _notrun previously, but it
should pass with 4.13-rc1 kernel. Thanks to all who have contributed to this
update!

New failures I've noticed in this update:
- generic/449 fails on extN filesystems (with ext2 driven by ext4 driver), the
  group permission was changed after a failed setfacl

Thanks,
Eryu

The new head of the master branch is commit:

22ea2f8c0a89 generic/192: use shorter sleep and tolerate 2s delay

New commits:

Eric Biggers (2):
      [fe7748f097b3] generic/421: stop test from hanging on buggy kernels
      [22ea2f8c0a89] generic/192: use shorter sleep and tolerate 2s delay

Ernesto A. Fernández (3):
      [fffff547d2fa] common/rc: support jfs in _scratch_mkfs_sized
      [c82ca8fd263c] common/attr: fix check for _require_attrs()
      [e1f216ddf6de] generic: add test of file mode when setfacl fails

Jeff Layton (1):
      [3d2b24042163] generic: add a less thorough testing mode for fsync-err program


Code Diffstat:

 common/attr           |  2 +-
 common/rc             | 15 ++++++++
 src/fsync-err.c       | 51 +++++++++++++++++----------
 tests/generic/192     | 13 +++----
 tests/generic/192.out |  6 ++--
 tests/generic/421     |  2 +-
 tests/generic/441     | 23 ++++++++----
 tests/generic/449     | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/449.out |  2 ++
 tests/generic/group   |  1 +
 10 files changed, 175 insertions(+), 38 deletions(-)
--
Eryu Guan
eguan@redhat.com

--wU9yvJqmWpAo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJZdDkMAAoJECZSqilcj+dj3AYP/1IUO7oIScGkWDUt9STtCf6k
5t1h0Xfl+jq4qSS7EKk3vRD/nUcl5yFt4hRlcmIHj2GuiAGyDpiFUf3o0cvuOrNE
ic6peWfgdG5yDMJugyMcapfPXxV197KCN/WxrFC8va9bHyypmidwYaFRHS0DgCEd
5ItmE5/HP69bJEYycPcwXD+x4lAyBYazg6N1bBZw9zRmNc+4MxuqZwxcjLDsJ+4C
O5ximjVHFjN5Bcv6jgtOK8bV2BDQp3vq/BNCu5YGh4NWJa2A5HWz31qdR1XYuw3L
YfMslOP7zDyZ35Axzvm1LURlCnFaORPnsS/HTokdWB3WhfjXnE3ghvFTKSz9FXk2
Ur2C3QNJKCOXPTqr23NiDm336lJGFiqoSreGt2+nTnwmG6QpNfU15lV2Q/BSm+99
JhhyGXwb/33iShFyPcG8Ktg2UTM4Zr3BZ9oT+b3Z0S5bVLu/voglBVjN2Qwr5n0Z
PV244h52MI3OKEtBcP2LjJiZVftfdfcz2ubbz5ZJtsvv8oCcHDR5Ehlqx8gSq62t
sjlxTUjXuunNE4XHlpZ3vxIjxaAfgPNs/kPRjLuVfkQZCy6rtmtFqH7jrjoJSQ/F
S8lZxzpaKL1hLgVQIkFuFmDlDT6Y2TnYyPJgqP8GXum54axBXwlM2H4gRl/RodxB
ynYh1r2lnL8S9ei2DJev
=fMxt
-----END PGP SIGNATURE-----

--wU9yvJqmWpAo--
