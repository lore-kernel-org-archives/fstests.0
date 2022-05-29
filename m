Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8375C433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 29 May 2022 10:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiE2KOW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 29 May 2022 06:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiE2KOV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 29 May 2022 06:14:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92859AE68
        for <fstests@vger.kernel.org>; Sun, 29 May 2022 03:14:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F40F160EAC
        for <fstests@vger.kernel.org>; Sun, 29 May 2022 10:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6460C34119;
        Sun, 29 May 2022 10:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653819258;
        bh=sOIo25otegjh0kaH8ZLSlIVEhS/MXnPjpQN8iOZTy4s=;
        h=Date:From:To:Subject:From;
        b=qKsStu3d4t1LV5DVHrw57+6AnguX8fRPf1IrY2bnPT/pdRDr/nEtnvi7jc8M7bqVN
         PgbaYbRxSGuMh4WWozFa5ZE9/pYLhBH77+xQaJ9Lqza9R73z/++XeTniGnsaR3wA+s
         zmUaref1KmU2Q8godsE/+9Ct9WUsB6YpdOC60ZVeiMHvFooA2RzvG20yaIJiwe6Dh/
         ltFIvVsx6OJ42+Ho4zxCMekwcodgpAaqIpuVV5qM3m+oK7rd+RT8qGx12RL0FcqMtN
         iVzGKP3ldOrn8RbBo8hmONk0l/aBgjshQqdvmT14y9sgQ5Ccct44telmtNm3tefuWT
         YhdkZV/N8/z/A==
Date:   Sun, 29 May 2022 18:14:14 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to d3cc66012a28
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="quNYphaSxJBJ"
Content-Disposition: inline
Message-Id: <20220529101417.C6460C34119@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--quNYphaSxJBJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2022.05.29 release.

Besides some case issue fixes, this release brings in 3 new test cases for
btrfs -- btrfs/265, btrfs/266 and btrfs/267. Thanks Christoph.

Amir tried to use _fixed_by_kernel_commit helper to mark known regression issues
in test cases. Welcome to do that when anyone write new case for any known
regression :)

Thanks,
Zorro

The new head of the for-next branch is commit:

d3cc66012a28 btrfs: test direct I/O read repair with interleaved corrupted sectors

New commits ([U]pdate, [N]ew):

Amir Goldstein (1):
[U]      [4fb72cffd9e3] xfs: annotate fix commits for upcoming 5.10.y backports

Christoph Hellwig (10):
[U]      [68da7b2ab804] btrfs: add a helpers for read repair testing
[U]      [b6daf3447d4d] btrfs/140: use common read repair helpers
[U]      [bd9306394f2c] btrfs/141: use common read repair helpers
[U]      [0baec6a82ada] btrfs/142: use common read repair helpers
[U]      [9106f321f91a] btrfs/143: use common read repair helpers
[U]      [ebb554efcbf7] btrfs/157: use _btrfs_get_first_logical
[U]      [cd87ca221a32] btrfs/215: use _btrfs_get_first_logical
[N]      [94b0abc48f77] btrfs: test repair with sectors corrupted in multiple mirrors
[N]      [fa1bcba58824] btrfs: test buffered I/O read repair with interleaved corrupted sectors
[N]      [d3cc66012a28] btrfs: test direct I/O read repair with interleaved corrupted sectors

Darrick J. Wong (1):
[U]      [a8812199578b] xfs/545: check for fallocate support before running test

Luís Henriques (2):
[U]      [96ca82d8e5d8] ceph/002: fix test expected output
[U]      [e57024a30588] ceph/001: skip metrics check if no copyfrom mount option is used

Zorro Lang (2):
[U]      [61775fb9e1ab] common: source base fs specific common file
[U]      [7eb01db2b776] tests: remove redundant common/$FSTYP importing


Code Diffstat:

 common/btrfs        |  75 ++++++++++++++++++++++++++++++++++++
 common/config       |  60 +++++++++++++++++++++++++++++
 common/overlay      |   4 ++
 common/rc           |  49 +----------------------
 tests/btrfs/140     |  13 +------
 tests/btrfs/141     |  15 +-------
 tests/btrfs/142     |  10 ++---
 tests/btrfs/143     |  10 ++---
 tests/btrfs/157     |   2 +-
 tests/btrfs/177     |   1 -
 tests/btrfs/215     |   2 +-
 tests/btrfs/258     |   1 -
 tests/btrfs/259     |   1 -
 tests/btrfs/265     |  85 ++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/265.out |  75 ++++++++++++++++++++++++++++++++++++
 tests/btrfs/266     |  93 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/266.out | 109 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/267     |  93 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/267.out | 109 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/ceph/001      |   6 ++-
 tests/ceph/002.out  |   2 +-
 tests/generic/623   |   3 ++
 tests/generic/631   |   2 +
 tests/generic/646   |   3 ++
 tests/generic/649   |   3 ++
 tests/xfs/145       |   3 ++
 tests/xfs/177       |   2 +
 tests/xfs/422       |   1 -
 tests/xfs/423       |   1 -
 tests/xfs/513       |   3 ++
 tests/xfs/517       |   1 -
 tests/xfs/539       |   7 +++-
 tests/xfs/542       |   3 ++
 tests/xfs/545       |   1 +
 34 files changed, 750 insertions(+), 98 deletions(-)
--
Zorro Lang
zlang@kernel.org

--quNYphaSxJBJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmKTR0MACgkQlNbPkfr2
tMwMgA//Rt8/yEinH3IArw6yVcK/6niKON/oVS/nG8awAmNCUD8Grlv7+GiTKsXM
sVk6igu19Isnm5/4orjMsz08DapWDiorRZzhsX2QEXxcchhEXFLL4Ez/Jxtj1Sd7
3JJ97GK1hCUZ39oaidV8DaceQkqIOJOwEuNECE9LPDfsAES5uzNtd+aVuud9LMzy
2lhM5A9mYjZF+Kx+UyL6HlLr3vxlwGFiL5rJfa2FLrfJmF/ihIBgPj773XXsNww6
t4d2e/0RDz+7KxN7s1k46BCwlK43MHFBjAvt8G8xeZf0MQFvOHKiCbiynWchjev2
wyIlg/9ipmDAZ9qVzRYYyeEP2jMVED5+KhESqdVvbQZGxC5A/sjbJfFemrwJL0Rz
owbkdw/hz4O6vW8NfN83EaYt9SKycvs5sWwfGgvdVsKvSNQSuA5eFoLnEhzj1lhN
BkkYlNAXzn2l856WtIU/hQv+tpj6KHT8f14cy/VxECUpbM+0W8efjO0+0bNoT8sp
bG1yt/czAGO5ostzzVRUBhmMI+MtHKk+1NhESIjkUXStOHI+n0m59Tbu+xdxgLdo
bOYuKV0/tFx0KjfYkcP35g0jLawGYeA9JXSGwHy1n9ROaoq25ixITmsMxTzVWdQe
P4SFjxIWUH2pwAXM1CRUj5pTPmDQQfOyu89aS196TMdM+5Bh1jA=
=UBqW
-----END PGP SIGNATURE-----

--quNYphaSxJBJ--
