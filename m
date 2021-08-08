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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4C8C4338F
	for <linux-fstests@archiver.kernel.org>; Sun,  8 Aug 2021 15:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F42261004
	for <linux-fstests@archiver.kernel.org>; Sun,  8 Aug 2021 15:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhHHPjj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 8 Aug 2021 11:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhHHPji (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 8 Aug 2021 11:39:38 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AACEC061760
        for <fstests@vger.kernel.org>; Sun,  8 Aug 2021 08:39:18 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l34-20020a05600c1d22b02902573c214807so12670618wms.2
        for <fstests@vger.kernel.org>; Sun, 08 Aug 2021 08:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=D1b7Y7YeZ0SH20ddztzsqkNTr+L/T88Xj/6iwqFlNCA=;
        b=WDssYiZX9xVVKwNSvvqPJsqjn5QE+tpssd4Km6zNGhXjKnV8ptDF5s2aTrZN9gPAQG
         2rVemMaybZZinIyr0NIITOmYkmV/C8HHIzfaixK/raxZykAnucZvtBJFRSgzT9vSMwLU
         62I7oZFE9OwvcfDk+ZfvaYq3sxt8Vm5iH2Jo2anPYbZdxY/PuCOXIYShrB0DFE4U1KZr
         7kOHarWUPfGCR0Cs4/JUAiBoutFiuYyKdz7+3EVkIpGZ/TUejFmqoollX7ejOpZXpR7H
         swCz0DtdNVDfwY7UjEggz5LF9Jv4RAwTNZE22aUVKrBWgqjf/di6o7C8XCzxQztdxp32
         Ja0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=D1b7Y7YeZ0SH20ddztzsqkNTr+L/T88Xj/6iwqFlNCA=;
        b=ZiqsF01hj2Si1UTZx61MgKS5rT0AR0njp/HyeuEGMAympf6N35qAuqnZ9OT8JlFox9
         FmDWV/DO1jADNRtyYE34Nb89f51Te38SnN9sp7XlfrfMfpmXHSRB5xvHaR0bHkcDLAF3
         syhs1D5+9Ztti22yOtJInH3KXV+bushPEIijAZdO2dokurVV/e/ZbXG8fNGGWAwEyrF/
         VT3QfmUPH1qyV8/NyfmCqeJ1mquJdRD27d1WQg27GHUxAIDAQuaDd7BxK9E43ahvOEXC
         IzMOrfVKbM64jytt9hxUmD3gIw4RSm2uxENmedzrRYr19CQJf/Ktdd6OprIvtYelPa58
         yD0g==
X-Gm-Message-State: AOAM532TGVDBe6yS4woIOW/slfBtcIjkM+wN2oapatEjukIiRKLRWYDJ
        PorkTA26WeJlvYVk8LAJnWYnMq+kHeE=
X-Google-Smtp-Source: ABdhPJw9wEQmGK4GnV1QLCrEAVKj/rY9mXwYynA7kEKYPmtxKzKIiaWid968fs2u6kwKT3uW8CaRpw==
X-Received: by 2002:a7b:c147:: with SMTP id z7mr12487626wmi.10.1628437155993;
        Sun, 08 Aug 2021 08:39:15 -0700 (PDT)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id x15sm16281617wrs.57.2021.08.08.08.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Aug 2021 08:39:15 -0700 (PDT)
Message-ID: <610ffaa3.1c69fb81.bcd0.708c@mx.google.com>
Date:   Sun, 08 Aug 2021 23:39:11 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to ab9b671c5549
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="e5Pxl1hVeWap"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--e5Pxl1hVeWap
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. And thanks to Darrick J. Wong, dmflakey tests now work
with xfs rt/log devices. dmerror support to rt/log devices is still on the way.

There're also two new tests, btrfs/244 and xfs/175, and btrfs/244 currently may
crash your v5.14-rc4 kernel, so it's marked as 'dangerous'. There're also two
bug fixes, one fixes a regression introduced by last update, one fixes
SEEK_DATA/SEEK_HOLE behavior on NFSv4.2.

And there're still remaining review backlogs:

- new xfs tests from Darrick
- Extend idmapped mount testsuite from Christian Brauner

It's really appreciated if anyone could help review above patches!

Thanks,
Eryu

The new head of the master branch is commit:

ab9b671c5549 dmerror: export configuration so that subprograms don't have to reinit

New commits:

Amir Goldstein (1):
      [de1196dcd9b6] overlay/078: Fix cleanup with unpatched kernel

Darrick J. Wong (2):
      [9c1f3149271f] dmflakey: support external log and realtime devices
      [ab9b671c5549] dmerror: export configuration so that subprograms don't have to reinit

Jeffle Xu (1):
      [4b7ea02dc05b] common/rc: only force nfs4.2 non-default SEEK_HOLE behaviour

Qu Wenruo (1):
      [da693469b7a1] btrfs: verify the behavior of deleting non-existing device

Zorro Lang (1):
      [c124d3a3116d] xfs: quota state command should report upg grace times separately


Code Diffstat:

 common/dmerror      |   8 ++--
 common/dmflakey     | 106 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 common/rc           |   8 ++--
 src/dmerror         |  13 +++----
 tests/btrfs/244     |  47 +++++++++++++++++++++++
 tests/btrfs/244.out |   2 +
 tests/overlay/078   |   3 ++
 tests/xfs/175       |  37 ++++++++++++++++++
 tests/xfs/175.out   |  21 +++++++++++
 9 files changed, 227 insertions(+), 18 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--e5Pxl1hVeWap
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmEP+m4ACgkQJlKqKVyP
52N4Sg/1EcKbaSKV4k7REhMGNTP1iQem3A0FzZlLoheAVIqx+N+B96b68oVBAHvZ
aiNJ2hjbIj4iLYOeU2Etx+NQdn1HCc14VWFwIgXELQR9hRdP+70+52CVpr6pbEH2
y1NDk+jKtuTHS8OArTqJCYKGtROHrQ12+/nefwutBpurfS/w7KW42X+Vw2a2tqVj
hrYx6B9bvMTFRRpnG7XMPYf5iD4at9BR3kbNqg+r0/Wpg0u6ORu6O16sCI3uRJ7P
O7j4FM5vkVWnpeL9DBPWuKaO3nARpwLXhyoKU8XVkQBY8nMXZy9+qFQ6SU5XhAdF
S5gUEjNXPC3MW9AXfF5dLB5Dhczen99NQjiEHo+/iHycvtwzkR6705LSDDTBmnCg
2fO6ayAuxdZahjI6Qnqrr59aEAb1VL+fKV6AIK9SVGTuHo+gZwOGUFTNnBvdfwvX
6H4xIUfW9IaL6n8KMpog1DLBwWoxcdv+aI4e5s+9JmR9F3ahKNwWW2TWuOcFgVPg
680eY84ILkOZbhmvkVIs7VbNN45K+I04pt+Pjff39hjJbWJKSzMcPPsQ1VbwdSKl
Jgaej3OPVQJdf4vSNRDpEWTSlnvVwzI8WOWApPSPlSXt6j0mM417s9dpckL1gRWN
7yOxJhMa6sf0wGcJI3XdTgDbz70DbvcbrM4165wF6QC1gGKPIw==
=Cs4V
-----END PGP SIGNATURE-----

--e5Pxl1hVeWap--
