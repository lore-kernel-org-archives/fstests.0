Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A6AC32772
	for <linux-fstests@archiver.kernel.org>; Tue, 23 Aug 2022 16:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244396AbiHWQ1a (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 23 Aug 2022 12:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244610AbiHWQ1F (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 23 Aug 2022 12:27:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6F2119116
        for <fstests@vger.kernel.org>; Tue, 23 Aug 2022 05:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661259163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tk0oq1WpSbdmQDVEWY+PGB7M5+hJ0X72rzDD6CbajPQ=;
        b=hqjN8k3eTOo3c/AI5NXIT9dWIjf6b0QwvBXbd8kBIdYW7jaWcpNah1UQAfCSDNc+R2nAQ/
        AxfsY3xJvT0SlKxsYHuH2Hg+7hsxabIeN1GxGDLpsCTE4cR7pLIjElhwQP7tJxW4Meg6yy
        XWiEWeivw6fUHudggPbB1XrrflBclOc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-372-MopIMvYkNyC7nRBlSpzsNA-1; Tue, 23 Aug 2022 08:52:42 -0400
X-MC-Unique: MopIMvYkNyC7nRBlSpzsNA-1
Received: by mail-qt1-f199.google.com with SMTP id cj19-20020a05622a259300b003446920ea91so10541534qtb.10
        for <fstests@vger.kernel.org>; Tue, 23 Aug 2022 05:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=tk0oq1WpSbdmQDVEWY+PGB7M5+hJ0X72rzDD6CbajPQ=;
        b=2eIt25q20QEKE5i+U5DdJsf2FfWQTbIpp5IGdA7eWxlz7DKfLqnh+68dEQTrVXx8gB
         iCe3Pb0yVwdGCehEj3cfPjrxai9ZyEVAP2sJJ752HWKiQXBsmKAxSWNu3WY4n6DPr47R
         l+xK/sLKDgo5lkKVu1Nhcjz9IeInNp7EC/sMyIJsaIo7imVnP18jQ4REbmNCeWch9537
         n1nBh//PaV3uwj7Ywu1UhZlXnsDmszTh9VvkAB5AS+42kBYYD9OMQycO0UzgyaT4Ktq9
         oCoQjAca76yWa9Dn1DxBCvzNIi87d1spOw25lCXiVv3SNsFrRdcW5YW2nzZ7CwNjmbOU
         Q1xA==
X-Gm-Message-State: ACgBeo0Lt/39U0gmHCeb0w6gAdPXuBd2OUfMPwzhb9+MPCl5y7wQYo/8
        akueWDCOwFa1dFLWC/vXqO5eb64vddoQCsH2F8WzGV43lc2GUr1jl0sqE6Eo5jrL/KPdxMN811I
        QhXrRXCp1sUepav8qew==
X-Received: by 2002:a05:620a:a1e:b0:6bc:192c:1268 with SMTP id i30-20020a05620a0a1e00b006bc192c1268mr6278194qka.732.1661259161918;
        Tue, 23 Aug 2022 05:52:41 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4SToSCYryIKAWbvL7hdVrvJb1BzI+nCy6W3N4K/egcxKj/1Og1rzQFKilOkGBai9M7SQ7+2Q==
X-Received: by 2002:a05:620a:a1e:b0:6bc:192c:1268 with SMTP id i30-20020a05620a0a1e00b006bc192c1268mr6278176qka.732.1661259161608;
        Tue, 23 Aug 2022 05:52:41 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id bm30-20020a05620a199e00b006bb11f9a859sm12749176qkb.122.2022.08.23.05.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 05:52:41 -0700 (PDT)
Date:   Tue, 23 Aug 2022 20:52:34 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     bingjingc <bingjingc@synology.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.orgto,
        fdmanana@kernel.org, bxxxjxxg@gmail.com
Subject: Re: [PATCH v2] fstests: btrfs: test incremental send for changed
 reference paths
Message-ID: <20220823125234.j5mlgzbbq4pmvfub@zlang-mailbox>
References: <20220822004932.1280053-1-bingjingc@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822004932.1280053-1-bingjingc@synology.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Aug 22, 2022 at 08:49:32AM +0800, bingjingc wrote:
> From: BingJing Chang <bingjingc@synology.com>
> 
> Normally btrfs stores file paths in an array of ref items. However, items
> for the same parent directory can not exceed the size of a leaf. So btrfs
> also store the rest of them in extended ref items alternatively.
> 
> In this test, it creates a large number of links under a directory causing
> the file paths stored in these two ways to be the parent snapshot. And it
> deletes and recreates just an amount of them that can be stored within an
> array of ref items to be the send snapshot. Test that an incremental send
> operation correctly issues link/unlink operations only against new/deleted
> paths, or the receive operation will fail due to a link on an existed path.
> 
> This currently fails on btrfs but is fixed by a kernel patch with the
> commit 3aa5bd367fa5a3 ("btrfs: send: fix sending link commands for
> existing file paths")
> 
> Signed-off-by: BingJing Chang <bingjingc@synology.com>
> ---
>  tests/btrfs/272     | 97 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/272.out |  3 ++
>  2 files changed, 100 insertions(+)
>  create mode 100755 tests/btrfs/272
>  create mode 100644 tests/btrfs/272.out
> 
> diff --git a/tests/btrfs/272 b/tests/btrfs/272
> new file mode 100755
> index 00000000..e1986de9
> --- /dev/null
> +++ b/tests/btrfs/272
> @@ -0,0 +1,97 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 BingJing Chang.
> +#
> +# FS QA Test No. btrfs/272
> +#
> +# Regression test for btrfs incremental send issue where a link instruction
> +# is sent against an existing path, causing btrfs receive to fail.
> +#
> +# This issue is fixed by the following linux kernel btrfs patch:
> +#
> +#   commit 3aa5bd367fa5a3 ("btrfs: send: fix sending link commands for
> +#   existing file paths")

As Filipe said, welcome to use _fixed_by_kernel_commit and others related
functions for a known regression test.

> +#
> +. ./common/preamble
> +_begin_fstest auto quick send
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	cd /
> +	rm -fr $send_files_dir

Will things in $send_files_dir take much disk space? If not, we can keep it
in $TEST_DIR (then remove this specific _cleanup), generally we don't need
to keep $TEST_DIR clean (except it will affect later testing).

> +	rm -f $tmp.*
> +}
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +_supported_fs btrfs
> +_require_test
> +_require_scratch
> +_require_fssum
> +
> +send_files_dir=$TEST_DIR/btrfs-test-$seq
> +
> +rm -fr $send_files_dir
> +mkdir $send_files_dir
> +
> +_scratch_mkfs > /dev/null 2>&1

What kind of stdout/stderr you need to fill out? Generally we can output it
into .full file for later debug. Anyway, I can't say this's wrong.

> +_scratch_mount
> +
> +# Create a file and 2000 hard links to the same inode
> +_run_btrfs_util_prog subvolume create $SCRATCH_MNT/vol
> +touch $SCRATCH_MNT/vol/foo
> +for i in {1..2000}; do
> +	link $SCRATCH_MNT/vol/foo $SCRATCH_MNT/vol/$i
> +done
> +
> +# Create a snapshot for a full send operation
> +_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT/vol $SCRATCH_MNT/snap1
> +_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/snap1
> +
> +# Remove 2000 hard links and re-create the last 1000 links
> +for i in {1..2000}; do
> +	rm $SCRATCH_MNT/vol/$i
> +done
> +for i in {1001..2000}; do
> +	link $SCRATCH_MNT/vol/foo $SCRATCH_MNT/vol/$i
> +done
> +
> +# Create another snapshot for an incremental send operation
> +_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2
> +_run_btrfs_util_prog send -p $SCRATCH_MNT/snap1 -f $send_files_dir/2.snap \
> +		     $SCRATCH_MNT/snap2
> +
> +$FSSUM_PROG -A -f -w $send_files_dir/1.fssum $SCRATCH_MNT/snap1
> +$FSSUM_PROG -A -f -w $send_files_dir/2.fssum \
> +	-x $SCRATCH_MNT/snap2/snap1 $SCRATCH_MNT/snap2
> +
> +# Recreate the filesystem by receiving both send streams and verify we get
> +# the same content that the original filesystem had.
> +_scratch_unmount
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount
> +
> +# Add the first snapshot to the new filesystem by applying the first send
> +# stream.
> +_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
> +
> +# The incremental receive operation below used to fail with the following
> +# error:
> +#
> +#    ERROR: link 1238 -> foo failed: File exists
> +#
> +# This is because the path "1238" was stored as an extended ref item in the
> +# original snapshot but as a normal ref item in the next snapshot. The send
> +# operation cannot handle the duplicated paths, which are stored in
> +# different ways, well, so it decides to issue a link operation for the
> +# existing path. This results in the receiver to fail with the above error.
> +_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
> +
> +$FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/snap1
> +$FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/snap2
> +
> +status=0
> +exit
> diff --git a/tests/btrfs/272.out b/tests/btrfs/272.out
> new file mode 100644
> index 00000000..b009b87a
> --- /dev/null
> +++ b/tests/btrfs/272.out
> @@ -0,0 +1,3 @@
> +QA output created by 272
> +OK
> +OK
> -- 
> 2.37.1
> 

