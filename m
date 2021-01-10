Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E05C433DB
	for <linux-fstests@archiver.kernel.org>; Sun, 10 Jan 2021 10:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38139238E9
	for <linux-fstests@archiver.kernel.org>; Sun, 10 Jan 2021 10:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbhAJKIm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 10 Jan 2021 05:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbhAJKIm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 10 Jan 2021 05:08:42 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27A5C061786
        for <fstests@vger.kernel.org>; Sun, 10 Jan 2021 02:08:01 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id c132so10666336pga.3
        for <fstests@vger.kernel.org>; Sun, 10 Jan 2021 02:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vAiZBWKfYKwywbXg4w8sr4q3bfHhKwhNjzav4aT0GwI=;
        b=GXYqS6s1BNuHmyayTbw0YaFUjBsETnCtf4fV5iSocG5dk15oyXSXvCT21VKjpxR1nB
         3QzufDJwbzp5IiotH17BfDthoVSnvvQkbWSbHyuWup0VeQ3w6CKE0KOKGGc9KUI33vqq
         mIgQP9zQXnSI/HvHFSP8aFdUoqhKAs+6BBPyoWOmvigSGAcRrFnW0TRzQjLNr8xUfw9p
         nQPVtoHI7XovSRRjSdKK3gcNfYcXOigZhxx+h9IPFE8kKPKVShG5nzPUkg9534ITKPSD
         5XKEe7ptgvEzu5haeJmqb7Rrqo4PFlW4JzCDVgKtI+zBRhv2kYfOHk8SZU1uWHuSdoad
         aVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vAiZBWKfYKwywbXg4w8sr4q3bfHhKwhNjzav4aT0GwI=;
        b=HJmW1nzRT/3VpoB1gU+CdUnO1+VkXew3l5iXB55G+bIcMoXTrCttXFWdHkTUUY7MN+
         IQUEpCyk7sy0d3Q0l0CEs/GKNP/PHtY7MFSmKk5WRMSV/7u4imlz9xO4dgcmGcfRnUkw
         UOoLiTq5xQPAnGlMCi5KOQwMb30O1h0iqZJzdLXfZ4xqdCPY1llf9dQJQj5w5Ad1JBK5
         2J6gFt06JRmiNIvA3retXaiMLrqAJ6NRstE327RafGE+71QiHVdQFbf8COgLEWDHrnox
         sSyZH0u8Y7xgSIwsqUfBRZDaB0uccAUm3PyjNndiEPZ/JqjCSRhb6qy5EYBRpj+d5q0y
         5L0w==
X-Gm-Message-State: AOAM533TtFUCMCrQx+pgnCpKsd6ZIa3RXQoFmLLSzn3Z/w6eC6U+7IN6
        KfGo1SNZvZ6Bko2M/5be9Mg1X4jYNmCf6w==
X-Google-Smtp-Source: ABdhPJxOLRTidDPOnMMtAyUGMMwc2yIXZEfLQZ+R5c7kOpl1zbjfAEa3wNXvnjJDLHHnCQyCD9oLJw==
X-Received: by 2002:a62:4e4e:0:b029:19e:aaab:8be with SMTP id c75-20020a624e4e0000b029019eaaab08bemr11855129pfb.59.1610273281118;
        Sun, 10 Jan 2021 02:08:01 -0800 (PST)
Received: from localhost ([47.89.231.86])
        by smtp.gmail.com with ESMTPSA id r79sm15049932pfc.166.2021.01.10.02.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 02:08:00 -0800 (PST)
Date:   Sun, 10 Jan 2021 18:07:57 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/filter: add _filter_stat
Message-ID: <20210110100757.GA2519@desktop>
References: <20201208104245.2dtfn6xz7qr6uga3@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208104245.2dtfn6xz7qr6uga3@xzhoux.usersys.redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Dec 08, 2020 at 06:42:45PM +0800, Murphy Zhou wrote:
> New stat(2) starts to use statx(7) call. Then if file does not
> exist, it breaks golden output like this:

It'd be great if you could describe this behavior change starts from
which version of coreutils in commit log and in comment as well, this
may help people debug if failure is related to this change.

Otherwise patch looks good to me.

Thanks,
Eryu

