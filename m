Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEB5C43334
	for <linux-fstests@archiver.kernel.org>; Sun,  3 Jul 2022 14:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbiGCOH7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 3 Jul 2022 10:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiGCOH6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 3 Jul 2022 10:07:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A35C5FC0
        for <fstests@vger.kernel.org>; Sun,  3 Jul 2022 07:07:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA6A460DD4
        for <fstests@vger.kernel.org>; Sun,  3 Jul 2022 14:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EEDAC341C6;
        Sun,  3 Jul 2022 14:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656857277;
        bh=z0FnkqHPi61Qc17kxmtI3Oq4BX2UNaLNoFH/ku6oifU=;
        h=Date:From:To:Subject:From;
        b=eniDvE2ZgnZgCbWoL/s61u61G9F0SnjIWK4zj8BO23/6M0QsS5U6wMgcTQW114ZL4
         h5bfQF0kv9QHxnxvTDM5MC1PI+17OFDVqDXCY/geT4WD9GYLBiXznOA2qgJV5iVi5i
         ImER0fIMLw1q8TD89NPm56e7k2yqil5LHTpm+HCsNRkAqQmtC4zC+y8bqBAf9ElQtn
         G1jjrQYEPkq6yb+hWeCpdhnOjmwc4l/3m6sxKhxZXk/yFfuMnxW99tRv0ZYfTw8PrG
         s/BkEWhV/BwIoH8o579PXBeYrL4z/uKUMY5fGb2gLUH2QhG2DIX73XlI/cLTnddNsP
         V7xG4ATtgQbGQ==
Date:   Sun, 03 Jul 2022 22:07:54 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2022.06.26 onto master branch
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Q8ExPu75yKof"
Content-Disposition: inline
Message-Id: <20220703140756.9EEDAC341C6@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--Q8ExPu75yKof
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2022.06.26 version (merged from for-next).

Thanks,
Zorro

The new head of the master branch is commit:

34c1208f601b xfs/{422,517}: kill background jobs on test termination

New commits:

Amir Goldstein (3):
      [4aa167d0d4d0] fstests: add missing _require_freeze() to tests
      [bc50d0f64a1b] fstests: unfreeze fs on cleanup routines
      [34c1208f601b] xfs/{422,517}: kill background jobs on test termination

David Disseldorp (6):
      [0730b5a94e0f] check: avoid FSTYP=<fstyp parameter> repetition
      [fdcff5481a86] check: simplify check.time parsing
      [40aa19bcc2f1] report: drop unused _xunit_make_section_report parameter
      [2b1016e1f507] report: fix xunit tests count
      [eda21d205f67] check: use arrays instead of separate n_ counters
      [0b0e82a4d755] check: remove err and first_test variables

Eric Biggers (1):
      [fc8c0d9f44dc] ext4/053: test changing test_dummy_encryption on remount

Eric Sandeen (1):
      [09f420da65a6] xfs/122: escape %zu in printf with %% not \\%

Luís Henriques (2):
      [ad794b00a3c2] generic/020: adjust max_attrval_size for ceph
      [b55aef7cfe6c] generic/486: adjust the max xattr size


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

--Q8ExPu75yKof
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmLBomcACgkQlNbPkfr2
tMzlchAAr/cD4CEwyaVs1j1ALW13SydOWFRHoXZquoGGnHodKZlVDfSOVEsYfXDo
wh36HFNKDHuiZEpm5QVVOK5+e9PUR05c6qEY0ljgHKaoFNrakg65ri5d6NZ7HbNA
PYBHCF0k8K0goOPc0h25yqIEbAiILpNM6A/00wfSFj7gfij3JBESzuciCGT1PVn6
iK2m6eV8tYK7kAeai3/A7xmPrHP8E+dYL8RvPk/y3nHLVisx/CaWjisxayLWk8t0
28B0Y8WApQYgdhpxhayPdvrvp+DQoIzRnMNt3yU63NAD2ttLSlEpRq9ihegLyLSx
vFGMuFNVXA7zo0jsPb9CDMsR1E4AzwqXXhj3TvbXDyh4iLvakATVIP8vMoNO98g/
i6EvU6AnxTNVki+0+S1TIKI06MRRNiY77e5NSPB9I6ZEDZFGckdthTmrdZIl5M13
n6tBJFCi1vMTIkLC4DJkJfkpZa7ejfqfnv8U6Epsz1j1SE4L91tUhcowxFFrtKQf
L0pujr/ro2QIbpK+X2XMfCcoaQYekxvVsWPy7RX/s3jC/pCS/w2+uxGAb9yXsJ1L
IowW6RBCJtgrZsKpEC61P0sG7L+3trIAGx473hb/Ul96UGRBkxaMqJitzzk8FM+i
tRTgZTvMTxD0yEUNJi4E3UXUJnTyar4ydALThUF8ZYgWJrhpDvw=
=x8HH
-----END PGP SIGNATURE-----

--Q8ExPu75yKof--
