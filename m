Return-Path: <SRS0=cgbt=IF=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F12C433DB
	for <linux-fstests@archiver.kernel.org>; Sun,  7 Mar 2021 18:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E839650AD
	for <linux-fstests@archiver.kernel.org>; Sun,  7 Mar 2021 18:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhCGSKx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 7 Mar 2021 13:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbhCGSK1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 7 Mar 2021 13:10:27 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C744DC06174A
        for <fstests@vger.kernel.org>; Sun,  7 Mar 2021 10:10:27 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id e6so4932139pgk.5
        for <fstests@vger.kernel.org>; Sun, 07 Mar 2021 10:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=69XRljIBkxePFfZ72T/j9nnJfrG5wUuA33ZPKMxeCDA=;
        b=mh1sHTWR8pXXGRhzUxUrmX17Q3lM7dNhmwr19kLuyEgABfKIFwtkA8f1SR8Bn3K4m5
         yGeWgR/hSoZGS0wNHrFZU1gNMf92itK54wn54KRF/k8on+o+XquN+NK2Ek8hKyglyahr
         88DMehaNgdmH6tsZwvkjpDNujX7xeYs6qG+JR+wMANwexo8SxD+Xi1JP0Wfq2K/4HPXm
         FYBdH+a8ODEntEw5CdtteISJw1NB/pLmUZj/h6EdyTAOo8+IP0oQDX3e6qGzLanBQNfV
         qUXiwCb2GEhvYK3xjCdhnmpDQDM/U2JFOgrR3vbZuZ8onhvwWWdfFTNM+OMzH/hMqL6C
         oE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=69XRljIBkxePFfZ72T/j9nnJfrG5wUuA33ZPKMxeCDA=;
        b=eagjclGKLTTn26tY1CkfuL83NAMQdtlIoEsMnDPMFHNa0HX2gDVbyRm82tr+wnGzxi
         iu4BPH2vlcK1X4kPI3ScpHgzp4j0UK+QEYyQAShrlKXwlq3xNDHgb9MGe/w5uFEJ1wf4
         uHWtxd0wQ4M/JT2CD0WpS5K+TbIEiTI0BukZ/5PuIZOrKnK3X7JZWgSvWlKtzGyv2agi
         BIeZnkiNa3995JFg6Xw4uba9sXP0b3t5lumIVjw9+kZ7K9VvZNOvL1cEvVd4gytlX72j
         SZzheUOENrPGC8r7k9aHlXQYJ0C+Q2jKLmPGVqHc6nTyE8Vo5CwRpyTKkv+W6vnHvUWY
         74kQ==
X-Gm-Message-State: AOAM531o/2AI0EP2VRYGeAtuVjNZb84TTleZGWdcryLzGMzbQNL4qyAx
        zPbXVRzNKBQPUEEbR8rdII+rr5P0eJNHHw==
X-Google-Smtp-Source: ABdhPJxoHDQToSwoKnXCswuaBGMHGQsCzU6a6gQ07v5wR9ZaQE1s66mTidSVG8oRPMyjRUSv0POx6w==
X-Received: by 2002:a65:5c44:: with SMTP id v4mr16871530pgr.362.1615140626942;
        Sun, 07 Mar 2021 10:10:26 -0800 (PST)
Received: from localhost ([47.89.231.86])
        by smtp.gmail.com with ESMTPSA id k15sm1658322pgt.23.2021.03.07.10.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 10:10:25 -0800 (PST)
Message-ID: <60451711.1c69fb81.2fa21.3b38@mx.google.com>
Date:   Mon, 08 Mar 2021 02:10:23 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 52a3700b26e1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6tZ5jPou8HlJ"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--6tZ5jPou8HlJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. We've added a few new options to 'check' in this update,
as the following:

  -e:		 exclude a specific list of tests
  --exact-order: run tests in the exact order specified
  -I		 iterate test <n> times, and stops in case of any failure

Also there're many bug fixes and 4 new tests, but all new tests should pass
with latest v5.12-rc2 kernel.

I should have went through all pending tests in the list, if your tests aren't
included in this update nor got any review comments, please resend.

Thanks,
Eryu

The new head of the master branch is commit:

52a3700b26e1 btrfs: Add simple stress test when qgroup limits are reached

New commits:

