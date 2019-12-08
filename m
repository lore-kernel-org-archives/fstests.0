Return-Path: <SRS0=dvpu=Z6=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF819C43603
	for <linux-fstests@archiver.kernel.org>; Sun,  8 Dec 2019 15:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 880A1205ED
	for <linux-fstests@archiver.kernel.org>; Sun,  8 Dec 2019 15:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5j6kTBM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfLHPud (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 8 Dec 2019 10:50:33 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39464 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfLHPuc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 8 Dec 2019 10:50:32 -0500
Received: by mail-pg1-f193.google.com with SMTP id b137so5795663pga.6
        for <fstests@vger.kernel.org>; Sun, 08 Dec 2019 07:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uncGkZgzIhdVdlpcftvhQOdEa9MWZm0N28vXhFGdn6k=;
        b=M5j6kTBMmakIq47TGMai+Ye2DTgHVubz7eSjgKNZoggt7vp/+RMXYVEwJA1eFHHnvI
         7uaQ+z9ByWyR0H/dtsnS9limy9/u/5c6mDcEg7gSSteM9XP6EBamWYbigHsHQYP14lBa
         uowyilr0bW00c5qHH0OSOf3feAi6pvGHah53w6VqQ9vlcFh0lPk11X6bKBvAXdutAGZu
         N0uNoT9SSmzks4ayqUbTbjOw4DHo0srKMfFz1OneBXiw53ktfRxoZvy/GOo3vRnQBFyY
         naw9pf1UQHQxt3X2wih7Ke8ynGTyhmfc3OGRjj5Fr2Br/KFiPIftwd+TLOEKo4eg81VN
         bnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uncGkZgzIhdVdlpcftvhQOdEa9MWZm0N28vXhFGdn6k=;
        b=OCg6LQujORq0lK5FkmWDcho6k3aajn0p6cMncGDB107+9+G97s0e21X9qYWSt3CYZn
         IuvaXT02+kPGXZ76vbuBGRQz5QUvpLCC8IWBDix84fPFHWd6JjFX6HRwVK54WWJMfZ5O
         uQjvVT20jIceMDoSXraiP+1LuFsnbmjISqNERbIlQ0IcljZLeal3KjAom+7fAt0dznpO
         JiJhAOnqBt5fFqBkDrcjzGXZDqk/720p2Ab9F7mODDQhebu1mTDNEtR7e6aQQ0mkKjD2
         wAeNBWuHsnLuzx8lVAg7iqGTWdPOnKKJa+em5RgnsVaErqTK3dL1LzuywSKx8Nj0N4CW
         yIrA==
X-Gm-Message-State: APjAAAUc8cq0h/XUc3TkDJ8EttWi7Wzr4obmihw8FHfbegk0bX79vG40
        vXbMP0/P+Xl2+Yt6V6+PNq1zOEJ2
X-Google-Smtp-Source: APXvYqyx8bD7H38hnR5GNmGn8imTJ7SJTgB+XOe1jciLyL0zrE7w92PzX8EsLL75fVCphhTGD3i6Bg==
X-Received: by 2002:a62:6246:: with SMTP id w67mr26001961pfb.130.1575820232203;
        Sun, 08 Dec 2019 07:50:32 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id z30sm12177309pfq.154.2019.12.08.07.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2019 07:50:31 -0800 (PST)
Date:   Sun, 8 Dec 2019 23:50:26 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Kusanagi Kouichi <slash@ac.auone-net.jp>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/filter: Don't use strtonum
Message-ID: <20191208155026.GM8664@desktop>
References: <20191202094302206.XGZM.12759.ppp.dion.ne.jp@dmta0004.auone-net.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202094302206.XGZM.12759.ppp.dion.ne.jp@dmta0004.auone-net.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Dec 02, 2019 at 06:43:01PM +0900, Kusanagi Kouichi wrote:
> It's a gawk extension and not needed. Make tests pass with non-gawk.

gawk is listed in README as one of the "prerequisite packages", so I
think using gawk extention is fine. But if we could get rid of it
easily, that will be better.

Thanks for the fix!

Eryu

> 
> Signed-off-by: Kusanagi Kouichi <slash@ac.auone-net.jp>
> ---
>  common/filter     | 23 +++++++++++++----------
>  tests/generic/386 |  2 +-
>  tests/xfs/009     | 10 +++++-----
>  3 files changed, 19 insertions(+), 16 deletions(-)
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
> diff --git a/tests/generic/386 b/tests/generic/386
> index 462c5869..ba6e654e 100755
> --- a/tests/generic/386
> +++ b/tests/generic/386
> @@ -75,7 +75,7 @@ _filter_quota_rpt() {
>  	# This function parses the human-readable values produced
>  	# by xfs_quota output
>  	function byte_size(value,  result) {
> -		result = strtonum(value);
> +		result = value;
>  		unit = value;
>  		gsub("[0-9][0-9]*", "", unit);
>  		shift = index("KMGTPE", unit);
> diff --git a/tests/xfs/009 b/tests/xfs/009
> index 6a31514c..956c4772 100755
> --- a/tests/xfs/009
> +++ b/tests/xfs/009
> @@ -66,12 +66,12 @@ _block_filter()
>  
>  	/CMD/ {
>  		split($3, off, "=")
> -		offset = strtonum(off[2])
> +		offset = off[2]
>  		if (offset != -1)
>  			offset = offset / bsize
>  
>  		split($4, len, "=")
> -		nr_blocks = strtonum(len[2])
> +		nr_blocks = len[2]
>  		if (nr_blocks != -1)
>  			nr_blocks = nr_blocks / bsize
>  
> @@ -82,13 +82,13 @@ _block_filter()
>  
>  	/MAP/ {
>  		split($2, off, "=")
> -		offset = strtonum(off[2])
> +		offset = off[2]
>  		if (offset != -1)
>  			offset = offset / bsize
>  
>  		split($3, len, "=")
>  
> -		nr_blocks = strtonum(len[2])
> +		nr_blocks = len[2]
>  
>  		if (nr_blocks != -1)
>  			nr_blocks = nr_blocks / bsize
> @@ -100,7 +100,7 @@ _block_filter()
>  
>  	/TRUNCATE/ {
>  		split($2, off, "=")
> -		offset = strtonum(off[2]) / bsize
> +		offset = off[2] / bsize
>  
>  		printf("    %s off=%s\n", $1, offset)
>  
> -- 
> 2.24.0
> 
