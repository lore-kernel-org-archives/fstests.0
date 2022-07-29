Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED5EC00144
	for <linux-fstests@archiver.kernel.org>; Fri, 29 Jul 2022 18:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbiG2SWq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 29 Jul 2022 14:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiG2SWp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 29 Jul 2022 14:22:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9839745057
        for <fstests@vger.kernel.org>; Fri, 29 Jul 2022 11:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659118963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VNWhmZoUZjJIpagEq2CDqSrvSr/sBhwgkq3aQaRTHWM=;
        b=NvfViqnmTEX4PN7D5+ZSDo+8b09M6DDhjBLbyH4yDv8xFBjeqGNCo3i94G1jXyFtxQDeZl
        dXcbIleAQvFzmpUCbMtQ+ygC1sgPykUwT6JPK2Il9rocR7o1n2owuNSUFCXP6yea6A/2pJ
        oXiULcOKljj8DgtOHpdTTRn/Z6UZIhk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-62-ZrO3srQwMjyIzYDUWjA5WQ-1; Fri, 29 Jul 2022 14:22:42 -0400
X-MC-Unique: ZrO3srQwMjyIzYDUWjA5WQ-1
Received: by mail-qt1-f197.google.com with SMTP id a18-20020a05622a02d200b0031ed7ae9abeso3305597qtx.8
        for <fstests@vger.kernel.org>; Fri, 29 Jul 2022 11:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VNWhmZoUZjJIpagEq2CDqSrvSr/sBhwgkq3aQaRTHWM=;
        b=YDnY300ds9UKlX02qevVr1DyP1j3b6/k4ycCOeHHwGohaXL9N7qFwXLcOQSp92TvT7
         Bdc/WKq4r+GvmXpqWZCnZQYmg846GJ+f9K9zOe5mJN5uPVATBqF7EMP3hX4QpMCZ6lIU
         IpE6hMuE53ruX0fNmjvg2DE86s9zixjiqqHOOa9dWORvWsMy/X7+POH4ccyK9ayBIJdw
         njhnAdeyOGvg4Qsrr+NVR4Ez5uFpmo7d3xx7GS630uU5ltMjK09X8We5s73CHEzhvRKA
         Swi6IpvC8gBUn8mJcuupwj5KR31uRAxr1z6+crt+vlbxnb1PhN1YAjpcr/T1c9/CtJUG
         2Tig==
X-Gm-Message-State: AJIora9cW+2agjVhiH6ZnwfXzH9QxNxIp16KIlHWdSWnEFrpPIAU5HLP
        mGnBk4tLoN8a93OFzBk3Umy+Ovl+9kgfJG8RSS+BdLcvJ8TEF/KJ8BbR18yFIE756hOJlhLsvJE
        Qxce9jpR0nLAVlOmQRg==
X-Received: by 2002:a37:5fc4:0:b0:6b5:ec2b:93e6 with SMTP id t187-20020a375fc4000000b006b5ec2b93e6mr3706351qkb.693.1659118961497;
        Fri, 29 Jul 2022 11:22:41 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u5OWpYRofAoBzGN2STPZmPDUhr+GRvLEj1EYRpHTL5FrfOd/TyaB2/fcGaXWamiz9OBtyhUA==
X-Received: by 2002:a37:5fc4:0:b0:6b5:ec2b:93e6 with SMTP id t187-20020a375fc4000000b006b5ec2b93e6mr3706335qkb.693.1659118961190;
        Fri, 29 Jul 2022 11:22:41 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v13-20020a05622a014d00b0031ef366c9b5sm2771847qtw.34.2022.07.29.11.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 11:22:40 -0700 (PDT)
Date:   Sat, 30 Jul 2022 02:22:35 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v3 3/3] xfs: add memory failure test for
 partly-reflinked&dax file
Message-ID: <20220729182235.2uchnrqcnizwwnlp@zlang-mailbox>
References: <20220520013534.2894233-1-ruansy.fnst@fujitsu.com>
 <20220520013534.2894233-4-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520013534.2894233-4-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, May 20, 2022 at 09:35:34AM +0800, Shiyang Ruan wrote:
> Verify that dax-rmap works for both normal extent and shared extent.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  tests/xfs/902     | 52 +++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/902.out |  9 ++++++++
>  2 files changed, 61 insertions(+)
>  create mode 100755 tests/xfs/902
>  create mode 100644 tests/xfs/902.out
> 
> diff --git a/tests/xfs/902 b/tests/xfs/902
> new file mode 100755
> index 00000000..85ae07a1
> --- /dev/null
> +++ b/tests/xfs/902
> @@ -0,0 +1,52 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 902
> +#
> +# Test memory failure mechanism when dax and reflink working together
> +#   test for partly reflinked file
> +#

Hi Shiyang,

I'd like to merge this patchset now, but I just noticed these 3 new cases
doesn't have Copyright announce, so I hope to double check with you that
if you intend to drop Copyright line?

If so, I'll merge directly, or please tell me what Copyright do you want
to use, or send a new version with your Copyright (and RVB from Darrick).

Thanks,
Zorro

> +. ./common/preamble
> +_begin_fstest auto quick clone dax
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/reflink
> +
> +# real QA test starts here
> +_require_check_dmesg
> +_require_scratch_reflink
> +_require_xfs_scratch_rmapbt
> +_require_scratch_dax_mountopt "dax"
> +_require_test_program "t_mmap_cow_memory_failure"
> +
> +echo "Format and mount"
> +_scratch_mkfs > $seqres.full 2>&1
> +_scratch_mount "-o dax" >> $seqres.full 2>&1
> +
> +testdir=$SCRATCH_MNT/test-$seq
> +mkdir $testdir
> +
> +echo "Create the original files"
> +nr=16
> +blksz=$(get_page_size)
> +_pwrite_byte 0x61 0 $((blksz * nr)) $testdir/testfile >> $seqres.full
> +_pwrite_byte 0x62 0 $((blksz * nr)) $testdir/poisonfile >> $seqres.full
> +seq 0 2 $((nr - 1)) | while read i; do
> +	_reflink_range $testdir/testfile $((blksz * i)) \
> +		$testdir/poisonfile $((blksz * i)) $blksz >> $seqres.full
> +done
> +_scratch_cycle_mount "dax"
> +
> +echo "Inject memory failure (1 page)"
> +$here/src/t_mmap_cow_memory_failure -s1 -S1 -R $testdir/testfile -P $testdir/poisonfile
> +
> +echo "Inject memory failure (2 pages)"
> +# poison on reflinked page and not reflinked page
> +$here/src/t_mmap_cow_memory_failure -s2 -S2 -R $testdir/testfile -P $testdir/poisonfile
> +
> +_check_dmesg_for "Sending SIGBUS to t_mmap_cow_memo" || echo "Memory failure didn't kill the process"
> +_check_dmesg_for "recovery action for dax page: Recovered" || echo "Failured page didn't recovered"
> +
> +# success, all done
> +status=0
> diff --git a/tests/xfs/902.out b/tests/xfs/902.out
> new file mode 100644
> index 00000000..3c055d54
> --- /dev/null
> +++ b/tests/xfs/902.out
> @@ -0,0 +1,9 @@
> +QA output created by 902
> +Format and mount
> +Create the original files
> +Inject memory failure (1 page)
> +Inject poison...
> +Process is killed by signal: 7
> +Inject memory failure (2 pages)
> +Inject poison...
> +Process is killed by signal: 7
> -- 
> 2.35.1
> 
> 
> 

