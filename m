Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32761C433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 22 May 2022 09:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241841AbiEVJqa (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 22 May 2022 05:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242997AbiEVJqa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 22 May 2022 05:46:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030281FCC0
        for <fstests@vger.kernel.org>; Sun, 22 May 2022 02:46:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DBF37B80AC0
        for <fstests@vger.kernel.org>; Sun, 22 May 2022 09:46:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25751C385AA;
        Sun, 22 May 2022 09:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653212782;
        bh=UsBjv+7hH0ui1tau6XFqMixFmcm0Y0ggq/1LrYbKDoQ=;
        h=Date:From:To:Subject:From;
        b=iLbEcSxEXGek0+co2l6aZ01x/yBLbBAJV1fVN/5KisxTO5gYN61wAkcu/wAvsrZ+I
         W4JoeqW4VIiRAv3fkRE2LWI/ni8vKKL8qIItzCjAjD2s3Czz1z7YV8yNPJLFn+uG3o
         C5xOkd4rudKzsiFXjgN/iWBtvtJdLTgC+kj03LyuEgjIml4sIBVy91b7gbTQhr74Sb
         HRSv1LYDLI9bvWRAf+pKgU9KMuO52M4FW8UqfdJxOk3f6rdeWZeyCTxaeqqeSTb74Y
         WdMRjw44AZ0Wk8qzjDZZ1N9/PCrGW2wGDfxAyg/HQg8B3diNdmp9Jd9VYqKUdHssGK
         hYsKry9XnKzxg==
Date:   Sun, 22 May 2022 17:46:19 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to 6849744065ea
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="NIGnWXQrAcKB"
Content-Disposition: inline
Message-Id: <20220522094622.25751C385AA@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--NIGnWXQrAcKB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2022.05.22 release.

Some release notes you might care about:

1. This update will bring in new failures on some of old kernel:
a) The generic/691 is a new case, if it fails please refer to:
  bc37e4fb5cac xfs: revert "xfs: actually bump warning counts when we send warnings"

b) The xfs/050 xfs/153 xfs/299 will fail on 5.9~5.17. To avoid these failues you
might need the patch above, and below patchset:
  [PATCH v3 0/3] xfs: remove quota warnings
  https://lore.kernel.org/linux-xfs/20220510202800.40339-1-catherine.hoang@oracle.com/

c) The xfs/348 will fail, refer to:
  1eb70f54c445 "xfs: validate inode fork size against fork format"

2. This release fix a small regression issue, which cause xfstests/new command
can't get profer new case number. So if you hit this issue, please update.

3. Dave improved the performance of XFS running. So you might get faster xfs
testing. Thanks for doing that!

4. Christoph added a new group name (for btrfs mostly) "read_repair", please
use it if you write a related cases. Thanks!

5. Broken or deprecated cases xfs/191-input-validation, xfs/018, xfs/081 and
xfs/082 are removed from this release.

More details please refer to below. Thanks for all your contribution.

Thanks,
Zorro

The new head of the for-next branch is commit:

6849744065ea tools/mkgroupfile: help the cases of group.list in number order

New commits ([N]ew, [U]pdate, [D]elete):

Christoph Hellwig (1):
[U]      [4c577efa1ee6] fstests: add a btrfs read_repair group

Dave Chinner (10):
[U]      [6a1c3ac03574] fstests: tests should not source common/rc directly
[U]      [fbb154f67dac] common/rc: fix test init performance regression on XFS
[U]      [307f05149987] fstests: filter quota warnings
[U]      [9a392f8d44e5] xfs/122: add attribute log formats to test output.
[U]      [dbcc5493176a] xfs/348: golden output is not correct
[U]      [460c460464cb] xfs/148: make test debuggable
[U]      [6812c3b2603b] xfs/148: fix failure from bad shortform size assumptions
[D]      [c1941d6f5d47] xfs/191: remove broken test
[D]      [e6d4d963c698] fstests: remove xfs deprecated test
[U]      [1a04a7c9e674] fstests: fix group list generation for whacky test names

Eric Biggers (1):
[U]      [a7b978f8f55b] generic/556: add test case for top-level dir rename

Gabriel Krisman Bertazi (1):
[U]      [3b878b60a77e] generic/556: Filter touch error message

Ojaswin Mujoo (1):
[U]      [ee264b3fa676] common/rc: Modify _require_batched_discard to improve test coverage

