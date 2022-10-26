Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB43C433FE
	for <linux-fstests@archiver.kernel.org>; Wed, 26 Oct 2022 13:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbiJZNlw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 26 Oct 2022 09:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbiJZNli (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 Oct 2022 09:41:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A1569F44
        for <fstests@vger.kernel.org>; Wed, 26 Oct 2022 06:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666791692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GwVEhshWOwuCNpaz/eMrmBxmNYTfEepQxmQKCVu1trg=;
        b=BVyFAk+/vEVm4JPFd4is5GccwJzZStQi8VGNwEY80Txwpt0GNhV2s0P/QKp/CtUJESQkND
        TDDuClqUVmtdEND1CffzIylegkSBDV7n97l0au9BR+tv1eRv/Nr4XWstpY50XbiJIWx8R1
        AoW/Z6XisJT1Wp8tdy0oh0LlbradlZY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-527-BkvEEujuNv2dPOr5S1nZ6A-1; Wed, 26 Oct 2022 09:41:31 -0400
X-MC-Unique: BkvEEujuNv2dPOr5S1nZ6A-1
Received: by mail-qv1-f69.google.com with SMTP id l6-20020ad44446000000b004bb60364075so5871593qvt.13
        for <fstests@vger.kernel.org>; Wed, 26 Oct 2022 06:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwVEhshWOwuCNpaz/eMrmBxmNYTfEepQxmQKCVu1trg=;
        b=tK1t3tv33jEtkD9k2WnR0EVeKCXJVjTInPfYqVW4vcpN73tr6Cd0qk2vm+KqF6SkHf
         knHmbCZ9mi1YXsCUPOErtpj4wLPUgO0QRxIGX3YtbtRIZcYDpKULEK71ie+wVMSzAPMI
         d3CB1WGzj/5iFQFGfOXjEjQ3JbdhIz2Suc318ylITpA3Fu+tXgBcq1u9GgaOXb11fI/W
         fVEnRiCQO+yna5JK6jv8L8IJkKTps7TLcubQN9n5cdjztAEXd206JwkDonO6Zf1q58LO
         i+SEMdcGL/WEShfLxP8V7RrF8/c3PDRrMATlEcskZz4sClwGEhqHeNstPuevhGszYf9Q
         hunQ==
X-Gm-Message-State: ACrzQf3tgq4nHFl/hUOtXKKe1suID27vG9bxEenOw6rqOEeso8Jc7Bre
        jzXk5SaQ3uKl2nLkXX0EUMdETmfT9Ynxy5rtAEX/s4jyRlSKhJZsnhKt9LExjyA0aShf6/ymEY9
        H+3VvoTsffJEClGu8eQ==
X-Received: by 2002:ae9:e401:0:b0:6e5:291d:4073 with SMTP id q1-20020ae9e401000000b006e5291d4073mr31256157qkc.635.1666791690243;
        Wed, 26 Oct 2022 06:41:30 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7QK79LFRoaUFCUEbsgq5ndvYcVmwGGcgwn11fbF1QDW8hIhXplEwVSNSnR3v3Pl3/gWdnRAw==
X-Received: by 2002:ae9:e401:0:b0:6e5:291d:4073 with SMTP id q1-20020ae9e401000000b006e5291d4073mr31256141qkc.635.1666791689963;
        Wed, 26 Oct 2022 06:41:29 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id az19-20020a05620a171300b006ce7cd81359sm3875235qkb.110.2022.10.26.06.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 06:41:29 -0700 (PDT)
Date:   Wed, 26 Oct 2022 21:41:24 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] tests: Add missing _require_odirect from generic tests
Message-ID: <20221026134124.sxnoqy2klspcsrhz@zlang-mailbox>
References: <20221024093524.15796-1-lczerner@redhat.com>
 <20221026105847.21885-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026105847.21885-1-lczerner@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Oct 26, 2022 at 12:58:47PM +0200, Lukas Czerner wrote:
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> ---
> v2: generic/252 already has _require_odirect, remove it from patch

This version looks good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
>  tests/generic/219 | 1 +
>  tests/generic/446 | 1 +
>  tests/generic/459 | 1 +
>  tests/generic/569 | 1 +
>  tests/generic/570 | 1 +
>  tests/generic/587 | 1 +
>  6 files changed, 6 insertions(+)
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

