Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE542EEAA40
	for <linux-fstests@archiver.kernel.org>; Thu, 14 Sep 2023 14:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239760AbjINOPH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 14 Sep 2023 10:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239493AbjINOPG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 14 Sep 2023 10:15:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69606C6
        for <fstests@vger.kernel.org>; Thu, 14 Sep 2023 07:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694700859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5APf6SF/g1QZ1s9vDqwPNfEmYcBSoWU4u5okowunXEg=;
        b=FbSPLZUOQLzVBiJXBfdPmEQTQSu4d867ZL/AK1eqwYQAG4LMiUv+/ZKdkbYMuj4zm7nd1n
        264IUT39wvgZ+t7zrXgwb94rCD2QSZ4oYkrVK7L0+ODpEFetgJlZVuIMQmAWZjbpX4mlBM
        QZW8Zhxx6RafEO9ralgaQOuh/pKBQcU=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-7fZ085PHM2KW_BLW9VRw9w-1; Thu, 14 Sep 2023 10:14:16 -0400
X-MC-Unique: 7fZ085PHM2KW_BLW9VRw9w-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1c07778146aso9221335ad.0
        for <fstests@vger.kernel.org>; Thu, 14 Sep 2023 07:14:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694700855; x=1695305655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5APf6SF/g1QZ1s9vDqwPNfEmYcBSoWU4u5okowunXEg=;
        b=M0ZKuIt7dyIjRMSvK9F7dblHezzwehMb6zee9nLhE74ScTgHqHe/jtfOZ9xzQX/N1r
         zwos66PkvFiQmz5ryvXeM72Voi4EYpdXg3h0Fu7IBIB64uSwQCKax+tP64IMw14JMNVz
         BY+rn/44m/7AEGpBASDZyUIbvoJ1enFH8ktOh25d+fzaaKbwd3HUeVtUjl45OjDFO32c
         NvuU+1mDVOPxOIxm8YChcGmFHPc8eJxNNUZrDqoWqVGVi9GorB4MnRtSdzgIi9GpbYxL
         HJIBM1BhPaCxMrIfo5iSkE6DP6YsN6nsAGmU2tChTCWcOraXewKVRUegiCxujEm4Mh2q
         7xnQ==
X-Gm-Message-State: AOJu0YzyC+So87PeKJoDCuX5F3Qhq+fDoyiYT/ohNb60SS8YwGJcGybC
        Z9/w1O9fcWYQVZQ70fXFSq58xMlJcExh49b+okqMysh4TjsL/3PO4MWnzCMrswr9LDZj3lia20R
        e3ywEqakPvIDfIEKR+226cb8HjzwWDyA=
X-Received: by 2002:a17:902:e84f:b0:1c3:2df4:8791 with SMTP id t15-20020a170902e84f00b001c32df48791mr7554533plg.27.1694700855267;
        Thu, 14 Sep 2023 07:14:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGL/YOXv9+En12nwSNEDcwBQAL5ZL0LmKA3blIJsfSJmwb2v1ziVfxW85lQzq1gSohJ6uqolw==
X-Received: by 2002:a17:902:e84f:b0:1c3:2df4:8791 with SMTP id t15-20020a170902e84f00b001c32df48791mr7554507plg.27.1694700854936;
        Thu, 14 Sep 2023 07:14:14 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o14-20020a170902d4ce00b001bde440e693sm1640324plg.44.2023.09.14.07.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 07:14:14 -0700 (PDT)
Date:   Thu, 14 Sep 2023 22:14:11 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs add more tests into the scrub group
Message-ID: <20230914141411.zat5up5kt5rd6ilu@zlang-mailbox>
References: <2fc42b09cdc710cc2ac83e3a1726b5f7b1d0af62.1693312237.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fc42b09cdc710cc2ac83e3a1726b5f7b1d0af62.1693312237.git.anand.jain@oracle.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Aug 29, 2023 at 08:32:40PM +0800, Anand Jain wrote:
> I wanted to verify tests using the command "btrfs scrub start" and
> found that there are many more test cases using "btrfs scrub start"
> than what is listed in the group.list file. So, get them to the scrub
> group.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---



