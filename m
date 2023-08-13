Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFD1C001DE
	for <linux-fstests@archiver.kernel.org>; Sun, 13 Aug 2023 14:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjHMOxc (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 13 Aug 2023 10:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjHMOxc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 13 Aug 2023 10:53:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153D7172B
        for <fstests@vger.kernel.org>; Sun, 13 Aug 2023 07:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691938343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1ElkgXaUdfkDE64dXDF4ysq8G0wqTbLX7vnZmq3ciHU=;
        b=CYUFfyhwPm6G5/uxNnRlrSfkAuOhVzvu90SDeberKWvF7+nLSYVnIwG3a/MMRRdLkrx94L
        KwqzFlxC0X7rll+Ccn8/GHWmvnbpKHwo5mjmeR8tIpOvZf4tQja3/ZzSHCati4YDotQxYj
        vk7B8EQ9kg2pVkxtele1Ls7is3UCTXU=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-UEsm0TVvNBaISAVhGzlT2w-1; Sun, 13 Aug 2023 10:52:21 -0400
X-MC-Unique: UEsm0TVvNBaISAVhGzlT2w-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1bc46ebab95so56813105ad.2
        for <fstests@vger.kernel.org>; Sun, 13 Aug 2023 07:52:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691938340; x=1692543140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ElkgXaUdfkDE64dXDF4ysq8G0wqTbLX7vnZmq3ciHU=;
        b=R5v/j6+dKJwea4KaUJt93t3XIgBpHcHaPksbwNUqxjmj8T94CGZvDpxVXe5CkNWYqM
         TfHHQrI8oSmA2YCJwWqiQetQAP3LiZIT9tjgNkpkFG2hKAaXW+360eOH170y/dgK+kaM
         M1zDc1IGPqqxnd2DV4TWgngPCJE+BhjIZUHNkJpgMtm8cTplrzs+z4qjBuppb7/tIRAU
         Ps+wl5Petjjnkne0UKA/mYwX11atQJ4F2oJWzf/pcKtQoXEqGC0VymJ/rJsfti5EvCHQ
         sYuURVkItvVmTa0OzTk0Qjq3xZghOODeswRYYiCdOb6HH6l1ItZ907CCSua/wUfEIgS8
         DOhA==
X-Gm-Message-State: AOJu0Yw0StRapYMoVB6a4CwLPUuqyREvz4EYfW9V+oL/YZqSrPgbrz5c
        5zkG7RWNs9YgM7i6psDfs3bEraN++9U2aLWsNiqM8KUxwwSZBuRcgRNFletZjRXN1M6C8idz+2I
        eeesqUeZf5SK4fmQp1XsCY+Z5GTwn
X-Received: by 2002:a17:902:f54d:b0:1b9:de67:286f with SMTP id h13-20020a170902f54d00b001b9de67286fmr10486815plf.49.1691938340067;
        Sun, 13 Aug 2023 07:52:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGx850AJ1Sb2bQVim83dWNx0zn6kwuo1ETroWBlaqLCusrQQq0DXxUk3/rLySljx6oQ8vBhjQ==
X-Received: by 2002:a17:902:f54d:b0:1b9:de67:286f with SMTP id h13-20020a170902f54d00b001b9de67286fmr10486800plf.49.1691938339734;
        Sun, 13 Aug 2023 07:52:19 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id a20-20020a170903101400b00198d7b52eefsm2961752plb.257.2023.08.13.07.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 07:52:19 -0700 (PDT)
Date:   Sun, 13 Aug 2023 22:52:15 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     "Darrick J . Wong" <djwong@kernel.org>,
        Chandan Babu R <chandan.babu@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/{175,297,298}: fix use of uninitialized var
Message-ID: <20230813145215.dxaqcmhlskvhxmuq@zlang-mailbox>
References: <20230812151500.553233-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812151500.553233-1-amir73il@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Aug 12, 2023 at 06:15:00PM +0300, Amir Goldstein wrote:
> Not sure how those tests pass in regression tests.
> Probably truncate silently fails and is not critical to the test.
> 
> in kdevops I get errors like:
> /data/fstests-install/xfstests/tests/generic/298: line 45: /dev/loop12):
>            syntax error: operand expected (error token is "/dev/loop12)")
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

