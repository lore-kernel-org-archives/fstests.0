Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814D5C433DB
	for <linux-fstests@archiver.kernel.org>; Sun, 17 Jan 2021 15:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 470D021D81
	for <linux-fstests@archiver.kernel.org>; Sun, 17 Jan 2021 15:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbhAQPH3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 17 Jan 2021 10:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728875AbhAQPHN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 17 Jan 2021 10:07:13 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DDCC061757
        for <fstests@vger.kernel.org>; Sun, 17 Jan 2021 07:06:32 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id i5so9347150pgo.1
        for <fstests@vger.kernel.org>; Sun, 17 Jan 2021 07:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3Ry62NCfuXJdQPzkASImldSyJSTiKgprZLe1YXT7MFM=;
        b=Hf43Nf2gu7XBYM2bZI/Jk4xcvHB8VXFtSWpNJrvwvO65X1QYiITmWxDiiVHm/zLtIQ
         g0QcYN5vQBv02P/dKFRFpTDQAc46oxEYxBDph1aNVutAKj7FsdU/ZZUXF/7iMfceEcVx
         Kn3+W4ipJPm61kTdVQxOfvE2v3lMZqYlZESVmwmRQlxJhma20SQBDVhE86s7BXxZOX2m
         pp0Asqv9vnx/clEMlT5dyO1R+6nfFcL3UNKC3SlYGARAeIo21bKzd+bRUna2KEZjPewh
         uaQanMXXYaCGtC4T2TBA1ehKD7/gEvkpSF4mCHaOZ16Kph+M1WinWx0pMcXuKVRVCVx4
         XfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Ry62NCfuXJdQPzkASImldSyJSTiKgprZLe1YXT7MFM=;
        b=h+5AkyMaKw5NNMuJoDWId48ysAuu5YjqFRoof/0ZDshmaBD0lXVCSpyckmvwzHEWr2
         SeXkvD4exRjEFXnC4zjKDUNUp1vBu/JjoCF09gcrFPEj0UJKQ2vmPKMPTV9nLw40aeBh
         IESIeU1iXug1MquKB6eWeKNxTGpIR+qQGxQY0lEcNHEgsI6epJuK1PHfs8Cb0TltSh9z
         zrps+2oeA/CuiuuKhspDfqCI6IYN7StN5LfboF/7xcqLI1aU0d8+B4jTOPhqaUvZ4U1f
         W98w2B4qMxuZx7cw7/L3tBckVdNi+BRirpPy3lqy/lBzDhgtCJSploxZX78kUPvOD6TE
         QvDQ==
X-Gm-Message-State: AOAM532rbtiGVshBxfbF3ZgQqb9hQbGzb8tf1juhtg4E/WtbHFZfFovN
        PWkxsX+jdahH2deoEoP9bZVOzGxPQkJDyg==
X-Google-Smtp-Source: ABdhPJw5v6Q/OoGsiKBeyLeJ6Clu5jmgbJs7VdOXO5r5GMPBPR+c/P7TLbXdwa49htCi4L71nPeASA==
X-Received: by 2002:a63:f44f:: with SMTP id p15mr22339458pgk.141.1610895992294;
        Sun, 17 Jan 2021 07:06:32 -0800 (PST)
Received: from localhost ([47.89.231.86])
        by smtp.gmail.com with ESMTPSA id a136sm14214170pfd.149.2021.01.17.07.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 07:06:31 -0800 (PST)
Date:   Sun, 17 Jan 2021 23:06:24 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] ext4/046: skip test when ext4 doesn't support bs < ps
 with dioread_nolock
Message-ID: <20210117150624.GA2347@desktop>
References: <1610596503-17149-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610596503-17149-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jan 14, 2021 at 11:55:03AM +0800, Yang Xu wrote:
> When testing arm machine, this case fails because ps > bs and kernel doesn't
> introduced commit c8cc88163f40 ("ext4: Add support for blocksize < pagesize in dioread_nolock").
> Only skip this case when mounting failed.

Perhaps it's the kernel that should be fixed? i.e. backport the
mentioned patch? Depends on if we treat it as a bug or a feature I
think..

> 
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>  tests/ext4/046 | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/ext4/046 b/tests/ext4/046
> index 5524024e..e307cbf1 100755
> --- a/tests/ext4/046
> +++ b/tests/ext4/046
> @@ -37,7 +37,8 @@ _require_xfs_io_command "falloc"
>  _require_scratch_size $((6 * 1024 * 1024)) #kB
>  
>  _scratch_mkfs >> $seqres.full 2>&1
> -_scratch_mount "-o dioread_nolock" >> $seqres.full 2>&1
> +_try_scratch_mount "-o dioread_nolock" >>$seqres.full 2>&1 || \
> +	_notrun "mount failed, ext4 doesn't support bs < ps with dioread_nolock?"

At least we should check if it's really the bs < ps case before _notrun
the test, otherwise we may fail to find dioread_nolock mount regression.

Thanks,
Eryu

>  
>  # Get blksz
>  blksz=$(_get_file_block_size $SCRATCH_MNT)
> -- 
> 2.23.0
> 
> 
