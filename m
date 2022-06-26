Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9C6C433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 26 Jun 2022 08:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbiFZI3D (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 26 Jun 2022 04:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbiFZI3C (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 26 Jun 2022 04:29:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88556FD07
        for <fstests@vger.kernel.org>; Sun, 26 Jun 2022 01:29:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A1E6B80CF8
        for <fstests@vger.kernel.org>; Sun, 26 Jun 2022 08:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7330CC34114;
        Sun, 26 Jun 2022 08:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656232138;
        bh=0Fc+Jui9xTYuH4EFOOy5s2tastvvKXkqAKNW6rhN9A0=;
        h=Date:From:To:Subject:From;
        b=CaIreMte78G+ztcVejiEogYtBIUr0hoG0IXjN31nVxvCraGJ06P9dvAsIkbc3Zzuy
         HOTYwt9lppckW2gaDYqwrYQwjCVeNpgCuxHhwB0ilt+oag+vtnArYxYYOFc87CB4Eh
         2BOjNWZcmi0Pq/YFGZh5MlDQ4k127IHLGlPiIw319xuIQCyX7ZiNVtDPDyvBS4e4Lk
         D0Alr+em18SembsErIWudNp+b0SchiiQnhzlJkxbMAMcNglHj0BpezVv2SYzteApFS
         9c+sV4jIYQtpT3eYC0zZHj723GIhVFpKVBxHkZQHbAxm8MDb5AOg17Ko8xCionxVxl
         6vrx4aJHxAspw==
Date:   Sun, 26 Jun 2022 16:28:55 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2022.06.12 onto master branch
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KWU4IpCPapEy"
Content-Disposition: inline
Message-Id: <20220626082858.7330CC34114@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--KWU4IpCPapEy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2022.06.12 version (merged from for-next).

Thanks,
Zorro

The new head of the master branch is commit:

0882b0913eae xfs: Verify correctness of upgrading an fs to support large extent counters

New commits:

Chandan Babu R (4):
      [5bb78c56ef59] xfs/270: Fix ro mount failure when nrext64 option is enabled
      [63b956a156ea] common/xfs: Add helper to check if nrext64 option is supported
      [9b448f06fe21] xfs: Verify that the correct inode extent counters are updated with/without nrext64
      [0882b0913eae] xfs: Verify correctness of upgrading an fs to support large extent counters

Naohiro Aota (1):
      [3493b8dc8b3d] btrfs/220: zoned: skip nodatacow mount option for zoned btrfs

Zorro Lang (2):
      [085faee2742c] xfs: corrupted xattr should not block removexattr
      [e937e23d2021] common/filter: filter out extra mount error output


Code Diffstat:

 common/filter     |  13 ++++++-
 common/xfs        |  12 ++++++
 tests/btrfs/220   |  18 +++++----
 tests/xfs/081     |  80 ++++++++++++++++++++++++++++++++++++++
 tests/xfs/081.out |   2 +
 tests/xfs/154     |   2 +-
 tests/xfs/154.out |   2 +-
 tests/xfs/158     |   2 +-
 tests/xfs/158.out |   2 +-
 tests/xfs/270     |  26 ++++++++++++-
 tests/xfs/270.out |   1 -
 tests/xfs/547     |  92 ++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/547.out |  13 +++++++
 tests/xfs/548     | 112 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/548.out |  12 ++++++
 15 files changed, 372 insertions(+), 17 deletions(-)
--
Zorro Lang
zlang@kernel.org

--KWU4IpCPapEy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmK4GG0ACgkQlNbPkfr2
tMxKIg/+KMGAI03di8axU1UWxjOhpUoVGmzOj94n3R5Z95ey8FsFZZ/NL3F6cZOo
5WnbcJIuT8oA+27gLx7nbTOtXtlDPK+SctfqZPkTUtOxbru+9WxXO6DbpkKDIdAa
M7NMzfLkoHhHVilu6wmXtkaiYifqHjqkGk69mHrxvbkfDBfhCZ00tBpBOA54XxPi
CHfrrrKxw8g5+5RLaehhwlvNz8hsJ0u0WTb/dWCE3XspG7+mfWJxYLgIAiwWHZVw
WBnEmK6rbgJC1JS8EtQkzadINU/Qd/8BowKd0eP5m9skLE1iFY7LL4iwAKugi1bm
yd1YzBEWqFqZZll1BcS+usAjTsbjGQCq35R+BUuCO/FjuJiAfiTG1/CFOs0ChKW1
gj2iBI7aXSRfrS1AL/crZFJjrBiXy7MgIiMeS3RgXZYpAOYf0K7cOgRbtgf9ppzZ
ENwCOGk/MiZkDAeG7Q2o+b6GqwDYZZP54tJT9reK2Pub08E/1T4gkn6hiI8rEAbk
mOt5UKSPzkuyubYNC+mtaQLIxWE0ex94jm6UYg2cvrXMhNrqP6PRIMtAvz++hZwA
TGa0LqOoGWFRrpQtsiD0RNziP1sSXt2M88GVccf6bGrAV6vjK21tKM2eGLvEwNnC
GHez/56XoRiDaka85nS2RpfzWmxrSSnc7dpsofR0zXOfmbbs0b8=
=DOKN
-----END PGP SIGNATURE-----

--KWU4IpCPapEy--