> 
> -stat: cannot stat 'SCRATCH_MNT/xxx': No such file or directory
> +stat: cannot statx 'SCRATCH_MNT/xxx': No such file or directory
> 
> Add this filter to fix it, and add this filter to testcases that
> need it.
> 
> Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> ---
>  common/filter     | 6 ++++++
>  tests/generic/397 | 6 +++---
>  tests/generic/435 | 2 +-
>  tests/generic/440 | 2 +-
>  tests/xfs/348     | 2 +-
>  5 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/common/filter b/common/filter
> index a8b3882f..6fbf70c2 100644
> --- a/common/filter
> +++ b/common/filter
> @@ -510,6 +510,12 @@ _filter_mv()
>  	sed -e "s/^renamed //"
>  }
>  
> +# New stat(2) uses statx(7)
> +_filter_stat()
> +{
> +	sed -e "s/cannot statx/cannot stat/"
> +}
> +
>  _filter_lostfound()
>  {
>  	sed -e '/^lost+found$/d'
> diff --git a/tests/generic/397 b/tests/generic/397
> index 97111555..bb4de31c 100755
> --- a/tests/generic/397
> +++ b/tests/generic/397
> @@ -83,8 +83,8 @@ _unlink_session_encryption_key $keydesc
>  _scratch_cycle_mount
>  
>  # Check that unencrypted names aren't there
> -stat $SCRATCH_MNT/edir/empty |& _filter_scratch
> -stat $SCRATCH_MNT/edir/symlink |& _filter_scratch
> +stat $SCRATCH_MNT/edir/empty |& _filter_stat |& _filter_scratch
> +stat $SCRATCH_MNT/edir/symlink |& _filter_stat |& _filter_scratch
>  
>  # Check that the correct numbers of files and subdirectories are there
>  ls $SCRATCH_MNT/edir | wc -l
> @@ -106,7 +106,7 @@ ln -s foo $SCRATCH_MNT/edir/0123456789abcdef |& _filter_scratch
>  
>  # Delete the encrypted directory (should succeed)
>  rm -r $SCRATCH_MNT/edir
> -stat $SCRATCH_MNT/edir |& _filter_scratch
> +stat $SCRATCH_MNT/edir |& _filter_stat |& _filter_scratch
>  
>  # success, all done
>  status=0
> diff --git a/tests/generic/435 b/tests/generic/435
> index 9f54c6c4..71c5a3f0 100755
> --- a/tests/generic/435
> +++ b/tests/generic/435
> @@ -73,7 +73,7 @@ _scratch_cycle_mount
>  # and ext4 reported a "Structure needs cleaning" error when removing files.
>  find $SCRATCH_MNT/edir/ -type f | xargs stat -c %i | sort | uniq | wc -l
>  rm -rf $SCRATCH_MNT/edir |& head -n 10
> -stat $SCRATCH_MNT/edir |& _filter_scratch
> +stat $SCRATCH_MNT/edir |& _filter_stat |& _filter_scratch
>  
>  # success, all done
>  status=0
> diff --git a/tests/generic/440 b/tests/generic/440
> index d775f1e0..8a81d60a 100755
> --- a/tests/generic/440
> +++ b/tests/generic/440
> @@ -87,7 +87,7 @@ _scratch_cycle_mount
>  cat $SCRATCH_MNT/edir2/link
>  exec 3< $SCRATCH_MNT/edir2/link # pin inode with cached key in memory
>  _unlink_session_encryption_key $keydesc
> -stat $SCRATCH_MNT/edir/file |& _filter_scratch
> +stat $SCRATCH_MNT/edir/file |& _filter_stat |& _filter_scratch
>  cat "$(find $SCRATCH_MNT/edir/ -type f)"
>  exec 3>&-
>  
> diff --git a/tests/xfs/348 b/tests/xfs/348
> index 194d9f99..208382fb 100755
> --- a/tests/xfs/348
> +++ b/tests/xfs/348
> @@ -112,7 +112,7 @@ for dt in $dtypes; do
>  		rm -f $tmp.stat.err
>  		ftype=$(stat --printf=%F $testdir/$file 2>$tmp.stat.err)
>  		if [ -s $tmp.stat.err ]; then
> -			cat $tmp.stat.err
> +			cat $tmp.stat.err | _filter_stat
>  		else
>  			echo "stat: '$testdir/$file' is a $ftype"
>  			# Verify that readlink of a file posing as a symlink
> -- 
> 2.20.1