Hmm, weird, I never hit this failure, all test passed [1]. But I think the
reason is [2], $(()) looks like treat empty variable as 0.

Anyway, this patch makes sense, so

Reviewed-by: Zorro Lang <zlang@redhat.com>

[1]
# ./check -s simpledev generic/175 generic/297 generic/298
SECTION       -- simpledev
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 hp-dl380pg8-01 6.5.0-0.rc3.23.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jul 24 13:32:24 UTC 2023
MKFS_OPTIONS  -- -f /dev/sda3
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sda3 /mnt/scratch

generic/175 91s ...  40s
generic/297        44s
generic/298 125s ...  44s
Ran: generic/175 generic/297 generic/298
Passed all 3 tests

SECTION       -- simpledev
=========================
Ran: generic/175 generic/297 generic/298
Passed all 3 tests


[2]
# blksz=4096
# echo $blksz
4096
# echo $i

# echo $(( (2 ** i) * blksz))
4096
# echo $i

# echo $((i))
0






>  tests/generic/175 | 2 +-
>  tests/generic/297 | 2 +-
>  tests/generic/298 | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/generic/175 b/tests/generic/175
> index 07af2199..14825a39 100755
> --- a/tests/generic/175
> +++ b/tests/generic/175
> @@ -33,7 +33,7 @@ _pwrite_byte 0x61 0 $blksz "$testdir/file1" >> "$seqres.full"
>  
>  fnr=19
>  echo "Create extents"
> -truncate -s $(( (2 ** i) * blksz)) "$testdir/file1"
> +truncate -s $(( (2 ** (fnr + 1)) * blksz)) "$testdir/file1"
>  for i in $(seq 0 $fnr); do
>  	echo " ++ Reflink size $i, $((2 ** i)) blocks" >> "$seqres.full"
>  	n=$(( (2 ** i) * blksz))
> diff --git a/tests/generic/297 b/tests/generic/297
> index 6bdc3e1c..1fc48671 100755
> --- a/tests/generic/297
> +++ b/tests/generic/297
> @@ -42,7 +42,7 @@ _pwrite_byte 0x61 0 $blksz $testdir/file1 >> $seqres.full
>  fnr=26		# 2^26 reflink extents should be enough to find a slow op?
>  timeout=8	# guarantee a good long run...
>  echo "Find a reflink size that takes a long time"
> -truncate -s $(( (2 ** i) * blksz)) $testdir/file1
> +truncate -s $(( (2 ** (fnr + 1)) * blksz)) $testdir/file1
>  for i in $(seq 0 $fnr); do
>  	echo " ++ Reflink size $i, $((2 ** i)) blocks" >> $seqres.full
>  	n=$(( (2 ** i) * blksz))
> diff --git a/tests/generic/298 b/tests/generic/298
> index 95d4c02b..2e917a87 100755
> --- a/tests/generic/298
> +++ b/tests/generic/298
> @@ -42,7 +42,7 @@ _pwrite_byte 0x61 0 $blksz $testdir/file1 >> $seqres.full
>  fnr=26		# 2^26 reflink extents should be enough to find a slow op?
>  timeout=8	# guarantee a good long run...
>  echo "Find a reflink size that takes a long time"
> -truncate -s $(( (2 ** i) * blksz)) $testdir/file1
> +truncate -s $(( (2 ** (fnr + 1)) * blksz)) $testdir/file1
>  for i in $(seq 0 $fnr); do
>  	echo " ++ Reflink size $i, $((2 ** i)) blocks" >> $seqres.full
>  	n=$(( (2 ** i) * blksz))
> -- 
> 2.34.1
> 

