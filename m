Return-Path: <SRS0=YV7M=ZQ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEF5C432C0
	for <linux-fstests@archiver.kernel.org>; Sun, 24 Nov 2019 16:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A2120748
	for <linux-fstests@archiver.kernel.org>; Sun, 24 Nov 2019 16:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2FGDkC4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfKXQ2z (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 24 Nov 2019 11:28:55 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:40379 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfKXQ2z (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 24 Nov 2019 11:28:55 -0500
Received: by mail-pf1-f173.google.com with SMTP id i187so1880991pfc.7
        for <fstests@vger.kernel.org>; Sun, 24 Nov 2019 08:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=tBDrnHe3iEho6XIW5tn+iNlev4Nrh3YWG6dH6mSV4ZY=;
        b=T2FGDkC4lRQpUuvGam0SThHv4XbcBy6o7R2lN3wxaZfv0IeesHDGV0s6jU+9h7PP3U
         lV66fYwr4I3s7kAzbfgM/I8vvEIZ4WmV4CwMGJNxfCcxkYa4RSdvzOrkIWRYUmOStJ9O
         l/9bDbDAuUpZ/zZoXlBvgncbNquPrnPlyh9H7MqjuqHZ7bQe+/rFOfOr+CA0ZDhWm0vV
         ffrsyj8i6YzsS5xljnDvoZL72LWAeKpLKpJGtiovyTLwVxSDatfZSKA+9Yx9CDtjnyhD
         Wg78sfM+49BnB1W9X7XzsSQds7MlRNJ4gCQX207rrGBDP/Y36KxxPkmro+0yBwiYqQsN
         8Wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=tBDrnHe3iEho6XIW5tn+iNlev4Nrh3YWG6dH6mSV4ZY=;
        b=lv7MVRfh6aM58qDdx2RY8Etr9eMncggDksbXAldEANDd4e3tDA1Byb5trn7q6mS3UR
         PTv0t94NrE1/ZO5xj5k4LWGHffPma6hWaTZgynt0DXJH485f8XGXqFOVPFAOWcZU+HD6
         DQWrIpKn2q66bJwBoCCetYQgKA+/P4NyUhJZ3ZIDBz8NdpSF5eF+BQsfvw+Vx6GoRM0A
         Gc9IdRkWDnE0xD+j1tcjuf/Bkk9LdlhgveA/RtakltOgqyyurI5N379PHT4PQHPzYaB9
         dMSqh3zwCt9RESMNDZFM03N+XFQo5bO81nmVzfW0OiyfCKeJHE2+D7ePBp6zLX7WkwfM
         A+Lw==
X-Gm-Message-State: APjAAAUu/Nd9i0ejclfIuGgG7IXxaHzD2qE4hGlKr6o6gqIysj+QO3y8
        QmBzb8cs2kKnuVv71Fc0S8KyQ6Hh
X-Google-Smtp-Source: APXvYqzJBRxzIe1iJBxlKy/qr/HhsBzuRxar6Goz9RsyeS1/9wSB0mtJJaKCedVHtfubcAAvRwFTtw==
X-Received: by 2002:a65:5648:: with SMTP id m8mr27916717pgs.286.1574612934045;
        Sun, 24 Nov 2019 08:28:54 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id f26sm4918839pgf.22.2019.11.24.08.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 08:28:53 -0800 (PST)
Message-ID: <5ddaafc5.1c69fb81.7e284.ad99@mx.google.com>
Date:   Mon, 25 Nov 2019 00:28:47 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 67a76593ba2e
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pu9XhhUd3UZf"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--pu9XhhUd3UZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is basically a bugfix update, the only new test is
btrfs/201, which currently fails with latest upstream kernel.

My apologies that I've been busy with other work recently and have limit time
reviewing patches, so there was no update last week, and I still have some
review backlogs to catch up. I'm really appreciated that if you could help
review the pending patches, especially the following patches:

- fscrypt patches (RFC), from Eric Biggers
- btrfs subvol & snapshot support to fsstress, from Josef Bacik
- ext4 tests ported from LTP, from Yong Sun

Thanks,
Eryu

The new head of the master branch is commit:

67a76593ba2e btrfs: test fsync after hole punching when using the no-holes feature

New commits:

Amir Goldstein (1):
      [acb2ba78a378] overlay: support timestamp range check

Filipe Manana (1):
      [67a76593ba2e] btrfs: test fsync after hole punching when using the no-holes feature

Jan Kara (2):
      [e0884798713c] generic/050: Handle xfs quota special case with different output
      [bb7c6d6172d3] generic/050: Consistently remove traling dot from umount output

Naohiro Aota (1):
      [3414cae6d231] btrfs/085: check flakey device instead of backend device

Xiaoli Feng (1):
      [86216d73ef61] ext4/031: use _try_scratch_mount instead of _scratch_mount

Zorro Lang (1):
      [f3e465ae9136] generic/563: fix the wrong case number in golden image


Code Diffstat:

 common/rc                      |  10 ++-
 tests/btrfs/085                |   2 +-
 tests/btrfs/201                | 190 +++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/201.out            |  24 ++++++
 tests/btrfs/group              |   1 +
 tests/ext4/031                 |   2 +-
 tests/generic/050              |  62 ++++----------
 tests/generic/050.cfg          |   1 +
 tests/generic/050.out.xfsquota |  25 ++++++
 tests/generic/563.out          |   2 +-
 10 files changed, 270 insertions(+), 49 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--pu9XhhUd3UZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl3arx0ACgkQJlKqKVyP
52PSAQ//dTsBCEz4wY+dc/UnfFp6XD+lWFEMohuBmkLUNZydTw7hCWD31sC2KMRd
v6C8EjDJEuclxnyn1T0G5cslBVva+69i8CZAJZhdH860oIwpH6oOm8QsShOcZO4p
x4/nPbgg+B2Glfj5/SCEwBxj8kYKE9zlG499M3A0ROxDbAD3zOl6xKC9AkY3KHmg
8t8ZyP4sqNN6CC1nQJVcfhuQKKegt5rAi3L8eSH1rkHijJ/TnrccWJ/jnGS2BX2f
I6hGFwWUW4ejZFUVDdkisBfD5D2R7QlvUf7PUCfJcBjre8Gfau4qRK7xCbcy/utP
KMMpwV3aZwIyH9WeEVYSgyPu+7rq3Z3UwhSo2+kTUmEGWDqu6ESJvIRNu9fvme4e
zNBYdc67cfPCP3+zmwYZ6CIF0qgrXx2+u+ZRpkHgs+yn6tZdRK/S42bnHaAClAtE
RC3hUYt4xZFh+E2MvYd43o7FBXTyRfM2TY82gvmE8Sj+CCmWUa7e3k5EOv5JUrlC
0XdPbWHr5Pa1LFX2qX59CHTXAkr9vWMRgRHXh0rmFp2DOL60erXlLSM2z9f5wzIG
EdqiRt+Cc37ti45GCm1wGqxdKcEZSdFyaCs+UbHlgpN3pxNFuHJ1oK4C0FoWZaN7
NS2oh6TMtWtTid+iksMX9rwXAnFy+pb9Y8t9RmrfLgw63RxeXmw=
=SOR4
-----END PGP SIGNATURE-----

--pu9XhhUd3UZf--
