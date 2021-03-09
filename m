Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA6AC433E0
	for <linux-fstests@archiver.kernel.org>; Tue,  9 Mar 2021 02:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D66FD65287
	for <linux-fstests@archiver.kernel.org>; Tue,  9 Mar 2021 02:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbhCICxa (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 8 Mar 2021 21:53:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35850 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229599AbhCICxR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 8 Mar 2021 21:53:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615258396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9mgZuqwTFXbF+rOwEKRY5lS58QYIqJVPdeGmJhL+MPc=;
        b=IEWo9SrWlWDNFsJaRnOrcKM/wVaXYOvFEjSUufT+7GAoGjFqH6rOw8KK4iPTM9ER3x6Xcy
        usnnbjZiSDqybFLFnkSGRLqa5cLY0u0ysoA8l/mm5SSpYIKy8UYhQ3uOiEZ2RyAlS0w88c
        VAn0gr1Ey+iX3SqCCDixMaVEiq3SCKE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-l9RtOS4EN12vv9b0nKICfg-1; Mon, 08 Mar 2021 21:53:14 -0500
X-MC-Unique: l9RtOS4EN12vv9b0nKICfg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B31EE10866A0;
        Tue,  9 Mar 2021 02:53:13 +0000 (UTC)
Received: from localhost (unknown [10.66.61.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B4A65D6D7;
        Tue,  9 Mar 2021 02:53:12 +0000 (UTC)
Date:   Tue, 9 Mar 2021 11:11:29 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     guan@eryu.me
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] xfstests: rename RENAME_WHITEOUT test on fs no enough
 sapce
Message-ID: <20210309031129.GD3499219@localhost.localdomain>
Mail-Followup-To: guan@eryu.me, fstests@vger.kernel.org
References: <20210308134327.345579-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308134327.345579-1-zlang@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Mar 08, 2021 at 09:43:27PM +0800, Zorro Lang wrote:
> This's a regression test for linux 6b4b8e6b4ad8 ("ext4: fix bug for
> rename with RENAME_WHITEOUT"). Rename a file with RENAME_WHITEOUT
> flag might cause corruption when there's not enough space to
> complete this renaming operation.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---

Hi Eryu,

Sorry I made a typo mistake on the patch subject, The 'sapce' should be 'space'.
If you don't mind, please help to modify it when you merge this patch. Or feel
free to tell me, if you need I re-send this patch again.

Thanks,
Zorro

> 
> Hi,
> 
> Thanks for the reviewing from Eryu. V2 did below changes:
> 1) Import ./common/renameat2 and _require_renameat2 whiteout
> 2) Replace CHUNKS with NR_FILE
> 3) Reduce the number of test files from 64*64 to 4*64
> 4) Add to quick group 
> 
> More details about the reviewing history, refer to:
> https://patchwork.kernel.org/project/fstests/patch/20210218071324.50413-1-zlang@redhat.com/
> 
> Thanks,
> Zorro
> 
>  tests/generic/626     | 74 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/626.out |  2 ++
>  tests/generic/group   |  1 +
>  3 files changed, 77 insertions(+)
>  create mode 100755 tests/generic/626
>  create mode 100644 tests/generic/626.out
> 
> diff --git a/tests/generic/626 b/tests/generic/626
> new file mode 100755
> index 00000000..1baa73f8
> --- /dev/null
> +++ b/tests/generic/626
> @@ -0,0 +1,74 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 HUAWEI.  All Rights Reserved.
> +# Copyright (c) 2021 Red Hat Inc.  All Rights Reserved.
> +#
> +# FS QA Test No. 626
> +#
> +# Test RENAME_WHITEOUT on filesystem without space to create one more inodes.
> +# This is a regression test for kernel commit:
> +#   6b4b8e6b4ad8 ("ext4: ext4: fix bug for rename with RENAME_WHITEOUT")
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
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/populate
> +. ./common/renameat2
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs generic
> +_require_scratch
> +_require_renameat2 whiteout
> +
> +_scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1
> +_scratch_mount
> +
> +# Create lots of files, to help to trigger the bug easily
> +NR_FILE=$((4 * 64))
> +for ((i=0; i<NR_FILE; i++));do
> +	touch $SCRATCH_MNT/srcfile$i
> +done
> +# Try to fill the whole fs
> +nr_free=$(stat -f -c '%f' $SCRATCH_MNT)
> +blksz="$(_get_block_size $SCRATCH_MNT)"
> +_fill_fs $((nr_free * blksz)) $SCRATCH_MNT/fill_space $blksz 0 >> $seqres.full 2>&1
> +# Use empty files to fill the rest
> +for ((i=0; i<10000; i++));do
> +	touch $SCRATCH_MNT/fill_file$i 2>/dev/null
> +	# Until no more files can be created
> +	if [ $? -ne 0 ];then
> +		break
> +	fi
> +done
> +# ENOSPC is expected here
> +for ((i=0; i<NR_FILE; i++));do
> +	$here/src/renameat2 -w $SCRATCH_MNT/srcfile$i $SCRATCH_MNT/dstfile$i >> $seqres.full 2>&1
> +done
> +_scratch_cycle_mount
> +# Expect no errors at here
> +for ((i=0; i<NR_FILE; i++));do
> +	ls -l $SCRATCH_MNT/srcfile$i >/dev/null
> +done
> +
> +echo "Silence is golden"
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/626.out b/tests/generic/626.out
> new file mode 100644
> index 00000000..130b2fef
> --- /dev/null
> +++ b/tests/generic/626.out
> @@ -0,0 +1,2 @@
> +QA output created by 626
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index 84db3789..c3448fe3 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -628,3 +628,4 @@
>  623 auto quick shutdown
>  624 auto quick verity
>  625 auto quick verity
> +626 auto quick rename enospc
> -- 
> 2.29.2
> 

