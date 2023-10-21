Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F71EC001E0
	for <linux-fstests@archiver.kernel.org>; Sat, 21 Oct 2023 13:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjJUNY5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 21 Oct 2023 09:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJUNY4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 21 Oct 2023 09:24:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E9DE7
        for <fstests@vger.kernel.org>; Sat, 21 Oct 2023 06:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697894648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U0ygw2vvEBmj2jhW78qox0ZhQRRmHMkEb8zFhHYSiKg=;
        b=DrjLGM1CTdg9Pjf6TX7XGne7c6LT5n9uTfzSVZdg2R79rqazblWc0dk6nvcicwsbhS9UfU
        g0/wUlZP7QrVrg/z/l+opooc52K2qfYc7fvnWda6GB4/i19oIvbvD44g2RP1C0VKXuOfGV
        QMDCmY53OWZwmi8v7LVSPck/hL29lfg=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-jbdJHO3IPraT0VfVXXtSyg-1; Sat, 21 Oct 2023 09:24:06 -0400
X-MC-Unique: jbdJHO3IPraT0VfVXXtSyg-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1e990f0629cso2637390fac.2
        for <fstests@vger.kernel.org>; Sat, 21 Oct 2023 06:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697894645; x=1698499445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0ygw2vvEBmj2jhW78qox0ZhQRRmHMkEb8zFhHYSiKg=;
        b=sdpHtkAv5OEeQqeWQR+bPmnk3DxkucXpztzzfNZhz6CTLah/H1ey4CRA9Oct9EASm5
         LXE3d83qx2/W20eC6PCTkOM77l/107Vmay/bX22tgsj29mcjl2QrOxaeatooaa+tDzoG
         s1U7KLxtLoF5wbhJQtMtg2LCX61re5x/h5cT8FOtLNIO2FybV19ZHcaVIk0gMPxK/Pyr
         4iEuUvbEoH7YvJTDwtzMWYyWf8Qa4KOcoeVYYpi/468Dn/2zsGxKC+Nm0xxSh0IXpjqe
         0G38Y8kFJPmHA0VL9S0bRq7nw/JXYf60U7IuHAnyXtC2yabgw9xS7sWyOGiDBkClvShB
         mRTA==
X-Gm-Message-State: AOJu0YyYwW0yzBgxgDOHzbqhx8lfIDppSFz2Pv1qMdZSqwint0QZTNeC
        WbXtLccxAwEeyL9MlAOARTfm3hGA14MKamTbwntmJXL0rESfdLRnpxlFg5JiIoOWQIjl9n90qrP
        Fv3SZvsXhITYQw39BCg==
X-Received: by 2002:a05:6870:1210:b0:1ea:7bd1:c48d with SMTP id 16-20020a056870121000b001ea7bd1c48dmr5266313oan.49.1697894645723;
        Sat, 21 Oct 2023 06:24:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0ExB7lqubcClDzjRYkJ+7/1PvDeQ8lcoK+G5SLNe7kv5os2l2O4azFA6ATS0OOI0Iin0t6g==
X-Received: by 2002:a05:6870:1210:b0:1ea:7bd1:c48d with SMTP id 16-20020a056870121000b001ea7bd1c48dmr5266293oan.49.1697894645399;
        Sat, 21 Oct 2023 06:24:05 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p15-20020aa7860f000000b0068fe9c7b199sm3237488pfn.105.2023.10.21.06.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 06:24:05 -0700 (PDT)
Date:   Sat, 21 Oct 2023 21:24:01 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] btrfs/298: add test for showing qgroups include staled
 sorted by path
Message-ID: <20231021132401.yczjnm34fk7lwpco@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20231009143123.9588-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009143123.9588-1-realwakka@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Oct 09, 2023 at 02:31:23PM +0000, Sidong Yang wrote:
> Test for showing qgroups include a staled qgroup list sorted by path.
> It crashed without checking qgroup has empty path. It fixed by the
> following commit in btrfs-progs:
> 
> cd7f1e48 ("btrfs-progs: qgroup: check null in comparing paths")
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
>  tests/btrfs/298     | 34 ++++++++++++++++++++++++++++++++++
>  tests/btrfs/298.out |  2 ++
>  2 files changed, 36 insertions(+)
>  create mode 100755 tests/btrfs/298
>  create mode 100644 tests/btrfs/298.out
> 
> diff --git a/tests/btrfs/298 b/tests/btrfs/298
> new file mode 100755
> index 00000000..5457423d
> --- /dev/null
> +++ b/tests/btrfs/298
> @@ -0,0 +1,34 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Sidong Yang.  All Rights Reserved.
> +#
> +# FS QA Test 298
> +#
> +# Test that showing qgourps list includes a staled qgroup without crash.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick qgroup
> +
> + . ./common/filter
> +
> +_supported_fs btrfs
> +_require_test
> +_require_scratch
> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +
> +# Create stale qgroup with creating and deleting a subvolume.
> +$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT >> $seqres.full
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a >> $seqres.full
> +$BTRFS_UTIL_PROG subvolume delete $SCRATCH_MNT/a >> $seqres.full
> +
> +# Show qgroups list with sorting path without crash.
> +$BTRFS_UTIL_PROG qgroup show --sort path $SCRATCH_MNT >> $seqres.full
> +
> +_scratch_unmount

Is the umount a necessary part of this test? If not, this step isn't needed.
The SCRATCH_DEV will be unmounted later.

Others looks good to me. I don't mind merging this case, if btrfs list
feels good to take time to run it in fstests. If no objection from btrfs, then:

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/btrfs/298.out b/tests/btrfs/298.out
> new file mode 100644
> index 00000000..63434267
> --- /dev/null
> +++ b/tests/btrfs/298.out
> @@ -0,0 +1,2 @@
> +QA output created by 298
> +Silence is golden
> -- 
> 2.34.1
> 

