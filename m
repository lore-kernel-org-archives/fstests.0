Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2E7C433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 26 Sep 2021 15:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B1906108E
	for <linux-fstests@archiver.kernel.org>; Sun, 26 Sep 2021 15:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhIZPIs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 26 Sep 2021 11:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbhIZPIs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 26 Sep 2021 11:08:48 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B690C061570
        for <fstests@vger.kernel.org>; Sun, 26 Sep 2021 08:07:12 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d21so43960723wra.12
        for <fstests@vger.kernel.org>; Sun, 26 Sep 2021 08:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=SWi55z++n7ta2ua+7yt3EWZjPRoYxJxTiBQRJ52mQTM=;
        b=TwlfgljBxJ4P+4uiCHTKi5y8N8ZsvEJVyMCs1cOnrkpHAuhQ0u0jCUL8YZ6MTr0NlQ
         XMQb1pQdfQGH7ownXHeIW5MouFUoeozzOqqyNqCTn2n88x9S1Yv/pm9Kj839JweKJs9q
         gcPX/xCCyc0m8Vsjw3qCAX84CgrtbUGBJd8qgjOPouMzeWJAPBKOCsFNtCvN24OkrYxR
         Ir4B/9rkM3erFCvIa+WbSK8CI1eG5AvAFSKoA905jriy0U9iyiNbXcvM+mNHj/nuwngm
         ps3gog4dsG7vpgORbXnDCuRUHXf5BIfY5QCO92Vn9CQ6O/gui29fC5/AtAiUWrIOyTfE
         a7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=SWi55z++n7ta2ua+7yt3EWZjPRoYxJxTiBQRJ52mQTM=;
        b=R/RGU6iOHQU2pYWRyW1VMDkeIKj8Fynrh+6agXe8AA707cfovGga1uJs2J0a5Qxxb3
         3vUnC8Y9y72gh4SYWsS6tur+COUJaF5JKdD9aPqYX8F9DC3OoeJdu0MDHkfphZ6R0I3M
         p3GBG74PeVK5A75bcfXOHU8e2gW9pOGPjC5D0+/Ciz8laAnLj8xR6U5HVqVdqIinEg1E
         n4ZTAsIZDmteQksgwSUoLnxFuyaTgCx+4S3YHmgHr1StRBeK9Yj3b1Gzl1dCxfN6I9DE
         VNitouwWw37CjUw3P7XDZQXVwCERCdjXVrsInYHPch1T80j374lxmMwe/adHTFQ+8kG3
         cORw==
X-Gm-Message-State: AOAM532kDR1sFZBwy9q2ZuAQcl5ZikdiJUcgn4E3Rg43sG5CXj2wNCYY
        qSk8PHDXvtsrJjom9yQIZpz8N/xJizyjnQ==
X-Google-Smtp-Source: ABdhPJyOVHuecywyK407Z1izsHzyMvn1l3HnxWBxT50fcEX2M1Y45PyMxzCMzHeYDHr7b5UezauvlQ==
X-Received: by 2002:adf:dd01:: with SMTP id a1mr22983913wrm.132.1632668830297;
        Sun, 26 Sep 2021 08:07:10 -0700 (PDT)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id u14sm12463979wml.24.2021.09.26.08.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 08:07:09 -0700 (PDT)
Message-ID: <61508c9d.1c69fb81.c72ff.6a53@mx.google.com>
Date:   Sun, 26 Sep 2021 23:07:05 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 344319453e8c
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Xgi0iv4dvGep"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--Xgi0iv4dvGep
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. One notable update is that Darrick helped document all
the test groups in doc/group-names.txt file, and made sure all groups of new
tests are defined in this file. Huge thanks to Darrick! Also many thanks to
Amir for reviewing this change!

The other updates are normal new tests & bugfixes. And I didn't notice any new
failures introduced by this update.

And it is public holiday from 1st Oct. to 7th Oct, I'll be on travel and have
limit internet access, so probably there won't be an update next week either,
but I'll still keep an eye on the list when possible :)

Thanks,
Eryu

The new head of the master branch is commit:

344319453e8c new: don't allow new tests in group 'other'

New commits:

Amir Goldstein (1):
      [bc26f13f6dfe] overlay: fix documented kernel commit ids

Ari Sundholm (1):
      [285c8e8a2d30] generic/361: require sparse file support and fix mounting the volume.

Darrick J. Wong (21):
      [fff8ae273534] generic: regression test for a FALLOC_FL_UNSHARE bug in XFS
      [d9f1b96b33e0] xfs: test DONTCACHE behavior with the inode cache
      [189eb6048564] xfs/108: sync filesystem before querying quota
      [410a2e3186a1] xfs: regresion test for fsmap problems with realtime
      [69613c2b0989] common/rc: re-fix detection of device-mapper/persistent memory incompatibility
      [9059da865899] common/rc: use directio mode for the loop device when possible
      [df4ffa35bf5a] xfs: test fsx with extent size hints set on a realtime file
      [b5e0b5f216da] xfs: test correct propagation of rt extent size hints on rtinherit dirs
      [74bbff883095] xfs: test adding realtime sections to filesystem
      [4174d883cffd] generic: fsstress with cpu offlining
      [b85dab5bc91a] ceph: re-tag copy_file_range as being in the copy_range group
      [6665bd9f4d85] xfs: move reflink tests into the clone group
      [99d5d77946a3] xfs: fix incorrect fuzz test group name
      [a2fd08bc83f2] btrfs: fix incorrect subvolume test group name
      [7e769ca8dce9] generic/631: change this test to use the 'whiteout' group
      [6dd78fdf65cb] tools: make sure that test groups are described in the documentation
      [5fa780ee6427] tools: add missing license tags to my scripts
      [797dcac566a0] new: only allow documented test group names
      [6fe95af39557] new: clean up the group name input code
      [401a1e5043fa] new: standardize group name checking
      [344319453e8c] new: don't allow new tests in group 'other'

