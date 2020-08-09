Return-Path: <SRS0=ooC1=BT=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F574C433E0
	for <linux-fstests@archiver.kernel.org>; Sun,  9 Aug 2020 17:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBC9A206CD
	for <linux-fstests@archiver.kernel.org>; Sun,  9 Aug 2020 17:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4RjpQNU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgHIRWG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 9 Aug 2020 13:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgHIRWG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 9 Aug 2020 13:22:06 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26368C061756
        for <fstests@vger.kernel.org>; Sun,  9 Aug 2020 10:22:06 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t11so3609577plr.5
        for <fstests@vger.kernel.org>; Sun, 09 Aug 2020 10:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=WWy8Z0Svk+ewRuLYxhpLfqW2ewcvL1eBJZpG/XMfBnM=;
        b=K4RjpQNUwqlYyaic6Wzcs93n2zG8rhHBnKsUnuCxXRBnL9SN8KaN8CkVL5x7zbvNWZ
         VS2lqUgF4AuSXHtupMVMnk5t6SXJC/lutGPssg/3XDWTAbZdyxv9x/ShOmfkJFLDA6HJ
         WCQfOS1eRNrYYX20EQscOAE4apH3539GCxfHoN8rmNGbJCgrvQ4uLdNIhv76MmWlLz4v
         iFLOmp1+eydmUg42UhvalJc2qBBt+ie9RglmgdVpA9WMr2wDaaiREt+RCOdSEBqYThed
         KZUUNkeeux+XZn3xM0E9fuTxf+7SfSNxsuz31SnSH51pbV6dd9wOmmBhw12JpHLA07fT
         s4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=WWy8Z0Svk+ewRuLYxhpLfqW2ewcvL1eBJZpG/XMfBnM=;
        b=qInXGGl1FEVIBxhqcsUAOKRke2/QztyfJqO8qaqukal2UKCbaOq8dOtIxXqBZXPeS2
         IRR+gXADxdKPE94NvBgruk36xrBF9p7Y5RvJrwHQus4QoVk0lNOELBfKhlFINJI1+nnJ
         gY0jIkqi3NtryvU7aUQmLUle3bpgvX+kXotO9jjJbGucJALINWSURU361Mx6PmT7d/rZ
         qtqeyCBmWA4XmzoqosJCO7R5u3rEbv8eF4Nh9Zj5x6F9DPaAUBJPVlCqq0yJFq4EsPiv
         xrcrnD3xi8GznMe5jKYq3VS6uyCMmBTodcDn+I+k2QIvVUjtQtZS9+95wRt2/zW+uS0w
         LbeQ==
X-Gm-Message-State: AOAM531bqyTrs6XkIxNWp1s96m7yO5rO05sYJ97jVjX53IvQkVz3Pgaz
        My2LcSsYqCTndL9HeklcqUUo1+kF
X-Google-Smtp-Source: ABdhPJw0hdRyqtoIG+pnx4CtrF9t5AMyA8LzLG6LI1FAWRi3QdjCbFBgOiiBP7awgd5JQPwYq6RoLQ==
X-Received: by 2002:a17:90a:4fa3:: with SMTP id q32mr23240699pjh.142.1596993725127;
        Sun, 09 Aug 2020 10:22:05 -0700 (PDT)
Received: from localhost ([47.89.231.86])
        by smtp.gmail.com with ESMTPSA id y79sm13775940pfb.65.2020.08.09.10.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 10:22:04 -0700 (PDT)
Message-ID: <5f3030bc.1c69fb81.7519b.378d@mx.google.com>
Date:   Mon, 10 Aug 2020 01:21:56 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 59d1f998fd61
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7isG5lojxm6M"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--7isG5lojxm6M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. The most notable change is the DAX patchset from Xiao
Yang, which update & add new tests to test the new DAX mount behavior. Many
thanks to Xiao Yang for the patchset, and to Ira Weiny and Darrick J. Wong for
reviewing the patches!

There're also some xfs quota related fixes to work with the new kernel &
xfsprogs behaviors on XFS.

And the new btrfs and ext4 tests currently fail on latest v5.8 kernel.

Thanks,
Eryu

The new head of the master branch is commit:

59d1f998fd61 generic: Verify how to change the S_DAX flag on an existing file

New commits:

Bill O'Donnell (2):
      [7cee3f17280c] xfs/518: modify timer/state commands to remove new g,p timer output
      [569789e54eb0] xfs/263: filters to accommodate new xfs_quota state command and prevent regression

Darrick J. Wong (4):
      [fc80a4954604] generic/603: don't run on XFS v4 filesystems
      [2b3de458c433] xfs/030: repair should actually find the zeroed block pointer in the agfl
      [9515832478a1] xfs/{263,106}: erase max warnings printout
      [e5bbd47e7c17] xfs/{050,299}: clear quota warnings in between checks

