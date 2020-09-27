Return-Path: <SRS0=/6m1=DE=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2BAC4346E
	for <linux-fstests@archiver.kernel.org>; Sun, 27 Sep 2020 10:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C8602399A
	for <linux-fstests@archiver.kernel.org>; Sun, 27 Sep 2020 10:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUQyov58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgI0KR4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 27 Sep 2020 06:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgI0KR4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 27 Sep 2020 06:17:56 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BD7C0613CE
        for <fstests@vger.kernel.org>; Sun, 27 Sep 2020 03:17:56 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id md22so1148777pjb.0
        for <fstests@vger.kernel.org>; Sun, 27 Sep 2020 03:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=zbtX7oycYxdMdrUcvTTNS94gZ49/B8/AL+Q1JpBc6d0=;
        b=NUQyov58ZjDs3+uGb2DnDXknB7uiqwAe0En0vVR9RNYZdfrWJLoQBJp2BW0Ev5BkYP
         AA4FxuKJ02jC4Z25gPAtbjKOvqA5lzQRA5LWKyKdNQeSr+BWTbeJx4XwmJqKIqX2Hn1B
         XnRoDa5VhajB6DMc5JqkqgAwBY1glbjRUMtyizQAXlLKtvcVOhxrmrMqyInL4hRt+8yE
         v+1fFTUQxU5S11RvHJHu+65ig3qpnh87srJOlW+nk5nmTVq2syXg+RBU1X56umVxwQY0
         ineoWThGqpc5zqRswaiOFE2F2BG3qLnB50a+1RxoJ/4ACwukXmF9X9TUr1h5rBZJ0/QX
         HHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=zbtX7oycYxdMdrUcvTTNS94gZ49/B8/AL+Q1JpBc6d0=;
        b=eh2hCGTD04rfluf0ruxA3SMLa45vRovrndn2Xh9NNRJFq3bR5ifmFJVIszUkK38t6C
         0c9e2DVg/hLnhhVASpQU2WuQMyjtglnQg2+AnpG//tWL+Uf427AcjrRQIIjV1SWumO+6
         ysTPLpix/M7lHY7vkHmt6tI+QCvEvsWTCj5jTRDuR4f6qSbpyhWBnddJ9CRJnISJ7FsQ
         h6OMWbTTepgDf3t0a0eamdOCtG25hYuvHdVEIOvcGiTi6OZOXI+p062t85N6/t6vFAff
         4a1vKZa8jNwrNDykXbtqaXIBZwnNjO6xW+I46sBPtZ7tX50KenXpbE4GLqrhxPUD/4b9
         qqJQ==
X-Gm-Message-State: AOAM531rjl8Q0wr5W3UIF57ROJwmt4eWvVZsIpR/GnqYIc8XHR+hcVL2
        tN2y+sv9fMVOyKT4dNJBfvrFuqoADlHBuw==
X-Google-Smtp-Source: ABdhPJxTMelDErj8hnXp19IVc+xHRYjOc1ShV1XU04cFLSTlQL7Q6DvaIdGMxVeK7WfpaAmemDws6Q==
X-Received: by 2002:a17:90b:693:: with SMTP id m19mr4961140pjz.111.1601201875811;
        Sun, 27 Sep 2020 03:17:55 -0700 (PDT)
Received: from localhost ([47.89.231.86])
        by smtp.gmail.com with ESMTPSA id p6sm7850680pfn.63.2020.09.27.03.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 03:17:54 -0700 (PDT)
Message-ID: <5f7066d2.1c69fb81.a8fa5.64fd@mx.google.com>
Date:   Sun, 27 Sep 2020 18:17:51 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 75bd80f900ea
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="emldZtPLlnjE"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--emldZtPLlnjE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update mainly added IO_URING support to fsstress
and fsx, many thanks to Zorro Lang for doing this, also thanks to Brian Foster
for reviewing the patches!

There're also 3 new btrfs tests, which all should fail with latest kernel.

Thanks,
Eryu

The new head of the master branch is commit:

75bd80f900ea src/t_mmap_dio: do not build if !HAVE_AIO

New commits:

