Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E651C4338F
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Aug 2021 04:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47411610CF
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Aug 2021 04:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhHSEye (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 Aug 2021 00:54:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40023 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229840AbhHSEyd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 Aug 2021 00:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629348837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DYUR2yrRBDOoqdaGfM0jUoL4Nv+fDfxlMLBm1iQy4og=;
        b=ObKyEc6UgW1G+YSZbO/Nat8oJr3y7Ey7a8jAN8cH9nj2eZ/8/RQr9RkMhoRmtf16ySQz0d
        O6/laAwj8JHk1eXQj/rsIRU7mVLiAOezpFlHvXuzi+z8JMRZXo4n+dGgntOKbkbsDDqodF
        flAGlm4bAaRdg27MkzCIILesG7eQHkM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-uxwaV7PuOeqn2cOljNKB-w-1; Thu, 19 Aug 2021 00:53:56 -0400
X-MC-Unique: uxwaV7PuOeqn2cOljNKB-w-1
Received: by mail-pj1-f69.google.com with SMTP id j6-20020a17090ac486b0290178ffdbd20dso2535198pjt.0
        for <fstests@vger.kernel.org>; Wed, 18 Aug 2021 21:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=DYUR2yrRBDOoqdaGfM0jUoL4Nv+fDfxlMLBm1iQy4og=;
        b=MHLvlh7N3pjGZh2mhdaJ22c9JUMylUcl6ewKHQGlrwEVWrXSRer21uZiHUjlWpsLfG
         FldtJSKNlGX+H21k55q3zeNuRv5XGLC1y234tflcJkO2ScnZu9WIBRdOHQTwpTae8Ksh
         w8eXWdIlIMwSTpFid/ybNHmpfXvxhIDutUMkNGBipTEg2huGqjcjTpFWKplTJdQ/00TZ
         9YNGHiXv3QBZu27ojaapV4/MdUZcet4feukQ/GkzEyoGuiZBVHNqCdE3XrBhgoAWp6Cc
         XHa/dY6Z5zvIc3lcGp9W/Gyj/hMm0rzTikV7hHmEuJ6qr0FK7q3vhUXpAcoYQ+nAs6Av
         7ViA==
X-Gm-Message-State: AOAM532bJunVdlivVn7p4efnQ91hl8I0krplf08q3Dh8TdfdsytrXP5p
        wGks/I3mFADYn6K1fdYsoiExFKjwx0Y+RUIxaIpd1ImsJdFk+EIl5FbKcnnUXZyA7Oj4PssFsDm
        EQYJPmV2UPVy7JG3jwQ==
X-Received: by 2002:a17:902:690a:b0:12d:86cf:d981 with SMTP id j10-20020a170902690a00b0012d86cfd981mr10233116plk.39.1629348835425;
        Wed, 18 Aug 2021 21:53:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTwlPzBxgGrKGY60dayzMAHDaDEDhpkimgsYFVvJXjtkvG82QRU9WAYTDsbNJJ2qLzpmLh9A==
X-Received: by 2002:a17:902:690a:b0:12d:86cf:d981 with SMTP id j10-20020a170902690a00b0012d86cfd981mr10233102plk.39.1629348835165;
        Wed, 18 Aug 2021 21:53:55 -0700 (PDT)
Received: from fedora ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id r3sm1478297pff.119.2021.08.18.21.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 21:53:54 -0700 (PDT)
Date:   Thu, 19 Aug 2021 13:14:31 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Xu Yu <xuyu@linux.alibaba.com>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, hch@infradead.org, riteshh@linux.ibm.com,
        tytso@mit.edu, gavin.dg@linux.alibaba.com,
        fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] generic: add swapfile maxpages regression test
Message-ID: <20210819051431.z3q46fswvkwnwmgn@fedora>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
        Xu Yu <xuyu@linux.alibaba.com>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, hch@infradead.org, riteshh@linux.ibm.com,
        tytso@mit.edu, gavin.dg@linux.alibaba.com,
        fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <db99c25a8e2a662046e498fd13e5f0c35364164a.1629286473.git.xuyu@linux.alibaba.com>
 <20210819014326.GC12597@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819014326.GC12597@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Aug 18, 2021 at 06:43:26PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Add regression test for "mm/swap: consider max pages in
> iomap_swapfile_add_extent".
> 
> Cc: Gang Deng <gavin.dg@linux.alibaba.com>
> Cc: Xu Yu <xuyu@linux.alibaba.com>
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

The code logic looks good to me. And [1][2]... so I think this test
is good. But of course, wait for more review points from cc list.

