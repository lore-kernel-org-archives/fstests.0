Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA242C4332F
	for <linux-fstests@archiver.kernel.org>; Sun, 16 Oct 2022 06:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJPG7h (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 16 Oct 2022 02:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiJPG7e (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 16 Oct 2022 02:59:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D1A11174
        for <fstests@vger.kernel.org>; Sat, 15 Oct 2022 23:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665903568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qn1p5fEX5nt1sUIWH4HJcxqLn8tZ0oqwU2IZhU77mRU=;
        b=hkvOk9fZU6rpQ4XN/hyn1oNxThxf2IYUoTMKXPW4n2ZOTS8y3CcisOp4Qo+Rz68uZOFZHg
        scqa2+uFJUJFAUcj+EzRoOfqJSE6EyVU2VtQqksh9FtR+Lmu2Wdz7Ch6YJR8sCegvOriUN
        yQGoW2WlXEvv46OtBc2NZ9r6rEwJbfE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-557-ahnvKnPHNUS8_yREMMIDUg-1; Sun, 16 Oct 2022 02:59:27 -0400
X-MC-Unique: ahnvKnPHNUS8_yREMMIDUg-1
Received: by mail-qk1-f200.google.com with SMTP id j13-20020a05620a410d00b006e08208eb31so7028148qko.3
        for <fstests@vger.kernel.org>; Sat, 15 Oct 2022 23:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qn1p5fEX5nt1sUIWH4HJcxqLn8tZ0oqwU2IZhU77mRU=;
        b=vgpRdqwh3ARBfUo+eNYwDZTAK6cYzHs8M5SNBnvOA2G+2HEuHNrUAvuS2hitNYo4dF
         I5BJbzSOCkvotYRWy+pky1KXGGajB+8swBhznKwxR0l8e1596RuNkNUO36+Cv6H91yRu
         HaX9abpBVzscBgqblcxm3MInnoUZI+MpKBVVUlp0LwTgwV4ydmaEOjERGcBnUSbEVZeL
         vl70DKZGXoizsWoq7Otr2ZvB8gPYxN7TAxmQy3e5lwx8cyUnR4tDmDErhBfKkIfLaBNS
         nltqeBScrzzm724iz45Re4P01qXZnlNfXVSBAb/62hBx3zbP7Ei65fXe3jXISdZh1R5z
         t39w==
X-Gm-Message-State: ACrzQf3IZLFSgwpTq4VJzBClLaztFukvxgjfowNWXNqV+8BBsnM61goS
        ky1ezh2QnbM/HsT0R170M/Q+1xOi7xucOTzMtGMA/pSwFWDBeUd9TvEAUgVbtXvN1M/QILKSnTL
        Sgh/uNXdkPuqxd9N7zt4HrjT6g5403cZ5NgKb5c1pDksNZKDW4nwBoQFlxHjUeoNNOQ==
X-Received: by 2002:a0c:f2ca:0:b0:4b1:8b7d:8e78 with SMTP id c10-20020a0cf2ca000000b004b18b7d8e78mr4194335qvm.5.1665903565989;
        Sat, 15 Oct 2022 23:59:25 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6IZvpnLxqWz5yczL0uXTo2xxkBtGHH1288Xgzb/i0PdVMphGsQTBlHMPULLB+EjyzW0O32EA==
X-Received: by 2002:a0c:f2ca:0:b0:4b1:8b7d:8e78 with SMTP id c10-20020a0cf2ca000000b004b18b7d8e78mr4194323qvm.5.1665903565632;
        Sat, 15 Oct 2022 23:59:25 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id s21-20020a05620a29d500b006bb78d095c5sm6631076qkp.79.2022.10.15.23.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Oct 2022 23:59:24 -0700 (PDT)
Date:   Sun, 16 Oct 2022 14:59:20 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] fstests: get section config after RUN_SECTION checks
Message-ID: <20221016065920.xx3msld5xi3hiq7f@zlang-mailbox>
References: <f214d554b294bd3d2515742ad3bd7eeeab4d361f.1661369519.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f214d554b294bd3d2515742ad3bd7eeeab4d361f.1661369519.git.josef@toxicpanda.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Aug 24, 2022 at 03:32:10PM -0400, Josef Bacik wrote:
> While trying to do
> 
> ./check -s <some section>
> 
> I was failing because I had a section defined higher than <some section>
> that had TEST_DEV=/some/nonexistent/device, since I was using the other
> section to test an experimental drive.  This appears to be because we
> run through all of the sections, and when getting the section config we
> check to see if it's valid, and in this case the section wasn't valid.
> 
> The section I was actually trying to use was valid however.  Fix check
> to see if the section we're trying to run is in our list of sections to
> run first, and then if it is get the config at that point.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---

This patch looks good to me, and I did a little testing on it, for example[1].
But I know other people might use section config in many different ways, so I
keep this patch here for several weeks, and no any objection for now. So I'd
like to merge this patch now, please feel free to tell me if anyone get problems
after having this change.

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

[1]
# cat local.config
[default]
export TEST_DEV=/dev/sda5
export TEST_DIR=/mnt/test
export SCRATCH_MNT=/mnt/scratch

[simpledev]
SCRATCH_DEV_POOL=""
export SCRATCH_DEV=/dev/sda3

[pooldev]
SCRATCH_DEV=""
export SCRATCH_DEV_POOL="/dev/mapper/testvg-scratchdev1 /dev/mapper/testvg-scratchdev2 /dev/mapper/testvg-scratchdev3 /dev/mapper/testvg-scratchdev4 /dev/mapper/testvg-scratchdev5"

[logdev]
SCRATCH_DEV_POOL=""
export SCRATCH_DEV=/dev/sda3
export USE_EXTERNAL=yes
export SCRATCH_LOGDEV=/dev/loop0

# ./check -s logdev xfs/001
SECTION       -- logdev
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 hp-dl380pg8-01 5.18.0-rc2+ #2 SMP PREEMPT_DYNAMIC Mon May 16 16:36:31 CST 2022
MKFS_OPTIONS  -- -f -llogdev=/dev/loop0 /dev/sda3
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 -ologdev=/dev/loop0 /dev/sda3 /mnt/scratch

xfs/001 9s ...  8s
Ran: xfs/001
Passed all 1 tests

# ./check -s simpledev -s pooldev -s logdev xfs/001
SECTION       -- simpledev
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 hp-dl380pg8-01 5.18.0-rc2+ #2 SMP PREEMPT_DYNAMIC Mon May 16 16:36:31 CST 2022
MKFS_OPTIONS  -- -f /dev/sda3   
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sda3 /mnt/scratch

xfs/001 7s ...  7s
Ran: xfs/001
Passed all 1 tests

SECTION       -- pooldev
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 hp-dl380pg8-01 5.18.0-rc2+ #2 SMP PREEMPT_DYNAMIC Mon May 16 16:36:31 CST 2022
MKFS_OPTIONS  -- -f /dev/mapper/testvg-scratchdev1
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/mapper/testvg-scratchdev1 /mnt/scratch

xfs/001 7s ...  6s
Ran: xfs/001
Passed all 1 tests

SECTION       -- logdev
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 hp-dl380pg8-01 5.18.0-rc2+ #2 SMP PREEMPT_DYNAMIC Mon May 16 16:36:31 CST 2022
MKFS_OPTIONS  -- -f -llogdev=/dev/loop0 /dev/sda3
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 -ologdev=/dev/loop0 /dev/sda3 /mnt/scratch

xfs/001 6s ...  9s
Ran: xfs/001
Passed all 1 tests

xfs/001 6s ...  9s
Ran: xfs/001
Passed all 1 tests

SECTION       -- simpledev
=========================
Ran: xfs/001
Passed all 1 tests

SECTION       -- pooldev
=========================
Ran: xfs/001
Passed all 1 tests

SECTION       -- logdev
=========================
Ran: xfs/001
Passed all 1 tests

>  check | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/check b/check
> index 0b2f10ed..ad0ab3cf 100755
> --- a/check
> +++ b/check
> @@ -678,7 +678,6 @@ function run_section()
>  
>  	OLD_FSTYP=$FSTYP
>  	OLD_TEST_FS_MOUNT_OPTS=$TEST_FS_MOUNT_OPTS
> -	get_next_config $section
>  
>  	# Do we need to run only some sections ?
>  	if [ ! -z "$RUN_SECTION" ]; then
> @@ -708,6 +707,8 @@ function run_section()
>  		fi
>  	fi
>  
> +	get_next_config $section
> +
>  	mkdir -p $RESULT_BASE
>  	if [ ! -d $RESULT_BASE ]; then
>  		echo "failed to create results directory $RESULT_BASE"
> -- 
> 2.26.3
> 

