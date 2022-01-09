Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F1CC433F5
	for <linux-fstests@archiver.kernel.org>; Sun,  9 Jan 2022 14:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbiAIOEo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 9 Jan 2022 09:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiAIOEn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 9 Jan 2022 09:04:43 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9251AC06173F
        for <fstests@vger.kernel.org>; Sun,  9 Jan 2022 06:04:43 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id s1so21757458wra.6
        for <fstests@vger.kernel.org>; Sun, 09 Jan 2022 06:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=nkVlqncG9q9xHgNAS9iQQcJbjTsUZq0P2IowS8A9HP4=;
        b=Bl6dhAfsx5FhUn6efUTgQn4HWI7inILstX4p7KEiSq+eJONPbjiz71Ni9bdkvtM+gF
         htZKcywZJFsHGZe6QyuRrPDlTuymR8kcu/RIQJcRkCCMRzgNMzm6zJdfa4FaX/5Rga8v
         hBTyDkmYV3DvoS+X7wb70hZOqfgvko5eZPIfg5MRbEaO1U4QcIRuJI6lGfhUJeT10kVj
         7IpuCooyfyqg//Kx2TKIT2rPqlh0+kfiygr/pBsTcEdSP1JATk9xRXsTgUBFUkbtzWBU
         60Bkp4cVFm19TT2dbg+tzIDTrDAbLbUvtGtQaqF23JZrnJC3HGeKo8rI4xZL5ySUx3Po
         FgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=nkVlqncG9q9xHgNAS9iQQcJbjTsUZq0P2IowS8A9HP4=;
        b=LVppcgjFAarQugTFFxX7ABNMrrj1CjUSfUzhrQCabP+T2hLtA7JmMU+d5zx7omFXxx
         DiOmVNT9fdjGytlNHvvTsgSVTf/q5/JIXxnezjrhkhi8aHldYBEGaWH96+OaySHWZdlP
         yUA5MTWCcgEANt7SCS4rD3kWIzPj+g9P0/ngCICdua2h10QEVAJLX6aN2AaixFxOMZ74
         fPeI3srMtMbPmnl5LMmhPLy/v6L3mmoc5UC1A3g1dpY1aV37IBxrjTOn0vznDJottsma
         j4m6OtOgq9ouijQaSqtrReZb/AbaamSosw6wVlbTSSuaY007Od52UkCOH6/ivjYerVek
         T8qg==
X-Gm-Message-State: AOAM530rXxDs8elAo2nnGU/TZSd8ELYTJKBl0IhP7s/o1o1sBOqumJlO
        NBM4KeMlJRQAgz6DyepLUMqdJn8Qf2U=
X-Google-Smtp-Source: ABdhPJwsb2FhEHa8Wnx1siZkqGKzlocdT8NaVXk2Cl4C0BaMkppa3wcgfVcFBorGSrxLs/S/whzZWg==
X-Received: by 2002:a05:6000:2cc:: with SMTP id o12mr63371727wry.285.1641737081730;
        Sun, 09 Jan 2022 06:04:41 -0800 (PST)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id s22sm4254358wmc.1.2022.01.09.06.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 06:04:40 -0800 (PST)
Message-ID: <61daeb78.1c69fb81.92670.eeb5@mx.google.com>
Date:   Sun, 09 Jan 2022 22:04:37 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to c61c1e2f4cad
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="hQNsnYH4flUl"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--hQNsnYH4flUl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update supports ceph's new mount syntax and
removes xfs/107, which is identified as a long-broken test. And you may want to
remove xfs/107 from your skip list as well, in case the seq number got reused
and skipped wrong test.

Thanks,
Eryu

The new head of the master branch is commit:

c61c1e2f4cad ceph/001-003: skip if test_dummy_encryption is enabled

New commits:

Anand Jain (1):
      [8b9922c8a41a] btrfs/254: fix non-unique fsid issue

Darrick J. Wong (2):
      [4feb867219a7] xfs/107: remove long-broken test
      [c0fd323596c5] xfs/014: try a few times to create speculative preallocations

Jeff Layton (2):
      [424b0975184a] common: handle ceph's new mount syntax
      [c61c1e2f4cad] ceph/001-003: skip if test_dummy_encryption is enabled


Code Diffstat:

 common/btrfs      |    2 +-
 common/config     |    8 +
 common/rc         |   50 +-
 tests/btrfs/254   |    9 +-
 tests/ceph/001    |    1 +
 tests/ceph/002    |    1 +
 tests/ceph/003    |    1 +
 tests/xfs/014     |   45 +-
 tests/xfs/107     |  129 -----
 tests/xfs/107.out | 1550 -----------------------------------------------------
 10 files changed, 82 insertions(+), 1714 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--hQNsnYH4flUl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmHa60EACgkQJlKqKVyP
52M8BhAAmdaWAc/UFwPQyUfMSUUM5ycdaj2cfubfo6hhP3WU2sm5WN3ZoRlKa9Xw
PvxXZEAgW/ecqMiaOuuPP+Runv5+EAyvBLdu1Ty/f4h3kBTSg+h5AwakHhebqbyv
2JSCAavFXXVRd8idkx2PjuW3pXSYKxSQ9bighLY69+Me2VTah1oADdvQsZT+Rn6H
E+dqXIX2/amF7+rE7Ev3aS5V+5eDN8mlfBDoJf/VF2yB2JDc83GAAJqi/AqXNZQu
1QncGfW05oiSeKOyqDcGUPMnRiju7pzWiu1xQIWsp01459HSmBIiOlp6kjDSxXcR
vH80HtA1iqT0mgc9dngu+Ra8ApNxCfJOAXc3BaRJp2thQ7yoaYODMznN+n+1B0ED
efjqk7FHM27sFwZR4mLla0mIT9vSNGfOH/kVnC5RVYM9zWdgpyBoyNruoNhArbKx
W0hBC0JfF42D60MPJ4qTWNXmhtMms6ovgtvVq3EuG0S+bYc+TaDiOerbkvGgtUrO
lZ39DcKDFZI0Madugy0jImJ/nw35jRnoQrZW+Zt6vNzh4OzeUjUMbytGRdn6DnM2
XVbkHtsGMAOmM3SHfefHjfC8ouL5hG64YTMqRfTbeAppiyDVfc62XYP3ZGHixdbs
dPBOfipPgg60JLOF7SX9Ja+oYMxe001pPiPYRe0m/wICax2FbmE=
=oEXp
-----END PGP SIGNATURE-----

--hQNsnYH4flUl--
