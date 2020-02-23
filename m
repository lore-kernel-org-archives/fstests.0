Return-Path: <SRS0=lR6x=4L=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45C4C35671
	for <linux-fstests@archiver.kernel.org>; Sun, 23 Feb 2020 15:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9497F2067D
	for <linux-fstests@archiver.kernel.org>; Sun, 23 Feb 2020 15:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtQJNHoO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgBWPTA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 23 Feb 2020 10:19:00 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41995 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgBWPTA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 23 Feb 2020 10:19:00 -0500
Received: by mail-pg1-f194.google.com with SMTP id w21so3659567pgl.9
        for <fstests@vger.kernel.org>; Sun, 23 Feb 2020 07:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=8fX9INNWDi2isLw5FE8Wski1jyxH90Gn2qbcgCtIzGo=;
        b=RtQJNHoO6fXeF4oTDmTo1hJz85KH3g3O+zeMYSYh4WqJllSKwYhFbKYQ9Q21atLzOL
         9to09M3r0WrppikcOqyi2YTAcD448+zEQ3WRrazaVRUW1ZDvevJMYftv/b0CI9BQiFSg
         MP9v++SfZYrFLaMoia0kH3sJk1PocYIME3uVQ6F1zdGVxzLOfBGSTJRMmEx9gPjJx6SZ
         rAJv8GQhVVy56psFrDsTPjfuyL7RJQsM2ipAx9y3zIOdmnRORUzijCilmjgMIN+G1tSI
         BAYhlBOx0PTIHo/O30mJcDYuM7EecWZuv2gxHuDKyFg7rzBwTJu/YVFzqpd8sl3alrUy
         DaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=8fX9INNWDi2isLw5FE8Wski1jyxH90Gn2qbcgCtIzGo=;
        b=h4SbZanWuwhGjaj0JQsocxTchzzTxocutpQJPstYlFrBCwOQ3RU75QUsddYVKhIUjG
         4s8TDE8nl6iSGWQnk0DuHUFsfTeNeOxFrr5AxPspCMMd1gAomccflcMv9N9jp+cnqzPZ
         C/U7VShkNNnSHO2QSyweG0OuJJpGTmb1xFSwogb5wEp7JfpHbMEHYdbiddmjscUPCQCl
         yWkpy7v4MJeP/lIoJP3Fe2MISMhvdAjD+SzpGzEwegasXsaEKfSnI/qCAeJUFn1GGYY0
         qr+I7HAilZIYZUU7ewGJhQdNwUYI0+LWBGcxT2ZP2GXUeIwkyc2mexZ5WoFgxBmub7rA
         g/uA==
X-Gm-Message-State: APjAAAV8VomSRwqnTapbCvKVVmvSicjtBHcdtiIOA16F0S+Kfx8famt8
        jg7rTifiOujZfLmyvsSbWLprwTzfsA6yFw==
X-Google-Smtp-Source: APXvYqypeTQ5A6ocGjlbwbMHHajZsa3B9oUu0K5gUn7F2X6pnbfNsklVOrx/hzivlALEeJl7KAYJHA==
X-Received: by 2002:a63:504f:: with SMTP id q15mr48519747pgl.8.1582471137915;
        Sun, 23 Feb 2020 07:18:57 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id 200sm9463748pfz.121.2020.02.23.07.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 07:18:57 -0800 (PST)
Message-ID: <5e5297e1.1c69fb81.fae04.a863@mx.google.com>
Date:   Sun, 23 Feb 2020 23:18:51 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 1d6d14db1165
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="o1btraeZzLtG"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--o1btraeZzLtG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. A new 'eio' group has been added, and all tests using
dmerror to simulate disk failures fall into this group. Also, btrfs gains two
new tests and gets some parts of the tests removed from btrfs/112, and xfs has
two minor bugfixes.

btrfs/205 currently fails with latest v5.6-rc2 kernel.

Thanks,
Eryu

The new head of the master branch is commit:

1d6d14db1165 fstests: add a another gap extent testcase for btrfs

New commits:

Filipe Manana (2):
      [dd0bcdadfed1] btrfs/112: remove some tests for cloning inline extents
      [6f7ef01037d2] btrfs: test newly supported cases of cloning inline extents

Josef Bacik (1):
      [1d6d14db1165] fstests: add a another gap extent testcase for btrfs

Theodore Ts'o (1):
      [f877833cf75a] fstests: add an eio group

Yang Xu (2):
      [8bdc8932fd2f] xfs/029: filter out "extended-header: cycle: 1" from output
      [cecafe158f49] xfs/044: Remove useless _filter_logprint


Code Diffstat:

 tests/btrfs/112     |  31 -------
 tests/btrfs/112.out |  48 -----------
 tests/btrfs/205     | 173 +++++++++++++++++++++++++++++++++++++
 tests/btrfs/205.out | 241 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/206     |  85 ++++++++++++++++++
 tests/btrfs/206.out |   5 ++
 tests/btrfs/group   |  10 ++-
 tests/generic/group |  42 ++++-----
 tests/xfs/029       |   6 +-
 tests/xfs/044       |  12 ---
 tests/xfs/group     |   8 +-
 11 files changed, 539 insertions(+), 122 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--o1btraeZzLtG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl5SluwACgkQJlKqKVyP
52M8iBAA5cyoTC2iz4DFP/1V1fRzQQXL9pFzhdOcsD8NgsY052G8w39fGY9ihoU/
7UucSKcRPlefPGrzbjMPriFRCJaW3KOC0sTkEx5E+R0E/MaQmr5ukjhsDQyu/Z5c
m9abfVdK6gWIAtaw2estDGO0Pbbrk+Gug3uCpic0EEuu6LpJx20LHCV5en4ww7o2
GXL8MY9VSHigWsOlHFuQ968r/qBvC9XOdyGifgMhOEFn6fwUlEcVtNvKXDnKWynT
21c3kUVVTFTICHfVzyDFd5x5XjFxLxvVd9D78qWIXDi+EGskNDu14bLcuAKFUt/X
QLhH6Oij7lDPZPQ29PzwNYlR75QO/eAXTSgT5lQlVXCqeWPJ2HOGHRp2CfJ6BaZy
r18rk4CW5xyv5j2rEM/0Z3QNkYx0ykFQzBUAb1Y9qWn1L1mORzNeVEbrBsCK/CMq
EcZzOWldGJQA24LjRFg+C4dycTC83U8dOvRwGgTu2Xwsfcc5iuEOiAsPw80aIWbJ
wr0JotrI+tStt/O9Hs0flWdwMUYEXyhO5u14TN4+PJGXoOPFhJsU4Og83P8myFEy
fbcO7SQWgP/DKY8ivZG6Ggd2cjVWa9Zs3BpB/iAokbWPoeDTz+UE7Z6Hr3Xser0E
CtqcWi5kt/tCSUWKcGsd9YRFmW6gTgqk6CobTnXNjsyhAjY96UE=
=tpz8
-----END PGP SIGNATURE-----

--o1btraeZzLtG--
