Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71875C41513
	for <linux-fstests@archiver.kernel.org>; Mon, 14 Aug 2023 10:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjHNKsl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 14 Aug 2023 06:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbjHNKs1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 14 Aug 2023 06:48:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62433D2
        for <fstests@vger.kernel.org>; Mon, 14 Aug 2023 03:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692010061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BF/4zzaKXvfhh+s7tw4kuSjVpH2bIit1WeEEManFpUY=;
        b=Q3QGKXmKFbSb4QuFZGPX0PbkcrRka/p7nC9/JMhmjicRWWzCwRi3aAjL20j+hKhLmHc2a7
        +795ql6vzqhmmHdW0nEhZNaPuUKYOIlLBa889YGLzw1BRTHOjnMHdDXQmlxQKb9vW6vSiP
        RXEsAkwscqjF6tVVNcQyCpDy0NSFueg=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-5FOOTzXNMau5qukARf1MaA-1; Mon, 14 Aug 2023 06:47:40 -0400
X-MC-Unique: 5FOOTzXNMau5qukARf1MaA-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-56dbba97510so4749558eaf.2
        for <fstests@vger.kernel.org>; Mon, 14 Aug 2023 03:47:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692010059; x=1692614859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BF/4zzaKXvfhh+s7tw4kuSjVpH2bIit1WeEEManFpUY=;
        b=Oidy9km/oh/h+1zCLU9ibR9HR6D22xiUFsR39zotO2FbGd7PDOc+b6HsfMpqsEbPpv
         P/QDbW6ZMOb2FUIANqkfbGziao2dohnWQJTenYl+fzGkICWhcGT3VNGoAM98tKb2TLaZ
         LZLe5Ym/G/+H6uwsoQK6B9zbZI14ArgcD/ZLx9e/M9PhXUxZA1IpVZ9QqYcVQyImMZy5
         GrXQ5ISTBfgq+KYqwQ7zE8fqBs6eEE6SZGRLIjNKwWPwxSgnlpfV5jv37zqVejV4a4gC
         JTCTXLiMczrEXptbg7uDA9TVtc2qPh4wHCqQ2ZbHVyPOMYVwG8KLnBEpTjhQb01cao6o
         166w==
X-Gm-Message-State: AOJu0Yz6Vsx5C4T+yUXY6d9BkA2/qt7bSMiiAKgdGGA3udok5wMmKpNY
        Nv1gh6gfjp594K81+uR5sAE1zTM1RQOgfh7OpSNuH7B9bK0Mm7ggQ+yGaPQ5KLPCi2yfTHuUqI5
        cxRKon7raHu0CjiLh7WXixzMFqvyl9TU=
X-Received: by 2002:a05:6358:3388:b0:135:acfd:8786 with SMTP id i8-20020a056358338800b00135acfd8786mr6451550rwd.3.1692010059061;
        Mon, 14 Aug 2023 03:47:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExFdbNvoUqlWQM4WmjBK376AIlhboNubppZvJbYUJBvsvcayV+ZLi8yn0v3dZ61Rbq/m6cGA==
X-Received: by 2002:a05:6358:3388:b0:135:acfd:8786 with SMTP id i8-20020a056358338800b00135acfd8786mr6451539rwd.3.1692010058766;
        Mon, 14 Aug 2023 03:47:38 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id j7-20020a17090276c700b001b893b689a0sm9073475plt.84.2023.08.14.03.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 03:47:38 -0700 (PDT)
Date:   Mon, 14 Aug 2023 18:47:35 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] fsx: tidy options usage and format
Message-ID: <20230814104735.r6m4b6bsgbvty3nc@zlang-mailbox>
References: <20230804054003.936263-1-ruansy.fnst@fujitsu.com>
 <20230814035503.1724774-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814035503.1724774-1-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Aug 14, 2023 at 11:55:03AM +0800, Shiyang Ruan wrote:
> 1. Add missing options and wrap the cli example line.
> 2. Cleanup and also add missing "-K" operation for options description
> part.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> ---

