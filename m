Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DFCC433F5
	for <linux-fstests@archiver.kernel.org>; Sun,  7 Nov 2021 14:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00E8A61038
	for <linux-fstests@archiver.kernel.org>; Sun,  7 Nov 2021 14:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbhKGOKN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 7 Nov 2021 09:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbhKGOKN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 7 Nov 2021 09:10:13 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3FBC061570
        for <fstests@vger.kernel.org>; Sun,  7 Nov 2021 06:07:30 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id v127so10907995wme.5
        for <fstests@vger.kernel.org>; Sun, 07 Nov 2021 06:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=wyHR6AKdl9/XXjioxsO9zB0A98SfMBd2bzLuPKPH97E=;
        b=l3eH9g6y0BhtFwY4hk5HgDFh/YsC5YuqBZd3IM/Jabra3XMeY/g1R09nwQCQt5qSDV
         G/y3F9xaK6YE6IbJjNPcBND8B5bGLQzSBh3WUj/ZJaRsWxNLO12rbAVvbIjJRqLOrwqj
         y8Els/uzS6imcmrijzxWiUkGdfZiaZbmGsIZNj9SlxviDhln6u77iCmVreYHJsDmJ1S+
         IlCNBRPhNrAVTN8jM2gEhyUzJNWr98CoH2omDI8hlG5SRYW50JmVsy0+hndiwgyjWB5/
         Zta0yWnRISSPVlDsnZJsc+7g4/eZvaj/AskGYMzvcI50Ik7/ZpXQqA9eAFVa7A570N7f
         mTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=wyHR6AKdl9/XXjioxsO9zB0A98SfMBd2bzLuPKPH97E=;
        b=P0fPJ20LVEYUaqLEwedsjJWCiWXBc1eQX07S5zWnQHrxELO++DhO0l2QPF8cJidImk
         Yyrpy30XZdlKzF5wgKshIdKVcFjNvaMlfei5fQsHHsuOmL0SakKlRVEbIrMgyisKPn5o
         J0o9ZvenfHHWDE85xMh9GrAubKi7gdqhY2mTXWx2DLQLPRkscuhmOHye1auouxKtPNfN
         OQzLpx7sIjvu742/tzce6ZMRsSF+OCGMvAqc60ePU04JxOXbJuVbKA8x0FIWJG6PwwsQ
         Doic7e1flP4H5ea/wnhAnMgGyrdt3pTeKPrX+8jrCcOTlJnYExJz/60SUjFCnpgckZvC
         fJew==
X-Gm-Message-State: AOAM531N2PvpT74py14gQK6u5uZq7skN2anozTjUXp7XbKS4QkfTCv44
        gY/wnrICqPK3XwdhaOZj6lLVPeChmdF3Ig==
X-Google-Smtp-Source: ABdhPJyRspqCj2UCaC2k2Q3QClNSBL2mxgbdrTgjEpITXaDd4lsu11NobW5OnU54iBL9972XLJ4ZeA==
X-Received: by 2002:a1c:f405:: with SMTP id z5mr46006495wma.33.1636294048644;
        Sun, 07 Nov 2021 06:07:28 -0800 (PST)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id x1sm13028263wmc.22.2021.11.07.06.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 06:07:27 -0800 (PST)
Message-ID: <6187dd9f.1c69fb81.164b2.61b4@mx.google.com>
Date:   Sun, 07 Nov 2021 22:07:15 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to bae1d15f6421
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UM01AhKjAvtV"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--UM01AhKjAvtV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update only contains a few bugfixes and two
enhancements to fsstress. And thanks to Darrick J. Wong, fsstress now supports
more than 2^32 operations.

Thanks,
Eryu

The new head of the master branch is commit:

bae1d15f6421 common/btrfs: source module file and remove duplicates

New commits:

Darrick J. Wong (1):
      [dda3e2452d4e] fsstress: run more than 2^32 operations

Luis Chamberlain (2):
      [86db85c33c69] fsstress: improve error message on check_cwd() error
      [bae1d15f6421] common/btrfs: source module file and remove duplicates

Nikolay Borisov (1):
      [955e0660288c] common/rc: Fix check for SCRATCH_DEV_POOL presence in _scratch_dev_pool_get


Code Diffstat:

 common/btrfs    |   2 +
 common/rc       |  10 +-
 ltp/fsstress.c  | 691 +++++++++++++++++++++++++++++---------------------------
 tests/btrfs/124 |   1 -
 tests/btrfs/125 |   1 -
 tests/btrfs/163 |   1 -
 tests/btrfs/164 |   3 -
 tests/btrfs/219 |   1 -
 tests/btrfs/225 |   1 -
 tests/btrfs/242 |   1 -
 10 files changed, 363 insertions(+), 349 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--UM01AhKjAvtV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmGH3WAACgkQJlKqKVyP
52MW3Q//So6xOZXBWzKPWUAJOHEg6NU7F0pE072CIR1HM2dzYwfs5mBz/x5eo3m+
2B9xKX8rIQGphF9T+SuIj3I7/aTOPtYHyAKgq1yiQho51dfxOLuxG7SQ1EGAaH2C
3kDs1xTi8f5X2KqPv+5nAbJUXgt63nm+GGzKl+25fDbEKRZRcv8GcblpFm2zrFv7
TtBjINPpmpOHiRKPOkf+IVGU9TaBVpmk0SpZAsdv0Lr/4IKRxjY2rlLJLdnSHTY8
TCUSDMRUKfNdytvpAv+pr8IAeqQpANn8PsqBgKmJ/lQxZcDsJTdLYb/JH85qS+zy
1giiXF+fO5Uz3vc+sZChm+mR8Xe7o6j18ItVPGbHDSkQ01kTPPGQTdpXXJpEuLgF
s7pvXykJKeTEn0TPU3jn/4pNDhD4+OfMShQ2/rjW6wIFSeyCgdwFtsQ3UT+iVGDv
TxNR4GbaypsKL+DUSjyZ8CrLqnItWbDdJwHvd7qcoiN4klycKHH1RDnzRxTUnmS5
pSQJZbksH5WjE5KqEKvuolc/nkiC/h+z5NPi98SbObL/eDiokdXPChDjqmQZb0RR
REChR8194gftQ39ednc0G/tmmZrtWdiGO5sKKCXU33Fva0qJOX0jV/Rh0qcg6tsc
hCQ2REZs4m6eGPWdrRiIHU2WOzJEVc/FxGkSR1QcdjeXHhJ+qDA=
=QKin
-----END PGP SIGNATURE-----

--UM01AhKjAvtV--
