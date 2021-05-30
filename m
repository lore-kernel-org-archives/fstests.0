Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A130C47092
	for <linux-fstests@archiver.kernel.org>; Sun, 30 May 2021 13:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A637611BD
	for <linux-fstests@archiver.kernel.org>; Sun, 30 May 2021 13:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbhE3OAK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 30 May 2021 10:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhE3OAJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 30 May 2021 10:00:09 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EC6C061574
        for <fstests@vger.kernel.org>; Sun, 30 May 2021 06:58:30 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v23so5764855wrd.10
        for <fstests@vger.kernel.org>; Sun, 30 May 2021 06:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=CE/6tTX/EJI6rSpuZHNIkFu9jbG1lKCC0LdL5/Q4McY=;
        b=LFTfkVd8WK8h5Gs+GqrcTbnW705fm0Ny/8SJ4Hb5HbRHvvOHquEueKbkEqWMFg4aS8
         oyezzmd6HHweocrEEuJCXvHhiH1VhD8yUxlE/JvoeKAt+NII6u5BQBRzqM2XP90QnsXG
         hQK3h5YqEfuGBpR0qbPidrG6zXLUs5UFVmTA1sINGYYOgEVmPx8yjsiTzqlsOgM5H9Cg
         mE5NJyeLan54SkC1RBjY0xYWVZsn6rXKkbJSa0ilodt+63aiivzyAM91MsCsyio8TnGw
         s4Daq0w3/GeXdMdob3PbZCd3TbIuMwj+KqsbwzgR02KD26y9WG3HHDPScJ/HVRfqCPjK
         0RQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=CE/6tTX/EJI6rSpuZHNIkFu9jbG1lKCC0LdL5/Q4McY=;
        b=DXfXoCHrFwtyQtQN1gxpC6lvAmhq96N24H+a8eKNJX9b7Mk1yk4s/Cly6Z3Ixh1qLi
         wNnaxVMMSYfgGwlhUe+aPOBPheXgG4hLhA9f3+i1Sk4Zkt/BR4ffy+u6ZRXLRqiItsAF
         fhDK+lS6Zjm+wd5KZ7ZD3uuZaUf0Yybvwuu9VS8Z3dkx+BycwYSkQrYKnUctO9/dFi2U
         aFTMKZKT0OrVG2pt2sTQBgKck+vlYqN0SEpRdRRvT4pfzgVTiq+uTtyQk7BnInZ1QT8f
         eQ1SmYlJLJUcYcSxaBfVl9LepM0Freh5EC6P6Q/kNNIbmq9zLICfN1QQXBVYi/XPunM/
         W7wA==
X-Gm-Message-State: AOAM532CZkdMfSfRB7d7G5JSnnP9Eax4dKvTGsIslp0C0FtDIvr/HL0F
        Rvt0bOx60VL/mchTgfYLbwNy5wH1C3M=
X-Google-Smtp-Source: ABdhPJzedj3BpbSuIx43bDnCFmU4Wgq7p/MG80V7SkBhGxMoHI65bYsx6rNJ9dUceb9LyXU7tFYbOw==
X-Received: by 2002:adf:fd82:: with SMTP id d2mr18063488wrr.218.1622383108866;
        Sun, 30 May 2021 06:58:28 -0700 (PDT)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id n12sm831085wrs.19.2021.05.30.06.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 06:58:27 -0700 (PDT)
Message-ID: <60b39a03.1c69fb81.19580.375a@mx.google.com>
Date:   Sun, 30 May 2021 21:58:21 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 37881397f1aa
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5enEhAYlYMiU"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--5enEhAYlYMiU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. Notably, initial bcachefs support has been added in
this update, though bcachefs itself is not upstreamed yet, this will help
bcachefs being tested widely, and help bcachefs being merged in upstream.

There're also new tests and fixes as usual, and the new btrfs/240 currently
fails with latest v5.13-rc3 kernel.

The group file re-work patchset from Darrick J. Wong is still in review, and
may need more eyes and testings.

Thanks,
Eryu

The new head of the master branch is commit:

37881397f1aa ext4: prevent initializing reserved inodes

New commits:

Filipe Manana (1):
      [2605c135e15c] btrfs: add test for multiple fsync with adjacent preallocated extents

Kent Overstreet (2):
      [5b44709187ce] fstests: improved .gitignore
      [986733634c61] fstests: initial bcachefs support

Sun Ke (2):
      [9bc323f334b6] xfs: fix check of whether the mkfs fail
      [05fafbff9950] generic/042: set size to 38M for f2fs

Yang Xu (1):
      [ee7383c5f54c] common/xfs: Fix _require_scratch_xfs_shrink bug

chenlong (1):
      [37881397f1aa] ext4: prevent initializing reserved inodes


Code Diffstat:

 .gitignore          |   3 +
 common/attr         |   6 ++
 common/config       |   3 +
 common/quota        |   4 +-
 common/rc           |  11 ++++
 common/xfs          |   3 +-
 tests/btrfs/240     | 173 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/240.out |  29 +++++++++
 tests/btrfs/group   |   1 +
 tests/ext4/049      |  67 ++++++++++++++++++++
 tests/ext4/049.out  |   7 +++
 tests/ext4/group    |   1 +
 tests/generic/042   |   8 ++-
 tests/generic/425   |   3 +
 tests/generic/441   |   2 +-
 tests/xfs/070       |   3 +-
 tests/xfs/448       |   3 +-
 17 files changed, 320 insertions(+), 7 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--5enEhAYlYMiU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmCzmbYACgkQJlKqKVyP
52OXdA//X+MvqOOeuJ6uJniZVjoW6vFdGaT7n148R2sAQojQKPwC5YZ34ksEBwVL
Fhvfx/TzYBNz1rfSHGZ5K+E+S3JIXP6yxAZHTQiOX+zSgYKSYy9LwXNlvd6/brmu
EKsgvMx5IXh836EaxLXet3KBiqTkF1XQ/2Q76xFO7IhJVZ7Wk6JHlYPCF2FC1iUX
pUyvhW1TI/OBhbN1yBHZIUCfdXygg7RyEUmZRYHtOqgbsgNYIMT7a1ZeTwsEYmB/
ucU/Oic0lGrLs9SXisHAGxvtBd0Xw2+mFrvlahALGRYYq8VmWG/34XTJUUAHvUdf
AAEfcrmshTJ3M/ajqnnY+g9hksuET5mm4vuxZ0Af0Bqn1/D/u0oz0ZwxsgmjzS9T
6iIssXDIWyV9wTho06Ne2GOCVbSj25N86ioEZi7YPSrAM5WU216tYL/+XNqqg3ZL
obJTg0jBeHCO5/nVzMwspFcUO18A3EIgr6tzbsxG5nphBaHXCiJcmJjKo+ewouD4
VvFiUZEx8FEUjhiV0Kvdd8T3PZ4GF2KhSSEB5LniQnYs9tPE//3FM4sOGQq7oulj
w95apwaDhhWNK0jP9FMd/BlPNHLppJn5YBlHKHAC25BbPyHI7POV5VAEwYLVHTm6
vHh6fUL86t4I0tgjEpO6RBunaJ6oSyd2tgG1FFk8VOuEPbr1ZHI=
=Bj1+
-----END PGP SIGNATURE-----

--5enEhAYlYMiU--
