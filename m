Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82796E772A7
	for <linux-fstests@archiver.kernel.org>; Thu,  5 Oct 2023 16:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbjJEQHB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 5 Oct 2023 12:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235616AbjJEQEz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 5 Oct 2023 12:04:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3CB4680
        for <fstests@vger.kernel.org>; Thu,  5 Oct 2023 07:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696516160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zxq28Ot4hQwMCF4bplBPtW8AxzWQ0vN05e7Cv8VyD/o=;
        b=N5h563p6KG6wQxxcbuB7EB9gh371Y8cuGzay+dr80LN1jVilzoQc73/WaQ+u0y4do1w5WK
        wkCLrSbXyTxEPqeGAywD0l6ezXu5LEkxQdXj1fUW4U8ivpzX4HHiiLkadWBL0e/XCq/aq+
        og/K0m4+DPKTm4u8L/ADMHaG50toWlM=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-NruKcVMLOESRsGha0aA99Q-1; Thu, 05 Oct 2023 10:29:18 -0400
X-MC-Unique: NruKcVMLOESRsGha0aA99Q-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1c74e099ba9so8855675ad.1
        for <fstests@vger.kernel.org>; Thu, 05 Oct 2023 07:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696516156; x=1697120956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zxq28Ot4hQwMCF4bplBPtW8AxzWQ0vN05e7Cv8VyD/o=;
        b=LPrCu66RHimlMlMPhu4wZGsc8OW1i5VISf7CFMTKdEx+tfot4MlBpobWOtxkGPoO81
         hQbvL2mXkT+b1U6gZac3wuuNHNqKf+oP0XwEFylcX8/Piu31hgWdyW6YJB2viURekduy
         deYm3pHasVQuVpypdEM3IlevhwVmlnn4vqd3IkvjLinec5aZHWsRyJvlxwRy5GZfhLcA
         vBut2wahMpJqrrQro1BPWZDaOOK0gk2d7vB9cZZMHpMxxWGDbXeMiRSWMDAHyzOehjO/
         3lslfgNO4H0NII1pUou0VYH6BbLXAa2dqYPBD1ff/bZ59oRRqTJvxw2uq968xsfJSvf2
         O0HA==
X-Gm-Message-State: AOJu0YwmqTEPMt56OR7D0uzZ9ja7ujPcw8QbOGj6xYhyqUYWzOgZMRwJ
        /nx+AqmxT44Bo2wRYSX/0SdJHGBCdB1kmP92uPHC5gfEBXxnr9dcwCPXBXQYfMAPBTi9+FyWGqH
        YfqzTpvPNIZZs4Vtq6w==
X-Received: by 2002:a17:902:868e:b0:1c3:3c91:61cc with SMTP id g14-20020a170902868e00b001c33c9161ccmr5211780plo.13.1696516155918;
        Thu, 05 Oct 2023 07:29:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE53o4JP2TBiTaPeQRG8/tta0j+byJTSdO49sEKd7wj58kFkDI9sKcJFpgaVu+GoZDmUGfGTw==
X-Received: by 2002:a17:902:868e:b0:1c3:3c91:61cc with SMTP id g14-20020a170902868e00b001c33c9161ccmr5211763plo.13.1696516155581;
        Thu, 05 Oct 2023 07:29:15 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ja10-20020a170902efca00b001c731b62403sm1736412plb.218.2023.10.05.07.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 07:29:15 -0700 (PDT)
Date:   Thu, 5 Oct 2023 22:29:11 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs test scan but not register the single device fs
Message-ID: <20231005142911.edxcwtwnvywq4dn6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <7f8e18168419ce6f89faddd3eea2611b53dac67d.1695891643.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f8e18168419ce6f89faddd3eea2611b53dac67d.1695891643.git.anand.jain@oracle.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Sep 28, 2023 at 05:01:30PM +0800, Anand Jain wrote:
> Recently, in the kernel commit 0d9436739af2 ("btrfs: scan but don't
> register device on single device filesystem"), we adopted an approach
> where we scan the device to validate it. However, we do not register
> it in the kernel memory since it is not required to be remembered.
> 
> However, the seed device should continue to be registered because
> otherwise, the mount operation for the sprout device will fail.
> 
> This patch ensures that we honor the mount requirements and do not break
> anything while making changes in this part of the code.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tests/btrfs/298     | 53 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/298.out |  2 ++
>  2 files changed, 55 insertions(+)
>  create mode 100755 tests/btrfs/298
>  create mode 100644 tests/btrfs/298.out
> 
> diff --git a/tests/btrfs/298 b/tests/btrfs/298
> new file mode 100755
> index 000000000000..1d10d27c1354
> --- /dev/null
> +++ b/tests/btrfs/298
> @@ -0,0 +1,53 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 298
> +#
> +#   Check if the device scan registers for a single-device seed and drops
> +#  it from the kernel if it is eventually marked as non-seed.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick seed
> +
> +_supported_fs btrfs
> +_require_command "$BTRFS_TUNE_PROG" btrfstune
> +_require_scratch_dev_pool 2
> +_scratch_dev_pool_get 1
> +_spare_dev_get
> +
> +$WIPEFS_PROG -a $SCRATCH_DEV

_require_command "$WIPEFS_PROG" wipefs

> +$WIPEFS_PROG -a $SPARE_DEV
> +
> +echo "#setup seed sprout device" >> $seqres.full
> +_scratch_mkfs "-b 300M" >> $seqres.full 2>&1

Better to with "|| _fail "....."", if we give specific options to _scratch_mkfs.

Others look good to me, if no more review points from others, I'll merge
this patch with above changes, and with

Reviewed-by: Zorro Lang <zlang@redhat.com>

> +$BTRFS_TUNE_PROG -S 1 $SCRATCH_DEV
> +_scratch_mount >> $seqres.full 2>&1
> +$BTRFS_UTIL_PROG device add $SPARE_DEV $SCRATCH_MNT
> +_scratch_unmount
> +$BTRFS_UTIL_PROG device scan --forget
> +
> +echo "#Scan seed device and check using mount" >> $seqres.full
> +$BTRFS_UTIL_PROG device scan $SCRATCH_DEV >> $seqres.full
> +_mount $SPARE_DEV $SCRATCH_MNT
> +umount $SCRATCH_MNT
> +
> +echo "#check again, ensures seed device still in kernel" >> $seqres.full
> +_mount $SPARE_DEV $SCRATCH_MNT
> +umount $SCRATCH_MNT
> +
> +echo "#Now scan of non-seed device makes kernel forget" >> $seqres.full
> +$BTRFS_TUNE_PROG -f -S 0 $SCRATCH_DEV >> $seqres.full 2>&1
> +$BTRFS_UTIL_PROG device scan $SCRATCH_DEV >> $seqres.full
> +
> +echo "#Sprout mount must fail for missing seed device" >> $seqres.full
> +_mount $SPARE_DEV $SCRATCH_MNT > /dev/null 2>&1
> +[[ $? == 32 ]] || _fail "mount failed to fail"
> +
> +_spare_dev_put
> +_scratch_dev_pool_put
> +
> +# success, all done
> +echo Silence is golden
> +status=0
> +exit
> diff --git a/tests/btrfs/298.out b/tests/btrfs/298.out
> new file mode 100644
> index 000000000000..634342678f11
> --- /dev/null
> +++ b/tests/btrfs/298.out
> @@ -0,0 +1,2 @@
> +QA output created by 298
> +Silence is golden
> -- 
> 2.39.3
> 