Filipe Manana (1):
      [02b9a880aed7] btrfs/179: fix test failure when there are no snapshots to delete

Luis Chamberlain (2):
      [b47ea0c69737] common/module: use patient module removal
      [91b2c035346b] fsstress: fix bogus compile warning do_renameat2()

Shin'ichiro Kawasaki (2):
      [070bdc3cc487] generic/{628,629}: fix order of _require_scratch* and _require_dm_target
      [b2fdc58725be] btrfs/146: require scratch dev and pool before _require_dm_target


Code Diffstat:

 common/module         |   6 +-
 common/preamble       |  21 +++++
 common/rc             |  26 ++++++-
 doc/group-names.txt   | 135 ++++++++++++++++++++++++++++++++
 ltp/fsstress.c        |   4 +-
 new                   |  94 ++++++++++++-----------
 tests/btrfs/146       |   5 +-
 tests/btrfs/179       |   4 +
 tests/btrfs/233       |   2 +-
 tests/btrfs/245       |   2 +-
 tests/ceph/001        |   2 +-
 tests/ceph/002        |   2 +-
 tests/ceph/003        |   2 +-
 tests/generic/361     |   3 +-
 tests/generic/628     |   2 +-
 tests/generic/629     |   2 +-
 tests/generic/631     |   2 +-
 tests/generic/649     |  77 +++++++++++++++++++
 tests/generic/649.out |   2 +
 tests/generic/650     |  74 ++++++++++++++++++
 tests/generic/650.out |   2 +
 tests/overlay/077     |   5 +-
 tests/overlay/078     |   4 +-
 tests/xfs/108         |   2 +
 tests/xfs/177         | 207 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/177.out     |  18 +++++
 tests/xfs/185         | 185 ++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/185.out     |   2 +
 tests/xfs/187         | 159 ++++++++++++++++++++++++++++++++++++++
 tests/xfs/187.out     |   3 +
 tests/xfs/419         |  81 ++++++++++++++++++++
 tests/xfs/419.out     |   5 ++
 tests/xfs/491         |   2 +-
 tests/xfs/492         |   2 +-
 tests/xfs/493         |   2 +-
 tests/xfs/519         |   2 +-
 tests/xfs/520         |   2 +-
 tests/xfs/535         |   2 +-
 tests/xfs/536         |   2 +-
 tests/xfs/540         |  59 ++++++++++++++
 tests/xfs/540.out     |   5 ++
 tests/xfs/541         | 114 +++++++++++++++++++++++++++
 tests/xfs/541.out     |   2 +
 tools/mkgroupfile     |  37 ++++++---
 tools/mvtest          |   5 +-
 tools/nextid          |   4 +-
 46 files changed, 1294 insertions(+), 86 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--Xgi0iv4dvGep
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmFQgGgACgkQJlKqKVyP
52P3eQ/7BZ9iLwlmA71lgoS57JoHR9J2Nk4CXOuoIuM887nkNXO+rv7zWfVQccGy
Krccy3CtTqwc1+5H6tdBcMzrfLkJrtYb5nHGxWOQBTiXUokeYIBUzwCvwIeWQZa9
dnLcswvXimeVOJs67cBFQqMSsVH7Vk71APTWRl1suJI+6NsJjxCCeUICRjgsS4cl
fBAcPAA5QpOyatGJP66pVHN5lokYj2EAyEJ7MtcvH+a878P97ty0DN/Nx5W/YK5x
3vwdccssaQYyMSpeTvel4hnZmtBKGTEXv5kTu4d8aT2cPZCsE9nHNmtDX6F//qe/
QFrBrAmNKLola5AGUTfgXmFzAswiE884Ne/v1flRgqhuJEeWxYnRjgJqku6v+ham
5MhB/GNEaPoZ9c1+Tetd9Mk84x9D7bIsWSm5VdGn15hT5hD+62n+Kcfz4ihON2Nb
rJGqmEoKI03Srp5fI1HB7yIteBl8lGbdM6F6LgU5aJjqJhtFUIbq4jQD+xqZ1XZH
6SHerFxYU7Bn57qL304Lvqgfh+dDwUIBTHClLjzyiqAZndUE76Wgd9DV2QKQCkQQ
vigLxbGLIVKx8IdJYuPP1aqkdSZPh5QWNcedJNUeRY5GpRWt6XKhv5y7frMty+8o
HahFsVZE1DjJyjYqmc83dHAR75z/sweU8NRNQ3BUkg68t5SpQmQ=
=D4G8
-----END PGP SIGNATURE-----

--Xgi0iv4dvGep--
