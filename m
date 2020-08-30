Return-Path: <SRS0=JoHA=CI=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C69C433E6
	for <linux-fstests@archiver.kernel.org>; Sun, 30 Aug 2020 16:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2F252071B
	for <linux-fstests@archiver.kernel.org>; Sun, 30 Aug 2020 16:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGU2f1ZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgH3Qb2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 30 Aug 2020 12:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgH3Qb1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 30 Aug 2020 12:31:27 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BD2C061573
        for <fstests@vger.kernel.org>; Sun, 30 Aug 2020 09:31:26 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id o68so3228562pfg.2
        for <fstests@vger.kernel.org>; Sun, 30 Aug 2020 09:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=4KorOM1AaREsSxzxP2FFmGr/4ZtCzhie0kePdXD0o70=;
        b=CGU2f1ZSdTVLz76OMJLcfVrRCKoRKPpXa20OpxOilWV2spqneygYcb8lyvb/llA26w
         eMs4pjUu8zrruPqPZaZfkgSNPxxsKgapw7e/DNhSA1HHDgFhKTuTx/Fnvt7k+zR+beva
         uRw76rEXR9nF97Chv1JRWEjlaD8tTT89UNwVgAGoCBKkcaUqrayEda7pt9SkkRhObthi
         Qrj4av8EUNUvmLRRISszuo/kZevKVcCd/coTefXoNCE6O44X6m64i0Ny6gLuXx1GwhPd
         xecNlHNNla4IsOGjmXz6g49Zebcd49lBewVwJNx9r44se8pDjvdEWJKM8YuggVHHdLOe
         pdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=4KorOM1AaREsSxzxP2FFmGr/4ZtCzhie0kePdXD0o70=;
        b=qac4f9gtCtAOsEbBgLLLtYDGc7si769kXS4TSNm6a51eey661AknfUF4A82uJHyxa8
         h63rfsmRMzY9J8v8kLPM7L5D8mz+mro98QhldDxVnLsAYQVlCiBJ1wEZ7kNxOOQiXume
         IMl01hXYQOJjrdqrRhM87WEviwxC6zJ4ffD3AP5WXJLz7oMqOv29dz6w+Sg3ZsExEXSF
         IqA44R0lXkd82Ljbp45LsrFKzvlgvC6bOjWfy0efieyZXRHKQ9gWQjG3HvYiwSCh5buO
         cxSrWct87z9Gf5vve72A91Jr7sBnSrhWW+yLGfQygwDdZvzS9UcrJkkibSFuEmWy/U3K
         zt9A==
X-Gm-Message-State: AOAM5326AoAvVVBGumDL22UeuzDYBvzFEvfhzxLmls5o92qLOufsQtx+
        OsqG6c9evD8vnR5C/QinELUo4dj7WnM=
X-Google-Smtp-Source: ABdhPJxxDP7nFUnVNAAzBAZCv/qz9ptQYEXezhkjxK8qnaUm6jBc+6gwIF0erCgXUX/izw29favmsA==
X-Received: by 2002:aa7:8646:: with SMTP id a6mr1704139pfo.54.1598805086092;
        Sun, 30 Aug 2020 09:31:26 -0700 (PDT)
Received: from localhost ([47.89.231.86])
        by smtp.gmail.com with ESMTPSA id p5sm4765637pgm.66.2020.08.30.09.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 09:31:24 -0700 (PDT)
Message-ID: <5f4bd45c.1c69fb81.f3fe2.2df1@mx.google.com>
Date:   Mon, 31 Aug 2020 00:31:21 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to cfea24abcf9a
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="aEeYC2xMFi2r"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--aEeYC2xMFi2r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update mainly contains btrfs new test and fixes.
And you may see the new btrfs/218 test fail with latest v5.9-rc2 kernel.

Thanks,
Eryu

The new head of the master branch is commit:

cfea24abcf9a generic/574: fix sporadic failure with test_dummy_encryption

New commits:

Eric Biggers (1):
      [cfea24abcf9a] generic/574: fix sporadic failure with test_dummy_encryption

Josef Bacik (1):
      [25824c270360] btrfs: add a test for btrfs seed device stats

Nikolay Borisov (3):
      [7b82ef0ff757] btrfs/024: Remove no longer valid test
      [473d0e1740ca] btrfs/205: Ignore output of chattr command
      [b9d1dcd13516] common/config: Allow sections names to contain hyphen


Code Diffstat:

 common/config         |  2 +-
 tests/btrfs/024       |  7 -----
 tests/btrfs/024.out   |  3 ---
 tests/btrfs/205       |  2 +-
 tests/btrfs/218       | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/218.out   | 25 ++++++++++++++++++
 tests/btrfs/group     |  1 +
 tests/generic/574     | 11 +++++---
 tests/generic/574.out |  6 ++---
 9 files changed, 112 insertions(+), 18 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--aEeYC2xMFi2r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl9L1CkACgkQJlKqKVyP
52OGehAAsS/pz4y9xOdf/oeqB01mQI/4kqAKHi8nllAtlPIXuutKdZmmmyjDRzvX
tZPlZF8StujqAZ3sHTDbFY9ewhPGvTUaymUwH1B7O1sNNnPraZD9XsUWhWC4G9gM
jF/74NLzGlaDdtJMxvhCQ3fXPo703L9xBe/Je7wYwYDnm/ChtOSSvdjEUVLUaxPb
cQIVedgp0N3T3qpMVjckNneh/R2ClTXA0ftGYp5t6KIT55Eu2OzW6kAA0LRGIpMc
zZBravEuk/312YcHxgwJZq4b5NEGRSXkMH/YE8jn37COZU1v7wgLPSdXL89b2Axb
BFMxuTa9bWTDmK3MT9cMKt29bzx79WktJa5ddH65qnswPTMrzzYeRCGtrk3mm5By
IFxhCyKwoujdKr+pm4U2MWV1YE1Sxb8acfbiJmqRduvRAH6D76hrgtn92riZwTsD
qpqaHy7GHY9QLBp/DrV3cAj92rJT1xFFGhKRE7cojnNttKwvbYACvh7jZ3ri96Yj
5KlMHx+/Zyu7dMSqwY2VMozLc0wq7HgRaAf1q17yCyPjK2/itabr/tZ9jMTVhR0f
zuljSSW+wbhaafZ3I/6UTDEcSYSTxExlg1k3EBbxE5PugQFFsR9YGs2qRF9ucuRt
FJmjNGdXApPloy9AumizhGg/BBVhEg3hNohAUUAYGjXKqHtHXOY=
=CM5O
-----END PGP SIGNATURE-----

--aEeYC2xMFi2r--
