Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99EDC74A5B
	for <linux-fstests@archiver.kernel.org>; Sun, 26 Mar 2023 15:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjCZP0S (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 26 Mar 2023 11:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCZP0R (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 26 Mar 2023 11:26:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7C41992
        for <fstests@vger.kernel.org>; Sun, 26 Mar 2023 08:26:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5751460DE7
        for <fstests@vger.kernel.org>; Sun, 26 Mar 2023 15:26:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D6DC433D2;
        Sun, 26 Mar 2023 15:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679844375;
        bh=Dwh6erExi6RADr5K4g9iFDJhBqOZAG3IuBUOBgfDH6w=;
        h=Date:From:To:Subject:From;
        b=oJP/NFpXcSCaFMWpALbBzmfbvVolUpwb28NzKDw7HCbz5ng5kwkQ3qjOdw9UATRAa
         0bazG87ESEdKVnRlutu8KEjcqS4QLt4isD3IFiQyM1zGDM3i9x7Hdqq/VP9/Z8A0yD
         yemOiYnApIc0CtT2n+W8kA6PqtfUXZJKYKhtm3LK25HmlQPre6jrpdFVkh9zpJt9Bg
         b18XZKfYKLbhmHVygrh52us7/3zmxgK78NjYa0vSVrmHhAcd7/NFyiIQRnpj7zuvAi
         tktJlbMUn+E0EflbE374IsO4kBMMVB5xZCD7QM7jt4Ii10WkqG/Gknx8LXssmB8LaA
         8aTSwn60NfJ6g==
Date:   Sun, 26 Mar 2023 23:26:11 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2023.03.26
Message-ID: <20230326152611.brcr3q7x4pxlh65q@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2023.03.26 release.

Release Notes:
1) No new test case in this release.
2) Some bug fix from fscrypt, btrfs, ceph side.
3) A big update on fstests report generator (xml). This change collected
   some suggestions from ext4 and btrfs users too, so it's worth a try if
   you'd like to use this report function.

Thanks for all these contribution, more details refer to below.

Thanks,
Zorro

The new head of the for-next branch is commit:

dc08f43f0fc9 report: allow test runners to inject arbitrary values

New commits:

Darrick J. Wong (15):
      [ec13788638b3] check: generate section reports between tests
      [b76a6cdb40b5] report: derive an xml schema for the xunit report
      [545315976e72] report: capture the time zone in the test report timestamp
      [72dc174d42d9] report: clarify the meaning of the timestamp attribute
      [a8963ceb25ef] report: record fstests start and report generation timestamps
      [77bedb6a7db2] report: encode cdata sections correctly
      [396d221df719] report: encode the kernel log as a separate xml element
      [9c54fea5f5f9] report: sort properties by name
      [e30945a820b4] report: pass property value to _xunit_add_property
      [35de6ce721cc] report: encode xml entities in property values
      [4f604f90f060] report: collect basic information about a test run
      [391134eaf760] report: record optional environment variables
      [159d630a3d53] report: record xfs-specific information about a test run
      [ea9db87c90a1] report: record ext*-specific information about a test run
      [dc08f43f0fc9] report: allow test runners to inject arbitrary values

Eric Biggers (3):
      [593fcfbb573a] fscrypt-crypt-util: fix HKDF self-test with latest OpenSSL
      [8727e8cb7810] fscrypt-crypt-util: use OpenSSL EVP API for AES self-tests
      [5d6a0f38d175] fscrypt-crypt-util: fix XTS self-test with latest OpenSSL

Khem Raj (1):
      [2a280de522cf] m4: Check for FTW_ACTIONRETVAL along with nftw

Qu Wenruo (1):
      [3a9e43ba45fb] btrfs/246: skip the test if the tested btrfs doesn't support inline extents creation

Xiubo Li (1):
      [2d7d5f49e727] generic/020: fix another really long attr test failure for ceph


Code Diffstat:

 README                   |   3 +
 check                    |  11 +++
 common/btrfs             |  22 +++++
 common/ext4              |   5 +
 common/report            | 130 +++++++++++++++++++++----
 common/xfs               |  11 +++
 doc/xunit.xsd            | 246 +++++++++++++++++++++++++++++++++++++++++++++++
 m4/package_libcdev.m4    |   2 +-
 src/fscrypt-crypt-util.c |  50 ++++++++--
 tests/btrfs/246          |   3 +
 tests/generic/020        |   6 ++
 11 files changed, 459 insertions(+), 30 deletions(-)
--
Zorro Lang
zlang@kernel.org
