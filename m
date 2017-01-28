Received: from mx1.redhat.com ([209.132.183.28]:33194 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751286AbdA1Msa (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 28 Jan 2017 07:48:30 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B27B981231
        for <fstests@vger.kernel.org>; Sat, 28 Jan 2017 12:39:59 +0000 (UTC)
Received: from localhost (ovpn-12-16.pek2.redhat.com [10.72.12.16])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id v0SCdw9g014782
        for <fstests@vger.kernel.org>; Sat, 28 Jan 2017 07:39:59 -0500
Message-Id: <201701281239.v0SCdw9g014782@int-mx11.intmail.prod.int.phx2.redhat.com>
Date: Sat, 28 Jan 2017 20:39:56 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: [ANNOUNCE] fstests: master branch updated to 519fc392af58
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bDsIYRCNZKL4"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--bDsIYRCNZKL4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a pretty big update that contains mainly xfs
fuzz and repair & scrub tests from Darrick. You need to install Darrick's
kernel & userspace development tree if you want to run these tests. There're
also new btrfs and generic tests, bug fixes in tests and tools. Big thanks to
Darrick, and others who have contributed/reviewed patches!

>From today to Feb. 3rd is Chinese New Year holiday, so I probably won't spend
much time reviewing & testing patches, my response could be slow too. I'll try
to keep the weekly update frequency, but no promise for next week :)

New failures I've noticed in this update:
- btrfs/047 fails on current 4.10-rc5 kernel

Thanks,
Eryu

The new head of the master branch is commit:

519fc392af58 generic: splitted large dio write could trigger assertion on btrfs

New commits:

Darrick J. Wong (12):
      [7d8fc2aff395] populate: create all types of XFS metadata
      [8eaf59b7c337] populate: add _require_populate_commands to check for tools
      [a7f8305f9a10] populate: optionally fill the filesystem when populating fs
      [7a7463d362cd] populate: fix some silly errors when modifying a fs while fuzzing
      [dac5feaea73a] common/fuzzy: move fuzzing helper functions here
      [d6445ed41ab8] populate: cache scratch metadata images
      [802f780868ab] populate: discover XFS structure fields and fuzz verbs, and use them to fuzz fields
      [898e0cf2a46e] common/populate: create attrs in different namespaces
      [f5f0c11a67a8] xfs: fuzz every field of every structure
      [4bf2c4461c70] mvtest: change "FSQA Test No." when we renumber tests
      [614e33f1b56b] xfs: test xfs_db source command
      [e53034c5b110] xfs/122: reduce xfs_dsb_t size

Eryu Guan (1):
      [aec50848c3d2] tools/nextid: pad 0 in next test id seq number

Liu Bo (1):
      [519fc392af58] generic: splitted large dio write could trigger assertion on btrfs

Omar Sandoval (1):
      [06e8d3e000c8] btrfs: setxattr on subvolume directory

Xiao Yang (1):
      [58da38734d16] fstests: fix wrong seq number in test


Code Diffstat:

 common/fuzzy          | 344 ++++++++++++++++++++++++++++++++++++++++++++++++++
 common/populate       | 248 ++++++++++++++++++++++++++++--------
 common/rc             |   3 +-
 tests/btrfs/047       |  69 ++++++++++
 tests/btrfs/047.out   |   2 +
 tests/btrfs/group     |   1 +
 tests/ext4/006        |   2 +
 tests/ext4/023        |  60 +++++++++
 tests/ext4/023.out    |   3 +
 tests/ext4/group      |   1 +
 tests/generic/381     |   2 +-
 tests/generic/382     |   2 +-
 tests/generic/383     |   2 +-
 tests/generic/400     |   2 +-
 tests/generic/406     |  74 +++++++++++
 tests/generic/406.out |   2 +
 tests/generic/group   |   1 +
 tests/shared/005      |   2 +-
 tests/shared/007      |   2 +-
 tests/xfs/083         |   4 +-
 tests/xfs/085         |   1 +
 tests/xfs/086         |   1 +
 tests/xfs/087         |   1 +
 tests/xfs/088         |   1 +
 tests/xfs/089         |   1 +
 tests/xfs/091         |   1 +
 tests/xfs/093         |   1 +
 tests/xfs/097         |   1 +
 tests/xfs/098         |   1 +
 tests/xfs/099         |   1 +
 tests/xfs/100         |   1 +
 tests/xfs/101         |   1 +
 tests/xfs/102         |   1 +
 tests/xfs/105         |   1 +
 tests/xfs/112         |   1 +
 tests/xfs/113         |   1 +
 tests/xfs/117         |   1 +
 tests/xfs/120         |   1 +
 tests/xfs/122.out     |   2 +-
 tests/xfs/123         |   1 +
 tests/xfs/124         |   1 +
 tests/xfs/125         |   1 +
 tests/xfs/126         |   1 +
 tests/xfs/133         |   2 +-
 tests/xfs/134         |   2 +-
 tests/xfs/138         |  66 ++++++++++
 tests/xfs/138.out     |  11 ++
 tests/xfs/269         |   1 +
 tests/xfs/273         |   1 +
 tests/xfs/349         |  63 +++++++++
 tests/xfs/349.out     |   3 +
 tests/xfs/350         |  60 +++++++++
 tests/xfs/350.out     |   4 +
 tests/xfs/351         |  60 +++++++++
 tests/xfs/351.out     |   4 +
 tests/xfs/352         |  60 +++++++++
 tests/xfs/352.out     |   4 +
 tests/xfs/353         |  60 +++++++++
 tests/xfs/353.out     |   4 +
 tests/xfs/354         |  65 ++++++++++
 tests/xfs/354.out     |   6 +
 tests/xfs/355         |  65 ++++++++++
 tests/xfs/355.out     |   6 +
 tests/xfs/356         |  60 +++++++++
 tests/xfs/356.out     |   4 +
 tests/xfs/357         |  60 +++++++++
 tests/xfs/357.out     |   4 +
 tests/xfs/358         |  60 +++++++++
 tests/xfs/358.out     |   4 +
 tests/xfs/359         |  60 +++++++++
 tests/xfs/359.out     |   4 +
 tests/xfs/360         |  60 +++++++++
 tests/xfs/360.out     |   4 +
 tests/xfs/361         |  60 +++++++++
 tests/xfs/361.out     |   4 +
 tests/xfs/362         |  60 +++++++++
 tests/xfs/362.out     |   4 +
 tests/xfs/363         |  60 +++++++++
 tests/xfs/363.out     |   4 +
 tests/xfs/364         |  60 +++++++++
 tests/xfs/364.out     |   4 +
 tests/xfs/365         |  60 +++++++++
 tests/xfs/365.out     |   4 +
 tests/xfs/366         |  61 +++++++++
 tests/xfs/366.out     |   4 +
 tests/xfs/367         |  61 +++++++++
 tests/xfs/367.out     |   4 +
 tests/xfs/368         |  61 +++++++++
 tests/xfs/368.out     |   4 +
 tests/xfs/369         |  61 +++++++++
 tests/xfs/369.out     |   4 +
 tests/xfs/370         |  62 +++++++++
 tests/xfs/370.out     |   4 +
 tests/xfs/371         |  62 +++++++++
 tests/xfs/371.out     |   4 +
 tests/xfs/372         |  62 +++++++++
 tests/xfs/372.out     |   4 +
 tests/xfs/373         |  62 +++++++++
 tests/xfs/373.out     |   4 +
 tests/xfs/374         |  65 ++++++++++
 tests/xfs/374.out     |   5 +
 tests/xfs/375         |  65 ++++++++++
 tests/xfs/375.out     |   5 +
 tests/xfs/376         |  65 ++++++++++
 tests/xfs/376.out     |   5 +
 tests/xfs/377         |  65 ++++++++++
 tests/xfs/377.out     |   5 +
 tests/xfs/378         |  65 ++++++++++
 tests/xfs/378.out     |   5 +
 tests/xfs/379         |  65 ++++++++++
 tests/xfs/379.out     |   5 +
 tests/xfs/380         |  67 ++++++++++
 tests/xfs/380.out     |   5 +
 tests/xfs/381         |  67 ++++++++++
 tests/xfs/381.out     |   5 +
 tests/xfs/382         |  65 ++++++++++
 tests/xfs/382.out     |   5 +
 tests/xfs/383         |  65 ++++++++++
 tests/xfs/383.out     |   5 +
 tests/xfs/384         |  65 ++++++++++
 tests/xfs/384.out     |   5 +
 tests/xfs/385         |  65 ++++++++++
 tests/xfs/385.out     |   5 +
 tests/xfs/386         |  65 ++++++++++
 tests/xfs/386.out     |   5 +
 tests/xfs/387         |  65 ++++++++++
 tests/xfs/387.out     |   5 +
 tests/xfs/388         |  66 ++++++++++
 tests/xfs/388.out     |   5 +
 tests/xfs/389         |  66 ++++++++++
 tests/xfs/389.out     |   5 +
 tests/xfs/390         |  67 ++++++++++
 tests/xfs/390.out     |   5 +
 tests/xfs/391         |  67 ++++++++++
 tests/xfs/391.out     |   5 +
 tests/xfs/392         |  67 ++++++++++
 tests/xfs/392.out     |   5 +
 tests/xfs/393         |  67 ++++++++++
 tests/xfs/393.out     |   5 +
 tests/xfs/394         |  67 ++++++++++
 tests/xfs/394.out     |   5 +
 tests/xfs/395         |  67 ++++++++++
 tests/xfs/395.out     |   5 +
 tests/xfs/396         |  67 ++++++++++
 tests/xfs/396.out     |   5 +
 tests/xfs/397         |  67 ++++++++++
 tests/xfs/397.out     |   5 +
 tests/xfs/398         |  65 ++++++++++
 tests/xfs/398.out     |   5 +
 tests/xfs/399         |  65 ++++++++++
 tests/xfs/399.out     |   5 +
 tests/xfs/400         |  65 ++++++++++
 tests/xfs/400.out     |   5 +
 tests/xfs/401         |  65 ++++++++++
 tests/xfs/401.out     |   5 +
 tests/xfs/402         |  65 ++++++++++
 tests/xfs/402.out     |   5 +
 tests/xfs/403         |  65 ++++++++++
 tests/xfs/403.out     |   5 +
 tests/xfs/404         |  65 ++++++++++
 tests/xfs/404.out     |   5 +
 tests/xfs/405         |  65 ++++++++++
 tests/xfs/405.out     |   5 +
 tests/xfs/406         |  64 ++++++++++
 tests/xfs/406.out     |   4 +
 tests/xfs/407         |  64 ++++++++++
 tests/xfs/407.out     |   4 +
 tests/xfs/408         |  62 +++++++++
 tests/xfs/408.out     |   4 +
 tests/xfs/409         |  62 +++++++++
 tests/xfs/409.out     |   4 +
 tests/xfs/410         |  62 +++++++++
 tests/xfs/410.out     |   4 +
 tests/xfs/411         |  62 +++++++++
 tests/xfs/411.out     |   4 +
 tests/xfs/412         |  65 ++++++++++
 tests/xfs/412.out     |   5 +
 tests/xfs/413         |  65 ++++++++++
 tests/xfs/413.out     |   5 +
 tests/xfs/414         |  65 ++++++++++
 tests/xfs/414.out     |   5 +
 tests/xfs/415         |  65 ++++++++++
 tests/xfs/415.out     |   5 +
 tests/xfs/416         |  65 ++++++++++
 tests/xfs/416.out     |   5 +
 tests/xfs/417         |  65 ++++++++++
 tests/xfs/417.out     |   5 +
 tests/xfs/418         |  60 +++++++++
 tests/xfs/418.out     |   4 +
 tests/xfs/group       |  71 +++++++++++
 tools/mvtest          |   4 +-
 tools/sort-group      |   2 +-
 192 files changed, 5716 insertions(+), 68 deletions(-)
--
Eryu Guan
eguan@redhat.com

--bDsIYRCNZKL4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJYjI9lAAoJECZSqilcj+djwRsP/jQLGgLdSs6h4u9WGYH0o48m
5Pt8ACl8VzVxJexeEIEHALQplnoSEXxC7VITAHMSL1AUeE/ktZhYPtHKmXmu55v/
IJ2Gy3UgFKIK/0+5Q1TnDCtN11Zg6PsubRfjgmIjmRCHzHjWi4OA4OTrLlqNQ9QB
NWT+9D2owL6nifz7uMxot7XsI5tQLUdwHqYOX86O27S22S9RvkMLPkDaqFU5WEK3
y+F/geVSR7ZkEkoAJgqIVD88H3odZNedrXXYGMZeY6DDXH65dxwudmhRtAIso3iB
o1Qw8junVI4TLEeqNVPxCqlDgPYYJdJztq8bZxzfqlu5xePcsdGxJ3KBEkFzol4o
Rbk1JTfRoR6EKBks4m2iAAwegrEVWxODGXC9WOUzguk5Ew1arRHsxDrAS9uf+kpV
nxhk1mYVmNan8S0HWyk475oAvhaIniFYOS5/iimNBpHanPtw/CvEgp60+aGYd2hw
h2sq7E9rFI9BxTBiJaA6D62X+5cKog/JUkjKaZgewYFNcpuJDUePC/S8xKlgET6R
6sKOOXvePMRWgSfmDXWV/I7313VjI8w39hdWCVGrZIzvlxqxWUBYUYZwUxzUeBS0
+VREm05sRTm8/KQ5N3Lf4DAs9gM+zCZFzR7nkWTifmknF6Wl/3wiW5U9C6qaDNQM
GP+U6r1y+qLv2gXRuZt0
=VW9M
-----END PGP SIGNATURE-----

--bDsIYRCNZKL4--
