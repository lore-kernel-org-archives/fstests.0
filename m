Return-Path: <SRS0=SJPO=Y3=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E05CA9EB0
	for <linux-fstests@archiver.kernel.org>; Sun,  3 Nov 2019 16:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9218920659
	for <linux-fstests@archiver.kernel.org>; Sun,  3 Nov 2019 16:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gA6vKNjw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfKCQ04 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 3 Nov 2019 11:26:56 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34663 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbfKCQ04 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 3 Nov 2019 11:26:56 -0500
Received: by mail-pg1-f194.google.com with SMTP id e4so9692117pgs.1
        for <fstests@vger.kernel.org>; Sun, 03 Nov 2019 08:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=xx53ECyaRFLGxIvH/HkIdGa/cfBYAdGsD4YJn4h8Hy8=;
        b=gA6vKNjwLxuM4qYZgAh71oS6irOTrWrlyyewdNKXzMwPHfKBthjzJvd6ayxk+lKyfD
         8R2vncmh/xZaSAm+UnHy9c350QWuSnI/PUleLAL5PXxcdniQOJ/TVZPGQd/7xqby6DZR
         ON1qwO/QDNEaJgsmIxdStVJQVKzDWdvcunD4hnA7h7th/LP7ktW8E2aw+wBSwt1w/Ct1
         sR9D+ISJhWJ41+rHZqj/TBocs7IMmJ3jAsMlcrMVpfTzJqwy53RSzEm1kRHWvcYMtwK2
         DflRyryiS92bLWVl9Hpc3gg0ZIrEkhvGrVKJ6wHU6hqoH+sO2GXIcl7J34H9DPBbI09Z
         MneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=xx53ECyaRFLGxIvH/HkIdGa/cfBYAdGsD4YJn4h8Hy8=;
        b=ttCJm+qzdQCqjsOwjSuAckttGBfhHWW5ssUBBPx3VCBsXRa9E0QGGOyO7QfuZfXMhC
         E1lGK/2sL+h3Xsi//xiwzxCdIvq4Y5t/TZun6qQUWZAC1lUOMJ5Pbd3Z/r6Kj6ym0iMF
         5sPvSZOojWhKW9R8eC4QA4V0VzytvDT6ZVKXZo824sNS0cT8Ik9go6fokA3yLHgHDpNS
         LCaa47moV0add+Elto5g8CHa8ZLEukhw+64NQOCn2oemGP2RXaYHy2Ta73S+moRc9Uel
         F9oVZ9AW0m6wvw+QLH6pjQxPIOA4dknZZJazwgNgdJh85ClnevNmCvjnnDeKqHVuLhhY
         UicQ==
X-Gm-Message-State: APjAAAWH5KTZ2RraNSeMO+UpqJa0nKeZmLI3wXfLJsSCkIkHDUfiAT4l
        56YBY5mhsLPJ6zZV7ckJB3174z72
X-Google-Smtp-Source: APXvYqy1r45ysCV6NKXideOa6kcxwrsrLOg+O1XAUYbDYKtFM7yqR6u5mftGssI4s+FgyZrtTySyyA==
X-Received: by 2002:a62:4e96:: with SMTP id c144mr26171788pfb.45.1572798414875;
        Sun, 03 Nov 2019 08:26:54 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id y144sm12739394pfb.188.2019.11.03.08.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 08:26:53 -0800 (PST)
Message-ID: <5dbeffcd.1c69fb81.d08e.49ba@mx.google.com>
Date:   Mon, 04 Nov 2019 00:26:48 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 220b7e35fe34
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TDUCammdkLmT"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--TDUCammdkLmT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. Thanks to kaixuxia, fsstress is now having renameat2
support, and there's a new test that takes use of this new functionality! Also
many thanks to Brian Foster reviewing the renameat2 support patchsets.

The other commits are fixing random bugs, so there should be no new failures
after this update.

Thanks,
Eryu

The new head of the master branch is commit:

220b7e35fe34 generic/317: Use relative paths to avoid traversal permission problems

