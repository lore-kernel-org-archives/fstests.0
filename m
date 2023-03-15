Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA2EC61DA4
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Mar 2023 18:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjCOSDN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 15 Mar 2023 14:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjCOSDM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 15 Mar 2023 14:03:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F75A75A40
        for <fstests@vger.kernel.org>; Wed, 15 Mar 2023 11:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678903335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RYcleJbx/TxT/BCnM0j9HwAoearFxmWLIJsZNmjV93M=;
        b=Iixo+I4KMXqVH/P6wMOVT7+ALnuyW/vN5kMgS7uIp+AsAdxGL2YakHd0jmynj0XkUIyhNZ
        iTd6yXnleMO0mUqIb4x3Iyn1YtONAWz7YFl+0kYGVdKBDshurHMmOXGgcbguyLIfuKAgnS
        huq1I1EqYYfItdKWqzV4dU3zhBdMDnM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-0Wg3C1ORN-SnBy8VZl_Row-1; Wed, 15 Mar 2023 14:02:12 -0400
X-MC-Unique: 0Wg3C1ORN-SnBy8VZl_Row-1
Received: by mail-pj1-f72.google.com with SMTP id n8-20020a17090a2bc800b0023f06808981so808967pje.8
        for <fstests@vger.kernel.org>; Wed, 15 Mar 2023 11:02:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678903331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYcleJbx/TxT/BCnM0j9HwAoearFxmWLIJsZNmjV93M=;
        b=WdC3nXMaLQbBSZtbDG67FJgsdVTcC5Tc4Y3XBW12GApMrIFWpsDPG7+rBELpvZCqWN
         fb9ssjz05emtU8oNYfd8zY26BOgmnkaA0SHSm360jmjbkys5fwoE6oQdpBOuHSptya8J
         zitJkjxOP/UBIS2AXWZfBG9O7ou8HecToLbpUM2/yqwu1lC3M9W0NxVWPX3WnUUxx2n6
         5NP0K9FULk6wcC/V0Oqy2sg5gh105QGVBAz+IAJ98LKgIE/+0slLbAU79xZgFkYy8yNf
         0FizkZFl6jbWMxlsHvR4rVraFPYXT6a72Ym5AT1ljo1QgfRWv/acQJXYTu2AVFoKI3/w
         1FmQ==
X-Gm-Message-State: AO0yUKU/i32Oqxb7SjYV7loI7pebIhAjCoItlZZaaZHDZJfZl88lQyfG
        U8jjh9CH688pYBJ8VeqagOkW11s2dThZ0L04gd3QM4KrhqrG5DhqFIN4Hebx+WL7AjlS9iMn7kM
        g6JkLgkcyZDPv/BuHAQ==
X-Received: by 2002:a17:90b:3889:b0:23d:2b11:b39b with SMTP id mu9-20020a17090b388900b0023d2b11b39bmr595882pjb.31.1678903331598;
        Wed, 15 Mar 2023 11:02:11 -0700 (PDT)
X-Google-Smtp-Source: AK7set+qxovw7oxJ1xjb3TmzmOCoseBKgF3zpx2nBEgj1vGgQkj9pltF0Y76inZslSvyzNKehW+4PA==
X-Received: by 2002:a17:90b:3889:b0:23d:2b11:b39b with SMTP id mu9-20020a17090b388900b0023d2b11b39bmr595850pjb.31.1678903331188;
        Wed, 15 Mar 2023 11:02:11 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h14-20020a17090a9c0e00b0023d270929bbsm1659901pjp.49.2023.03.15.11.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 11:02:10 -0700 (PDT)
Date:   Thu, 16 Mar 2023 02:02:06 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] xfs: stress test cycling parent pointers with online
 repair
Message-ID: <20230315180206.3zqiiooqepiyg35c@zlang-mailbox>
References: <20230315005817.GA11360@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315005817.GA11360@frogsfrogsfrogs>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 14, 2023 at 05:58:17PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Add a couple of new tests to exercise directory and parent pointer
> repair against rename() calls moving child subdirectories from one
> parent to another.  This is a useful test because it turns out that the
> VFS doesn't lock the child subdirectory (it does lock the parents), so
> repair must be more careful.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

This patchset looks good to me.

Two questions before acking this patch:
1) The 2nd case fails [1] on mainline linux and xfsprogs, but test passed on
your djwong linux and xfsprogs repo. Is this expected? Is it a known issue
you've fixed in your repo?

2) I remember there was a patchset [1] (from your team too) about parent pointer
test half years ago. I've reviewed its 3rd version, but no more response anymore.
Just curious, do you drop that patchset ? Or you hope to send it again after
xfsprogs and kernel support that feature? If dropped, I'll remove it from my
pending list :)

Thanks,
Zorro