Jeff Layton (2):
      [760616041b67] generic/377: filter out xattrs that don't start with 'user.'
      [85c3ee84f07b] generic/062: use more restrictive filter when querying for attributes

Lukas Czerner (1):
      [3c9b1fe59ebd] ext4: Test read-only external journal device

Qu Wenruo (1):
      [912521c9fa1a] btrfs: Add test to check if shrink works well with fstrim

Xiao Yang (9):
      [f4a1c15b58de] generic/452: Fix the wrong commit id
      [c1a28a6e3a94] common/rc: Introduce helpers for new dax mount options and FS_XFLAG_DAX
      [49ba983a76a6] fstests: Use _require_scratch_dax_mountopt() and _require_dax_iflag()
      [2aaaef91f305] generic/223: Don't clear MKFS_OPTION before calling _scratch_mkfs_geom()
      [ab0680e58176] generic/413, xfs/260: Improve format operation for PMD fault testing
      [f85344a72f74] xfs/260: Move and update xfs/260
      [efb26477fd3c] generic: Verify if statx() can qurey S_DAX flag on regular file correctly
      [76cfca6472ad] generic: Verify the inheritance behavior of FS_XFLAG_DAX flag in various combinations
      [59d1f998fd61] generic: Verify how to change the S_DAX flag on an existing file


Code Diffstat:

 common/rc                      | 105 ++++++++++++++++++++---
 tests/btrfs/217                |  62 ++++++++++++++
 tests/btrfs/217.out            |   2 +
 tests/btrfs/group              |   1 +
 tests/ext4/002                 | 139 ++++++++++++++++++++++++++++++
 tests/ext4/002.out             |  32 +++++++
 tests/ext4/030                 |   2 +-
 tests/ext4/031                 |   4 +-
 tests/ext4/group               |   1 +
 tests/generic/062              |  10 ++-
 tests/generic/223              |   1 -
 tests/generic/377              |   4 +-
 tests/generic/413              |  12 +--
 tests/generic/452              |   2 +-
 tests/generic/462              |   2 +-
 tests/generic/603              |   4 +
 tests/{xfs/260 => generic/605} |  79 +++++++++--------
 tests/generic/605.out          |   2 +
 tests/generic/606              |  92 ++++++++++++++++++++
 tests/generic/606.out          |   2 +
 tests/generic/607              | 189 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/607.out          |   2 +
 tests/generic/608              | 121 ++++++++++++++++++++++++++
 tests/generic/608.out          |   2 +
 tests/generic/group            |   4 +
 tests/xfs/030.out              |   1 +
 tests/xfs/050                  |  23 +++--
 tests/xfs/106                  |   3 +-
 tests/xfs/260.out              |   2 -
 tests/xfs/263                  |  21 ++++-
 tests/xfs/299                  |  23 +++--
 tests/xfs/518                  |   8 +-
 tests/xfs/group                |   1 -
 33 files changed, 867 insertions(+), 91 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--7isG5lojxm6M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl8wMD4ACgkQJlKqKVyP
52MqmhAAgDtBQ23TkXQtdTX+TBKdfjMrn65EUL/3SaunxRhFNV+DxcDt5IhMN7Vx
uPQtEAwQPRoJqcITH1I9DGDF3flXkzvJPLgUxIr58NnAKhNun+94UXDigMUeccRZ
E/ZAixbe4uy1OGF+dxWd8MB6CBsXMbIlQvIYNRjBblaHktTUaaXKjdBLpqeYydKK
iUKuFQkquEdU/1wANyEE/IVi4Dm0MeAfCkVbl4wSYUS5HqsEyUM12rEaHWz8oW6B
h7e6ne0XUyObk45Ky9Z0s1s/26Sr1zSS/6nt/GrCcmx+LFe0XQvY2NL+8s2JHFey
PSaxl80jYNASvzAt5CcGpa3pyIxsuB32iLJwmhwUgcFe1mEJ5XzpROYThgqLCd4M
aeZCQFUmAt5ajx3IshB4TeJpp+Y8KpJPh77r2fL4HtFHQFmRqIoSQHSxPQWfErTJ
pAGO7UDVEv34ACt32MZ2IsHfoL9LxQrp92mJpJCkxxRLZlN45wL2yI2xsP4H5USX
ZHaOY/NQkzObK4IbA2nPwfDVb+EL129bdbRftale4suvqSl9qenTGUjXskLalmhT
LE/rVh/zWb13EDSW6t3FTVFY5Bb4AkmrIaflyA9ngi2PpDRJFetf8YYs69foBZsF
CWWmPSpIcMCH67vYuIHxpUivvNY442KhPMRcX2Z/TxtrgcNE9oE=
=DfVF
-----END PGP SIGNATURE-----

--7isG5lojxm6M--
