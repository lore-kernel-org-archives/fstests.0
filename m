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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0024C636C8
	for <linux-fstests@archiver.kernel.org>; Sun, 18 Jul 2021 15:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D5B860C41
	for <linux-fstests@archiver.kernel.org>; Sun, 18 Jul 2021 15:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbhGRP2T (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 18 Jul 2021 11:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbhGRP2T (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 18 Jul 2021 11:28:19 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C818C061762
        for <fstests@vger.kernel.org>; Sun, 18 Jul 2021 08:25:20 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id m11-20020a05600c3b0bb0290228f19cb433so11235517wms.0
        for <fstests@vger.kernel.org>; Sun, 18 Jul 2021 08:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=4YCOX3rUI+ThFlewz/Af+orJMyoe8UOkjEXI+1uEjoU=;
        b=eMphQLRhu/1CJBVUvmdjqzjNIzwn307YnASWdyrBvVjeAsk8TN58YegyCkFBkr8NU/
         BJzi2o5DjXYHSpn2JYL03fvyX7eY46oGG7c6XpDyftshB4TrdttAJUa/TSptx+/N4tTX
         FlpJV17pnzcCacsMhPMWBVuT549j7mKEb7ATRwt/xn/l7OmpjQEO9K8jV2ZGzQ560H/u
         fLmgLTah0fqSrp/oOwop1b0l28dEeZBju8vt4wo/+4hWIL3fKN4XsZvBM2tXNqtEkxIb
         Lbh6SogJNOj4seyoB9zAWPnqaQ8yLOhZQphfrXOa68mdYAUSa/F15itxsmS4nWqRE1+l
         qWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=4YCOX3rUI+ThFlewz/Af+orJMyoe8UOkjEXI+1uEjoU=;
        b=DdWVwrbqH1sO40UcugLwmLy53UcvFzDHtyx7BsAxImrbUmhc/g51yERLOIDW4uQSFl
         RHLyvdUHzicPC8/+0ii6f6/h/yN+hiKnC2jA80/NzFrjmMDdl88upR4YNa0dEHxPfnTG
         dmI6QBuJjmQnO7eKuC3xMqPHTAQ3QZZyqrHB4yry6IX79FJmjhHl2u0eDLm1HLf7y/VE
         KRkfZ82x/CT5wi8Q0JrUsCTaoDlfhDrs+6ziTyr3ikIEppDZ+eWk7XdPI+rlWpBgSgSB
         pcyRqfcSjEIJsI7FeSZMhh0F02B7nk4Co80Gnmj1OzG2VzuLJI37AOg7kP8dQqe4zZfO
         Z8Zg==
X-Gm-Message-State: AOAM5309wURrUKHi4zslGrO9X7u+S8+DBRGi8Hwi+9ojdC8MkNm/XAw6
        tpZSwvl6NZaJTj87H259IXj1Wh9tTxY=
X-Google-Smtp-Source: ABdhPJxdyZht+fORTA6QLh+qfZFDSi/HX+Z7D9VYXwAFQ5e4r3JqDIBf3MY8kuVsjT/xwFOJbCxTRw==
X-Received: by 2002:a05:600c:414b:: with SMTP id h11mr28048036wmm.95.1626621917648;
        Sun, 18 Jul 2021 08:25:17 -0700 (PDT)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id t9sm16458439wrq.92.2021.07.18.08.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 08:25:16 -0700 (PDT)
Message-ID: <60f447dc.1c69fb81.4d473.788f@mx.google.com>
Date:   Sun, 18 Jul 2021 23:25:12 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 10f6b23121ea
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kKNv3qvXdBSr"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--kKNv3qvXdBSr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. There're two new btrfs tests, and btrfs/243 currently
fails with v5.13 kernel (I haven't tried v5.14-rc1 as I couldn't boot my vm due
to NULL pointer dereference, but the proposed fix hasn't landed upstream, so it
should fail there as well).

Others are random bug fixes as usual, most of them are contributed by
Darrick J. Wong and reviewed by Allison Henderson, thank you both!

Thanks,
Eryu

The new head of the master branch is commit:

10f6b23121ea generic/019: don't dump cores when fio/fsstress hit io errors

New commits:

Anand Jain (1):
      [2226eece67ba] btrfs: test case to fstrim on a degraded filesystem

Darrick J. Wong (7):
      [0de642617f18] xfs/172: disable test when file writes don't use delayed allocation
      [75c9b616fc84] shared/298: fix random deletion when filenames contain spaces
      [ffaba0eb3fc1] dmthin: erase the metadata device properly before starting
      [473cf6fb2e5e] check: run _check_filesystems in an OOM-happy subshell
      [d72d1ba33055] xfs/084: fix test program status collection and processing
      [272940ff28e9] generic/371: disable speculative preallocation regressions on XFS
      [10f6b23121ea] generic/019: don't dump cores when fio/fsstress hit io errors

Dave Chinner (1):
      [391b0b0908da] generic/459: catch mount failure

Filipe Manana (1):
      [8ae8a045b54d] btrfs: test fsync after increasing file size with truncate

Matthew Wilcox (1):
      [6aa7a5c71497] src/seek_sanity_test: test seeks from LLONG_MIN

Naohiro Aota (1):
      [99baa0ade4e1] fstests: install btrfs_crc32c_forged_name.py

Pavel Reichl (1):
      [6fc0bd027a74] generic/{453,454}: Don't run for FSs restricting names

Theodore Ts'o (1):
      [3ff9e88c096a] ext4/048: skip test of filename wipe if journal checkpoint is not supported


Code Diffstat:

 check                  | 24 +++++++++----
 common/dmthin          |  8 +++--
 common/rc              | 13 +++++++
 src/Makefile           |  5 ++-
 src/seek_sanity_test.c |  4 +++
 tests/btrfs/242        | 49 ++++++++++++++++++++++++++
 tests/btrfs/242.out    |  7 ++++
 tests/btrfs/243        | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/243.out    | 15 ++++++++
 tests/ext4/048         |  8 +++++
 tests/generic/019      |  3 ++
 tests/generic/371      |  8 +++++
 tests/generic/453      |  1 +
 tests/generic/454      |  1 +
 tests/generic/459      |  4 ++-
 tests/shared/298       |  2 +-
 tests/xfs/084          |  8 +++--
 tests/xfs/172          | 30 +++++++++++++++-
 18 files changed, 268 insertions(+), 15 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--kKNv3qvXdBSr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmD0R20ACgkQJlKqKVyP
52OFoBAArDJfAI6Ai4iD+M5+q5DIwTtl6O/P7FgiuyqK+Iod4MdpFv8dDzhoX0T4
LO3yf/r0wmjcrYy4LqqYR3HL/KJeQrcQcid4mQ3Bed75JFMFcEQm96RUSehjRn9Q
G8DbCJMiLpkS/V5Mh796nCD+8CScCQXH4P6BnKFFEaRCftDBbPCrnfU2cHBdqrzS
5LKYyNiwp9khkLS+ZEjCCJKnCLN8AzchUrXUG4EPFWWDaZSdh/6sWdKV6c1Qaec7
7ei31/dbnOIH4I1GtGX/U92yKLw4DBAl5GvzWgDJEbBD/7qHllFCTpKeaIQSUiwa
bDrFCWMd7aeUX7rTo2w23/qkhEkVvuYd7lW1yx2Qgo7ctnVqnAlYIjTtZOAJScrC
fUTtf03rqRabKapKoZld3awdKVd5evgTsnmtXkh4zPhMRNEiFXuIFBoWHx4NDd4D
YsK61BsJe1dEowiYw4JEVXENViDa8vSy6s32mQWi2dtJ03+C4LCTWHObizBCtYhA
Pb1ogdwi2rhsfXDXWGygZydpNBphMTyHCKPm4C67GwL+l8IXu+S8CF7uvfsnzko2
LFjhBf1Pb8AlhQYMmHQJ4o4V9F9aq0Ky4FlbVLwwXJEoi8DKRkqLixZs7YDMRvqE
gToPiaLO7dSQku24YJmrW5NCmdnXHMF5kLlO4MawN1sQStYznUk=
=HCKb
-----END PGP SIGNATURE-----

--kKNv3qvXdBSr--
