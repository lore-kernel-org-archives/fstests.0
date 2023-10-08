Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55136E95A82
	for <linux-fstests@archiver.kernel.org>; Sun,  8 Oct 2023 13:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjJHNd4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 8 Oct 2023 09:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjJHNdz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 8 Oct 2023 09:33:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8BCB6
        for <fstests@vger.kernel.org>; Sun,  8 Oct 2023 06:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696771997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=qfnQXFI0AVr8DqhHlpHNgkwrrOpVjfmomJjzCrRdnjM=;
        b=OhhbBRjMPdTXGB567rufGHHL/rLJFa0IgCpkdU/MTCzpROgmnB37w3j1nE+OrucaRo8zJw
        t1xKbnvIUKY3Zrp3bPw7o9OFcspBzaVs4DzZPEuZhy/tdVoqiz9URwO/mOgS+O5J43n7vu
        V7aZEDcW2sjTmJZfYJp3Df7ncitzLX0=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-Tvs1pwLpOeyISjn-66mZMQ-1; Sun, 08 Oct 2023 09:33:11 -0400
X-MC-Unique: Tvs1pwLpOeyISjn-66mZMQ-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6c4717c4745so4582062a34.0
        for <fstests@vger.kernel.org>; Sun, 08 Oct 2023 06:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696771990; x=1697376790;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qfnQXFI0AVr8DqhHlpHNgkwrrOpVjfmomJjzCrRdnjM=;
        b=wctzOXsYe/VmYstPhRwBf84pw20tJKb9yAfgTwdpdsS5a24w5rjJ+53ZFLK01HeMJj
         Te1lisuD/ZEIs7IWIxek0CfJA7yUNY1PZJZdyFuZFI1ouN6O2G8P76MGtIUSsKLrlBSj
         sJ6w9IAX/m6mZFwH5wgvNuJ6A/JG2xe6WUApHRuZvnLdgohM3G7fo83Ohnkag8rmypCK
         Xochj2JArZl1au57q6LgZhGgMWigUuA7C0DeIxk/GT5aXoigW51vTmV8S3UKTNbIqRdb
         7bidPgpSPoTF1yNV8/6Q4xiaMAlVfHZ84Iyxqkl+UmhnkzLEmQAnBR4wa+Tl0Jyt1TqJ
         dEtQ==
X-Gm-Message-State: AOJu0YxNh55HUkkcgZ+18oB/o5gxkwnKcrHLkXf7yKmbG8B9yNZPIO2b
        avKIJ3NBe4QdqwHcBYS98ZM0v5fDo7L7VeUJnG1ZFwkzRNjl69epULGu4nQxOG2VOthXqJ1FxKZ
        opHbvcNU42U2XrHsvXXBqYZUHloXjWB0RmsgZaD1l4hZ2te6mSfZaE5+JNXGUwAhN7iqCaOb57k
        J4+MA=
X-Received: by 2002:a9d:784c:0:b0:6c6:1c54:a1b7 with SMTP id c12-20020a9d784c000000b006c61c54a1b7mr14564671otm.24.1696771989924;
        Sun, 08 Oct 2023 06:33:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRUF1EtpQt0dBc5xCMHga+PE6Ki/wgw9nRS8XLOUgdsI7yVWO0uzLWyXBj4DKoNKoUHL09jg==
X-Received: by 2002:a9d:784c:0:b0:6c6:1c54:a1b7 with SMTP id c12-20020a9d784c000000b006c61c54a1b7mr14564658otm.24.1696771989545;
        Sun, 08 Oct 2023 06:33:09 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q30-20020a638c5e000000b0058a9621f583sm3508974pgn.44.2023.10.08.06.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 06:33:09 -0700 (PDT)
Date:   Sun, 8 Oct 2023 21:33:05 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2023.10.08
Message-ID: <20231008133305.kqpxoedjwd4pggb4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2023.10.08 release.

Release Notes:
1) There're 3 new test cases in this release. They're btrfs/298, btrfs/301
   and generic/732. Two for btrfs functional testing, and one for a nfs
   known issue (fixed by upstream). They won't cause panic/hang on old
   downstream kernel.
2) A big change for btrfs qgroup feature testing.
3) Fix a regression on btrfs/076.
4) Lots of fixes or improvements in this release.

More details refer to below, thanks for all your contribution!

Thanks,
Zorro

The new head of the for-next branch is commit:

59299b65ac8f README: Update overlayfs instructions

New commits ([N]ew, [U]pdate):

Anand Jain (1):
[N]      [0b70188b651b] btrfs: test scan but not register the single device fs

Boris Burkov (6):
[U]      [c0cafb48a892] common: refactor sysfs_attr functions
[U]      [587984a47e44] btrfs: quota mode helpers
[N]      [b887c9f7bd38] btrfs/301: new test for simple quotas
[U]      [177848f09a13] btrfs: quota rescan helpers
[U]      [c4e3b3d482d7] btrfs: use new rescan wrapper
[U]      [15792e35ae9b] btrfs: skip squota incompatible tests

