Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082F9C38A02
	for <linux-fstests@archiver.kernel.org>; Sun, 30 Oct 2022 11:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiJ3LGy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 30 Oct 2022 07:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiJ3LGx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 30 Oct 2022 07:06:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1751031
        for <fstests@vger.kernel.org>; Sun, 30 Oct 2022 04:06:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BA29B80D34
        for <fstests@vger.kernel.org>; Sun, 30 Oct 2022 11:06:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784C1C433C1;
        Sun, 30 Oct 2022 11:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667128007;
        bh=8fAF6Trvflt74cvsjNEFnpZRaG6qkKkLG7N6qcDxjZw=;
        h=Date:From:To:Subject:From;
        b=GXsHQgr69u47t5fFMWGEL3W+TMJK6sny2FUSeqQxOQ2CsN2+BoXUfUJOWg/Jjz3+h
         A162wzIdNMkrX7acB6bv/C1xh/SdkFudKuYKes9aAVGOqcetZcXGES+RppYXEy890T
         ZCoOHL8K3jn9KyLhM1Q9CpQ4Bv9nMv3a6ZHxKUDRKlp+msABFoC9s/en2tWmpqKx+H
         maW8w21RbC/RNqTipaNsQoTtRpQwCdpY0Oe09z9rjy4JmO15qhINYCzsjPCeg0BuAI
         U8MLrIeut2Kw3ejEFoz0SPk2rida5IXsw5WfpgqdtkQVEam+0XHYxgkt78HqAm9ZiO
         LdC3JG65txyhQ==
Date:   Sun, 30 Oct 2022 19:06:44 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to 7d839ccc1a13
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bJV0NpjnN019"
Content-Disposition: inline
Message-Id: <20221030110647.784C1C433C1@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--bJV0NpjnN019
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2022.10.30 release.

Release note:
1) There're 3 new cases (btrfs/278, xfs/554 and xfs/555) in this release.
   They're all regression tests for known issue, xfs/555 might crash or hang
   on kernel <= v3.14.
2) Encrypt test supports ceph fs, feel free to give it a try.

More update/improvement as below, thanks for all your contribution!

Thanks,
Zorro

The new head of the for-next branch is commit:

7d839ccc1a13 xfs: new test on xfs with corrupted sb_inopblock

New commits ([N]ew, [U]pdate):

BingJing Chang (1):
[N]      [12f644786574] btrfs: test incremental send for orphan inodes

Darrick J. Wong (5):
[U]      [65f937954f5e] populate: unexport the metadump description text
[U]      [3cfd47b936e9] xfs: refactor filesystem feature detection logic
[U]      [e33f8bfd0d70] xfs: refactor filesystem directory block size extraction logic
[U]      [898ace3b1835] xfs: refactor filesystem realtime geometry detection logic
[U]      [1153cd05b987] common: simplify grep pipe sed interactions

Hironori Shiina (1):
[N]      [1ffa16c57368] xfs: test for fixing wrong root inode number in dump

Lukas Czerner (1):
[U]      [2df0aa04659b] tests: Add missing _require_odirect from generic tests

Xiubo Li (1):
[U]      [b38f94bbe96e] encrypt: add ceph support

Zorro Lang (1):
[N]      [7d839ccc1a13] xfs: new test on xfs with corrupted sb_inopblock


Code Diffstat:

 common/dump             |   2 +-
 common/encrypt          |   3 +
 common/ext4             |   9 ++
 common/populate         |  32 +++----
 common/rc               |   2 +-
 common/xfs              | 110 +++++++++++++++++++++---
 src/Makefile            |   2 +-
 src/fake-dump-rootino.c | 224 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/278         | 218 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/278.out     |   3 +
 tests/generic/219       |   1 +
 tests/generic/446       |   1 +
 tests/generic/459       |   1 +
 tests/generic/569       |   1 +
 tests/generic/570       |   1 +
 tests/generic/587       |   1 +
 tests/xfs/097           |   2 +-
 tests/xfs/099           |   2 +-
 tests/xfs/100           |   2 +-
 tests/xfs/101           |   2 +-
 tests/xfs/102           |   2 +-
 tests/xfs/105           |   2 +-
 tests/xfs/112           |   2 +-
 tests/xfs/113           |   2 +-
 tests/xfs/146           |   2 +-
 tests/xfs/147           |   2 +-
 tests/xfs/151           |   3 +-
 tests/xfs/271           |   2 +-
 tests/xfs/307           |   2 +-
 tests/xfs/308           |   2 +-
 tests/xfs/348           |   2 +-
 tests/xfs/530           |   3 +-
 tests/xfs/554           |  75 ++++++++++++++++
 tests/xfs/554.out       |  40 +++++++++
 tests/xfs/555           |  32 +++++++
 tests/xfs/555.out       |   6 ++
 36 files changed, 748 insertions(+), 50 deletions(-)
--
Zorro Lang
zlang@kernel.org

--bJV0NpjnN019
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmNeWo8ACgkQlNbPkfr2
tMxiIRAAr46NyPbvBf5NiJ/yq7XDhYvEpYdBmvr/NTzwkyXUlsTQW3T2Xq8NM/lL
QIDwNeFGWK7RDyMzvIWTTWjlt3xx0OGPYgQ4zLjcXpS69YRziZa61Qje30BkQYQ2
lyAOLc1vXIY8pfCBFbwbhZx981J6Rk6hhraF5c/AQDI+XwdqpYXMjlByIegZJVUc
FG+Ab+K6Ck8IQgycdDi4A5y/NdxzzWc32zmoqc2S9ZhRKliSTSaNy8wLFE9MzNfL
/ypLCIbrZc9UIJp82lIDUhOY0SHFmXrmbi6PQuuRfCGlG3G6EpRYfdfXCcGoABYI
zKf1jlG8dvASjjL5721RKhZZjObrcgpeZvevM9f/ggftcXQqgVAVUGi5ZsYy/GNj
eYNeffkXDTfMRViCsm+lQvJVqOfUMKFXvybbXum1lGahR3UgnzqK9vgpulaLIWIt
4aWvQHLu0nqB2ARERGpwWCz3NmxwpczlhLyweHKvVofBDZSTT3K+4dFFjiI0jTSv
pra8lER3J3oH7f6OB9HmWvTwRs9cwx4h848wwt/A5tIJCdkHEYhx5Kg0wsVYyOKW
iTd9/44v+ovFLmEWXm9cc+XH4YleK8gbHfl4SAxTViQxRFWgbkCbbvq6Hjb4F3lA
AeMsYQxMg3Z/6FhVrsTRvNrUZjDHzfIXcjtRefolKHj4aSNKIXg=
=WDvT
-----END PGP SIGNATURE-----

--bJV0NpjnN019--