Reviewed-by: Zorro Lang <zlang@redhat.com>

[1]
Test passed on old kernel without this regression (xfs fails):

# ./check generic/727                                                                                                                    
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 xx-xxxx-xx 4.18.0-xxx.el8.x86_64+debug #1 SMP Wed Jul 14 12:35:49 EDT 2021
MKFS_OPTIONS  -- /dev/mapper/rhel-xx-xxxx-xx-xfscratch
MOUNT_OPTIONS -- -o acl,user_xattr -o context=system_u:object_r:root_t:s0 /dev/mapper/rhel-xx-xxxx-xx-xfscratch /mnt/scratch

generic/727      15s
Ran: generic/727
Passed all 1 tests

[2]
Reproduced on new kernel with this regression:

# ./check generic/727
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 xxx-xxxx-xx 5.14.0-rc4-xfs #14 SMP Thu Aug 12 00:56:07 CST 2021
MKFS_OPTIONS  -- /dev/mapper/testvg-scratchdev
MOUNT_OPTIONS -- -o acl,user_xattr -o context=system_u:object_r:root_t:s0 /dev/mapper/testvg-scratchdev /mnt/scratch

generic/727     - output mismatch (see /root/git/xfstests-dev/results//generic/727.out.bad)
    --- tests/generic/727.out   2021-08-19 11:20:14.677794743 +0800
    +++ /root/git/xfstests-dev/results//generic/727.out.bad     2021-08-19 11:21:46.654450307 +0800
    @@ -1,2 +1,3 @@
     QA output created by 727
    +swapon added 2044 pages, expected 1020
     Silence is golden
    ...
    (Run 'diff -u /root/git/xfstests-dev/tests/generic/727.out /root/git/xfstests-dev/results//generic/727.out.bad'  to see the entire diff)
Ran: generic/727
Failures: generic/727
Failed 1 of 1 tests

>  tests/generic/727     |   62 +++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/727.out |    2 ++
>  2 files changed, 64 insertions(+)
>  create mode 100755 tests/generic/727
>  create mode 100644 tests/generic/727.out
> 
> diff --git a/tests/generic/727 b/tests/generic/727
> new file mode 100755
> index 00000000..a546ad51
> --- /dev/null
> +++ b/tests/generic/727
> @@ -0,0 +1,62 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 727
> +#
> +# Regression test for "mm/swap: consider max pages in iomap_swapfile_add_extent"
> +
> +# Xu Yu found that the iomap swapfile activation code failed to constrain
> +# itself to activating however many swap pages that the mm asked us for.  This
> +# is an deviation in behavior from the classic swapfile code.  It also leads to
> +# kernel memory corruption if the swapfile is cleverly constructed.
> +#
> +. ./common/preamble
> +_begin_fstest auto swap
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +	test -n "$swapfile" && swapoff $swapfile &> /dev/null
> +}
> +
> +# real QA test starts here
> +_supported_fs generic
> +_require_scratch_swapfile
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount >> $seqres.full
> +
> +# Assuming we're not borrowing a FAT16 partition from Windows 3.1, we need an
> +# unlikely enough name that we can grep /proc/swaps for this.
> +swapfile=$SCRATCH_MNT/386spart.par
> +_format_swapfile $swapfile 1m >> $seqres.full
> +
> +swapfile_pages() {
> +	local swapfile="$1"
> +
> +	grep "$swapfile" /proc/swaps | awk '{print $3}'
> +}
> +
> +_swapon_file $swapfile
> +before_pages=$(swapfile_pages "$swapfile")
> +swapoff $swapfile
> +
> +# Extend the length of the swapfile but do not rewrite the header.
> +# The subsequent swapon should set up 1MB worth of pages, not 2MB.
> +$XFS_IO_PROG -f -c 'pwrite 1m 1m' $swapfile >> $seqres.full
> +
> +_swapon_file $swapfile
> +after_pages=$(swapfile_pages "$swapfile")
> +swapoff $swapfile
> +
> +# Both swapon attempts should have found the same number of pages.
> +test "$before_pages" -eq "$after_pages" || \
> +	echo "swapon added $after_pages pages, expected $before_pages"
> +
> +# success, all done
> +echo Silence is golden
> +status=0
> +exit
> diff --git a/tests/generic/727.out b/tests/generic/727.out
> new file mode 100644
> index 00000000..2de2b4b2
> --- /dev/null
> +++ b/tests/generic/727.out
> @@ -0,0 +1,2 @@
> +QA output created by 727
> +Silence is golden
> 

