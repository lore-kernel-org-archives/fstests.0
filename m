Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BDCC433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 26 Jun 2022 08:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbiFZItX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 26 Jun 2022 04:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbiFZItX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 26 Jun 2022 04:49:23 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5B311453
        for <fstests@vger.kernel.org>; Sun, 26 Jun 2022 01:49:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CAE5ACE0F90
        for <fstests@vger.kernel.org>; Sun, 26 Jun 2022 08:49:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCAE2C34114;
        Sun, 26 Jun 2022 08:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656233358;
        bh=boNyLeSTxPpyu7cztj8UhYgz3FjBszA/nF2LTULZ1/g=;
        h=Date:From:To:Subject:From;
        b=bPy7PwkhdllaoqlZ+B34he/Bd/RHnOYpoWB+cMgCEJ+TIP/KH7NlYiawamIO4X7Zc
         noEdP8KYEzRHeGswg7kGBVRGSaLDvu544CfOHAWl6nKawzu0NaiMC/0thVGP872tGJ
         6MN4Ls39yag04C15nkdunYR8SdOaDtR5PmzTDTV3jrdnFm+NhEYz1Y1Gsl7KF+TYSI
         bij2K+WNc3FPGNtiY/tht2uM0/KSwGH1U5P18UjOhHrtffDmngrGDhmwaa8AI2BaYN
         PeQsB/QEavN4st6aRsVXyB6C+h95ld79tI4R9WF5MvpFUhPLYk52WwXKeNhB7zKErq
         X6O9i3LCkMknQ==
Date:   Sun, 26 Jun 2022 16:49:15 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to 34c1208f601b
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SiYmxbThKoOT"
Content-Disposition: inline
Message-Id: <20220626084917.BCAE2C34114@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--SiYmxbThKoOT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2022.06.26 release.

There's not new cases this week, nearly all cases fix/improvement. Just an
update  on ext4/053 which brings in new test part, might fails on old kernel.

Thanks David Disseldorp, who is trying to add a new feature to help fstests to
loop run failed cases automatically (suggested by Ted). This week I haven't
merged that feature patchset, but merged 6 related pre-fix patches. More details
refer to:
https://lore.kernel.org/fstests/20220621160153.29591-1-ddiss@suse.de/

And welcome to try it, and give it your review points if you have. I'll try to
merge that feature in next release.

Thanks All!
Zorro

The new head of the for-next branch is commit:

34c1208f601b xfs/{422,517}: kill background jobs on test termination

New commits ([U]pdate):

Amir Goldstein (3):
[U]      [4aa167d0d4d0] fstests: add missing _require_freeze() to tests
[U]      [bc50d0f64a1b] fstests: unfreeze fs on cleanup routines
[U]      [34c1208f601b] xfs/{422,517}: kill background jobs on test termination

David Disseldorp (6):
[U]      [0730b5a94e0f] check: avoid FSTYP=<fstyp parameter> repetition
[U]      [fdcff5481a86] check: simplify check.time parsing
[U]      [40aa19bcc2f1] report: drop unused _xunit_make_section_report parameter
[U]      [2b1016e1f507] report: fix xunit tests count
[U]      [eda21d205f67] check: use arrays instead of separate n_ counters
[U]      [0b0e82a4d755] check: remove err and first_test variables

Eric Biggers (1):
[U]      [fc8c0d9f44dc] ext4/053: test changing test_dummy_encryption on remount

Eric Sandeen (1):
[U]      [09f420da65a6] xfs/122: escape %zu in printf with %% not \\%

Luís Henriques (2):
[U]      [ad794b00a3c2] generic/020: adjust max_attrval_size for ceph
[U]      [b55aef7cfe6c] generic/486: adjust the max xattr size


Code Diffstat:

 check                   | 148 ++++++++++++++++++++----------------------------
 common/report           |  14 +++--
 src/attr_replace_test.c |  30 ++++++++--
 tests/ext4/053          |   3 +
 tests/generic/020       |  33 ++++++++---
 tests/generic/068       |  14 +++--
 tests/generic/085       |   3 +
 tests/generic/280       |  13 ++++-
 tests/generic/390       |   8 ++-
 tests/generic/459       |   2 +
 tests/generic/486       |  11 +++-
 tests/generic/491       |   9 +++
 tests/xfs/011           |   3 +-
 tests/xfs/119           |  10 ++++
 tests/xfs/122           |   4 +-
 tests/xfs/297           |  11 ++++
 tests/xfs/318           |   6 +-
 tests/xfs/325           |   6 +-
 tests/xfs/422           |  35 +++++++++++-
 tests/xfs/438           |   4 +-
 tests/xfs/517           |  27 ++++++++-
 21 files changed, 270 insertions(+), 124 deletions(-)
--
Zorro Lang
zlang@kernel.org

--SiYmxbThKoOT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmK4HMQACgkQlNbPkfr2
tMynYBAAqn3TOsL6KdWOIk44I09JruUJmJjY7kjgVeO8BWmsPlrWofn0ooNcLVS9
7xfO1o7M6v2Ni+4AOxsTBxLsRchSeqSh09jtrPUiQ3AReepOay61dmbXu5NuUtA9
XgXthchcsAWYhQxt4hXEeWJCf4yHNb7Mfv3gXKcylEwYATLmOep5ShglEPUAvzO/
J3ZzvsNZWvlnR8gUkQuNHcaAPBwOr7M4ooK7P1uMnKdUloODTO8zuIWI/GwPfyEO
CtJnhen4we2FhLyxSLtgmdIeJlgmRQIewmwLiJ9wcRdza8uCVdv4fnNpuH9m0v7+
xA7F5j/bYaW8W5mm8pUG0Fe3vbQjYeppK8o246THvsrifTnJvwxPzwpwt96AAo4C
cpMFB+3CcJC5XckXKBDrt9AOZQ9CZzQwfVbxiSN+RARk+ps7Qx11fpXVYsf+YUYP
ZIsdKpY4R0XvoDHXpc0macsQKOiQdiEP/z8Ehxlzl6uOkM7nTYaREJELXDs1or/Z
7+nGmwTYQyBXPGop3AAjwWwrK3gEYuvNNexN6fCB8FYo4l99bhNTLrCVUUguchuc
2PyvqOaL3EHaTQPhMQeksz3J3tf9A3Fe99EP6R2aVdxN3WabeLXzYnFu4Q1U7fXo
WwXEFAiVUj+YdaJFQxxcPuG+G91S+ZG0fvqY+l94wfLjY8WpJy8=
=7vi3
-----END PGP SIGNATURE-----

--SiYmxbThKoOT--
