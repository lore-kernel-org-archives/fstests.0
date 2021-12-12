Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E5BC433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 12 Dec 2021 15:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhLLPaD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 12 Dec 2021 10:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhLLPaC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 12 Dec 2021 10:30:02 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCCEC061714
        for <fstests@vger.kernel.org>; Sun, 12 Dec 2021 07:30:02 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m25-20020a7bcb99000000b0033aa12cdd33so9670858wmi.1
        for <fstests@vger.kernel.org>; Sun, 12 Dec 2021 07:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=QwfkY4dIsQzkh2Oa7za3cTW6+xNi5yufdSqIum0/ZJQ=;
        b=BFh9uOHHtIzJ2rtHqUL4LkrgIsIDP29VZ5h23wRrx2rW34nnsRYTBU0n3B3SzCmr83
         nJrG6wpuizs6SeubRYaV/z3lpe/524iEl4OskmnHfcoRyZsdhT6TaXtDgVeX/qll2WBC
         kpwwqXioRHyv0SRG7kivptsB1nCpAuHkV6mlx7nIYlm1ERqhWwAFHkTGEHc31t0R1yWn
         p6MsyH8AvhuMLWSoXMwuh5Xo6f4MP6Jm0s+gRM8RoKbeq3+/ujh9Fhm8gfaZihh7hsdm
         iKBlkyOvXuBhfAC+4Ue6jrlbJlxnuq1l00kcTjqLpHlmGmO19/2Kz5S0NTNuBodHVucZ
         4JEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=QwfkY4dIsQzkh2Oa7za3cTW6+xNi5yufdSqIum0/ZJQ=;
        b=1ah9p/afo4gEYUT3oqRd0xIxl8IQQhB8YRt3z0DhPuj4XGiWBny/FJjETyos06Ah+G
         SRwbhBK04Pt5q9m8eaCryYYurSQeXqO0J9qcGXUKL7HjCzkOm+lDN72H2urqzP/VUHEp
         i2OlR+WkFSo/+o1J4DChaKUTnaaoB4zZvWtOQZROfFPmW1krhMXCShVhEK+3UGFDvTaV
         vwf/rkaDMz5dP1e5mtArWfyJe6y7weyN4FYxw/DGS0qgIL4mIs6UQAnQInUlblr9il/t
         4ca68yGaDNfsMeb3uMnO8mdtgE0TReWPxjlNQl7b5wpXpgi4/Yfd1XzHIeXqL6YbtGdm
         1FPg==
X-Gm-Message-State: AOAM5316AOL9trowS2h1AaDfzgRRAJvo8vHAhaPVYYpoBmU+siVZe2pG
        WimyIoW61xxI8OtH+fzhqIa82F+kqjg=
X-Google-Smtp-Source: ABdhPJwsrC4x8N3dH5c797IBlaKbE+iljIELI+kaurXF8t5vUsCyUp8SaxBKFkINIbh6kZRcEdiIzA==
X-Received: by 2002:a05:600c:3846:: with SMTP id s6mr30722154wmr.37.1639323000638;
        Sun, 12 Dec 2021 07:30:00 -0800 (PST)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id s8sm8976047wra.9.2021.12.12.07.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 07:30:00 -0800 (PST)
Message-ID: <61b61578.1c69fb81.f9dbf.e836@mx.google.com>
Date:   Sun, 12 Dec 2021 23:29:56 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 13dd19cee429
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="fZ6DjAd62p72"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--fZ6DjAd62p72
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. fsstress has been updated, thanks to Darrick J. Wong,
now OPs are easier to maintain, and adding new OPs are unlikely to break ops
array. Also there're two minor bug fixes.

Patches often get missed, please resend or ping the pending patches if they got
zero comments in two weeks without being merged.

Thanks,
Eryu

The new head of the master branch is commit:

13dd19cee429 generic/335: explicitly fsync file foo when running on btrfs

New commits:

Darrick J. Wong (1):
      [160a3b4b4477] fsstress: consistently index the ops array by OP_ type

Filipe Manana (1):
      [13dd19cee429] generic/335: explicitly fsync file foo when running on btrfs

Luis Chamberlain (1):
      [ee78726548e0] common/module: fix patient module remover when module is not present


Code Diffstat:

 common/module     |   2 +
 ltp/fsstress.c    | 140 +++++++++++++++++++++++++-----------------------------
 tests/generic/335 |   9 ++++
 3 files changed, 77 insertions(+), 74 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--fZ6DjAd62p72
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmG2FP8ACgkQJlKqKVyP
52O4GBAAu2pV/zli9/NJ7vpzST+uD84WMgReCFue9OeE7E52isIjdsYvcJCAXfxm
fvfDf3uX7HN5RdOrtGc1/X1KGa1mBhGoSF3uuz4uQw+DBeLyTQu14o1MWqfW298n
6da8hr5hjpnVO3kHdAqN/DkyBv8hLlsYZIIsJ1G1+SGgIxzdISMMO49bBeOvOQdm
kRhiRKEoYaB7N4IrBYqPeWel5wh3PWq2cbX/sEjN+pSUGi4GN6FHBwiuFDyibXvw
LZBQb1hfX6+nOduWf32BzJYRpEYBUCUsKUWavaUspkn9uBkSM3wZb4I4BidgtM7W
/f/IGGNdI7X6cecTJ/ijAIl9tAfv6R1+X9i0b2Wli+RV6HZGFnk+W9xUB6uwKwl+
hh+h8qgiDBF3rcq3/bxYfnyRg0P0YfdIRJkf/NkTJaepte13QVCq8uJurt+TKUvW
7KBssnNy5lUSSghAV9w4J35/NP4VYTieMwNmuKOSL/HMffR0NZkaMk7N+7Hg1iHJ
SI8Ob7PaDeVbWW7ungksKpfd8j01D5+9HqtQrz9eDk4BjlgROpZ6DEYrt43ciiYs
zdzE9xIIZPxHqYp3XUKKgc8wawth2Q6OW/7h1LbV7aoTXzBW/B1WLysDJ5IQJRJ8
+bz2KYzjf6XOG+o/3GfFOsBVR3xPjlsqE6JCJO1QTOKj/u6SmaY=
=i7Br
-----END PGP SIGNATURE-----

--fZ6DjAd62p72--
