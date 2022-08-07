Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC4AC19F2A
	for <linux-fstests@archiver.kernel.org>; Sun,  7 Aug 2022 15:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbiHGPvT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 7 Aug 2022 11:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbiHGPvQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 7 Aug 2022 11:51:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F542DD6
        for <fstests@vger.kernel.org>; Sun,  7 Aug 2022 08:51:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB83260FB1
        for <fstests@vger.kernel.org>; Sun,  7 Aug 2022 15:51:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0989C433D6;
        Sun,  7 Aug 2022 15:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659887474;
        bh=2rcYZwG56P52zn0hZF8xFvEhqD0MYeeLCruAl5N9kq4=;
        h=Date:From:To:Subject:From;
        b=YpfZkkt00hxpITvAcLtp9OJSeUK5osPfC4SZ29cI/q1y0kvfFaP0g2b7j14JiJSZq
         gjpkuBxx5vMFpjq2lf+Oc9ll7dJAyO6+vIZvjrHWe96UxurSBRP22hA2RiJ/CMNtfS
         74aQQLGvUHMX5h9yThe578uK1Gvj3t16kfgAmKdiVzNFwTYN7W322bArlmNSw+5fV3
         spe6XTFVYTI6y1S+F2ALEWMy6un8Qi9Y60jUge9ftHVe6ZcknNdRmliKYMFT43Vi1E
         hZReAeqls6M1/C+LSTacILX9KIFtyVjVWFRWllxxK/63P1HCaEt3S6K/xR8kOV0K/l
         TZ51M8NpT6qxA==
Date:   Sun, 07 Aug 2022 23:51:08 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to 16ddbd1aee29
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="RG6yOUgWUL2F"
Content-Disposition: inline
Message-Id: <20220807155112.E0989C433D6@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--RG6yOUgWUL2F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2022.08.07 release.

There're 4 new cases in this release (g/693, x/550, x/551 and x/552), but they
test for new features,  so won't fail on old kernel generally. Those 3 xfs
cases are written for xfs' dax&reflink feature, it'll be in linux v5.20, if
no exception.

More details refer to below.

Thanks,
Zorro

The new head of the for-next branch is commit:

16ddbd1aee29 xfs: add memory failure test for partly-reflinked&dax file

New commits ([U]pdate, [N]ew):

Darrick J. Wong (4):
[U]      [437f7742b8f1] xfs/432: fix this test when external devices are in use
[U]      [bbfa39e7a5cf] xfs/291: convert open-coded _scratch_xfs_repair usage
[U]      [b41bf16361fe] xfs/533: fix false negatives for this test
[U]      [78a3ce021ba8] xfs/018: fix LARP testing for small block sizes

Nathan Huckleberry (2):
[U]      [f57ffcf43811] fscrypt-crypt-util: add HCTR2 implementation
[N]      [94e0bda55b36] generic: add tests for fscrypt policies with HCTR2

Shiyang Ruan (3):
[N]      [2eaabb1d38cf] xfs: add memory failure test for dax mode
[N]      [545d6b783773] xfs: add memory failure test for dax&reflink mode
[N]      [16ddbd1aee29] xfs: add memory failure test for partly-reflinked&dax file

Zorro Lang (1):
[U]      [378cf1c48143] fstests: add more dmerror related test cases into eio group


Code Diffstat:

 .gitignore                      |   1 +
 common/encrypt                  |   2 +
 src/Makefile                    |   3 +-
 src/fscrypt-crypt-util.c        | 357 +++++++++++++++++++++++++++++++++-------
 src/t_mmap_cow_memory_failure.c | 157 ++++++++++++++++++
 tests/generic/484               |   2 +-
 tests/generic/628               |   2 +-
 tests/generic/629               |   2 +-
 tests/generic/693               |  31 ++++
 tests/generic/693.out           |  16 ++
 tests/xfs/018                   |  15 +-
 tests/xfs/018.out               |  43 +----
 tests/xfs/291                   |   6 +-
 tests/xfs/432                   |   3 +-
 tests/xfs/533                   |  10 +-
 tests/xfs/550                   |  50 ++++++
 tests/xfs/550.out               |   9 +
 tests/xfs/551                   |  51 ++++++
 tests/xfs/551.out               |   9 +
 tests/xfs/552                   |  54 ++++++
 tests/xfs/552.out               |   9 +
 21 files changed, 717 insertions(+), 115 deletions(-)
--
Zorro Lang
zlang@kernel.org

--RG6yOUgWUL2F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmLv3xkACgkQlNbPkfr2
tMygMg//cLWP7UW171eR0dWgSfvoJ/OWOshSYv3pSVqQ/toJ2CqH74NZv5G2YrtL
5K3xmB3u3tcPGbAUPp34+79g4HrfaxvVXi87k+y+kwaVdMXt4rCumJ6jX234W53L
x9yhmZBasT6gFptyctlFAiK6f8fTZu4UWwx+F5PvlcT3QAxS5m2w+SnGd9LzuNE9
WnZjyyycB0D2qelMzoKyo5vTIxw4TjM7YvRFexSXZzI94A7I3kiNkY2p9fkccDz6
JnJUWvb4yr+F7DoVjXoW5rWgk0CigdAE9Wuv1NvrqPwwlgIdNn/zFkYpTBxAX9LY
h7pj8x3kiTqNVY6k4dJ2F6/LJp7t/SAcETzpOclHGoGgvz9HfPL42XOfWzhkgxyP
HUITi0xXWAp4Ucb+mNEfoAAt1tEW/glsoc147QS6wOhCUUlGwSG+/c9h5A8fBA0z
jnEylvkpYvJ4NSuNdZRCiSaqNOvudnC0LY8TZw9WQOXvSHCmyJmeHC5UASVK/pUO
5RsU+uaK/7eBUbomt4TsfUaD3dDhZ1DeTMF2pojitJHPQT+Cb3k84n9N8+NFt3kh
zAojTB3TA4N1xbzMQM54RLRWOnIqG9CNFZtKUakGaLFDMHWYAwEQeDEupbOf4zaJ
fglvZTXMJhzcNMbzFrHSueR6B2oXNdv9/fIWcHBTtqTjFgEJADs=
=QI5o
-----END PGP SIGNATURE-----

--RG6yOUgWUL2F--
