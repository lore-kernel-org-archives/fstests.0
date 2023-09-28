Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F445CE7AF8
	for <linux-fstests@archiver.kernel.org>; Thu, 28 Sep 2023 03:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjI1DnB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 27 Sep 2023 23:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjI1Dm7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Sep 2023 23:42:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F27F1A2
        for <fstests@vger.kernel.org>; Wed, 27 Sep 2023 20:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695872530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VmTiX+0/+aFN8cFt5h57GNILP7gRG2Ts9XjKchIAyGk=;
        b=TvlDkiMHNCKWpp4KAPEkNm0qaIqERD+FT2aCSJqYI6g5qM9zC22Swtof5J4w3VQXXCNPH8
        E/8NRaL3NBORACktPbbEqd5GKlJm9RSX0E02uQTtX+0QmAML8ec45SGfyn5Lqg04x9CLS3
        v3dqyKBF81M4cjQOfACh5NJ5LqEzIL8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-V5mlnFMlMd6kkP-Xgcs2Zg-1; Wed, 27 Sep 2023 23:42:09 -0400
X-MC-Unique: V5mlnFMlMd6kkP-Xgcs2Zg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2775642edfcso9561539a91.0
        for <fstests@vger.kernel.org>; Wed, 27 Sep 2023 20:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695872528; x=1696477328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmTiX+0/+aFN8cFt5h57GNILP7gRG2Ts9XjKchIAyGk=;
        b=Uhdqxf2SM/rHrT//fnRGCGzVx0RNTfqAlgTrZmBCDKIu4JbvLRT55p6ucs5U8ywoAh
         sfCubySFeMMnl/Z7rbDBZbb11lBgwwjQHRuCRoxg3eIeKMAUSHH60/+VkNbkPhf+iqk1
         cpBFl+olsoXI33JT4T32nWJRCe1Kq3SmYRE5npRGekm0VUGQeGneuawAcj0CGAYM0KjM
         KXBKI/qD+A5bG4ZgllKFVj8XiD/GxZKM37psbnuFk8KTCG1iDNhtDtv04xOrEHbcv0ps
         gVv/xM4wQDupLmbpWx1KqrPVRrifjjUYd953sjJ0XYPG11OknQ//ZAheivi2ZHdkClAU
         8fAQ==
X-Gm-Message-State: AOJu0YyJoS1BrBbeLHH0gGoOR8jaKuhSE1bPVoFcLzdILmu4ZTYbS5yf
        dNdIOqMI87jOOQx81S9Fe3OXJcnVW5SkbE06tJdcCednb0F3PYYQpzMcR8roJhTdP+JiJf4mhfL
        GY52j/qIi39Up37rmvQ==
X-Received: by 2002:a17:90b:908:b0:268:7be6:29a5 with SMTP id bo8-20020a17090b090800b002687be629a5mr69057pjb.9.1695872528170;
        Wed, 27 Sep 2023 20:42:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVWjmUi3fcWivC4xa1ZTR1pwE/OGC4EbBW67iSreLcD3ERXyUWgKaBVIDMc2Rj1qphXnuRxg==
X-Received: by 2002:a17:90b:908:b0:268:7be6:29a5 with SMTP id bo8-20020a17090b090800b002687be629a5mr69046pjb.9.1695872527818;
        Wed, 27 Sep 2023 20:42:07 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id m6-20020a17090a414600b00274a9f8e82asm2821466pjg.51.2023.09.27.20.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 20:42:07 -0700 (PDT)
Date:   Thu, 28 Sep 2023 11:42:04 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCHv2 2/2] generic: Add integrity tests with synchronous
 directio
Message-ID: <20230928034204.htefxfkdobn3d5e4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <3b86ab1f1447f0b6db88d4dfafe304fd04ae2b11.1695469920.git.ritesh.list@gmail.com>
 <3c21207848460ffe8aab734b32c1c2464049296c.1695469920.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c21207848460ffe8aab734b32c1c2464049296c.1695469920.git.ritesh.list@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Sep 23, 2023 at 05:30:24PM +0530, Ritesh Harjani (IBM) wrote:
> This test covers data & metadata integrity check with directio with
> o_sync flag and checks the file contents & size after sudden fileystem
> shutdown once the directio write is completed. ext4 directio after iomap
> conversion was broken in the sense that if the FS crashes after
> synchronous directio write, it's file size is not properly updated.
> This test adds a testcase to cover such scenario.
> 
> Man page of open says that -
> O_SYNC provides synchronized I/O file integrity completion, meaning write
> operations will flush data and all associated metadata to the underlying
> hardware