New commits:

Baihua Lu (1):
      [c062fdb6705e] common/rc: fix _require_xfs_io_command utimes check

Chao Yu (1):
      [11d3da6a7fe1] common/rc: generalize _get_filesize()

Eric Biggers (1):
      [eff343fb5d5f] generic: handle fs.verity.require_signatures being enabled

Zhihao Cheng (1):
      [220b7e35fe34] generic/317: Use relative paths to avoid traversal permission problems

kaixuxia (4):
      [266e3c91d649] fsstress: show the real file id and parid in rename_f()
      [7f41cf24140c] fsstress: add NOREPLACE and WHITEOUT renameat2 support
      [65dfd40a97b6] fsstress: add EXCHANGE renameat2 support
      [0f211f5bca40] generic: test the deadlock between the AGI and AGF with RENAME_WHITEOUT


Code Diffstat:

 common/populate       |   2 +-
 common/rc             |   7 +-
 common/verity         |  41 +++++++--
 ltp/fsstress.c        | 231 +++++++++++++++++++++++++++++++++++++++++---------
 tests/btrfs/086       |   2 +-
 tests/generic/013     |   5 --
 tests/generic/275     |   2 +-
 tests/generic/286     |   8 +-
 tests/generic/297     |   2 +-
 tests/generic/298     |   2 +-
 tests/generic/315     |   2 +-
 tests/generic/317     |   5 +-
 tests/generic/399     |   2 +-
 tests/generic/497     |   8 +-
 tests/generic/514     |   2 +-
 tests/generic/572     |   6 +-
 tests/generic/573     |   2 +
 tests/generic/574     |   2 +
 tests/generic/575     |   2 +
 tests/generic/576     |   2 +
 tests/generic/577     |   8 +-
 tests/generic/577.out |   1 -
 tests/generic/579     |   2 +
 tests/generic/585     |  56 ++++++++++++
 tests/generic/585.out |   2 +
 tests/generic/group   |   1 +
 tests/overlay/060     |   2 +-
 tests/xfs/014         |   2 +-
 tests/xfs/076         |   2 +-
 tests/xfs/306         |   2 +-
 30 files changed, 334 insertions(+), 79 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--TDUCammdkLmT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl2+/3QACgkQJlKqKVyP
52Nm1w/9FYpeMscCv1IUrLQzjp5oO9AlHmIKrLw3RFCyZBEV4Xn3sm0xBUV7756M
hzivR1nfr1s17DPa7gfb4vfu7GS3d/Xy1ziR+YPkxaVwCqsQynsdfBXDoe96hKWk
8oX+lC+WuLiL4tEbqnS7725+BKb/zL5OvG6xxXR/NsHzrkwNUtQbzj87HlEWuKGv
gac+ZglPPwQXmVSFhxjtTa3oKgypo/2d96yfFwoblzX4kCgxHxFSPdG4t9kt3krQ
1F+jAIPVFlo7uKfCX+CUaSYxgyTs2L7SqCJiHuOko4YEyIPe7Ejtuhj3S3OmP0FY
uxncTLhU0GWocX6x8rGpgSGfQOuJsx0EowlccvonQu1tXDksxqDmutvmcyVRqfut
mGQa/WcGYoDHnHyBTElErn3nBdb+1uBUGMQ5BajXWtQkP7OiSI7jNpSaYUg9z7oL
RgsAP+NvhSMMYYQ+Ayi9g7iRIOMC47buQOx/bw9P1kIl41I8CJaexhma9xDL02px
P8BXj7OEjIJlIApapiM7iReUZPAUHu9uGejxDY3bvlivTVfib2Lwj5l0bbWy/aNC
azPKfo7d4vjI3fwv+tcNo8kkJ95UYnL5Qc2JF725Aimc8LFUETnJZzbw/jCTh3re
BfGNY3q6EKIrcX1O0LqeH+Mlkiirxv0AS17Q/M7MZG7UJtjsXhE=
=aAHy
-----END PGP SIGNATURE-----

--TDUCammdkLmT--
