Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51567CDB465
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Oct 2023 17:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbjJSRuu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 Oct 2023 13:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbjJSRut (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 Oct 2023 13:50:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3884112
        for <fstests@vger.kernel.org>; Thu, 19 Oct 2023 10:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697737807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vBo9qNbCaq1aaCu5iL2pH64UNqxb4qts6lg0w0QBmFo=;
        b=i5WKkH1500+mV0kO6oflGmwPg2kj+TUPzappTqVsJQFWmQEsMQ4rtlZsUQKzFN4WOuy5+C
        EescIyZU8zV4thrs/WkErdo4OQDTVaMdp53PKpNV+PFf04TQV+FDd0NvbAvG1r6dQxYZ6u
        imSq2+IuJoN9HqlSMWyp1LOJsmNorZM=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443--o3Ld6YQMrChYG5qf5BjpA-1; Thu, 19 Oct 2023 13:50:05 -0400
X-MC-Unique: -o3Ld6YQMrChYG5qf5BjpA-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6927dfe8c75so5949289b3a.2
        for <fstests@vger.kernel.org>; Thu, 19 Oct 2023 10:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697737804; x=1698342604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBo9qNbCaq1aaCu5iL2pH64UNqxb4qts6lg0w0QBmFo=;
        b=bF2CQqfH7Y8Gv6k51jeA25XODZBV6Vz+wsdDFWWI7HAzoRr4VQD35zgeG7bfheOigt
         WW0RN4WSklnnYO/qw4IztplU+bWtCVaBm6TQrwOF2EFG+AKdNKuZre2iZEwYMBJTXfGl
         DJeixVFh6XnIVMNC2WVp8LnVzV70N7YefJi9kPgvrZtNao2NhRQwDravngjOK+AMjBJJ
         fkdSfa5S0FzRrw0wwynMGyJTAek2JCdZDd4q537A3n60bVoMii2zVrNn2kjWeFyLP1Sp
         AePMDovIRoaLzlu8/0kngflFzkBFGmYLyZODU+661+7HQ50vSrU91p2PMCgK5mdJSCWm
         ZO5Q==
X-Gm-Message-State: AOJu0YzLiLFg1D9lnTs/CzatRfh7VHdJXuhYk6LR8/pvz5Xr4Oa+8hTe
        HfOSDgiBIrj8P7hVPrU7GQNDy15MdecL0pe38lwQgpKJsgY9dKMso0b12o1/CN78oS6TqQ9LtHo
        kkvz1ihsTVtU4R51d1c0Ivsv4yC5PA/c=
X-Received: by 2002:a62:5e05:0:b0:690:2e46:aca3 with SMTP id s5-20020a625e05000000b006902e46aca3mr2655170pfb.25.1697737804278;
        Thu, 19 Oct 2023 10:50:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElCM1XB2p4gMZ5FzxcJOztpLN0XaelBrX2WyLiATG8BeT6hMiLS/TvRvuajkFaf7BH9r28Fw==
X-Received: by 2002:a62:5e05:0:b0:690:2e46:aca3 with SMTP id s5-20020a625e05000000b006902e46aca3mr2655154pfb.25.1697737803865;
        Thu, 19 Oct 2023 10:50:03 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id w18-20020aa78592000000b006b1ded40f36sm60636pfn.216.2023.10.19.10.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 10:50:03 -0700 (PDT)
Date:   Fri, 20 Oct 2023 01:50:00 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: [PATCH] overlay: add test for lowerdir mount option parsing
Message-ID: <20231019175000.afv2b5fma3ttkt4v@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20231017101145.2348571-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017101145.2348571-1-amir73il@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Oct 17, 2023 at 01:11:45PM +0300, Amir Goldstein wrote:
> Check parsing and display of spaces and escaped colons and commans in
> lowerdir mount option.
> 
> This is a regression test for two bugs introduced in v6.5 with the
> conversion to new mount api.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Zorro,
> 
> This is a test for two regressions in kernel v6.5.
> The two fixes were merged in 6.6-rc6 and have been picked for
> the upcoming LTS 6.5.y release.


> 
> Thanks,
> Amir.
> 
>  tests/overlay/083     | 54 +++++++++++++++++++++++++++++++++++++++++++
>  tests/overlay/083.out |  2 ++
>  2 files changed, 56 insertions(+)
>  create mode 100755 tests/overlay/083
>  create mode 100644 tests/overlay/083.out
> 
> diff --git a/tests/overlay/083 b/tests/overlay/083
> new file mode 100755
> index 00000000..071b4b84
> --- /dev/null
> +++ b/tests/overlay/083
> @@ -0,0 +1,54 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2023 CTERA Networks. All Rights Reserved.
> +#
> +# FS QA Test 083
> +#
> +# Test regressions in parsing and display of special chars in mount options.
> +#
> +# The following kernel commits from v6.5 introduced regressions:
> +#  b36a5780cb44 ("ovl: modify layer parameter parsing")
> +#  1784fbc2ed9c ("ovl: port to new mount api")
> +#
> +
> +. ./common/preamble
> +_begin_fstest auto quick mount
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +_supported_fs overlay
> +_fixed_by_kernel_commit 32db51070850 \
> +	"ovl: fix regression in showing lowerdir mount option"
> +_fixed_by_kernel_commit c34706acf40b \
> +	"ovl: fix regression in parsing of mount options with escaped comma"

Hi Amir,

I tried this case on the latest linux kernel which contains the
two commits, but still hit below failure:

FSTYP         -- overlay
PLATFORM      -- Linux/x86_64 hp-dl380pg8-01 6.6.0-rc6-mainline+ #7 SMP PREEMPT_DYNAMIC Thu Oct 19 22:34:28 CST 2023
MKFS_OPTIONS  -- /mnt/scratch
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /mnt/scratch /mnt/scratch/ovl-mnt

overlay/083       - output mismatch (see /root/git/xfstests/results//overlay/083.out.bad)
    --- tests/overlay/083.out   2023-10-19 14:07:18.099496414 +0800
    +++ /root/git/xfstests/results//overlay/083.out.bad 2023-10-20 00:25:47.682874383 +0800
    @@ -1,2 +1,4 @@
     QA output created by 083
    +mount: /mnt/scratch/ovl-mnt: special device ovl_esc_test does not exist.
    +       dmesg(1) may have more information after failed mount system call.
     Silence is golden

Thanks,
Zorro

> +
> +# _overlay_check_* helpers do not handle special chars well
> +_require_scratch_nocheck
> +
> +# Remove all files from previous tests
> +_scratch_mkfs
> +
> +# Create lowerdirs with special characters
> +lowerdir1="$OVL_BASE_SCRATCH_MNT/lower1 with  spaces"
> +lowerdir2="$OVL_BASE_SCRATCH_MNT/lower2:with::colons"
> +lowerdir3="$OVL_BASE_SCRATCH_MNT/lower3,with,,commas"
> +lowerdir2_esc="$OVL_BASE_SCRATCH_MNT/lower2\:with\:\:colons"
> +lowerdir3_esc="$OVL_BASE_SCRATCH_MNT/lower3\,with\,\,commas"
> +upperdir=$OVL_BASE_SCRATCH_MNT/$OVL_UPPER
> +workdir=$OVL_BASE_SCRATCH_MNT/$OVL_WORK
> +mkdir -p "$lowerdir1" "$lowerdir2" "$lowerdir3"
> +
> +# _overlay_mount_* helpers do not handle special chars well, so execute mount directly.
> +# if escaped colons and commas are not parsed correctly, mount will fail.
> +$MOUNT_PROG -t overlay ovl_esc_test $SCRATCH_MNT \
> +	-o"upperdir=$upperdir,workdir=$workdir,lowerdir=$lowerdir3_esc:$lowerdir2_esc:$lowerdir1"
> +
> +# if spaces are not escaped when showing mount options,
> +# mount command will not show the word 'spaces' after the spaces
> +$MOUNT_PROG -t overlay | grep ovl_esc_test  | tee -a $seqres.full | grep -v spaces
> +
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/overlay/083.out b/tests/overlay/083.out
> new file mode 100644
> index 00000000..0beba309
> --- /dev/null
> +++ b/tests/overlay/083.out
> @@ -0,0 +1,2 @@
> +QA output created by 083
> +Silence is golden
> -- 
> 2.34.1
> 

