Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA28EB64DD
	for <linux-fstests@archiver.kernel.org>; Mon, 17 Jul 2023 03:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjGQDEF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 16 Jul 2023 23:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjGQDD6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 16 Jul 2023 23:03:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE15F10D
        for <fstests@vger.kernel.org>; Sun, 16 Jul 2023 20:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689562990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ohf9oTE8PoNQM+gBA+nwQjAZJRHtXYuggoi5MTM7ouA=;
        b=FTJxR3WyrK8l3PCjv8kkU0cGEzWXEV5MlwNV+zUdvh6MODnVy9elW7dQ35ndgPm2+wjBwO
        i8c6cz0hQQjnwFq0mPzS2K+pu/qEZ9drjUf0O4QEZqM+95f/4WLDETi4/dkzXxA+zIsPZh
        CHva+eG+stOIEM7p9CtaJnD5V+Hxht8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-4h5rawvtNUmkOvGNtY_g5w-1; Sun, 16 Jul 2023 23:03:09 -0400
X-MC-Unique: 4h5rawvtNUmkOvGNtY_g5w-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1b8af49a5d2so32207035ad.2
        for <fstests@vger.kernel.org>; Sun, 16 Jul 2023 20:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689562988; x=1692154988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohf9oTE8PoNQM+gBA+nwQjAZJRHtXYuggoi5MTM7ouA=;
        b=UQHzu3dDPAwdSyxpf++kaa689+/g1BpDVtOmWx3ROn1ybbDPx+qmB10hExRxsF9pQ1
         L4aIJq80GPtfP5OvcTCQjjyCU/LmkXdzQ6UYQIuuYaEl/7rLWjBQKeKudTUyZcS9ohrt
         sJu6SAE2RFbddNpz69ocNJpFsx/WFlTMxu5vpIv0Eawirt+Zl7JZWUvzZ9g0e4Otho/g
         SJg5TsWOSP7SS0eHURDxffjVI9hA5Fn5tw/NB5TAqmhmchpMK8XCpIrJRQWXSrEcP+lz
         4wREjYUElaVjj3rzfu+XBVOkFHSkp+43H46OsC1NLi7wbUmnMVI45eaUykzYkN2vvr1n
         PDug==
X-Gm-Message-State: ABy/qLaRERqKsKjyz53oxVxc4Er9E8ykK+/hhudMf6UDRi6ZREFI5x3w
        PVcaw4qFc1d92+Zf4crWuZ6DpkZosJ7Ysp6YAar4Y7eKUllpVgvHSTS9y4X3acN2c3vzIPYr0kT
        krVw3fZqHZtr/qX7FXQ==
X-Received: by 2002:a17:903:32c9:b0:1b8:9598:6508 with SMTP id i9-20020a17090332c900b001b895986508mr15969566plr.18.1689562988521;
        Sun, 16 Jul 2023 20:03:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFjIVdnxQL4YXmYK6fefJwo/CmOB2L4VfbDTw32sAIHT2Xg0S8EWdBTcFEGuH8pSVYWzEay6g==
X-Received: by 2002:a17:903:32c9:b0:1b8:9598:6508 with SMTP id i9-20020a17090332c900b001b895986508mr15969552plr.18.1689562988233;
        Sun, 16 Jul 2023 20:03:08 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jc6-20020a17090325c600b001b2069072ccsm11602636plb.18.2023.07.16.20.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 20:03:07 -0700 (PDT)
Date:   Mon, 17 Jul 2023 11:03:03 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org,
        mpatocka@redhat.com
Subject: Re: [PATCH] generic/558: avoid forkbombs on filesystems with many
 free inodes
Message-ID: <20230717030303.i3stvautu3oh55ao@zlang-mailbox>
References: <20230714145900.GM11442@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714145900.GM11442@frogsfrogsfrogs>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jul 14, 2023 at 07:59:00AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Mikulas reported that this test became a forkbomb on his system when he
> tested it with bcachefs.  Unlike XFS and ext4, which have large inodes
> consuming hundreds of bytes, bcachefs has very tiny ones.  Therefore, it
> reports a large number of free inodes on a freshly mounted 1GB fs (~15
> million), which causes this test to try to create 15000 processes.
> 
> There's really no reason to do that -- all this test wanted to do was to
> exhaust the number of inodes as quickly as possible using all available
> CPUs, and then it ran xfs_repair to try to reproduce a bug.  Set the
> number of subshells to 4x the CPU count and spread the work among them
> instead of forking thousands of processes.
> 
> Reported-by: Mikulas Patocka <mpatocka@redhat.com>
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> Tested-by: Mikulas Patocka <mpatocka@redhat.com>
> ---
>  tests/generic/558 |   18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/generic/558 b/tests/generic/558
> index 4e22ce656b..de5c28d00d 100755
> --- a/tests/generic/558
> +++ b/tests/generic/558
> @@ -39,15 +39,21 @@ _scratch_mkfs_sized $((1024 * 1024 * 1024)) >>$seqres.full 2>&1
>  _scratch_mount
>  
>  i=0
> -free_inode=`_get_free_inode $SCRATCH_MNT`
> -file_per_dir=1000
> -loop=$((free_inode / file_per_dir + 1))
> +free_inodes=$(_get_free_inode $SCRATCH_MNT)
> +nr_cpus=$(( $($here/src/feature -o) * 4 * LOAD_FACTOR ))
> +echo "free inodes: $free_inodes nr_cpus: $nr_cpus" >> $seqres.full
> +
> +if ((free_inodes <= nr_cpus)); then
> +	nr_cpus=1
> +	files_per_dir=$free_inodes
> +else
> +	files_per_dir=$(( (free_inodes + nr_cpus - 1) / nr_cpus ))
> +fi
>  mkdir -p $SCRATCH_MNT/testdir
>  
>  echo "Create $((loop * file_per_dir)) files in $SCRATCH_MNT/testdir" >>$seqres.full

Has the $loop been removed?


> -while [ $i -lt $loop ]; do
> -	create_file $SCRATCH_MNT/testdir $file_per_dir $i >>$seqres.full 2>&1 &
> -	let i=$i+1
> +for ((i = 0; i < nr_cpus; i++)); do
> +	create_file $SCRATCH_MNT/testdir $files_per_dir $i >>$seqres.full 2>&1 &
>  done
>  wait
>  
> 

