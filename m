Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2AAC07E95
	for <linux-fstests@archiver.kernel.org>; Sun,  4 Jul 2021 13:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 026E661376
	for <linux-fstests@archiver.kernel.org>; Sun,  4 Jul 2021 13:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhGDNY7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 4 Jul 2021 09:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhGDNY7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 4 Jul 2021 09:24:59 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166F3C061574
        for <fstests@vger.kernel.org>; Sun,  4 Jul 2021 06:22:23 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id n9so1308352wrs.13
        for <fstests@vger.kernel.org>; Sun, 04 Jul 2021 06:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=eTOlOdT6Slsc5buJU767+IJtiGO7p9qgieeklyTdGJQ=;
        b=SwkFE6HCZF75shxeGuCyGTUXglazQiLOkL/URpMlLvqdPurNeZ2rkDy6S1QXs1eqtc
         x8fM4cGCf5H05ETx6TSJrfBphlM1Vxd6xVvhbBujdFG6XKyapTZR2D+YQDdHUvRxcKIj
         YecobORCKiyZVSRoo1AVeFHcRXDvbciIN812M1AjhJ930cclJM0KfEAP3fJBR0J/oL4I
         jaQbZRaHvLEgxH5Jrb9cHRAep4hmmfktgoZCWRXA1oHcFcdw0u60Pmsg2X5fgB41zaMR
         lFTteWk7uE569EszTGsgFsu+gQcHvgTu14+Cn3FNsJdNBdtnPlKNEiWn/QL35rUxm0xF
         Zveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=eTOlOdT6Slsc5buJU767+IJtiGO7p9qgieeklyTdGJQ=;
        b=KqTUHnICgv97KB5VOh6rC+Pxlh9b2yUnEvSlX25DM06z01Rdlyyi79OI9zoHW5KnCf
         0mZmq3tq0ptBWq+EWh+Ohk1/DJCzQxXVFUBpVP4Ttmqbn7/Fdkaf54HeiCUP3fn33TSi
         ZfRdr7dcxx+frTE5QuP1VBts2DdZ+/zu8oGMALUktG6/AERpoyrpkfYhBe/1le29xnFV
         rYByLVc+cNmYKBhK+uMwxtDlHJr4PAcR5SN7vVMuN3VLVJdcfdEiHY/QkI8ervrirYud
         2QyFg7sXu2Ee//Ww+cI/iOW5z7eQPg6fatnIWnE8S+2gq/T+ZvwivTuf3SojB0MlcF71
         rppw==
X-Gm-Message-State: AOAM531H30BnY/edIGil4qyRUObtJJQC1SN+a3kd5h6L85BUSmNutFSi
        FkXdtyRsoANjm2d1l93ByLOuKi+B+eo=
X-Google-Smtp-Source: ABdhPJxSgW8ycf+KAKpvmku3LNJWYkLn+yAYejdY7ysd8Ob55GNSQm4gtZSFlMhnELOwsl1kAMANiA==
X-Received: by 2002:a5d:4e43:: with SMTP id r3mr10260237wrt.132.1625404941367;
        Sun, 04 Jul 2021 06:22:21 -0700 (PDT)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id f2sm9685834wrd.64.2021.07.04.06.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 06:22:19 -0700 (PDT)
Message-ID: <60e1b60b.1c69fb81.b47e1.7376@mx.google.com>
Date:   Sun, 04 Jul 2021 21:22:15 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 623b4ea4082b
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2m0tW3ZN9wff"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--2m0tW3ZN9wff
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a normal bugfix update, with only one new test,
which should pass on all filesystems.

And the 'auto generated group file rework' seems stable, it didn't introduce
any regression so far, the only issue reported was generic/019 failure, which
was exposed not caused by the rework. But bugs may still hide somewhere, please
help report and/or fix bugs, as always, if you hit any.

Thanks,
Eryu

The new head of the master branch is commit:

623b4ea4082b overlay/Makefile: Use the unified name rules

New commits:

Anju T Sudhakar (1):
      [3be0233fbbcf] xfs/504: Add scratch_mount before checking for xfs_scrub unicode support

Darrick J. Wong (1):
      [c9419e671d0c] tools: make convert-group ignore converted test files

Dave Chinner (1):
      [35ff42b1dc1e] generic/019: fix test cleanup

Jeff Layton (1):
      [80b8fe47d013] generic: ensure that page is properly filled before write

Sun Ke (3):
      [7f17fee84a88] generic/042: make a bigger img for f2fs
      [9e31513f5fbd] generic/103: special left calculation for f2fs
      [c360cd10a1b8] generic/260: f2fs is also special

Theodore Ts'o (1):
      [a9e50808a843] check: exit with exit code 1 after printing the usage message

Yang Xu (2):
      [23e3bf7e28be] Makefile: fix bug when running make install under tests/* directory
      [623b4ea4082b] overlay/Makefile: Use the unified name rules


Code Diffstat:

 Makefile               |  3 ++-
 check                  |  2 +-
 include/builddefs.in   |  2 +-
 tests/generic/019      |  2 --
 tests/generic/042      |  6 ++++--
 tests/generic/103      | 10 +++++++++-
 tests/generic/260      | 10 ++++++++--
 tests/generic/639      | 39 +++++++++++++++++++++++++++++++++++++++
 tests/generic/639.out  |  5 +++++
 tests/overlay/Makefile |  4 ++--
 tests/xfs/504          |  3 +++
 tools/convert-group    |  2 ++
 12 files changed, 76 insertions(+), 12 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--2m0tW3ZN9wff
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmDhtdcACgkQJlKqKVyP
52Pdxg//ZC7m1rpfUdDDT0nOoWjsI8sxX1FS4uOGnZRV5EoRCAJAq4FNKOTkd2bW
Woal7PGcexx0RQTMIMMgteZRojw1QLPvcLceiPheVDMpI9hvIVmo6couVSZi5tkU
eZGyBSwC4aWP72z/tbCRJidPLQKwF71zaTYNhp/n2xqcNZQYevK/2BfJaehO5N4d
0UryR49MLWW1bWnmxJFw61brasNx7erH9c/sPKu9FYyRSrg5EGJJmampkAJ1Cxdb
HgeCBURpP9+sbIMa1/y3WiU2bVcCmvE0LVxdvlj1yNk06O5EZuhk074HwgnsnYlj
RoRNm7qHkj+396+AylWAD3AZD/AhxM8UoCV8vea3MkGPCKxXCw8PaEfOhmjEx7NZ
GhGH1qNzRpTQk0ji+iVZWwxfax1qZt6hf9xaIi0ZusN1et59BdC0DA3jDj1eZrrq
JiDLpGduwyJVJUGER4T69CaS8IC3C9H4fwidpDwizAc3RgZ5EyKTee4o+9WEHqkp
fz6oJbC6y0f6Ext4FG8tfk/hiwJrQZKpjbywWqxA+SVZ5jHxfGni5HLvp61/Zxtd
qtiFGp91//uHAwqPjq2Yk5Zdr5Q87yoWn5lsYD/042a0o94o5fUWYKRVRSgZOQ7Y
oi+sNprXGl19mMW45iEavsqKjrfUpc4y3Aw39HPganI2DzGdD9Q=
=l1z1
-----END PGP SIGNATURE-----

--2m0tW3ZN9wff--
