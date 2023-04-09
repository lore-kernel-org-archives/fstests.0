Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3DCC77B61
	for <linux-fstests@archiver.kernel.org>; Sun,  9 Apr 2023 14:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjDIOkM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 9 Apr 2023 10:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDIOkL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 9 Apr 2023 10:40:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B29730DA
        for <fstests@vger.kernel.org>; Sun,  9 Apr 2023 07:40:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B286460C1C
        for <fstests@vger.kernel.org>; Sun,  9 Apr 2023 14:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1A2C433D2;
        Sun,  9 Apr 2023 14:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681051210;
        bh=DG2i22+ojMsF8tlFn2al3XFtaaDOmxnOUwGd6FqUQn0=;
        h=Date:From:To:Subject:From;
        b=hhuuN/tY5C7EbqV20e+pZ6c5l3d8c44tJh+czvm4xeCAomkBBepH+ol+QbEvky/03
         Lo974giPFVAvfoJexx8GhCjbXSwGajI/BrfPXZzv9N4JrKS2ISu2IZLq1cWwLuhaM/
         vruNcFqo/UQKqyfOYQB9uN+rfmZa9/Gz6AjB87OfeRazNIKaoGoRc2RYFiu0yNB1Un
         DpJ1Tq/thZc9mf0e0HqCAI5aH0HmyPcI/H0jVCB2rt1RE6HitOrZ9ged83pSHBRmjb
         yyPSTP0655+jPrcQbaZqvI5o7gzvYB6d1GIbF2IwrvKOv5QpbHRzQXIYaOwMI1lg4A
         G6flS2yBj9aVw==
Date:   Sun, 9 Apr 2023 22:40:04 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2023.03.26 onto master branch
Message-ID: <20230409144004.iajzmcrs3sxuwdyy@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2023.03.26 version.

Thanks,
Zorro

The new head of the master branch is commit:

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
