Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2983FC433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 24 Jul 2022 15:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiGXPJQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 24 Jul 2022 11:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiGXPJP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 24 Jul 2022 11:09:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D193F2606
        for <fstests@vger.kernel.org>; Sun, 24 Jul 2022 08:09:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67DBD6113C
        for <fstests@vger.kernel.org>; Sun, 24 Jul 2022 15:09:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F452C3411E;
        Sun, 24 Jul 2022 15:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658675353;
        bh=tAJ8CgKcw3VkKdv8rNlDMaZGaMs4nFtLJWYPx+H/qSU=;
        h=Date:From:To:Subject:From;
        b=TV+rnJXWcNa3q3Tw1OIXQdGoUJEeXxcWGjG8NuPI72m4D6uAEfPVbOpBRFPljWMac
         qrEBUxedBOJhvAfUYF62XVh5vzrsON5W5uCsWdbryiifkIUsBGDU2vlPVesKrCw4U/
         8fFO+Djsme0kAQmOkiloFNd2iTKmS7vDxHMhJE+H6RTJMt4IYaEoSskgaZ4K/ALvvH
         hnjMkgXkZfmfKmJ2VgtdmP+zlTeEjeex5KGgka5u0DD+ZnhazPg9HIEfDR8Dg1cayk
         vu8oodCmRj7cvn4Q5y4bG7eIDXdGfqEt+KKgvx8RO1ZXbCrDbwLhDT4tfRy3jmQ3cq
         0UAou1ie3vHrA==
Date:   Sun, 24 Jul 2022 23:09:08 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to 33ac1a74fb63
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ARiVYVAPlqa7"
Content-Disposition: inline
Message-Id: <20220724150913.4F452C3411E@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--ARiVYVAPlqa7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2022.07.24 release.

Release Note:
1) This release contains 3 new cases for btrfs, 1 new case for ext4 new ioctl,
and many fixes and improvement. Thanks for these contribution!

2) Darrick brings in a new common helper _require_congruent_file_oplen(), and
use it in lots of old cases. I tried my best to give it a testing, but if anyone
still find that breaks or _notrun some cases which you always tend to run, feel
free to send email to mail list.

3) There're still some patches gotten or getting review, but I didn't get enough
time to give them testing, so I will try to merge those reviewed ones in next
release, please don't worry.

More details as below.


Thanks,
Zorro

The new head of the for-next branch is commit:

33ac1a74fb63 report: add support for the xunit-quiet format

New commits:

Boris Burkov (5):
[U]      [7ba973a15d0d] common/verity: require corruption functionality
[U]      [ea5b5f41fb61] common/verity: support btrfs in generic fsverity tests
[N]      [6defaf786e80] btrfs: test btrfs specific fsverity corruption
[N]      [85fb8eb0523b] btrfs: test verity orphans with dmlogwrites
[N]      [1bc6935c9b97] generic: test fs-verity EFBIG scenarios

Christoph Hellwig (1):
[U]      [bcfb2b00eea8] btrfs/270: fix uncompressed data from previously bad mirror

Darrick J. Wong (9):
[U]      [ef25a29fa49a] generic/275: fix premature enospc errors when fs block size is large
[U]      [2048658186d3] misc: use _get_file_block_size for block (re)mapping tests
[U]      [ed329de34763] misc: skip remap/fallocate tests when op length not congruent with file allocation unit
[U]      [9f6312a49078] misc: skip extent size hint tests when hint not congruent with file allocation unit
[U]      [181c9826a5b7] misc: avoid tests encoding FIEMAP/BMAP golden output with weird file blocksizes
[U]      [a4acb097a6d1] punch: use allocation unit to test punching holes
[U]      [ce205e9a4a96] punch: skip fpunch tests when op length not congruent with file allocation unit
[U]      [793f5a860d2a] filter: report data block mappings and od offsets in multiples of allocation units
[U]      [9e0b9837cc49] punch: skip fpunch tests when page size not congruent with file allocation unit

Jeremy Bongio (1):
[N]      [d628ffcb3278] ext4: add test for ext4 uuid get/set ioctls during fsstress.