Thanks, this version looks good to me now.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  ltp/fsx.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index ffa64cfa0..ccb382e77 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -2393,11 +2393,17 @@ void
>  usage(void)
>  {
>  	fprintf(stdout, "usage: %s",
> -		"fsx [-dknqxBEFJLOWZ][-A|-U] [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid] [-l flen] [-m start:end] [-o oplen] [-p progressinterval] [-r readbdy] [-s style] [-t truncbdy] [-w writebdy] [-D startingop] [-N numops] [-P dirpath] [-S seed] fname\n\
> +		"fsx [-dfknqxyzBEFHIJKLORWXZ0]\n\
> +	   [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid]\n\
> +	   [-l flen] [-m start:end] [-o oplen] [-p progressinterval]\n\
> +	   [-r readbdy] [-s style] [-t truncbdy] [-w writebdy]\n\
> +	   [-A|-U] [-D startingop] [-N numops] [-P dirpath] [-S seed]\n\
> +	   [--replay-ops=opsfile] [--record-ops[=opsfile]] [--duration=seconds]\n\
> +	   ... fname\n\
>  	-b opnum: beginning operation number (default 1)\n\
>  	-c P: 1 in P chance of file close+open at each op (default infinity)\n\
>  	-d: debug output for all operations\n\
> -	-f flush and invalidate cache after I/O\n\
> +	-f: flush and invalidate cache after I/O\n\
>  	-g X: write character X instead of random generated data\n\
>  	-i logdev: do integrity testing, logdev is the dm log writes device\n\
>  	-j logid: prefix debug log messsages with this id\n\
> @@ -2412,15 +2418,15 @@ usage(void)
>  	-s style: 1 gives smaller truncates (default 0)\n\
>  	-t truncbdy: 4096 would make truncates page aligned (default 1)\n\
>  	-w writebdy: 4096 would make writes page aligned (default 1)\n\
> -	-x: preallocate file space before starting, XFS only (default 0)\n\
> -	-y synchronize changes to a file\n"
> +	-x: preallocate file space before starting, XFS only\n\
> +	-y: synchronize changes to a file\n"
>  
>  #ifdef AIO
>  "	-A: Use the AIO system calls, -A excludes -U\n"
>  #endif
>  #ifdef URING
>  "	-U: Use the IO_URING system calls, -U excludes -A\n"
> - #endif
> +#endif
>  "	-D startingop: debug output starting at specified operation\n"
>  #ifdef HAVE_LINUX_FALLOC_H
>  "	-F: Do not use fallocate (preallocation) calls\n"
> @@ -2449,16 +2455,17 @@ usage(void)
>  #ifdef FIEXCHANGE_RANGE
>  "	-0: Do not use exchange range calls\n"
>  #endif
> -"	-L: fsxLite - no file creations & no file size changes\n\
> +"	-K: Do not use keep size\n\
> +	-L: fsxLite - no file creations & no file size changes\n\
>  	-N numops: total # operations to do (default infinity)\n\
>  	-O: use oplen (see -o flag) for every op (default random)\n\
> -	-P: save .fsxlog .fsxops and .fsxgood files in dirpath (default ./)\n\
> +	-P dirpath: save .fsxlog .fsxops and .fsxgood files in dirpath (default ./)\n\
> +	-R: read() system calls only (mapped reads disabled)\n\
>  	-S seed: for random # generator (default 1) 0 gets timestamp\n\
>  	-W: mapped write operations DISabled\n\
> -	-X: Read file and compare to good buffer after every operation.\n\
> -        -R: read() system calls only (mapped reads disabled)\n\
> -        -Z: O_DIRECT (use -R, -W, -r and -w too)\n\
> -	--replay-ops opsfile: replay ops from recorded .fsxops file\n\
> +	-X: Read file and compare to good buffer after every operation\n\
> +	-Z: O_DIRECT (use -R, -W, -r and -w too)\n\
> +	--replay-ops=opsfile: replay ops from recorded .fsxops file\n\
>  	--record-ops[=opsfile]: dump ops file also on success. optionally specify ops file name\n\
>  	--duration=seconds: ignore any -N setting and run for this many seconds\n\
>  	fname: this filename is REQUIRED (no default)\n");
> -- 
> 2.41.0
> 

