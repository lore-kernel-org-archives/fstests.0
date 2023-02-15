Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C30C636D4
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Feb 2023 14:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjBOOYz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 15 Feb 2023 09:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBOOYy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 15 Feb 2023 09:24:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7599623861
        for <fstests@vger.kernel.org>; Wed, 15 Feb 2023 06:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676471050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jSIKkot8QTaKRSc9LAyx2lDHIDveDMhL+xYOW2MFkz0=;
        b=Tj8fdqQGB5tmhFj3eGY3VILlx4fcm/Gok7mUtdHIIaYJ+/EE9DsTlh2GwaBZlbZ15ETlz1
        wk6K2MPtpvrF1hbxJRSKATnjjvLeTXdxQVS4HzNYmNSKypaAOiGiGz+OXhWAF1ZcGb+Zfu
        ZBpJUBMETHV4e2WAnzEjimKveFyXGeg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-97-0qltDCLWPCqlSF9vvDvpxw-1; Wed, 15 Feb 2023 09:24:07 -0500
X-MC-Unique: 0qltDCLWPCqlSF9vvDvpxw-1
Received: by mail-pj1-f71.google.com with SMTP id gb21-20020a17090b061500b00233c6b388ddso1123497pjb.5
        for <fstests@vger.kernel.org>; Wed, 15 Feb 2023 06:24:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSIKkot8QTaKRSc9LAyx2lDHIDveDMhL+xYOW2MFkz0=;
        b=kVyEsHLlMYCX49Z69dSZeAL/jamINQAeMkR/IdoC+l/xne9HsWa6VJvUi9IYRwelq5
         PZTun5ct5Q8Tia5/ALbC1wE3sy4aDR8gjPKP2tVBOifg7kpiVcbxkTJaRneJZcdY9kK8
         DfnuuK/MyljXgbxwlxoFOkgfMo+39Mcwaosph0VmrMmXbU6YPAiU8Qg5OTzYzu+dHVP2
         2tGJL7YXMn/9id462Zb67B4VTn2Ym+2Ojil1GA4ta72w2G3J2VUvVLWdCnoeSL6zRlif
         DOqgyT9BCEZC8YCfea6s/9syZDLzSlmWkUbrg/p2LLKuYKfCjuKfzCK6IvaF58EBPx+v
         kAvw==
X-Gm-Message-State: AO0yUKXQuQV4ei4bgSjyQPgKc1U5B7TkbaiRnjBRKN6pQ19xNbvWc5ZF
        9KlGCsp5OUXfk46sZ4C9d9FVUG/L3VenLSqAsNm5jtRT5GugJOrF+2RhVPqawg1gxeOUr6oZcqp
        oXZFS9GZ7bQ5NLfpjrij8LGsPpM9P
X-Received: by 2002:a17:902:c641:b0:19a:743e:b152 with SMTP id s1-20020a170902c64100b0019a743eb152mr1941826pls.63.1676471045906;
        Wed, 15 Feb 2023 06:24:05 -0800 (PST)
X-Google-Smtp-Source: AK7set/zjEDh12onm8Psu6/eQfyVHBWcD1SbgI/9RCVRufOgmdQtw4dt55uGvlDPFX7fiKn3Lq+6BA==
X-Received: by 2002:a17:902:c641:b0:19a:743e:b152 with SMTP id s1-20020a170902c64100b0019a743eb152mr1941809pls.63.1676471045563;
        Wed, 15 Feb 2023 06:24:05 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jf21-20020a170903269500b0019a7bb18f98sm9332476plb.48.2023.02.15.06.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 06:24:05 -0800 (PST)
Date:   Wed, 15 Feb 2023 22:24:01 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] fstests: btrfs/185, 198 and 219 add
 _fixed_by_kernel_commit