Chandan Babu R (1):
[U]      [809fd13575df] _scratch_mkfs_geom: Fix regex used for matching block size option

Darrick J. Wong (3):
[U]      [4609e9481fe8] xfs/018: make sure that larp mode actually works
[U]      [9b88ac7ee508] btrfs/300: check existence of unshare arguments
[U]      [975277cea4c4] xfs/{270,557,600}: update commit id for _fixed_by tag.

Filipe Manana (2):
[U]      [f55e46d62968] fstests: redirect fsstress' stdout to $seqres.full instead of /dev/null
[U]      [d213e332a32b] btrfs/192: use append operator to output log replay results to $seqres.full

Khem Raj (1):
[U]      [ab81b565f360] fsx: Add a return type to aio_rw

Naohiro Aota (4):
[U]      [0f4d4a18b397] btrfs/283: skip if we cannot write into one extent
[U]      [80e277fd69a2] btrfs/076: fix file_size variable
[U]      [7a093dfa66d6] btrfs/295: skip on zoned device as we cannot corrupt it directly
[U]      [ffa82237277e] common/rc: check error case and fail the test

Vyacheslav Yurkov (1):
[U]      [59299b65ac8f] README: Update overlayfs instructions

Yongcheng Yang (1):
[N]      [fb817fa4be6b] generic: add a test to check move in mountpoints of the same export


Code Diffstat:

 README                |  12 --
 README.overlay        |   9 +-
 common/btrfs          |  64 ++++++++
 common/rc             | 139 ++++++++++------
 ltp/fsx.c             |   1 +
 tests/btrfs/017       |   1 +
 tests/btrfs/022       |   1 +
 tests/btrfs/028       |   4 +-
 tests/btrfs/049       |   2 +-
 tests/btrfs/057       |   1 +
 tests/btrfs/060       |   2 +-
 tests/btrfs/061       |   2 +-
 tests/btrfs/062       |   2 +-
 tests/btrfs/063       |   2 +-
 tests/btrfs/064       |   2 +-
 tests/btrfs/065       |   2 +-
 tests/btrfs/066       |   2 +-
 tests/btrfs/067       |   2 +-
 tests/btrfs/068       |   2 +-
 tests/btrfs/069       |   2 +-
 tests/btrfs/070       |   2 +-
 tests/btrfs/071       |   2 +-
 tests/btrfs/072       |   2 +-
 tests/btrfs/073       |   2 +-
 tests/btrfs/074       |   2 +-
 tests/btrfs/076       |   2 +-
 tests/btrfs/091       |   3 +-
 tests/btrfs/104       |   2 +-
 tests/btrfs/123       |   2 +-
 tests/btrfs/126       |   2 +-
 tests/btrfs/136       |   2 +-
 tests/btrfs/139       |   2 +-
 tests/btrfs/153       |   2 +-
 tests/btrfs/171       |   6 +-
 tests/btrfs/179       |   2 +-
 tests/btrfs/180       |   2 +-
 tests/btrfs/190       |   2 +-
 tests/btrfs/192       |   4 +-
 tests/btrfs/193       |   2 +-
 tests/btrfs/210       |   2 +-
 tests/btrfs/224       |   6 +-
 tests/btrfs/230       |   2 +-
 tests/btrfs/232       |   4 +-
 tests/btrfs/261       |   2 +-
 tests/btrfs/283       |   8 +
 tests/btrfs/286       |   2 +-
 tests/btrfs/295       |   2 +
 tests/btrfs/298       |  55 +++++++
 tests/btrfs/298.out   |   2 +
 tests/btrfs/300       |   2 +-
 tests/btrfs/301       | 444 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/301.out   |  18 ++
 tests/ext4/057        |   2 +-
 tests/ext4/307        |   2 +-
 tests/generic/068     |   2 +-
 tests/generic/269     |   2 +-
 tests/generic/409     |   2 +-
 tests/generic/410     |   2 +-
 tests/generic/411     |   2 +-
 tests/generic/589     |   2 +-
 tests/generic/732     |  58 +++++++
 tests/generic/732.out |   2 +
 tests/xfs/018         |  13 ++
 tests/xfs/051         |   2 +-
 tests/xfs/057         |   2 +-
 tests/xfs/270         |   2 +-
 tests/xfs/297         |   2 +-
 tests/xfs/305         |   2 +-
 tests/xfs/538         |   2 +-
 tests/xfs/557         |   2 +-
 tests/xfs/600         |   2 +-
 71 files changed, 828 insertions(+), 125 deletions(-)
--
Zorro Lang
zlang@kernel.org