>  tests/btrfs/011 | 2 +-
>  tests/btrfs/027 | 2 +-
>  tests/btrfs/060 | 2 +-
>  tests/btrfs/062 | 2 +-
>  tests/btrfs/063 | 2 +-
>  tests/btrfs/064 | 2 +-
>  tests/btrfs/065 | 2 +-
>  tests/btrfs/067 | 2 +-
>  tests/btrfs/068 | 2 +-
>  tests/btrfs/069 | 2 +-
>  tests/btrfs/070 | 2 +-
>  tests/btrfs/071 | 2 +-
>  tests/btrfs/074 | 2 +-
>  tests/btrfs/148 | 2 +-
>  tests/btrfs/195 | 2 +-
>  tests/btrfs/261 | 2 +-
>  16 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/tests/btrfs/011 b/tests/btrfs/011
> index 852742ee8396..ff52ada94a17 100755
> --- a/tests/btrfs/011
> +++ b/tests/btrfs/011
> @@ -20,7 +20,7 @@
>  # performed, a btrfsck run, and finally the filesystem is remounted.
>  #
>  . ./common/preamble
> -_begin_fstest auto replace volume
> +_begin_fstest auto replace volume scrub
>  
>  noise_pid=0
>  
> diff --git a/tests/btrfs/027 b/tests/btrfs/027
> index 46c14b9c1c1f..dbf12c26d0cd 100755
> --- a/tests/btrfs/027
> +++ b/tests/btrfs/027
> @@ -7,7 +7,7 @@
>  # Test replace of a missing device on various data and metadata profiles.
>  #
>  . ./common/preamble
> -_begin_fstest auto replace volume
> +_begin_fstest auto replace volume scrub
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/060 b/tests/btrfs/060
> index 26db8a9bee20..7dd4d2af74cd 100755
> --- a/tests/btrfs/060
> +++ b/tests/btrfs/060
> @@ -8,7 +8,7 @@
>  # with fsstress running in background.
>  #
>  . ./common/preamble
> -_begin_fstest auto balance subvol
> +_begin_fstest auto balance subvol scrub
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/062 b/tests/btrfs/062
> index 47b0b9373f33..10f95111f8ff 100755
> --- a/tests/btrfs/062
> +++ b/tests/btrfs/062
> @@ -8,7 +8,7 @@
>  # running in background.
>  #
>  . ./common/preamble
> -_begin_fstest auto balance defrag compress
> +_begin_fstest auto balance defrag compress scrub
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/063 b/tests/btrfs/063
> index c96390b9315c..cef80771d457 100755
> --- a/tests/btrfs/063
> +++ b/tests/btrfs/063
> @@ -8,7 +8,7 @@
>  # simultaneously, with fsstress running in background.
>  #
>  . ./common/preamble
> -_begin_fstest auto balance remount compress
> +_begin_fstest auto balance remount compress scrub
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/064 b/tests/btrfs/064
> index 741161889150..f29e68ba96af 100755
> --- a/tests/btrfs/064
> +++ b/tests/btrfs/064
> @@ -10,7 +10,7 @@
>  # run simultaneously. One of them is expected to fail when the other is running.
>  
>  . ./common/preamble
> -_begin_fstest auto balance replace volume
> +_begin_fstest auto balance replace volume scrub
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/065 b/tests/btrfs/065
> index 4ebf93267a59..b6c9dbadfd32 100755
> --- a/tests/btrfs/065
> +++ b/tests/btrfs/065
> @@ -8,7 +8,7 @@
>  # operation simultaneously, with fsstress running in background.
>  #
>  . ./common/preamble
> -_begin_fstest auto subvol replace volume
> +_begin_fstest auto subvol replace volume scrub
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/067 b/tests/btrfs/067
> index 44803f9faf7f..970a23c470fb 100755
> --- a/tests/btrfs/067
> +++ b/tests/btrfs/067
> @@ -8,7 +8,7 @@
>  # operation simultaneously, with fsstress running in background.
>  #
>  . ./common/preamble
> -_begin_fstest auto subvol defrag compress
> +_begin_fstest auto subvol defrag compress scrub
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/068 b/tests/btrfs/068
> index e03a4891ec89..e0bcc2ac4930 100755
> --- a/tests/btrfs/068
> +++ b/tests/btrfs/068
> @@ -9,7 +9,7 @@
>  # in background.
>  #
>  . ./common/preamble
> -_begin_fstest auto subvol remount compress
> +_begin_fstest auto subvol remount compress scrub
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/069 b/tests/btrfs/069
> index 6e798a2e5061..824ca3c3110b 100755
> --- a/tests/btrfs/069
> +++ b/tests/btrfs/069
> @@ -8,7 +8,7 @@
>  # running in background.
>  #
>  . ./common/preamble
> -_begin_fstest auto replace scrub volume
> +_begin_fstest auto replace scrub volume scrub

I'll remove this duplicated change when I merge it. So ...

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/070 b/tests/btrfs/070
> index dcf978b36b0c..f2e61ad392cd 100755
> --- a/tests/btrfs/070
> +++ b/tests/btrfs/070
> @@ -8,7 +8,7 @@
>  # running in background.
>  #
>  . ./common/preamble
> -_begin_fstest auto replace defrag compress volume
> +_begin_fstest auto replace defrag compress volume scrub
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/071 b/tests/btrfs/071
> index cd1de2642a96..40230b112cbc 100755
> --- a/tests/btrfs/071
> +++ b/tests/btrfs/071
> @@ -8,7 +8,7 @@
>  # algorithms simultaneously with fsstress running in background.
>  #
>  . ./common/preamble
> -_begin_fstest auto replace remount compress volume
> +_begin_fstest auto replace remount compress volume scrub
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/074 b/tests/btrfs/074
> index dc26d8c02497..92e25c7cc24a 100755
> --- a/tests/btrfs/074
> +++ b/tests/btrfs/074
> @@ -8,7 +8,7 @@
>  # simultaneously with fsstress running in background.
>  #
>  . ./common/preamble
> -_begin_fstest auto defrag remount compress
> +_begin_fstest auto defrag remount compress scrub
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/148 b/tests/btrfs/148
> index 510e46dc0826..65a262922569 100755
> --- a/tests/btrfs/148
> +++ b/tests/btrfs/148
> @@ -7,7 +7,7 @@
>  # Test that direct IO writes work on RAID5 and RAID6 filesystems.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick rw
> +_begin_fstest auto quick rw scrub
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/195 b/tests/btrfs/195
> index 747345973244..96cc41343925 100755
> --- a/tests/btrfs/195
> +++ b/tests/btrfs/195
> @@ -8,7 +8,7 @@
>  # source profiles just rely on being able to read the data and metadata.
>  #
>  . ./common/preamble
> -_begin_fstest auto volume balance
> +_begin_fstest auto volume balance scrub
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/261 b/tests/btrfs/261
> index 21567052d58e..b33c053fbca0 100755
> --- a/tests/btrfs/261
> +++ b/tests/btrfs/261
> @@ -8,7 +8,7 @@
>  # without affecting the consistency of the fs.
>  #
>  . ./common/preamble
> -_begin_fstest auto volume raid
> +_begin_fstest auto volume raid scrub
>  
>  _supported_fs btrfs
>  _require_scratch_dev_pool 4
> -- 
> 2.39.3
> 