Message-ID: <20230215142401.3lkbmkpxvkhads7t@zlang-mailbox>
References: <cover.1676034764.git.anand.jain@oracle.com>
 <b0375c439b0f4d4da5de569d19bcb53bc2a0c66a.1676446803.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0375c439b0f4d4da5de569d19bcb53bc2a0c66a.1676446803.git.anand.jain@oracle.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Feb 15, 2023 at 03:51:22PM +0800, Anand Jain wrote:
> Recently, these test cases were added to the auto group. To ensure we have
> some clues if they fail in older kernels, add "_fixed_by_kernel_commit"
> for the fix and update the test summary.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---

Looks good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

> v3: Combine these patches together.
> 	fstests: btrfs/198, add _fixed_by_kernel_commit
> 	fstests: btrfs/219, add _fixed_by_kernel_commit
> 	fstests: btrfs/185, add _fixed_by_kernel_commit
>     
> v2: btrfs/219: _fixed_by_kernel_commit: Substitute the placeholder with
>     the commit id.
> 
>  tests/btrfs/185 | 2 ++
>  tests/btrfs/198 | 6 +++---
>  tests/btrfs/219 | 9 ++++-----
>  3 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/tests/btrfs/185 b/tests/btrfs/185
> index efb10ac72b79..ba0200617e69 100755
> --- a/tests/btrfs/185
> +++ b/tests/btrfs/185
> @@ -27,6 +27,8 @@ _cleanup()
>  _supported_fs btrfs
>  _require_scratch_dev_pool 2
>  _scratch_dev_pool_get 2
> +_fixed_by_kernel_commit a9261d4125c9 \
> +	"btrfs: harden agaist duplicate fsid on scanned devices"
>  
>  device_1=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
>  device_2=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
> diff --git a/tests/btrfs/198 b/tests/btrfs/198
> index 2b68754ade52..7d23ffcee3c5 100755
> --- a/tests/btrfs/198
> +++ b/tests/btrfs/198
> @@ -4,9 +4,7 @@
>  #
>  # FS QA Test 198
>  #
> -# Test stale and alien non-btrfs device in the fs devices list.
> -#  Bug fixed in:
> -#    btrfs: remove identified alien device in open_fs_devices
> +# Test outdated and foreign non-btrfs devices in the device listing.
>  #
>  . ./common/preamble
>  _begin_fstest auto quick volume
> @@ -22,6 +20,8 @@ _require_scratch
>  _require_scratch_dev_pool 4
>  # Zoned btrfs only supports SINGLE profile
>  _require_non_zoned_device ${SCRATCH_DEV}
> +_fixed_by_kernel_commit 96c2e067ed3e3e \
> +	"btrfs: skip devices without magic signature when mounting"
>  
>  workout()
>  {
> diff --git a/tests/btrfs/219 b/tests/btrfs/219
> index d69e6ac918ae..b747ce34fcc4 100755
> --- a/tests/btrfs/219
> +++ b/tests/btrfs/219
> @@ -6,11 +6,8 @@
>  #
>  # Test a variety of stale device usecases.  We cache the device and generation
>  # to make sure we do not allow stale devices, which can end up with some wonky
> -# behavior for loop back devices.  This was changed with
> -#
> -#   btrfs: allow single disk devices to mount with older generations
> -#
> -# But I've added a few other test cases so it's clear what we expect to happen
> +# behavior for loop back devices.
> +# And, added a few other test cases so it's clear what we expect to happen
>  # currently.
>  #
>  
> @@ -42,6 +39,8 @@ _supported_fs btrfs
>  _require_test
>  _require_loop
>  _require_btrfs_forget_or_module_loadable
> +_fixed_by_kernel_commit 5f58d783fd78 \
> +	"btrfs: free device in btrfs_close_devices for a single device filesystem"
>  
>  loop_mnt=$TEST_DIR/$seq.mnt
>  loop_mnt1=$TEST_DIR/$seq.mnt1
> -- 
> 2.38.1
> 

