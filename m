Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1809C433ED
	for <linux-fstests@archiver.kernel.org>; Sun, 11 Apr 2021 14:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 856BF611AD
	for <linux-fstests@archiver.kernel.org>; Sun, 11 Apr 2021 14:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbhDKOiE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 11 Apr 2021 10:38:04 -0400
Received: from out20-50.mail.aliyun.com ([115.124.20.50]:47280 "EHLO
        out20-50.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235827AbhDKOiD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 11 Apr 2021 10:38:03 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07444869|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00418535-0.000523253-0.995291;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047205;MF=guan@eryu.me;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.JyL9Z3V_1618151864;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.JyL9Z3V_1618151864)
          by smtp.aliyun-inc.com(10.147.40.44);
          Sun, 11 Apr 2021 22:37:44 +0800
Date:   Sun, 11 Apr 2021 22:37:44 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Christian Brauner <brauner@kernel.org>
Cc:     fstests@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v12 0/6] fstests: add idmapped mounts tests
Message-ID: <YHMJuKI8sLTgSZmx@desktop>
References: <20210328223400.1800301-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210328223400.1800301-1-brauner@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Mar 29, 2021 at 12:33:54AM +0200, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Hey everyone,
> 
> This series is available from:
> https://git.kernel.org/brauner/xfstests-dev/h/idmapped_mounts
> https://gitlab.com/brauner/xfstests/-/tree/idmapped_mounts
> https://github.com/brauner/xfstests/tree/idmapped_mounts
> 
> /* v12 */
> - Main change is a fix to the io_uring tests. io_uring_wait_cqe()
>   doesn't set errno, it returns a negative errno.
> - Make sure we also run without error when libcap isn't available (That
>   was always the goal but the logic missed a few new tests.)

Thanks for the revision! The whole patchset looks fine to me, except
that I'm not sure if the generic/632 failure on btrfs & overlayfs is
expected.

With that resolved (either it's expected failure or test needs fix), I
think the patchset is ready to be merged.

Thanks,
Eryu

> 
> /* v11 */
> Reworked according to Amir's comments.
> 
> /* v10 */
> Reworked according to Eryu's comments.
> 
> /* v9 */
> Rebased onto current master.
> 
> ubuntu@f1-vm:~/src/git/xfstests$ sudo ./check -g idmapped
> FSTYP         -- xfs (debug)
> PLATFORM      -- Linux/x86_64 f1-vm 5.12.0-rc3-syz #18 SMP PREEMPT Fri Mar 26 13:27:16 UTC 2021
> MKFS_OPTIONS  -- -f -bsize=4096 /dev/loop1
> MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch
> 
> generic/632 files ...  27s
> xfs/529 files ...  67s
> xfs/530 files ...  43s
> Ran: generic/632 xfs/529 xfs/530
> Passed all 3 tests
> 
> Thanks!
> Christian
> 
> Christian Brauner (6):
>   generic/631: add test for detached mount propagation
>   generic/632: add fstests for idmapped mounts
>   common/rc: add _scratch_{u}mount_idmapped() helpers
>   common/quota: move _qsetup() helper to common code
>   xfs/529: quotas and idmapped mounts
>   xfs/530: quotas on idmapped mounts
> 
>  .gitignore                            |    3 +
>  README                                |    5 +-
>  common/quota                          |   20 +
>  common/rc                             |   60 +
>  configure.ac                          |    2 +
>  include/builddefs.in                  |    1 +
>  m4/Makefile                           |    1 +
>  m4/package_libcap.m4                  |    4 +
>  src/Makefile                          |    8 +-
>  src/detached_mounts_propagation.c     |  189 +
>  src/feature.c                         |   40 +-
>  src/idmapped-mounts/Makefile          |   40 +
>  src/idmapped-mounts/idmapped-mounts.c | 8873 +++++++++++++++++++++++++
>  src/idmapped-mounts/missing.h         |  151 +
>  src/idmapped-mounts/mount-idmapped.c  |  431 ++
>  src/idmapped-mounts/utils.c           |  134 +
>  src/idmapped-mounts/utils.h           |   30 +
>  tests/generic/631                     |   43 +
>  tests/generic/631.out                 |    2 +
>  tests/generic/632                     |   42 +
>  tests/generic/632.out                 |    2 +
>  tests/generic/group                   |    2 +
>  tests/xfs/050                         |   19 -
>  tests/xfs/299                         |   19 -
>  tests/xfs/529                         |  377 ++
>  tests/xfs/529.out                     |  657 ++
>  tests/xfs/530                         |  212 +
>  tests/xfs/530.out                     |  129 +
>  tests/xfs/group                       |    2 +
>  29 files changed, 11453 insertions(+), 45 deletions(-)
>  create mode 100644 m4/package_libcap.m4
>  create mode 100644 src/detached_mounts_propagation.c
>  create mode 100644 src/idmapped-mounts/Makefile
>  create mode 100644 src/idmapped-mounts/idmapped-mounts.c
>  create mode 100644 src/idmapped-mounts/missing.h
>  create mode 100644 src/idmapped-mounts/mount-idmapped.c
>  create mode 100644 src/idmapped-mounts/utils.c
>  create mode 100644 src/idmapped-mounts/utils.h
>  create mode 100644 tests/generic/631
>  create mode 100644 tests/generic/631.out
>  create mode 100644 tests/generic/632
>  create mode 100644 tests/generic/632.out
>  create mode 100644 tests/xfs/529
>  create mode 100644 tests/xfs/529.out
>  create mode 100644 tests/xfs/530
>  create mode 100644 tests/xfs/530.out
> 
> 
> base-commit: f6ddaf130d5b0817278afe441fdde52f464f321b
> -- 
> 2.27.0