Eric Sandeen (1):
      [75bd80f900ea] src/t_mmap_dio: do not build if !HAVE_AIO

Filipe Manana (3):
      [03abb090754c] btrfs: test incremental send after a succession of rename and link operations
      [e240c4a965a5] btrfs: test incremental send after swapping same file with two directories
      [353bfccf5cdd] btrfs: test fstrim after doing a device replace

Johannes Thumshirn (2):
      [63aee278f796] btrfs: remove stale test for alien devices from auto group
      [6e723496c1bc] btrfs/125: remove constantly failing test from auto group

Pavel Reichl (1):
      [bfe532d6e26c] xfs: Add test for too-small device with stripe geometry

Zorro Lang (6):
      [57a18fcb244c] fsstress: add IO_URING read and write operations
      [4cf0a1e57cdc] fsstress: reduce the number of events when io_setup
      [7f9458a36f9b] fsstress: fix memory leak in do_aio_rw
      [5fbda8d18375] fsx: introduce fsx_rw to combine aio_rw with general read and write
      [f27875f08965] fsx: add IO_URING test
      [823c491b2dca] generic/611: remove _supported_os line


Code Diffstat:

 README                 |   4 +-
 configure.ac           |   1 +
 include/builddefs.in   |   1 +
 ltp/Makefile           |   5 ++
 ltp/fsstress.c         | 183 ++++++++++++++++++++++++++++++++++++++++++-------
 ltp/fsx.c              | 165 +++++++++++++++++++++++++++++++++++++++-----
 m4/Makefile            |   1 +
 m4/package_liburing.m4 |   4 ++
 src/Makefile           |   3 +-
 tests/btrfs/221        | 119 ++++++++++++++++++++++++++++++++
 tests/btrfs/221.out    |   6 ++
 tests/btrfs/222        | 142 ++++++++++++++++++++++++++++++++++++++
 tests/btrfs/222.out    |   6 ++
 tests/btrfs/223        |  71 +++++++++++++++++++
 tests/btrfs/223.out    |   7 ++
 tests/btrfs/group      |   7 +-
 tests/generic/611      |   1 -
 tests/xfs/260          |  51 ++++++++++++++
 tests/xfs/260.out      |   2 +
 tests/xfs/group        |   1 +
 20 files changed, 733 insertions(+), 47 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--emldZtPLlnjE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl9wZnIACgkQJlKqKVyP
52PE8BAArah6XDGNpF9PW82wzJ5KFNbCaNgWoTeZpbOrUWEHRRvQ5xPSILVIKhTk
3cjDHLvre9zBjstIyzapsu/WdNjtD/hli7CF5i1Shn75R4dHfymUkbghpWE9kCRQ
Bo6jnBnTRZWuKP8gfRU1n4fRwkEpA4sYchtdLx54s6Z6ygtZUo+yLKY5fA/j/VxX
+GBumshCPcLKOGjCsW9/BV8pOYwsjnMBDbmOBXmO+c3nLzRzjaxbWXVjk1aAD2/N
w0b+RCghvFhabeW4mdhdG7E/LH7pZs+46YtFYurszSshvxJJHyjzrRWMGzYeHvdI
7Am+mEbUWjzIu4HcNaea97VAyuKY/Y9MDWNjE1vCSCAXH/jnm6ZNEaiXlFGQ1FEg
OJB6u9/LVrnB+8gu/eUTBGjz9phTBYBDHj9n+83vEfWzpUulJaeTK/RVPl4Tce66
ZFkrcJbIjLbQ0GT/nzHYm9ZNJYodVRcSSabYdjZzpvyIz93dQL2meXQf4XHmgSng
wDKO9Y5Nx3x82FgqoLLI9gX0rxEFaWKGwtdPr4QSrbRPRqSaqahhEyZ4vSjcWROA
vnMRQCU0qcV4/fpkbAacmDXgBHx7LDsvGVO73YRX53Cl1Kg5u3MKjPgRip5IRd71
mytMf9b6cGjRg2t6tqX9UXAgIjRDZ9N5HU1+gNQss9ykJz8uGFo=
=C+KN
-----END PGP SIGNATURE-----

--emldZtPLlnjE--