[1]
xfs/855 33s ... _check_xfs_filesystem: filesystem on /dev/sda3 failed health check
(see /root/git/xfstests/results//simpledev/xfs/855.full for details)
- output mismatch (see /root/git/xfstests/results//simpledev/xfs/855.out.bad)
    --- tests/xfs/855.out       2023-03-16 00:47:28.256187590 +0800
    +++ /root/git/xfstests/results//simpledev/xfs/855.out.bad   2023-03-16 01:42:25.764902276 +0800
    @@ -1,2 +1,37 @@
     QA output created by 855
    +xfs_scrub reports uncorrected errors:
    +Corruption: inode 100663424 (12/128) parent pointer: Repairs are required. (scrub.c line 190)
    +Corruption: inode 125829312 (15/192) parent pointer: Repairs are required. (scrub.c line 190)
    +xfs_scrub reports uncorrected errors:
    +Corruption: inode 117440647 (14/135) parent pointer: Repairs are required. (scrub.c line 190)
    +xfs_scrub reports uncorrected errors:
    ...
    (Run 'diff -u /root/git/xfstests/tests/xfs/855.out /root/git/xfstests/results//simpledev/xfs/855.out.bad'  to see the entire diff)
Ran: xfs/854 xfs/855
Failures: xfs/855
Failed 1 of 2 tests

[2]
[PATCH v3 0/4] xfstests: add parent pointer tests
https://lore.kernel.org/fstests/20221028215605.17973-1-catherine.hoang@oracle.com/



>  common/fuzzy      |   15 +++++++++++++++
>  tests/xfs/854     |   38 ++++++++++++++++++++++++++++++++++++++
>  tests/xfs/854.out |    2 ++
>  tests/xfs/855     |   38 ++++++++++++++++++++++++++++++++++++++
>  tests/xfs/855.out |    2 ++
>  5 files changed, 95 insertions(+)
>  create mode 100755 tests/xfs/854
>  create mode 100644 tests/xfs/854.out
>  create mode 100755 tests/xfs/855
>  create mode 100644 tests/xfs/855.out
> 
> diff --git a/common/fuzzy b/common/fuzzy
> index 4609df4434..744d9ed65d 100644
> --- a/common/fuzzy
> +++ b/common/fuzzy
> @@ -995,6 +995,20 @@ __stress_scrub_fsstress_loop() {
>  	local focus=()
>  
>  	case "$stress_tgt" in
> +	"parent")
> +		focus+=('-z')
> +
> +		# Create a directory tree very gradually
> +		for op in creat link mkdir; do
> +			focus+=('-f' "${op}=2")
> +		done
> +		focus+=('-f' 'unlink=1' '-f' 'rmdir=1')
> +
> +		# But do a lot of renames to cycle parent pointers
> +		for op in rename rnoreplace rexchange; do
> +			focus+=('-f' "${op}=40")
> +		done
> +		;;
>  	"dir")
>  		focus+=('-z')
>  
> @@ -1285,6 +1299,7 @@ __stress_scrub_check_commands() {
>  #       'writeonly': Only perform fs updates, no reads.
>  #       'symlink': Only create symbolic links.
>  #       'mknod': Only create special files.
> +#       'parent': Focus on updating parent pointers
>  #
>  #       The default is 'default' unless XFS_SCRUB_STRESS_TARGET is set.
>  # -X	Run this program to exercise the filesystem.  Currently supported
> diff --git a/tests/xfs/854 b/tests/xfs/854
> new file mode 100755
> index 0000000000..0aa2c2ee4f
> --- /dev/null
> +++ b/tests/xfs/854
> @@ -0,0 +1,38 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Oracle, Inc.  All Rights Reserved.
> +#
> +# FS QA Test No. 854
> +#
> +# Race fsstress doing mostly renames and xfs_scrub in force-repair mode for a
> +# while to see if we crash or livelock.
> +#
> +. ./common/preamble
> +_begin_fstest online_repair dangerous_fsstress_repair
> +
> +_cleanup() {
> +	cd /
> +	_scratch_xfs_stress_scrub_cleanup &> /dev/null
> +	rm -r -f $tmp.*
> +}
> +_register_cleanup "_cleanup" BUS
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/fuzzy
> +. ./common/inject
> +. ./common/xfs
> +
> +# real QA test starts here
> +_supported_fs xfs
> +_require_scratch
> +_require_xfs_stress_online_repair
> +
> +_scratch_mkfs > "$seqres.full" 2>&1
> +_scratch_mount
> +_scratch_xfs_stress_online_repair -S '-k' -x 'parent'
> +
> +# success, all done
> +echo Silence is golden
> +status=0
> +exit
> diff --git a/tests/xfs/854.out b/tests/xfs/854.out
> new file mode 100644
> index 0000000000..f8d9e27958
> --- /dev/null
> +++ b/tests/xfs/854.out
> @@ -0,0 +1,2 @@
> +QA output created by 854
> +Silence is golden
> diff --git a/tests/xfs/855 b/tests/xfs/855
> new file mode 100755
> index 0000000000..6daff05995
> --- /dev/null
> +++ b/tests/xfs/855
> @@ -0,0 +1,38 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Oracle, Inc.  All Rights Reserved.
> +#
> +# FS QA Test No. 855
> +#
> +# Race fsstress doing mostly renames and xfs_scrub in read-only mode for a
> +# while to see if we crash or livelock.
> +#
> +. ./common/preamble
> +_begin_fstest scrub dangerous_fsstress_scrub
> +
> +_cleanup() {
> +	cd /
> +	_scratch_xfs_stress_scrub_cleanup &> /dev/null
> +	rm -r -f $tmp.*
> +}
> +_register_cleanup "_cleanup" BUS
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/fuzzy
> +. ./common/inject
> +. ./common/xfs
> +
> +# real QA test starts here
> +_supported_fs xfs
> +_require_scratch
> +_require_xfs_stress_scrub
> +
> +_scratch_mkfs > "$seqres.full" 2>&1
> +_scratch_mount
> +_scratch_xfs_stress_scrub -S '-n' -x 'parent'
> +
> +# success, all done
> +echo Silence is golden
> +status=0
> +exit
> diff --git a/tests/xfs/855.out b/tests/xfs/855.out
> new file mode 100644
> index 0000000000..fa60f65432
> --- /dev/null
> +++ b/tests/xfs/855.out
> @@ -0,0 +1,2 @@
> +QA output created by 855
> +Silence is golden
> 