Darrick J. Wong (9):
      [2d4fb6bb3078] config: wrap xfs_metadump as $XFS_METADUMP_PROG like the other tools
      [5baeea6fe8c2] check: allow '-e testid' to exclude a single test
      [3d79e8ea2424] check: don't abort on non-existent excluded groups
      [49c09b5bad5e] check: run tests in exactly the order specified
      [656e1b10820d] fuzzy: capture core dumps from repair utilities
      [71636cfbaf35] generic/623: don't fail on core dumps
      [5c076a5adbd1] xfs/271: fix test failure on non-reflink filesystems
      [e05491b34134] common/rc: fix detection of device-mapper/persistent memory incompatibility
      [976ca65307d2] generic/60[78]: ensure the initial DAX file flag state before test

Eric Biggers (4):
      [c363e7a1fca5] generic: factor out helpers for fs-verity built-in signatures
      [45495efc3829] generic: add helpers for dumping fs-verity metadata
      [c4ef001021ee] generic: test retrieving verity Merkle tree and descriptor
      [456734557033] generic: test retrieving verity signature

Filipe Manana (1):
      [bdad282d47da] btrfs: clone a hole post eof when using NO_HOLES feature

Nikolay Borisov (1):
      [52a3700b26e1] btrfs: Add simple stress test when qgroup limits are reached

Qu Wenruo (1):
      [46f896c0a55d] btrfs: make sure we rescan all devices after unregistering

Ritesh Harjani (1):
      [9b298bdf540f] check: add CLI option to repeat and stop tests in case of failure

Zorro Lang (1):
      [8fe4fdf8ca22] fstests: remove _require_no_rtinherit completely


Code Diffstat:

 check                 | 52 ++++++++++++++++++++++++------
 common/btrfs          |  8 +++++
 common/config         |  1 +
 common/fuzzy          |  3 ++
 common/rc             |  5 +--
 common/verity         | 73 +++++++++++++++++++++++++++++++++++++++++-
 tests/btrfs/124       |  2 ++
 tests/btrfs/125       |  2 ++
 tests/btrfs/163       |  2 ++
 tests/btrfs/164       |  2 ++
 tests/btrfs/219       |  2 ++
 tests/btrfs/225       |  3 ++
 tests/btrfs/231       | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/231.out   | 35 +++++++++++++++++++++
 tests/btrfs/232       | 73 ++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/232.out   |  2 ++
 tests/btrfs/group     |  2 ++
 tests/generic/250     |  7 +++--
 tests/generic/252     |  6 ++--
 tests/generic/441     |  7 +++--
 tests/generic/484     |  7 +++--
 tests/generic/487     |  7 +++--
 tests/generic/577     | 15 ++-------
 tests/generic/607     |  4 +++
 tests/generic/608     |  3 ++
 tests/generic/623     |  1 +
 tests/generic/624     | 79 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/624.out | 16 ++++++++++
 tests/generic/625     | 66 ++++++++++++++++++++++++++++++++++++++
 tests/generic/625.out |  7 +++++
 tests/generic/group   |  2 ++
 tests/xfs/271         | 12 ++++++-
 32 files changed, 553 insertions(+), 40 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--6tZ5jPou8HlJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmBFFrwACgkQJlKqKVyP
52MbpA//QfiAJpgofou0iJUX+6f/BgzddCJB3VzhGDMp7+hBpW+UaUQW+8Pkexww
HcotVWGBKrd+9kFTvS8XkdNzUP65KxSkF9njjZJP4gWF8BTAlWTveE0xmJH8vpc1
Yq6SM0pFW7zOLukxo43zaSy9xdsvdpsv9InjgtJ7zQQJX2QRSoL44LX4ye9YZv/u
/UvgsHlY7R/btGSfomBI+rs755oFqbuAeSwMTB/kuNmbEtyGK4C6qhy7/6nNQfKw
b3QAcOW+mJ0ZMBWhLrbh7o51XpYljWaRoOXP5ufqQzhJRRVdWVt7/X32hv8gKUZI
TysjwzSOCR0fB8BkWvrU9O+ZeP7xnR7Lgt0b2C55yw2agFPnSCyWhBpW9+wTTHKQ
S3posmSgN+WMvJCGHKCrOBC+HxbfqoSYYhY3YEqiik5eYvAYvLY2IhPMRPUaaRMN
8py7MSo+9DtMUEdJKZqIVwDxVGtKl97jGFuAdBYUKqkpfRPB9bnLNZhS0mJMh63C
LAsUDikB+3pT8iTQ25fNR+laUtHifyKZ0sCaxwW2UqswGvvBYfej9SENddtHhbgA
go23/S1DkI/KSTLf3QcDaRRAgz+aiaoinE/CKfOYYFqF4H9KvpJttLO+tFYlpP67
WMOd4f54m+9GXN8nZOY53JqQ31K8wRjxLNnhpwlXN/KFn8EkeD8=
=PbF0
-----END PGP SIGNATURE-----

--6tZ5jPou8HlJ--
