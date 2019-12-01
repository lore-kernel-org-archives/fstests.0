Return-Path: <SRS0=1u3g=ZX=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492DBC432C0
	for <linux-fstests@archiver.kernel.org>; Sun,  1 Dec 2019 15:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1630320725
	for <linux-fstests@archiver.kernel.org>; Sun,  1 Dec 2019 15:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejkJ/VH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfLAPrx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 1 Dec 2019 10:47:53 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36341 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfLAPrx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 1 Dec 2019 10:47:53 -0500
Received: by mail-pl1-f195.google.com with SMTP id k20so2689848pls.3
        for <fstests@vger.kernel.org>; Sun, 01 Dec 2019 07:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OK62MqlnHq1gL+sAFHs3fO+8OWyNi2arv0skKKa25Bg=;
        b=ejkJ/VH2TYLYBh2ixn7rbFWvWunh/y559yaO6/aphkGDljnyt8sYhdZLyuAVnoJO5f
         qjqcOdOzJuPjKthtshl/IfMEjNFIG1u1Qfyhzapkeu1RnEL/D2DTVWY7r97lBUde+PBA
         qpehPCVR+NdXc2y/+qWlKN4l6gqXJABUQxyA9f6//xaTzwXyMQPkdlZzS33omzOk5kGm
         nIfPCHxgNyAHjJidciwhbPJsutVB4cGtrp2OJye+YBFY2OnlFtg/GSDeoB85BcuafoFB
         DI6DLx2wQYrG20dco6ZmQz+4VhAYO2mJPd8dEPl2RnHamcELeOnYK39QZd8Xp7dAIMZh
         eGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OK62MqlnHq1gL+sAFHs3fO+8OWyNi2arv0skKKa25Bg=;
        b=GNzLLbPX5yvaFWKW4Tf9il3Ks9L5eseyiA0ruJVqeg7gkVb5phdqTE72P87W3KuPdk
         DR0QCN1MXdN4/SmAizNy+GdTPqvretpf5gMTIeskPQ7nmi+/W/Ob2XBdq0Snuy/J6o7W
         jgpLZa5UsdkYhq8dyvupylqOy/sjzLzVW+hgWCmf/BpprMsa8KM07VyQpjqaRvLxrlTN
         tt16n/x+QYDrqO1WfzJA3ZzNgTeFbJ5ICPvw/T5Ofq+kGlx5jnpk3TkRTZDE1jQlVK7/
         VbrSMftX3HR1/hrXeIhQveYQnnw8/Kx0pFLvmz1NrIcPh+OYuEOLFjUTI342frCtiqqj
         5L/A==
X-Gm-Message-State: APjAAAUwQvKpNpylMvsTD+A3fsTO58N+uypAOZWWRXdg3IJUtA4r6UWf
        wj1dQLOahhoiA6a3QOxs8ZQ=
X-Google-Smtp-Source: APXvYqwyhO2B9jBiaL5Tcu57/0kxihDs+xQ5vzDneleyxPgQt55429X/0rxUZQfvVnpTQg65JEcYrA==
X-Received: by 2002:a17:902:a60c:: with SMTP id u12mr22578648plq.113.1575215272751;
        Sun, 01 Dec 2019 07:47:52 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id a26sm7600254pfo.5.2019.12.01.07.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2019 07:47:52 -0800 (PST)
Date:   Sun, 1 Dec 2019 23:47:47 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Kusanagi Kouichi <slash@ac.auone-net.jp>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/filter: Don't use strtonum
Message-ID: <20191201154747.GJ8664@desktop>
References: <20191129072108857.YEGH.25002.ppp.dion.ne.jp@dmta0003.auone-net.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129072108857.YEGH.25002.ppp.dion.ne.jp@dmta0003.auone-net.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Nov 29, 2019 at 04:21:08PM +0900, Kusanagi Kouichi wrote:
> It's a gawk extension and not needed. Make tests pass with non-gawk.
> 
> Signed-off-by: Kusanagi Kouichi <slash@ac.auone-net.jp>

I noticed that you sent another two patches that fix similar issue in
another test. I think we could fold them into one patch that fixes all
the strtonum problem.

Thanks,
Eryu

> ---
>  common/filter | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/common/filter b/common/filter
> index 2477f386..e02cc0b9 100644
> --- a/common/filter
> +++ b/common/filter
> @@ -241,9 +241,9 @@ _filter_xfs_io_units_modified()
>  		/wrote/ {
>  			split($2, bytes, "/")
>  
> -			bytes_written = strtonum(bytes[1])
> +			bytes_written = bytes[1]
>  
> -			offset = strtonum($NF)
> +			offset = $NF
>  
>  			unit_start = offset / unit_size
>  			unit_start = int(unit_start)
> @@ -487,14 +487,17 @@ _filter_busy_mount()
>  _filter_od()
>  {
>  	BLOCK_SIZE=$(_get_block_size $SCRATCH_MNT)
> -	$AWK_PROG -v block_size=$BLOCK_SIZE '
> -		/^[0-9]+/ {
> -			offset = strtonum("0"$1);
> -			$1 = sprintf("%o", offset / block_size);
> -			print $0;
> -		}
> -		/\*/
> -	'
> +	while read line
> +	do
> +		if test "$line" = '*'
> +		then
> +			printf '*\n'
> +			continue
> +		fi
> +
> +		offset="${line%% *}"
> +		printf '%o%s\n' $((offset / BLOCK_SIZE)) "${line#$offset}"
> +	done
>  }
>  
>  # Remove quotes from failed mknod calls. Starting with Coreutils v8.25,
> -- 
> 2.24.0
> 