> 
> Reported-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  tests/generic/471     | 50 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/471.out | 22 +++++++++++++++++++
>  2 files changed, 72 insertions(+)
>  create mode 100755 tests/generic/471
>  create mode 100644 tests/generic/471.out
> 
> diff --git a/tests/generic/471 b/tests/generic/471

The generic/471 has been taken last week, you can choose another number.
Or simply use generic/999, then I'll change the 999 to a proper number.

> new file mode 100755
> index 00000000..218e6676
> --- /dev/null
> +++ b/tests/generic/471
> @@ -0,0 +1,50 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 IBM Corporation.  All Rights Reserved.
> +#
> +# FS QA Test 471
> +#
> +# Integrity test for O_SYNC with buff-io, dio, aio-dio with sudden shutdown
> +#
> +. ./common/preamble
> +_begin_fstest auto quick shutdown aio
> +
> +# real QA test starts here
> +_supported_fs generic

Is the bug fix be reviewed and acked now? If it is, please use _fixed_by_kernel_commit
at here. The commit id can be "xxxxxxxxxxxx" if it's not merged by acked.

> +_require_scratch
> +_require_scratch_shutdown
> +_require_odirect

Due to you add aio test in v2, so this line should be: _require_aiodio

> +_require_aiodio aio-dio-write-verify
> +
> +_scratch_mkfs > $seqres.full 2>&1
> +_scratch_mount
> +
> +echo "T-1: Create a 1M file using buff-io & O_SYNC"
> +$XFS_IO_PROG -fs -c "pwrite -S 0x5a 0 1M" $SCRATCH_MNT/testfile.t1 > /dev/null 2>&1
> +echo "T-1: Shutdown the fs suddenly"
> +_scratch_shutdown
> +echo "T-1: Cycle mount"
> +_scratch_cycle_mount
> +echo "T-1: File contents after cycle mount"
> +_hexdump $SCRATCH_MNT/testfile.t1
> +
> +echo "T-2: Create a 1M file using O_DIRECT & O_SYNC"
> +$XFS_IO_PROG -fsd -c "pwrite -S 0x5a 0 1M" $SCRATCH_MNT/testfile.t2 > /dev/null 2>&1
> +echo "T-2: Shutdown the fs suddenly"
> +_scratch_shutdown
> +echo "T-2: Cycle mount"
> +_scratch_cycle_mount
> +echo "T-2: File contents after cycle mount"
> +_hexdump $SCRATCH_MNT/testfile.t2
> +
> +echo "T-3: Create a 1M file using AIO-DIO & O_SYNC"
> +$AIO_TEST -a size=1048576 -S -N $SCRATCH_MNT/testfile.t3 > /dev/null 2>&1

So you just need aio-dio-write-verify.c to do aio write. Maybe we can have aio
read and write support in xfs_io in one day:)

Thanks,
Zorro


> +echo "T-3: Shutdown the fs suddenly"
> +_scratch_shutdown
> +echo "T-3: Cycle mount"
> +_scratch_cycle_mount
> +echo "T-3: File contents after cycle mount"
> +_hexdump $SCRATCH_MNT/testfile.t3
> +
> +status=0
> +exit
> diff --git a/tests/generic/471.out b/tests/generic/471.out
> new file mode 100644
> index 00000000..2bfb033d
> --- /dev/null
> +++ b/tests/generic/471.out
> @@ -0,0 +1,22 @@
> +QA output created by 471
> +T-1: Create a 1M file using buff-io & O_SYNC
> +T-1: Shutdown the fs suddenly
> +T-1: Cycle mount
> +T-1: File contents after cycle mount
> +000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
> +*
> +100000
> +T-2: Create a 1M file using O_DIRECT & O_SYNC
> +T-2: Shutdown the fs suddenly
> +T-2: Cycle mount
> +T-2: File contents after cycle mount
> +000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
> +*
> +100000
> +T-3: Create a 1M file using AIO-DIO & O_SYNC
> +T-3: Shutdown the fs suddenly
> +T-3: Cycle mount
> +T-3: File contents after cycle mount
> +000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
> +*
> +100000
> -- 
> 2.41.0
> 

