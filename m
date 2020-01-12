Return-Path: <SRS0=AeqX=3B=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53791C33CA2
	for <linux-fstests@archiver.kernel.org>; Sun, 12 Jan 2020 16:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D89821744
	for <linux-fstests@archiver.kernel.org>; Sun, 12 Jan 2020 16:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkqiYbY5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbgALQyx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 12 Jan 2020 11:54:53 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37197 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730145AbgALQyx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 12 Jan 2020 11:54:53 -0500
Received: by mail-pf1-f193.google.com with SMTP id p14so3694427pfn.4
        for <fstests@vger.kernel.org>; Sun, 12 Jan 2020 08:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=Amx7LXMUyQmZsUGH6rI2n9KGEya232S0aFCrN17YzNw=;
        b=UkqiYbY5n3+7IClbSFpuWi46RuhPlCrZW8CTsDJxG8Y+KppGKvJVTqu8lqJzoxF25m
         d/CbFouHYTed2lCYMBjJIuAgum/JWWODtqpJBypw1WHGUTXGDyQZF5IQl8C1eHKaxfI1
         6dRJkFlEDo+9PbaoV0XYkAhjIp0ICJihEMCI0Eic/sfKR6yAjRNiG3GJC6Gfut7oOr3S
         rcadIC65yP/FRmE0+Pwu682ilxAPBioAiZz9xSe374H9viFSWLN4CS0KDCTfDAI5ouBe
         GcYGbxNunP8X1v3L/iIQgEIXaNu3GdssxoUVdHyaP4sNY/DhoNWLiQRC0BbiNmitSZg8
         uSQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=Amx7LXMUyQmZsUGH6rI2n9KGEya232S0aFCrN17YzNw=;
        b=qTDjNff2r6borWRAIMsB7zLfl8kFx1mNrVW2ZDJpMZo9FJPgxYScuNnHCXZvXTC1Bg
         ExaL9VseeAkda2lTLPJNOjsMq9d3YrQsXpqL/dUiMb5nnzhyE38BBUNj3eBM2CmNdZq3
         Uzd/Lx/6af4iKC1cxIbEYryNRFYT+121AkV+H34rARNjsFdYUwpplPUJV8J4i5LhTrdY
         f5JVp2gvSXm269IysIMVulEt7EAQEtfH7ItHThR4CUqW4BjcCebEFy7kJZUmn772lTkt
         hAYfOGq/xkdYyJBp8h1KiqlfRd2dIBR82usPl8g9a/RBiWRRXrvfOTW44iSRs6qDA8gF
         38FA==
X-Gm-Message-State: APjAAAUe/M3TULL4rWojP+9T//T+eu9fmCrCa8X1wAnN8VQBp1zRLVyl
        L5JIl12GBOQlC6awVupiEUX/NAkp
X-Google-Smtp-Source: APXvYqwhBSdf9+piW4LoWhbsXMNVl5srB0l9YG1JxifYzQJJqjWl9sVkuH4HRI0URTNHXzZBFsKzZg==
X-Received: by 2002:a63:190c:: with SMTP id z12mr15442088pgl.1.1578848092840;
        Sun, 12 Jan 2020 08:54:52 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id l14sm6076645pjq.5.2020.01.12.08.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 08:54:51 -0800 (PST)
Message-ID: <5e1b4f5b.1c69fb81.7dd3f.d564@mx.google.com>
Date:   Mon, 13 Jan 2020 00:54:47 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 12973fc04fd1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8McbUFkpn6tF"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--8McbUFkpn6tF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update contains one new test for overlayfs, also
removes btrfs/172. The other two commits are bug fixes.

There're still some pending patches to review, but I think I'm getting closer
to the end of to-review list :)

Thanks,
Eryu

The new head of the master branch is commit:

12973fc04fd1 btrfs/022: Correct seq number in golden output

New commits:

Amir Goldstein (1):
      [0f7340ad478d] overlay: Test unique st_dev;st_ino on non-samefs setup

Nikolay Borisov (1):
      [12973fc04fd1] btrfs/022: Correct seq number in golden output

Qu Wenruo (1):
      [538d8a4bcc78] btrfs/172: Remove the dead test which we have no plan to fix

Yang Xu (1):
      [dec3ec2dff1e] ltp/fsstress: Add header file stdbool.h


Code Diffstat:

 ltp/fsstress.c        |  1 +
 tests/btrfs/172       | 73 ---------------------------------------
 tests/btrfs/172.out   |  2 --
 tests/btrfs/202.out   |  2 +-
 tests/btrfs/group     |  1 -
 tests/overlay/067     | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/067.out |  2 ++
 tests/overlay/group   |  1 +
 8 files changed, 99 insertions(+), 77 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--8McbUFkpn6tF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl4bTtoACgkQJlKqKVyP
52P7BA//Tm+nI9qEOQbQ0+HaYBx1jbX2RrxIFfWlgvu1ZNNuIwMZ53wBqUp/+zTu
Rse4bG8VQJ7iuVijDSSvGskTxOu8YsBJueHlx7SpggyR98DmkMqRJbniMugEs2vc
uvyVgIHiuusQNbTMu5gYOSWB27iJL2poqb3Ck36YhjIuxad3okD1tbHI7Vw1pE5M
Teaeqz5Xsuu3xddnVNDzX/iWUU+3YWoBChnlOuwoQjEMw8MuBdjy0zSZflshsNsP
EOBuiyAL0kJK6a9Hv6Ja+kY4j5Y1EslRTMnASlT79eYARv6UJrdX39XwuypZHih2
zTis5K3Nqp4U/wh8PYcYK15nRU9xSe5pLOTQGZIxcpCfXBlHK8zw3nbeUZ+7o1rS
AxsQd/gHFRKM9X8XN6Y/QYVnDdgKTvqZreR3BCLyAJ0/2f0AvvJQMQBU+CVb/orI
iSJz7fWGW4dRtt8zLijoGdT4saVPD/KcDpiK7gmdnIGp9RswZmh9SOtD8N32SBSF
Q8P+76tTTNVx8glOheRzEVC8Mw5epgLA0R/VTwYl14pz2/V1zlIeVeE2t6ou8wKl
nqbOyuAviMAS2do3vI0J5IM3LXJap9gePLg8ANTl1m6p6bb50lR/ATZAmYzFY2Ab
aInsLCH58JCI89U1DJcJj3EdI/C+tO/GPN/UANGkpAYstkcUY/A=
=C13D
-----END PGP SIGNATURE-----

--8McbUFkpn6tF--
