Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B97C77B73
	for <linux-fstests@archiver.kernel.org>; Sun, 30 Apr 2023 16:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjD3QbV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 30 Apr 2023 12:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjD3QbU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 30 Apr 2023 12:31:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC6A1BC3
        for <fstests@vger.kernel.org>; Sun, 30 Apr 2023 09:31:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0E5860C06
        for <fstests@vger.kernel.org>; Sun, 30 Apr 2023 16:31:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82F2C433D2;
        Sun, 30 Apr 2023 16:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682872278;
        bh=xydMG98e9gBLRqBDhx0LEC0uHLwWrSU+I/XtmcRRrVA=;
        h=Date:From:To:Subject:From;
        b=aeJG1N2UQJTNC31UyHiJgVNCVez/bmvsWke11JK3DO7cDjNWyIr7MsEPCPLNKpL7y
         wtNydHvFRwellZ66NuFLdm5vBpu+JD7wLGip4QzQHNngwxPgyRCF4UAIAui83SYkvX
         PBuTEpv5y4+Fl+XuA0JBkUpv2PbFQJ9KUpB7CQ6F8TmxLBb6aGV8A1ZGgvYCSNSdF/
         bvPWeS8rAgVcnWVHTGgg1NsEagDBlxatBK4Qbn6lxU1pbNuaTfslfW78auENmpKJIs
         Z4MxY+AlK4zedjZ4ASQ//3ikaauz/V6ALQC2WxGEPj1q4mcAYC223Fkvh/0qYuowE1
         k5KB1tNImNxRg==
Date:   Mon, 1 May 2023 00:31:13 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to v2023.05.01
Message-ID: <20230430163113.mhpbswdqfwbbaloh@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2023.05.01 release.

Release Note:
1. There's not new case in this release.
2. New SOAK_DURATION global parameter, to help part of soak group testing keep
   running a specific time. New option "--duration" for fsstress.c and fsx.c
   to support this feature. I'd like to add more cases to soak group, and
   support this parameter.
3. fstests offically supports AFS testing now, Thanks David Howells.

More updates and bug fixes refer to below, thanks for all these contribution!

Thanks,
Zorro

The new head of the for-next branch is commit:

2e361b3da66d misc: add duration for recovery loop tests

New commits:

Darrick J. Wong (5):
      [c63ce4a5eac8] xfs/517: add missing freeze command
      [a1daffd9bbff] generic/476: reclassify this test as a long running soak stress test
      [2b56a7d93ab0] readme: document TIME/LOAD_FACTOR
      [3e85dd4fe423] misc: add duration for long soak tests
      [2e361b3da66d] misc: add duration for recovery loop tests

David Howells (7):
      [3e7529aff5d2] fstests: add AFS support
      [2ce9cd8c026f] generic/314, afs: Allow for a filesystem that doesn't honour SGID inheritance
      [ec575a86da79] generic/317, afs: Allow for a filesystem not to honour the local uid/gid
      [f1f408150d09] generic/123, generic/128, afs: Allow for an fs that does its own perm management
      [ddff883c8c3a] generic/531: Check for O_TMPFILE
      [c71a4391eadd] generic/696: AFS doesn't support the "noacl" command line option
      [5f6b9e575f1b] fstests: Doc changes for afs

Leah Rumancik (1):
      [4a444bc19a83] check: _check_filesystems for errors even if test failed

Theodore Ts'o (1):
      [c7d81cdecbef] check: try to fix the test device if it gets corrupted

Xiubo Li (1):
      [067acc189b6d] common/rc: skip ceph when atime is required

Yang Xu (1):
      [ea9160e0fcaf] src: Don't include <sys/mount.h> and <linux/mount.h> together


Code Diffstat:

 README                            |  14 +++-
 README.config-sections            |   7 ++
 build/rpm/xfstests.spec.in        |   2 +-
 check                             |  23 +++++-
 common/config                     |  17 ++++-
 common/fuzzy                      |   7 +-
 common/rc                         | 151 ++++++++++++++++++++++++++++++++++++--
 common/report                     |   1 +
 common/xfs                        |  12 +++
 doc/group-names.txt               |   3 +-
 doc/requirement-checking.txt      |  23 ++++++
 doc/testing-afs.txt               |  36 +++++++++
 ltp/fsstress.c                    |  78 +++++++++++++++++++-
 ltp/fsx.c                         |  50 ++++++++++++-
 src/detached_mounts_propagation.c |   5 +-
 src/soak_duration.awk             |  23 ++++++
 src/vfs/utils.c                   |   1 -
 tests/generic/019                 |   1 +
 tests/generic/123                 |   1 +
 tests/generic/128                 |   1 +
 tests/generic/314                 |   1 +
 tests/generic/317                 |   1 +
 tests/generic/388                 |   2 +-
 tests/generic/475                 |   2 +-
 tests/generic/476                 |   7 +-
 tests/generic/482                 |   1 +
 tests/generic/521                 |   1 +
 tests/generic/522                 |   1 +
 tests/generic/531                 |   1 +
 tests/generic/642                 |   1 +
 tests/generic/648                 |   8 +-
 tests/generic/696                 |   5 +-
 tests/xfs/517                     |   2 +-
 33 files changed, 456 insertions(+), 33 deletions(-)
--
Zorro Lang
zlang@kernel.org
