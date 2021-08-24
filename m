Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB77C4338F
	for <linux-fstests@archiver.kernel.org>; Tue, 24 Aug 2021 12:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59E566128A
	for <linux-fstests@archiver.kernel.org>; Tue, 24 Aug 2021 12:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237289AbhHXMhS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 Aug 2021 08:37:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37760 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237269AbhHXMhS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 Aug 2021 08:37:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629808593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0IPLuzIq0l1CF2+yxT3pcZy+fE59Q4bGwoZBRqH85Uk=;
        b=U9nwK2HEp249woMkSMAlZuhb7p+/3Ev7WzECohhaZN5Ur2PbMHmm8qwjo6T+BhRKhvpY22
        jYEvf8uExcc/z08zvcBxq4GeVsPMP2cH25POmOPTjOl5vtcJoz+TYrvwRDslk6e7jCvZuL
        jvMULwe+XYyOlbhD9+AUu5sLFkRfRVs=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-8oZns_GrODyicLHttlS3jA-1; Tue, 24 Aug 2021 08:36:32 -0400
X-MC-Unique: 8oZns_GrODyicLHttlS3jA-1
Received: by mail-pl1-f197.google.com with SMTP id u6-20020a170902bf46b029012c971d6226so5537468pls.21
        for <fstests@vger.kernel.org>; Tue, 24 Aug 2021 05:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=0IPLuzIq0l1CF2+yxT3pcZy+fE59Q4bGwoZBRqH85Uk=;
        b=mzKdqKYr0s65qIYOifE2HVhnpYmacaJyZ2ZrM6z5sidKiol5W1ea2ssYX+YIG4CXK8
         72BTE0UaxcfKw0eqyY+46FPrVKhZlgeUlMeDVZx9CEl3Dy26nvXISm2eleSyFGKHD03Y
         9s9QeyRXlGlXxHNE+JzrIF/FSBjHNSQi+DSY1YLz4jSmsFEeFQPp3xiGV3tCvH3v0Sgx
         qlf7DKRUwwKxR2izJ6EaW3fY3BD3ToerT2S4KPPP+2GM0VUiTRZXCCaLqMDd620YBsa4
         dRU1HUIf8V+3bfT896R6M6rWrPZsj9bU/qM2Z+FeBxrQFklH8K0nloHtEXg0K8Lv/jD4
         hA+A==
X-Gm-Message-State: AOAM5311n5EpakyXDfDAqDODJmepHCrWCYMRem2w2yVvtISmUt+ofEH5
        AK5sfCH6OVQc5RbOyy/esZbHM77nHPb8d6QcpZeSeUuXDwCDt+Piw3+7rM5XNwJ7AlvhutgKoQR
        SP5VhR0tRD3/lqk2BJA==
X-Received: by 2002:a17:902:d504:b029:12d:4cb3:397e with SMTP id b4-20020a170902d504b029012d4cb3397emr33426557plg.41.1629808591224;
        Tue, 24 Aug 2021 05:36:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdPICT/nu032MN0NL5APZdnG00t/VqJ0ToKTmTrXLdcanpIbjvpSTkHl8J+qALGLKnQtdTNg==
X-Received: by 2002:a17:902:d504:b029:12d:4cb3:397e with SMTP id b4-20020a170902d504b029012d4cb3397emr33426547plg.41.1629808590853;
        Tue, 24 Aug 2021 05:36:30 -0700 (PDT)
Received: from fedora ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q21sm2442540pjg.55.2021.08.24.05.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 05:36:30 -0700 (PDT)
Date:   Tue, 24 Aug 2021 20:57:17 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Murphy Zhou <xzhou@redhat.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
        ddouwsma@redhat.com, Eryu Guan <eguan@linux.alibaba.com>
Subject: Re: [PATCH v4] tests/generic: check log recovery with readonly mount
Message-ID: <20210824125717.revcpz7bvirta3mo@fedora>
Mail-Followup-To: Murphy Zhou <xzhou@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
        ddouwsma@redhat.com, Eryu Guan <eguan@linux.alibaba.com>
References: <20210806014938.npfn2ykyirfrdlra@xzhoux.usersys.redhat.com>
 <20210806185545.GE3601425@magnolia>
 <20210823070541.mn2y4pn4256dwnhm@xzhoux.usersys.redhat.com>
 <20210823174316.GE12612@magnolia>
 <20210824050436.3l5jodgjhwt7wqzl@xzhoux.usersys.redhat.com>
 <20210824062354.lcbmbz2r6fv5zowo@fedora>
 <20210824090638.cfg7irh6bo55ey26@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824090638.cfg7irh6bo55ey26@xzhoux.usersys.redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Aug 24, 2021 at 05:06:38PM +0800, Murphy Zhou wrote:
> And followed by a rw mount. After log recovery by these 2 mount, the
> filesystem should be in a consistent state.
> 
> Suggested-by:  Donald Douwsma <ddouwsma@redhat.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Murphy Zhou <xzhou@redhat.com>
> ---
> 
> Thanks Eryu and Zorro!
> 
> v2:
>    Add explanation of the issue
>    add xfs_force_bdev data $SCRATCH_MNT
>    use DF_PROG
>    Re numbered this test
> v3:
>    Add _require_scratch_shutdown
>    Use _get_available_space
>    Explain why does not use _scratch_mount
> v4:
>    Add to recoveryloop group
>    Move to generic as there are no xfs specific operations
>    Remove all operations after 2 cycle mounts, let the fsck in fstests
> to check the filesystem consistency
>    Use _scratch_shutdown, MOUNT_PROG
>    Remove unnecessary comments
> 
>  tests/generic/999     | 45 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/999.out |  2 ++
>  2 files changed, 47 insertions(+)
>  create mode 100755 tests/generic/999
>  create mode 100644 tests/generic/999.out
> 
> diff --git a/tests/generic/999 b/tests/generic/999
> new file mode 100755
> index 00000000..9685488b
> --- /dev/null
> +++ b/tests/generic/999
> @@ -0,0 +1,45 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 RedHat All Rights Reserved.
> +#
> +# FS QA Test 999
> +#
> +# Testcase for kernel commit:
> +#   50d25484bebe xfs: sync lazy sb accounting on quiesce of read-only mounts
> +#
> +# After shutdown and readonly mount, a following read-write mount would
> +# get wrong number of available blocks. This is caused by unmounting the log
> +# on a readonly filesystem doesn't log the sb counters.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick recoveryloop shutdown
> +
> +# real QA test starts here
> +
> +_require_scratch
> +_require_scratch_shutdown
> +_scratch_mkfs > $seqres.full 2>&1
> +
> +# Don't use _scratch_mount because we need to mount without SELinux context
> +# to reproduce this issue. If we mount with _scratch_mount, SELinux context
> +# maybe applied and this testcase is not reproducing the original issue.
> +$MOUNT_PROG $SCRATCH_DEV $SCRATCH_MNT

This's weird, I think the SELinux mount option only can make below testfile
have no selinux label (xattr). But I don't think it's related with this bug.
So I tried to use "_scratch_mount", then still can reproduce this bug. May
you try it again?

# git diff
diff --git a/tests/generic/999 b/tests/generic/999
index 9685488b..a196e65d 100755
--- a/tests/generic/999
+++ b/tests/generic/999
@@ -23,8 +23,11 @@ _scratch_mkfs > $seqres.full 2>&1
 # Don't use _scratch_mount because we need to mount without SELinux context
 # to reproduce this issue. If we mount with _scratch_mount, SELinux context
 # maybe applied and this testcase is not reproducing the original issue.
-$MOUNT_PROG $SCRATCH_DEV $SCRATCH_MNT
-_xfs_force_bdev data $SCRATCH_MNT
+#$MOUNT_PROG $SCRATCH_DEV $SCRATCH_MNT
+_scratch_mount
+if [ "$FSTYP" = "xfs" ];then
+       _xfs_force_bdev data $SCRATCH_MNT
+fi

# ./check generic/999
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 hp-dl380pg8-01 4.18.0-xxx.el8.x86_64+debug #1 SMP Tue Jun 15 10:43:04 EDT 2021
MKFS_OPTIONS  -- -f /dev/mapper/rhel_hp--dl380pg8--01-xfscratch
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/mapper/rhel_hp--dl380pg8--01-xfscratch /mnt/scratch

generic/999 16s ... _check_xfs_filesystem: filesystem on /dev/mapper/rhel_hp--dl380pg8--01-xfscratch is inconsistent (r)
(see /home/xfstests-dev/results//generic/999.full for details)

Ran: generic/999
Failures: generic/999
Failed 1 of 1 tests

> +_xfs_force_bdev data $SCRATCH_MNT

This's a xfs only helper, for a generic case, better to:

if [ "$FSTYP" = "xfs" ];then
	_xfs_force_bdev data $SCRATCH_MNT
fi

> +
> +echo Testing > $SCRATCH_MNT/testfile
> +
> +# -f is required to reproduce
> +_scratch_shutdown -f
> +
> +_scratch_cycle_mount ro
> +_scratch_cycle_mount
> +
> +# These 2 mount should have the log fully recovered. Exit here and let the
> +# fsck operation to check the consistence of the tested filesystem. On the
> +# buggy kernel, this testcase reports filesystem is in inconsistent state.
> +# On the fixed kernel, testcase pass.
> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/999.out b/tests/generic/999.out
> new file mode 100644
> index 00000000..3b276ca8
> --- /dev/null
> +++ b/tests/generic/999.out
> @@ -0,0 +1,2 @@
> +QA output created by 999
> +Silence is golden
> -- 
> 2.20.1
> 