Zorro Lang (3):
[N]      [0110e1eeb73d] generic: soft quota limits testing within grace time
[U]      [2eb19ea49c65] generic/603: use project quota create and restore common helpers
[U]      [6849744065ea] tools/mkgroupfile: help the cases of group.list in number order


Code Diffstat:

 common/filter                      |    8 +
 common/quota                       |   52 +
 common/rc                          |   20 +-
 common/xfs                         |   12 +
 doc/group-names.txt                |    1 +
 tests/btrfs/140                    |    2 +-
 tests/btrfs/141                    |    2 +-
 tests/btrfs/142                    |    2 +-
 tests/btrfs/143                    |    2 +-
 tests/btrfs/150                    |    2 +-
 tests/btrfs/157                    |    2 +-
 tests/btrfs/215                    |    2 +-
 tests/btrfs/243                    |    1 -
 tests/btrfs/245                    |    1 -
 tests/ext4/053                     |    1 -
 tests/generic/556                  |   25 +-
 tests/generic/556.out              |    4 +-
 tests/generic/603                  |   36 +-
 tests/generic/644                  |    1 -
 tests/generic/645                  |    1 -
 tests/generic/647                  |    1 -
 tests/generic/677                  |    1 -
 tests/generic/678                  |    1 -
 tests/generic/679                  |    1 -
 tests/generic/690                  |    1 -
 tests/generic/691                  |  107 +
 tests/generic/691.out              |   34 +
 tests/xfs/018                      |   72 -
 tests/xfs/018.op                   | 4714 ------------------------------------
 tests/xfs/018.out                  |   17 -
 tests/xfs/018.trans_buf            | 1821 --------------
 tests/xfs/018.trans_inode          | 2609 --------------------
 tests/xfs/050                      |    9 -
 tests/xfs/081                      |   55 -
 tests/xfs/081.out                  |    4 -
 tests/xfs/081.ugquota.trans_inode  | 3091 -----------------------
 tests/xfs/082                      |  101 -
 tests/xfs/082.op                   | 4714 ------------------------------------
 tests/xfs/082.out                  |   39 -
 tests/xfs/082.trans_buf            | 1821 --------------
 tests/xfs/082.trans_inode          | 2609 --------------------
 tests/xfs/122.out                  |    2 +
 tests/xfs/148                      |   15 +-
 tests/xfs/153                      |    9 -
 tests/xfs/191-input-validation     |  324 ---
 tests/xfs/191-input-validation.out |    2 -
 tests/xfs/299                      |    9 -
 tests/xfs/348.out                  |    4 +-
 tools/mkgroupfile                  |    5 +-
 49 files changed, 270 insertions(+), 22099 deletions(-)
--
Zorro Lang
zlang@kernel.org

--NIGnWXQrAcKB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmKKBg8ACgkQlNbPkfr2
tMyyhA//YQmtURxaFTChyzAOo7uN0X9Lb6rqFncPqREhRaduRm+4wUtQKyrbR2jb
o14TSox6fgzSCBIbCsR1Me6/2uWZabqqn/I3ovU3PQ9KpZ/A1H8Uu/U7+RvhcOW1
2wNTN8F2RAE2TFOyGFQ7E2eCi6IK4KZlEaBSO6GHP5DNUSsNu3ivgfMJrfUH6I2/
DB4XTr87j8aixcl1ixEv3WHXiv1iQFUyk/ZfDVqk2CoGF3BEC6bdHcY4ZqFh1fhW
vVylV0v2BHmOKAObH5apuvJBFVoz11V6Wc0aM/lLksy65/TD+XqvrnDV8VFp7TQF
emkuz//0OOU5yGQ4vPuXk4v03Gb9J73BPqtKZ+0B33nvtH18BywJl0R2Xnwk0C1u
pDa24mFWl8CHP7dpax5ekviSl4/PlWNgF/7KtxBGQa1G4049Yx9tUiNfjc/5TCIT
EzHi9I6B+BZhPWtrlSAn2HpGQgpljA+vZF3YtRrnSaiG/2R2iEVQbYfHEzC+35/v
jBzY38+XtZMPblGJtiIKbFFoHqmJVTwLgHeFw2hCJLtblrUPnSOp3VT0vGG1DCtB
wixUrWdANXKCmbYu+4X4ZVDyCdkoxR/vya+9rMEfsiEE4Azu0Hux48U/Dc3rwks5
2Agi8e/4I5Ut43PNoXwrFFcliIf0a4W5PEbTCh8xDEnGnzmLvQc=
=rDxL
-----END PGP SIGNATURE-----

--NIGnWXQrAcKB--
