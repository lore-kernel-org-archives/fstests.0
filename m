Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E9AC67871
	for <linux-fstests@archiver.kernel.org>; Tue, 25 Oct 2022 02:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiJYC6x (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 24 Oct 2022 22:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJYC6v (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Oct 2022 22:58:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CA01373B0
        for <fstests@vger.kernel.org>; Mon, 24 Oct 2022 19:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666666695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D0+jZUIzPSz0wqUftqhBmhR+krTMx39jFmpR+H76iic=;
        b=JokXynLCdU+KK9WfJuHbHefTeUc6K9qE1VxY3ImumcCazGT+TawEEx/LxklYpmsBMS4Ubk
        ZJGwGd0be5Dq9j4ZnEoEv5kWuETySmaUoB3HC7c0OuX9OJDn0tbZajRvQk88P9YZGclyFC
        J5XRP+rzzMQAJ0ZDlkgfdXRnKooJnC8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-416-p9OOJJDfMW6r6ZvabanCjA-1; Mon, 24 Oct 2022 22:58:08 -0400
X-MC-Unique: p9OOJJDfMW6r6ZvabanCjA-1
Received: by mail-qk1-f199.google.com with SMTP id f12-20020a05620a408c00b006ced53b80e5so10496074qko.17
        for <fstests@vger.kernel.org>; Mon, 24 Oct 2022 19:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0+jZUIzPSz0wqUftqhBmhR+krTMx39jFmpR+H76iic=;
        b=U2ujbWtnI4bKTha9KanRAr7vWXpoidS19EeqCAZa0Z43ALTRpLHhDBsFDMQmgyx+gU
         dIVHamd6T55msxJFOI2mpSkJmUxk61QE5Ig2ggg/K3wgwdEwEZyaJx+W2ODDT0bfPCXv
         AflSTfFxDwYnDP23Q1F7pE9OEXSinLEDEoX+xOfz59EXUyUv200028MeipJoGTK0d5j7
         L/UV9w3TzGgs7typQga5Q8STt1Ib6/EhS8lqCVA9ATxyATgLLMrqyh3YJuGQ6sFiWMKF
         lmg23OVaQc/ORBeamhiQjar1HPauzLJmdpkbMDjmp6vlajxdOCpM2jzlmDX5daesJdMJ
         3BmA==
X-Gm-Message-State: ACrzQf1rZ1vMhGfKkttDBO0GdvHu+cwRTe7SH6novyLWmf5s9Jqy3s2o
        j0H7OajvEuKgPBrXMNQ4D0ssIaM4vuV7VD0Wjo3W0ObyLEcqk2eshpNed4xA5wEwy84SVkGmsQj
        xYAJRbMgFjRHe3s3j6g==
X-Received: by 2002:ac8:5ac1:0:b0:39a:123c:9df5 with SMTP id d1-20020ac85ac1000000b0039a123c9df5mr29317959qtd.27.1666666686792;
        Mon, 24 Oct 2022 19:58:06 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5ZuQ2s3ljsXOtFdrxAVrznx7IzpPPZgsinwxc/N422myBoktqDvt/tWhf4hrbInJOwXn/Axg==
X-Received: by 2002:ac8:5ac1:0:b0:39a:123c:9df5 with SMTP id d1-20020ac85ac1000000b0039a123c9df5mr29317947qtd.27.1666666686296;
        Mon, 24 Oct 2022 19:58:06 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id t1-20020a05620a004100b006ee957439f2sm1069081qkt.133.2022.10.24.19.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 19:58:05 -0700 (PDT)
Date:   Tue, 25 Oct 2022 10:58:01 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] tests: Add missing _require_odirect from generic tests
Message-ID: <20221025025801.ade33zwn5qiosnsc@zlang-mailbox>
References: <20221024093524.15796-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024093524.15796-1-lczerner@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Oct 24, 2022 at 11:35:24AM +0200, Lukas Czerner wrote:
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> ---
>  tests/generic/219 | 1 +
>  tests/generic/252 | 1 +
>  tests/generic/446 | 1 +
>  tests/generic/459 | 1 +
>  tests/generic/569 | 1 +
>  tests/generic/570 | 1 +
>  tests/generic/587 | 1 +
>  7 files changed, 7 insertions(+)
> 
> diff --git a/tests/generic/219 b/tests/generic/219
> index d3d257f1..71da25e3 100755
> --- a/tests/generic/219
> +++ b/tests/generic/219
> @@ -20,6 +20,7 @@ _require_scratch
>  _require_quota
>  _require_user
>  _require_group
> +_require_odirect
>  
>  test_files()
>  {
> diff --git a/tests/generic/252 b/tests/generic/252
> index 8c5adb53..b35833ba 100755
> --- a/tests/generic/252
> +++ b/tests/generic/252
> @@ -27,6 +27,7 @@ _require_scratch
>  _require_dm_target error
>  _require_xfs_io_command "falloc"
>  _require_aiodio "aiocp"
> +_require_odirect

I think this's a duplication, due to _require_aiodio already contains
the _require_odirect. Do you hit any failure on this test?

Others make sense to me.

Thanks,
Zorro

>  AIO_TEST="$here/src/aio-dio-regress/aiocp"
>  
>  # Disable the scratch rt device to avoid test failures relating to the rt
> diff --git a/tests/generic/446 b/tests/generic/446
> index 5f2d2edd..b69502cb 100755
> --- a/tests/generic/446
> +++ b/tests/generic/446
> @@ -21,6 +21,7 @@ _begin_fstest auto quick rw punch
>  _require_scratch
>  _require_xfs_io_command "truncate"
>  _require_xfs_io_command "fpunch"
> +_require_odirect
>  
>  # format and mount
>  _scratch_mkfs > $seqres.full 2>&1
> diff --git a/tests/generic/459 b/tests/generic/459
> index 7be39089..4dd7a43b 100755
> --- a/tests/generic/459
> +++ b/tests/generic/459
> @@ -47,6 +47,7 @@ _require_dm_target snapshot
>  _require_command $LVM_PROG lvm
>  _require_command "$THIN_CHECK_PROG" thin_check
>  _require_freeze
> +_require_odirect
>  
>  vgname=vg_$seq
>  lvname=lv_$seq
> diff --git a/tests/generic/569 b/tests/generic/569
> index c5dcfefe..eeaf3f16 100755
> --- a/tests/generic/569
> +++ b/tests/generic/569
> @@ -25,6 +25,7 @@ _supported_fs generic
>  _require_xfs_io_command "falloc"
>  _require_test_program swapon
>  _require_scratch_swapfile
> +_require_odirect
>  
>  _scratch_mkfs > $seqres.full 2>&1
>  _scratch_mount >> $seqres.full 2>&1
> diff --git a/tests/generic/570 b/tests/generic/570
> index 126b222d..2143c742 100755
> --- a/tests/generic/570
> +++ b/tests/generic/570
> @@ -25,6 +25,7 @@ _supported_fs generic
>  _require_test_program swapon
>  _require_scratch_nocheck
>  _require_block_device $SCRATCH_DEV
> +_require_odirect
>  # We cannot create swap on a zoned device because it can cause random write IOs
>  _require_non_zoned_device "$SCRATCH_DEV"
>  test -e /dev/snapshot && _notrun "userspace hibernation to swap is enabled"
> diff --git a/tests/generic/587 b/tests/generic/587
> index 19b047ac..ebfeea1d 100755
> --- a/tests/generic/587
> +++ b/tests/generic/587
> @@ -25,6 +25,7 @@ _require_user
>  _require_quota
>  _require_xfs_io_command "falloc"
>  _require_scratch
> +_require_odirect
>  
>  cat > $tmp.awk << ENDL
>  {
> -- 
> 2.37.3
> 