Josef Bacik (1):
[U]      [4e040ac3c568] btrfs/257: not run if we have compression enabled

Theodore Ts'o (1):
[U]      [33ac1a74fb63] report: add support for the xunit-quiet format


Code Diffstat:

 .gitignore            |   1 +
 check                 |   2 +-
 common/btrfs          |   5 ++
 common/config         |   1 +
 common/filter         |   4 +-
 common/punch          |   3 +-
 common/rc             |  28 +++++++-
 common/report         |  21 ++++--
 common/verity         |  48 ++++++++++++++
 src/Makefile          |   5 +-
 src/uuid_ioctl.c      | 105 ++++++++++++++++++++++++++++++
 tests/btrfs/257       |   3 +
 tests/btrfs/270       |  11 ++--
 tests/btrfs/270.out   |  34 ----------
 tests/btrfs/290       | 172 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/290.out   |  25 ++++++++
 tests/btrfs/291       | 168 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/291.out   |   2 +
 tests/ext4/057        |  64 +++++++++++++++++++
 tests/ext4/057.out    |   2 +
 tests/generic/017     |   2 +-
 tests/generic/031     |   1 +
 tests/generic/064     |   2 +-
 tests/generic/116     |   1 +
 tests/generic/118     |   1 +
 tests/generic/119     |   1 +
 tests/generic/121     |   1 +
 tests/generic/122     |   1 +
 tests/generic/134     |   1 +
 tests/generic/136     |   1 +
 tests/generic/137     |   1 +
 tests/generic/144     |   1 +
 tests/generic/149     |   1 +
 tests/generic/153     |   2 +-
 tests/generic/158     |   2 +-
 tests/generic/162     |   1 +
 tests/generic/163     |   1 +
 tests/generic/164     |   1 +
 tests/generic/165     |   1 +
 tests/generic/168     |   1 +
 tests/generic/170     |   1 +
 tests/generic/181     |   1 +
 tests/generic/183     |   1 +
 tests/generic/185     |   1 +
 tests/generic/186     |   1 +
 tests/generic/187     |   1 +
 tests/generic/188     |   1 +
 tests/generic/189     |   1 +
 tests/generic/190     |   1 +
 tests/generic/191     |   1 +
 tests/generic/194     |   1 +
 tests/generic/195     |   1 +
 tests/generic/196     |   1 +
 tests/generic/197     |   1 +
 tests/generic/199     |   1 +
 tests/generic/200     |   1 +
 tests/generic/201     |   1 +
 tests/generic/275     |  15 ++++-
 tests/generic/284     |   1 +
 tests/generic/287     |   1 +
 tests/generic/289     |   1 +
 tests/generic/290     |   1 +
 tests/generic/291     |   1 +
 tests/generic/292     |   1 +
 tests/generic/293     |   1 +
 tests/generic/295     |   1 +
 tests/generic/352     |   1 +
 tests/generic/358     |   1 +
 tests/generic/359     |   1 +
 tests/generic/372     |   1 +
 tests/generic/404     |   2 +-
 tests/generic/414     |   1 +
 tests/generic/483     |   4 ++
 tests/generic/495     |   4 ++
 tests/generic/501     |   1 +
 tests/generic/503     |   4 ++
 tests/generic/515     |   1 +
 tests/generic/516     |   1 +
 tests/generic/540     |   1 +
 tests/generic/541     |   1 +
 tests/generic/542     |   1 +
 tests/generic/543     |   1 +
 tests/generic/544     |   1 +
 tests/generic/546     |   1 +
 tests/generic/574     |  38 ++++++++++-
 tests/generic/574.out |  13 ++--
 tests/generic/576     |   1 +
 tests/generic/578     |   1 +
 tests/generic/588     |   2 +
 tests/generic/673     |   1 +
 tests/generic/674     |   1 +
 tests/generic/675     |   1 +
 tests/generic/677     |   4 ++
 tests/generic/683     |   1 +
 tests/generic/684     |   1 +
 tests/generic/685     |   1 +
 tests/generic/686     |   1 +
 tests/generic/687     |   1 +
 tests/generic/688     |   1 +
 tests/generic/692     |  64 +++++++++++++++++++
 tests/generic/692.out |   7 ++
 tests/xfs/069         |   1 +
 tests/xfs/114         |   2 +
 tests/xfs/166         |   4 ++
 tests/xfs/180         |   1 +
 tests/xfs/182         |   1 +
 tests/xfs/184         |   1 +
 tests/xfs/192         |   1 +
 tests/xfs/193         |   1 +
 tests/xfs/198         |   1 +
 tests/xfs/200         |   1 +
 tests/xfs/203         |   4 ++
 tests/xfs/204         |   1 +
 tests/xfs/208         |   1 +
 tests/xfs/209         |   1 +
 tests/xfs/210         |   1 +
 tests/xfs/211         |   1 +
 tests/xfs/212         |   1 +
 tests/xfs/215         |   1 +
 tests/xfs/218         |   1 +
 tests/xfs/219         |   1 +
 tests/xfs/221         |   1 +
 tests/xfs/223         |   1 +
 tests/xfs/224         |   1 +
 tests/xfs/225         |   1 +
 tests/xfs/226         |   1 +
 tests/xfs/228         |   1 +
 tests/xfs/230         |   1 +
 tests/xfs/231         |   1 +
 tests/xfs/232         |   1 +
 tests/xfs/237         |   1 +
 tests/xfs/239         |   1 +
 tests/xfs/240         |   1 +
 tests/xfs/241         |   1 +
 tests/xfs/248         |   1 +
 tests/xfs/249         |   1 +
 tests/xfs/251         |   1 +
 tests/xfs/254         |   1 +
 tests/xfs/255         |   1 +
 tests/xfs/256         |   1 +
 tests/xfs/257         |   1 +
 tests/xfs/258         |   1 +
 tests/xfs/280         |   1 +
 tests/xfs/312         |   1 +
 tests/xfs/315         |   1 +
 tests/xfs/322         |   1 +
 tests/xfs/326         |   1 +
 tests/xfs/329         |   1 +
 tests/xfs/346         |   1 +
 tests/xfs/347         |   1 +
 tests/xfs/436         |   1 +
 tests/xfs/507         |   3 +
 tests/xfs/537         |   2 +-
 153 files changed, 924 insertions(+), 73 deletions(-)
