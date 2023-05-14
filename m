Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6987DC77B7D
	for <linux-fstests@archiver.kernel.org>; Sun, 14 May 2023 15:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbjENPEI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 14 May 2023 11:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjENPEI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 14 May 2023 11:04:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE071994
        for <fstests@vger.kernel.org>; Sun, 14 May 2023 08:04:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E87B60C48
        for <fstests@vger.kernel.org>; Sun, 14 May 2023 15:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEB8C433EF;
        Sun, 14 May 2023 15:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684076645;
        bh=4fYtgfI96A++rjFmVyNods5Y1R3jGfFaE6rpHN1wrtQ=;
        h=Date:From:To:Subject:From;
        b=Ok0OuoqzqaIW5I8NzFm5GePVoUejNM2RlfQH44ySZPesosoaDp5Pn3AWuV+gTmByg
         qFd65lvAQf2PDn+dMSDsc0pRqo4ONlnhmuk6+4+Tlns7XkAQshW781rz2S+fLDw661
         93t5kyU2Ol8Psf4VX6qxMXhKK5v4CVAPzkoxyw37/NEsrAVgQOp3FdMHIic2tqC4Es
         3W0yGT+MAG2rx1Md6hBb3nvpa5LYbOJ+whNjnTTSTGGz1M7vFGBdUEqMrWPeHQ9mZW
         uD4Zym56iSpw0+Yjrj9XFpkReqfeRM+TMaT3ebjDBxe9h4JRk+2kazDniUoEq/2qJ4
         P7E/So3iMwLpg==
Date:   Sun, 14 May 2023 23:03:59 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2023.05.01 onto master branch
Message-ID: <20230514150359.zutlp7b72gih3iyv@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2023.05.01 version.

Thanks,
Zorro

The new head of the master branch is commit:

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
