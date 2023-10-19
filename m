Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E26CDB482
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Oct 2023 18:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbjJSSRH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 Oct 2023 14:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235508AbjJSSRG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 Oct 2023 14:17:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEB011D
        for <fstests@vger.kernel.org>; Thu, 19 Oct 2023 11:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697739376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PMBPL97PiJ5sy8GbZ77cqZvfHVEPat5RWY5uZUKTmoc=;
        b=Xs/+RzlRvNmgNECBzvm2+nBB7LLD1oH/K/lZZ/FuurvdHwW2421nEWs0qzUrVxfKkOYYcL
        5+tuNt+X0Lq6MjUOyLpdf8cIykUzKfjjEsO1Bwv5yJlvbZw7FyR+kpXtxJ81a7zwSqvwa9
        TB0vbn3F6xvr//ivxfQOGH1pqSg2itw=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-LweWwqR3MEWwKlxWZLMI2g-1; Thu, 19 Oct 2023 14:16:14 -0400
X-MC-Unique: LweWwqR3MEWwKlxWZLMI2g-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1c9d42aedc6so61601675ad.0
        for <fstests@vger.kernel.org>; Thu, 19 Oct 2023 11:16:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697739373; x=1698344173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMBPL97PiJ5sy8GbZ77cqZvfHVEPat5RWY5uZUKTmoc=;
        b=jvoa7djdUYwBzqNAmstHwU1SEKRbyZD6QuUZ2fw0bM/6gWGcubfZXqYL9qRokGke23
         1vynX41vRN/9CVkUnrYtCLeBVHSCH1cDLFmw8yyDZFh+28Pj46Vn3VN4AQ073kjoZOFO
         PXQCF1Ofv5zTGXDdoy4Nl8bYM1D5gBGC+3Ftvibr8iraAAuxs9Vr7dj7PWLsJignsllP
         6965D2pRvyKXO3LMsvvM7bEOaHcL0ifML9Se5AKwFdZYBpnV/dKwWJjw7eP96SV+NKyT
         i4EXytzQZ0D3rULsplibmbCnIuwGnGtKwj/AA4O/l+1HGL0tzd5Ql/TXuoFOy/RsPRCM
         WCrQ==
X-Gm-Message-State: AOJu0YyaTSBOyub4cGzn1xMppGHn7wbC+N4GiD8hoVIWzsxwlnZEriEo
        /SfE3Oc9m94mINi5gi4zpOLAbFRVRwzI/YKFPqPStxJbuB3jEv8Gb+Y/KK6BgmquMyjUGgIX6Vp
        xekzYPOi0OKI6HBXndw==
X-Received: by 2002:a17:903:2306:b0:1ca:6abe:cb37 with SMTP id d6-20020a170903230600b001ca6abecb37mr3812122plh.9.1697739373239;
        Thu, 19 Oct 2023 11:16:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOcCef8eMnUzXpO7dHbU2muBz1MQ62jXzhe09bjeOznq4AHglhm2rRTnTgyNy09FtNAfsR8g==
X-Received: by 2002:a17:903:2306:b0:1ca:6abe:cb37 with SMTP id d6-20020a170903230600b001ca6abecb37mr3812106plh.9.1697739372956;
        Thu, 19 Oct 2023 11:16:12 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902f7c700b001b8a3e2c241sm17541plw.14.2023.10.19.11.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 11:16:12 -0700 (PDT)
Date:   Fri, 20 Oct 2023 02:16:09 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] btrfs/298: fix failure when added device supports trim
Message-ID: <20231019181609.m5oi2uxsa6pqgigr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <ee1d17b6f4956c0638cb7faa6f9c92b7bf3c25ac.1697709904.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee1d17b6f4956c0638cb7faa6f9c92b7bf3c25ac.1697709904.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Oct 19, 2023 at 11:06:14AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> A btrfs device add command issues a trim on the device if the device
> supports trim, and then it outputs a message to stdout informing that it
> performed a trim. If that happens it breaks the golden output and the
> test fails like this:
> 
>    $ ./check btrfs/298
>    FSTYP         -- btrfs
>    PLATFORM      -- Linux/x86_64 debian0 6.6.0-rc3-btrfs-next-139+ #1 SMP PREEMPT_DYNAMIC Tue Oct  3 13:52:02 WEST 2023
>    MKFS_OPTIONS  -- /dev/sdc
>    MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> 
>    btrfs/298       - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/298.out.bad)
>        --- tests/btrfs/298.out	2023-10-18 23:29:06.029292800 +0100
>        +++ /home/fdmanana/git/hub/xfstests/results//btrfs/298.out.bad	2023-10-19 10:54:29.693210881 +0100
>        @@ -1,2 +1,3 @@
>         QA output created by 298
>        +Performing full device TRIM /dev/sdd (100.00GiB) ...
>         Silence is golden
>        ...
>        (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/298.out /home/fdmanana/git/hub/xfstests/results//btrfs/298.out.bad'  to see the entire diff)
>    Ran: btrfs/298
>    Failures: btrfs/298
>    Failed 1 of 1 tests
> 
> Fix this by redirecting the device add's stdout to the $seqres.full file.
> Any device add errors are sent to stderr, so we'll notice if errors happen
> due to possible future regressions, as it will break the golden output.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/298 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/298 b/tests/btrfs/298
> index d5536cf3..0cea81d0 100755
> --- a/tests/btrfs/298
> +++ b/tests/btrfs/298
> @@ -25,7 +25,7 @@ _scratch_mkfs "-b 300M" >> $seqres.full 2>&1 || \
>  	_fail "Fail to make SCRATCH_DEV with -b 300M"
>  $BTRFS_TUNE_PROG -S 1 $SCRATCH_DEV
>  _scratch_mount >> $seqres.full 2>&1
> -$BTRFS_UTIL_PROG device add $SPARE_DEV $SCRATCH_MNT
> +$BTRFS_UTIL_PROG device add $SPARE_DEV $SCRATCH_MNT >> $seqres.full
>  _scratch_unmount
>  $BTRFS_UTIL_PROG device scan --forget
>  
> -- 
> 2.40.1
> 