--
Zorro Lang
zlang@kernel.org

--ARiVYVAPlqa7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmLdXg0ACgkQlNbPkfr2
tMzsWBAAo8ckX+h4jYZ9hL1XS8m0N0rGzVlpHHdWb8Csw/PfIwYZVZ72jGyEOgcn
V99CwbvNvhigEj9qI1i38+EvF1nxJ15pXV5obWyjm14UrcLT7KoozKEtyOYtGucG
xQloNR4w3BufpWlN9DggLLhuyabDsJWJx088/M7lV8Z/yGeXlrJVdjePfrXxpsNg
CQN5+wpY42V7Ip8aehhjaBqf/TkJayvVGQMIvQ7qkATn1RHuUR39dWTjgy85lOCa
Ma5CCX4Ap4gxW3V+A9dAlb3u5z0hX9Gz8OIIM5oOjmzSXABzluVToxJXIMbZUZSJ
OW8w4pTr8owsBIEM5ZDBSWRsWcwmZtRWY6TaDShqYDhq3b0uQolOkn2PVbVfBPgb
p+QMBfk6YaHXeCZ7vHxbX+BJlZrscrKx2QCxxAYohfGeAgwmr018Qrn6YSS2c7wx
i2Crk+7ogAmLKt8LuZfIkb68/zZKkTeBNRUM4ClcV+IfT8porGQ0JtKdbYYMREGK
IHbHNLosZ2UdDiajwhj1O2dXPa9q5S8Bs7/1F1hl6SZ4lo5CXk6mpRzuhZ1/N/ho
eCWrSyheKR9U+uewrGML1I4AjlbNBzYJbjCHj2LVN92gbvP1Gpast+ak0px+X5rk
GGUib7Zo0oECsAnsauU+JuvuzxqHXW+/KM4gAhl+B47p4v8msG8=
=8Ot8
-----END PGP SIGNATURE-----

--ARiVYVAPlqa7--
