Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342ECC433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 10 Jul 2022 10:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiGJKPN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 10 Jul 2022 06:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGJKPM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 10 Jul 2022 06:15:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD17120B5
        for <fstests@vger.kernel.org>; Sun, 10 Jul 2022 03:15:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A910D611AF
        for <fstests@vger.kernel.org>; Sun, 10 Jul 2022 10:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8F7C341CD;
        Sun, 10 Jul 2022 10:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657448111;
        bh=KQEMq7OWHfS/W8v+QQ1Nf2XED/eftd7ZGjaRlDdGve8=;
        h=Date:From:To:Subject:From;
        b=j9JxTB8WgyuYONNMv4xRsWuyAo9LGu0x6cyEz4EgqDRilkn377k6oBKkbiFxB64fk
         OFI3bux5P30SYWP8TEZVY9l9Q4c7VY2wcGPp7r71iCszE5U72+25AP3BtltuCSIK2K
         HHrF8QPO5ywm4U1WAoLre32mW8EdxmqP089i8iRklxVdDU6gVqguUB2Z7Jp0eBv0in
         kFuvg3wrYN/qbhl29bWTPxrLfsXvXMSDXYdNHH0Wy7wYcjzA6MGgns6BC51OSkjXWe
         RRDqsTGmVi926xZQs7cxZquazrwn89xW2cATRgu4bmQjlFximan/1JM+CrmgWlRp55
         tPqruqXq6jFhQ==
Date:   Sun, 10 Jul 2022 18:15:07 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to 47ed06630971
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="CefiWI8zHiSj"
Content-Disposition: inline
Message-Id: <20220710101510.7A8F7C341CD@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--CefiWI8zHiSj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2022.07.10 release.

Release Note:
1) This release has a new feature which help fstests to rerun failed tests, by
using the new "-L <n>" option. Thanks this contribution from David.

2) There're two new cases in this release -- xfs/191 and btrfs/271, xfs/191
will fail on old kernel or xfsprogs.

More details as below.

Thanks,
Zorro

The new head of the for-next branch is commit:

47ed06630971 xfs/144: fix test mkfs.xfs sizing of internal logs that overflow the AG

New commits ([N]ew, [U]pdate, [F]eature):

Christoph Hellwig (1):
[N]      [d3eb6a2b1599] btrfs: test raid1 write error handling

Darrick J. Wong (4):
[U]      [6ecd4b5b7cd9] xfs/288: skip repair -n when checking empty root leaf block behavior
[N]      [c9ef32ad6e38] xfs: make sure that we handle empty xattr leaf blocks ok
[U]      [daba59ddecf3] xfs/547: fix problems with realtime
[U]      [47ed06630971] xfs/144: fix test mkfs.xfs sizing of internal logs that overflow the AG

David Disseldorp (5):
[F]      [de1fda54e5f0] report: use array for REPORT_ENV_LIST
[F]      [e47930fb73bc] report: pass through most details as function parameters
[F]      [5c31ba9b7299] check: make a few variables local
[F]      [6bae394bcd50] check: append bad / notrun arrays in helper function
[F]      [2fe10922349c] check: add -L <n> parameter to rerun failed tests


Code Diffstat:

 check               | 137 ++++++++++----
 common/report       |  90 +++++----
 tests/btrfs/271     |  78 ++++++++
 tests/btrfs/271.out | 521 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/144       |  14 +-
 tests/xfs/191       | 117 ++++++++++++
 tests/xfs/191.out   |   7 +
 tests/xfs/288       |  32 ++--
 tests/xfs/547       |  14 +-
 9 files changed, 899 insertions(+), 111 deletions(-)
--
Zorro Lang
zlang@kernel.org

--CefiWI8zHiSj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmLKpnEACgkQlNbPkfr2
tMxFVBAAkImxKPaRF0GBnmzUQSSMYlytWNe0qAXZ51TzCvD0zG7Gf6h6hWsBY+Xg
6VLS7hRsKfiv6otoJmbbWxZEw2J9coNoiXnTCqrCbcheyeYkW2sqaw0QOUnJiHol
/zBZBTOx5yVFucKSgC1i3MrJnRpkNYXEKqoRa98SY3iA5Cs/S9D0ic+nTeSta07W
udvkCtrS7FMOr4c2S5OP3ukULWV35wemrbTGxUVlZNvck0QnLzcmY7A11sjVJ5AC
1Wd1zEH4K6PL7oimbvMFfOwhTthh6toC2y8ldD4UEwB+8FX1XVyysrjcVqAc4pUF
XHjSpyQmyuukxYlQXbfD1j2IPoC+b2YLxBK1TTqrEx+1KG8B8gXh3B4luuZswEGg
lyHrEQWVGtQXPoG/rQqKnhu2rmznNrC9/ON/fn10xU6LTwD9VN/j/SguZZHdKpos
BqsNct/qVADT6RcDiDklkc/UkbY7soRYtT3qiXacvixjnKpVNlQdXKUY0w9IA7Ql
fBfMeLCgHwo0M9V6xkp1erZnhfQCaPSh1qnkOhp7w4F0K9kbVtAuNqYqFEls3G04
AssENMbrhH/ThleAYafuEBOVZafxJqYwifV4fV4GfRxyNsIfaMhsjMUC7cYz3nQp
feSFD87FGkww5XPjX3KJVNlCyFyp96eUDylKZfLctggUulmaaL0=
=hyAv
-----END PGP SIGNATURE-----

--CefiWI8zHiSj--
