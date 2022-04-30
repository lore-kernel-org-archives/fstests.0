Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3E4C433F5
	for <linux-fstests@archiver.kernel.org>; Sat, 30 Apr 2022 19:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbiD3TMu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 30 Apr 2022 15:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiD3TMt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 30 Apr 2022 15:12:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5156F8E1AA
        for <fstests@vger.kernel.org>; Sat, 30 Apr 2022 12:09:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id ACF86CE0025
        for <fstests@vger.kernel.org>; Sat, 30 Apr 2022 19:09:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC56C385A7;
        Sat, 30 Apr 2022 19:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651345761;
        bh=OYLEcpSbDBnte4K+NbTqQysCz6aGv7crQWxWqjz93rs=;
        h=Date:From:To:Subject:From;
        b=T+rQg6bXSWVjvjLXHLrEl/zmpw+efkwjMjVpjbLJE4eiEE85oNo8tfhY39aELw9/R
         odASuoERMAECLbAvAjNGVEHxey4CamVKRElK128Vlgfpnfu9Wc1e0B154F0VbHJhmZ
         jkmzDzYpDEs2tGTMbIjQebFjWFim9GtWtPMvGIvFZo395gfDPlWnLo+Yuzz+2mUN+o
         WG8Dy9qiwsoBpYOH4UxloiTehYNfaQkgM2sAxElcK34kFyKcSb4Xf5mmjJlv/gKFfZ
         OFUFKcclKpi/O1Q6AqkNbA2QfgbJ/rnPn40Kg8KpeA+IQs3wmJKUKlnA+fEiNntPMI
         EIC2mHunqs22Q==
Date:   Sun, 01 May 2022 03:09:13 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to bb04d577435d
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VGdgslCgeMyO"
Content-Disposition: inline
Message-Id: <20220430190921.7BC56C385A7@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--VGdgslCgeMyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged for a v2022.05.01 release.

This's the first time for me to release a new fstests version. I just got the
maintaining job from Eryu. Thanks Eryu, for his long time contribution and help
to fstests project!

As you can see, I just updated on a new branch. From now on, I make two changes
for later fstests release:

1) A new offical branch -- for-next

You might notice that fstests has two old enough remote branches named
origin/mmap-truncate and origin/upstream-queue, it's been ~10 years we never
touched these two branches, so I've removed them after talking with other
maintainers.

After remove these two branches, I create a new 'for-next' branch. I'll merge
and push new patches to "for-next" branch at first, and leave one (maybe more,
sometimes) week "Soak period" to the for-next release. I'll test new patches
before push them, but it's hard for me to test all things which fstests support.
So I decide to leave about one week to let other users use it. Welcome more
using and testing on this branch, and find big issues as soon as better. That's
what the for-next branch aims to.

If there's big regression on for-next branch, I will fix on for-next branch and
push it next time. If there's not big regression issue, I'll merge for-next
to master and push master, then update and push new for-next release too.

For example, as below, this week I pushed for-next R1', next time I'll push
for-next R2' and master R1. Next next time will be for-next R3' and master R2,
and so on... If there's a big regression issue on R3', I will try to fix it in
next R4', and master branch has to wait one more week to merge and push R4.

                                           (fix regression)
  for-next ----> R1' ----> R2' -----> R3' -----------------> R4' -----> R5'
     ^           |         |                                 |
     | (fork)    | (merge) | (merge)                         | (merge)
     |           V         V                                 V
  master   ----> R1 -----> R2 -----------------------------> R4
  (orig)

So if you prefer latest fstests, or contributing fstests, please use for-next.
Or you can keep using master branch.

And of course, there might be some topic(/unstable/temporary) branches appear,
those branches might be rebase / reset / delete ... so don't rely on them too
much.

2) Push signed version tag for new release.

I start to push singed (by me) version tag each time I push to for-next branch.
The version format is "v$(date +%Y.%m.%d)", e.g. "v2022.05.01".

Thanks,
Zorro

The new head of the for-next branch is commit:

bb04d577435d fstests: add some missing _require_loop's

New commits (N=New case, U=Update, D=Delete case):

Christian Brauner (1):
(N)      [31c01ce18f73] generic: add test for tmpfs POSIX ACLs

Chung-Chiang Cheng (1):
(N)      [987700db300d] fstests: btrfs: test setting compression via xattr on nodatacow files

Darrick J. Wong (4):
(U)      [af8aeeea48d0] xfs/019: fix golden output for files created in setgid dir
(U)      [ad5f89ef3013] generic/019: fix incorrect unset statements
(N)      [7f27a290aca8] xfs: make sure syncfs(2) passes back super_operations.sync_fs errors
(N)      [e81417a0964a] generic: ensure we drop suid after fallocate

Eric Sandeen (2):
(N)      [80a82f6926fa] xfs: test xfsdump when an inode < root inode is present
(D)      [7753e08d22e9] fstests: remove xfs/144

Jan Kara (2):
(U)      [858a19c5e9b0] idmapped_mounts: Prepare for support for more features
(U)      [95c10ab90c28] generic/633: Avoid failure without CONFIG_USER_NS

Josef Bacik (1):
(U)      [bb04d577435d] fstests: add some missing _require_loop's

Murphy Zhou (1):
(U)      [0fd8e26141f5] chown: fix ownership format string

Rishabh Dave (1):
(U)      [1dac95cb0d6e] cephfs: add ceph-fuse suport for ceph-fuse

Theodore Ts'o (1):
(U)      [5528f7843b1a] generic/681, generic/682: add debugging information to $seqreq.full

Yang Xu (1):
(U)      [298f60c81a93] generic/673: Add separate sgid stripping sub-tests

