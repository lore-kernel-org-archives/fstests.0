Received: from mail-pg0-f48.google.com ([74.125.83.48]:34082 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751786AbdGIKJq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 9 Jul 2017 06:09:46 -0400
Received: by mail-pg0-f48.google.com with SMTP id t186so36104770pgb.1
        for <fstests@vger.kernel.org>; Sun, 09 Jul 2017 03:09:46 -0700 (PDT)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id r69sm16982278pfg.28.2017.07.09.03.09.39
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Jul 2017 03:09:39 -0700 (PDT)
Message-ID: <596200e3.48d6620a.a568d.41c1@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 09 Jul 2017 18:09:34 +0800
Subject: [ANNOUNCE] fstests: master branch updated to ab803945aec1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="D05eRCjJ2VFS"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--D05eRCjJ2VFS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. There're many overlayfs test updates in this release,
Amir enhanced overlay hardlink tests and zhangyi improved whiteout tests. Other
than that, there's also a new scrub test for XFS from Darrick and some random
bug fixes.

New failures I've noticed in this update:
- overlay/032 and overlay/033 are new tests to test copyups of hardlinks, which
  is broken at this moment

Thanks,
Eryu

The new head of the master branch is commit:

ab803945aec1 xfs/297: fail test if _scratch_mount fails

New commits:

Amir Goldstein (7):
      [a76feb07aa9f] overlay/018: re-factor and add to hardlink group
      [35965a3dfdb0] overlay/018: print hardlink content to golden output
      [a48fc5d3e9c1] overlay/018: test broken hardlinks after mount cycle
      [004a78036ece] overlay/018: test lower hardlinks re-unite on copy up
      [7b4d655bb815] overlay: test concurrent copy up of lower hardlinks
      [af55e91fd2ea] overlay: test nlink accounting of overlay hardlinks
      [c7169fada68c] overlay: test dropping nlink below zero

Brian Foster (1):
      [ab803945aec1] xfs/297: fail test if _scratch_mount fails

Darrick J. Wong (4):
      [ea39bbf3dea2] common/populate: remember multi-device configurations
      [7c0af043221a] common/rc: test that the xfs_io scrub/repair commands actually work
      [c28b406918d4] ext4: don't online scrub ever
      [1b6d979780d3] xfs: scrub while appending to a file

Eric Biggers (1):
      [eeea532122f8] generic/095, generic/247: unmount correct devices

Xiao Yang (1):
      [65fd511691ac] generic/446: add __xfs_get_blocks() into _filter_xfs_dmesg

zhangyi (F) (2):
      [537d954b7db7] overlay/031: factor out _create_whiteout() helper
      [bbe93c0e7546] overlay/031: add tests of whiteouts in lowerdir and both dirs


Code Diffstat:

 common/fuzzy          |   4 +-
 common/populate       |  13 ++++-
 common/rc             |   5 ++
 common/xfs            |   4 +-
 tests/ext4/023        |   7 ++-
 tests/ext4/023.out    |   2 +-
 tests/generic/095     |   4 ++
 tests/generic/247     |   2 +-
 tests/overlay/018     |  60 ++++++++++++++++----
 tests/overlay/018.out |  21 ++++++-
 tests/overlay/031     |  84 +++++++++++++++++++++-------
 tests/overlay/032     | 109 ++++++++++++++++++++++++++++++++++++
 tests/overlay/032.out |   4 ++
 tests/overlay/033     | 150 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/033.out |  69 +++++++++++++++++++++++
 tests/overlay/034     | 107 +++++++++++++++++++++++++++++++++++
 tests/overlay/034.out |   2 +
 tests/overlay/group   |   5 +-
 tests/xfs/297         |   2 +-
 tests/xfs/423         |  82 +++++++++++++++++++++++++++
 tests/xfs/423.out     |   6 ++
 tests/xfs/group       |   1 +
 22 files changed, 699 insertions(+), 44 deletions(-)
--
Eryu Guan
eguan@redhat.com

--D05eRCjJ2VFS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJZYa2dAAoJECZSqilcj+dj6fUQAIloooz4xBjynQ1oE5yQ2cia
80D7CB+/7jxPp5EnSYdsSxstW8kueKJW8mKFObQLJpZLZfiMSNF8Y7mZTUIeFZBJ
RKDa2HJEelUBo2T+Daxs2qY12O8VZQ0Z33sGOOzEMMhFA8aDIipt3UWb9qvoM5Ou
N68oP7DkP2ucrpMeeAiggVQ/45iok9OWSIm7w9WBwXZwNYWI66/WTPyqZusWyMNB
QiJv35eMK8hmW+yHEHCeHuqnSvxQyMl3ipHz/YNUQQUyhJ0fbbe8pNly8mEw1Yws
PUGceKlMnZeVkOEBeFnZ4urWPfsf35kPcIzkV8AFwcMz6LygCjF1W6msCBQIfyQO
mjoDOmr60LMPIuYauamlrw2Jg2N2wKlnNOC0XKlbBKwo+qK6A/xpYWRjpx64R1xN
4iQh7uXnCZpG7XMRkqxTpYLE+1Q77gXnw73jxKkcCGopj32a2rP945BCvorSaSa9
gDKgP9ySurrj0ecygYHAoPczeK26zD58dhduqSc21q8vGx/if/5dieLWDJCjcDJa
QX1/YMiHopTOk9c8Nijyeu+gG1LfbRAXuiu1HYlTjXfFbe1fYg3illiBIGkSXwZe
jefLUCX+UhKPcw04xBQ/0jl+3sDkGQloy5PFFMpoSbiF6MKfxFDIOjPBWR6lfi7l
Nbz2DXO3obh1GGkq2622
=U3Xk
-----END PGP SIGNATURE-----

--D05eRCjJ2VFS--
