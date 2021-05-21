Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C262AC47076
	for <linux-fstests@archiver.kernel.org>; Fri, 21 May 2021 15:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98420613E4
	for <linux-fstests@archiver.kernel.org>; Fri, 21 May 2021 15:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhEUPQE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 21 May 2021 11:16:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230420AbhEUPQD (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 21 May 2021 11:16:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BA09613CB;
        Fri, 21 May 2021 15:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621610080;
        bh=7yVKfryXsVOPLqJlBw9jiMwSD/AWC6thwWadt4bfIE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=soRiZXiMeU9lZObMD05gsnAjjDoaIEm+1iibKlR0EAMtuGWCate0Ha/uk3djwljYK
         bIdtKFtSkzvVYzVY10SDmgZKKBd9g7uv5Fr0E5SYZmMPfnt7RrxmXl590mnNmMM697
         U2213YmEGZVXjiwxG0kCSplg8vpPAF81nVGVsVBjRuY72AvI+XodJhd6vZQDL47dk5
         owWcxMoK/+0L7yChcZGbqWWL51IZl5rOQ2E4XLdP7uSmVw9wzZ0Cnal+ar2I4+EXOg
         IXk4KNS1RGfyhcmpAaLPMUhJR7aw+FkxZXsnlrIHnepXNG1j8fqA+x4J1Y88Oj0dK/
         S5274Zkus3trQ==
Date:   Fri, 21 May 2021 08:14:40 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     chenlong <chenlongcl.chen@huawei.com>
Cc:     fstests@vger.kernel.org, guaneryu@gmail.com, tytso@mit.edu
Subject: Re: [PATCH v3] ext4/048: Add new regression test
Message-ID: <20210521151440.GH9648@magnolia>
References: <20210521120038.139848-1-chenlongcl.chen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210521120038.139848-1-chenlongcl.chen@huawei.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, May 21, 2021 at 08:00:38PM +0800, chenlong wrote:
> Check the block group zero and prevent initializing reserved inodes.
> But in some special cases, the reserved inode may not all belong to
> the group zero, it may exist into the second group if we format 
> filesystem below.
> mkfs.ext4 -b 4096 -g 8192 -N 1024 -I 4096 /dev/sda
> So, it will end up triggering a false positive report of a corrupted
> file system
> 
> It's a regression test for commit a149d2a5cabb.
> 
> Signed-off-by: Chen Long <chenlongcl.chen@huawei.com>
> ---
>  tests/ext4/048     | 60 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/048.out |  5 ++++
>  tests/ext4/group   |  1 +
>  3 files changed, 66 insertions(+)
>  create mode 100755 tests/ext4/048
>  create mode 100644 tests/ext4/048.out
> 
> diff --git a/tests/ext4/048 b/tests/ext4/048
> new file mode 100755
> index 00000000..fbbd229a
> --- /dev/null
> +++ b/tests/ext4/048
> @@ -0,0 +1,60 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 Huawei.  All Rights Reserved.
> +#
> +# FS QA Test 048
> +#
> +# Regression test for commit:
> +# a149d2a5cabb(ext4: fix check to prevent false positive report of incorrect
> +# used inodes)
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +    cd /
> +    rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs ext4
> +_require_scratch
> +
> +# default sleep interval
> +sleep_time=5
> +
> +echo "+ create scratch fs"
> +_scratch_mkfs_ext4 -b 4096 -g 8192 -N 1024 -I 4096 >> $seqres.full 2>&1
> +
> +echo "+ mount fs"
> +_scratch_mount -o errors=remount-ro
> +# The default maximum wake-up delay of the lazy init thread of ext4 is
> +# EXT4_DEF_LI_MAX_START_DELAY (5s).
> +# After mounting the file system, the lazy init thread will be awakened to
> +# perform group initialization at 0~5s after the current time. If an error
> +# is detected during the initialization process, it will be set to read-only,
> +# so the test case needs to delay a little while waiting for the init thread
> +# to execute.
> +sleep $sleep_time
> +
> +echo "+ check mountpoint status"
> +cat /proc/self/mounts | grep -w ${SCRATCH_MNT} | \
> +    $AWK_PROG '{print $4}' | grep -oE '^rw,' | tee -a $seqres.full

Er, sorry to be a pain yet again, but I think the critical part of the
above line is checking that the mount is still in read-write mode,
correct?

If that's the case, couldn't this test check the writability of the
mountpoint?  e.g.

test -w $SCRATCH_MNT || echo "scratch mount should still be writable"

(Or is there some other complication here, such as a crashed ext4 fs
will return EROFS and then `test' does the wrong thing, hence the manual
check of /proc/self/mounts?)

--D

> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/ext4/048.out b/tests/ext4/048.out
> new file mode 100644
> index 00000000..16e50e86
> --- /dev/null
> +++ b/tests/ext4/048.out
> @@ -0,0 +1,5 @@
> +QA output created by 048
> ++ create scratch fs
> ++ mount fs
> ++ check mountpoint status
> +rw,
> diff --git a/tests/ext4/group b/tests/ext4/group
> index ceda2ba6..82b77efb 100644
> --- a/tests/ext4/group
> +++ b/tests/ext4/group
> @@ -50,6 +50,7 @@
>  045 auto dir
>  046 auto prealloc quick
>  047 auto quick dax
> +048 auto quick
>  271 auto rw quick
>  301 aio auto ioctl rw stress defrag
>  302 aio auto ioctl rw stress defrag
> -- 
> 2.18.0.huawei.25
> 