Zorro Lang (2):
(U)      [380ee98d92e6] fstests: remove _wipe_fs from dump testing entirely
(U)      [ab47e281b70f] fsstress: remove ALLOCSP and FREESP operations entirely


Code Diffstat:

 common/config                         |   2 +
 common/dump                           |  23 +--
 common/rc                             |  47 +++++--
 ltp/fsstress.c                        | 117 ----------------
 src/idmapped-mounts/idmapped-mounts.c | 257 +++++++++++++++++++++++++++-------
 tests/btrfs/012                       |   1 +
 tests/btrfs/264                       |  91 ++++++++++++
 tests/btrfs/264.out                   |  11 ++
 tests/generic/019                     |   4 +-
 tests/generic/070                     |   2 -
 tests/generic/099                     |   4 +-
 tests/generic/237                     |   2 +-
 tests/generic/318                     |   2 +-
 tests/generic/380                     |   2 +-
 tests/generic/597                     |   6 +-
 tests/generic/598                     |   6 +-
 tests/generic/648                     |   1 +
 tests/generic/673                     |  37 ++++-
 tests/generic/673.out                 |  24 ++++
 tests/generic/681                     |   4 +
 tests/generic/682                     |   4 +
 tests/generic/683                     | 127 +++++++++++++++++
 tests/generic/683.out                 |  33 +++++
 tests/generic/684                     | 127 +++++++++++++++++
 tests/generic/684.out                 |  33 +++++
 tests/generic/685                     | 127 +++++++++++++++++
 tests/generic/685.out                 |  33 +++++
 tests/generic/686                     | 127 +++++++++++++++++
 tests/generic/686.out                 |  33 +++++
 tests/generic/687                     | 127 +++++++++++++++++
 tests/generic/687.out                 |  33 +++++
 tests/generic/688                     |  77 ++++++++++
 tests/generic/688.out                 |  13 ++
 tests/generic/689                     |  33 +++++
 tests/generic/689.out                 |   2 +
 tests/xfs/019                         |   3 +-
 tests/xfs/019.out                     |   2 +-
 tests/xfs/022                         |   3 +
 tests/xfs/023                         |   3 +
 tests/xfs/024                         |   3 +
 tests/xfs/025                         |   3 +
 tests/xfs/026                         |   3 +
 tests/xfs/027                         |   3 +
 tests/xfs/028                         |   7 +-
 tests/xfs/035                         |   7 +
 tests/xfs/036                         |   3 +
 tests/xfs/037                         |   3 +
 tests/xfs/038                         |   3 +
 tests/xfs/039                         |   3 +
 tests/xfs/043                         |   5 +-
 tests/xfs/046                         |   3 +
 tests/xfs/047                         |   7 +-
 tests/xfs/055                         |   4 +
 tests/xfs/056                         |   3 +
 tests/xfs/059                         |   3 +
 tests/xfs/060                         |   3 +
 tests/xfs/061                         |   3 +
 tests/xfs/063                         |   3 +
 tests/xfs/064                         |   3 +
 tests/xfs/065                         |   3 +-
 tests/xfs/066                         |   3 +
 tests/xfs/068                         |   3 +
 tests/xfs/144                         | 128 -----------------
 tests/xfs/144.out                     | 151 --------------------
 tests/xfs/266                         |   3 +
 tests/xfs/267                         |   4 +-
 tests/xfs/268                         |   4 +-
 tests/xfs/281                         |   4 +-
 tests/xfs/282                         |   4 +-
 tests/xfs/283                         |   4 +-
 tests/xfs/296                         |   4 +-
 tests/xfs/301                         |   2 +
 tests/xfs/302                         |   3 +-
 tests/xfs/545                         |  62 ++++++++
 tests/xfs/545.out                     |  47 +++++++
 tests/xfs/546                         |  43 ++++++
 tests/xfs/546.out                     |   2 +
 77 files changed, 1611 insertions(+), 521 deletions(-)
--
Zorro Lang
zlang@kernel.org

--VGdgslCgeMyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmJthscACgkQlNbPkfr2
tMzpbBAAlTj4S8RVddSq3P6t03sJboJEvOAnk3BpmzSZF2zpKcqe8DXf6uYtBKQD
z6fQa5csYAkSQJeMTMgdv9UF0O/KNYvtB3QzTUqZNU+mPZuCNLelL1lgFURz/Ir7
gibLbyBUDf8T1G+omw+ikyFdTK0K0inz69nL5LH5tC+l8wX/peElVJdRAu+v/UK3
1KEUlj3tflr6gLUiTtp0J7LuadGJJciG6EOdD4dCdGIsDqKw0h58jQwkbo66Uxk6
cueWKKFrVl8BVLyOcRxDn19AB1hHAqgAlyxi1zJHLTkt/3zxif7H+6hEzY9isvWO
TbN5U81EY8sXQy4V7pwSus5Gswb5CQe4FfKqeYj6YNnzxtuGbYTDP/D1oFGF6fI2
TIIBCw5vAC0Ukcc0jliThvc7MIx6iSo6FdwEdzhOGlTpchWuEJgC04nMKD/hsXAe
E9ZWBSC1FAzxCGidmBF4HujK+L9Q77JToyzMcWaTzIqCpG2nNyJXKRcAMEXtmyKv
5au2SaIGNBNBSg+jdqA+vX/7/8Vh556RSNnJsx7B36aNhz+8M6S+GapCemxTNjC8
/IwszifF4dp4QaiOdvJ6KvTwmuZEOyWcQY0bQ9PPvLjua+5OkIxTWp3O/Jq0w1tx
rJCkvmrpPMypFWrVyNA4ATEj2LZA+EeJjdiyKF4lg4ZOgH/iULA=
=24CZ
-----END PGP SIGNATURE-----

--VGdgslCgeMyO--
