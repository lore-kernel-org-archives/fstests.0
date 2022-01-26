Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AAAC2BA4C
	for <linux-fstests@archiver.kernel.org>; Wed, 26 Jan 2022 06:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiAZGNt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 26 Jan 2022 01:13:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53882 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235212AbiAZGNt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 Jan 2022 01:13:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643177628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TF0FaFoejbH4+YEixXMu4kt3Mg7d0J4mQPXJu5XxpTg=;
        b=b+Ne0TdeDvJ7B7G3HTw3iB0ClHXY603xOMmBhMS9CiHkjvJW8lxhoASDtAKP5OlttU8q4x
        /DcLJKQoWXdgrdnyDPk9ygkDUTrjUoLAdHoIwDa/tu+UEPxpxxcprOKNZtnzEj/CMTMKwZ
        Kr/dBGkYOt3zVt8pvNARENV7Tl5hMQg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-6eJroLNjOYmlID2vVGt3YA-1; Wed, 26 Jan 2022 01:13:46 -0500
X-MC-Unique: 6eJroLNjOYmlID2vVGt3YA-1
Received: by mail-qk1-f198.google.com with SMTP id n3-20020ae9c303000000b00477e4f3dfd2so16458962qkg.21
        for <fstests@vger.kernel.org>; Tue, 25 Jan 2022 22:13:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=TF0FaFoejbH4+YEixXMu4kt3Mg7d0J4mQPXJu5XxpTg=;
        b=PwbPMBxsNBFWuH3j1kYqMDFigPxLkpVy4YvtTF2ow24Ypg3BoMfN+2wi2NyfmUjAkE
         j8c3tvNoKr9sAqMLI/TmjoQHW/u4fnL2ZuEydB919MrUybf9FqYqKJat77SGRzrzDLcI
         WroEzr9z9o1JWYKWLglj7eK4uj9K3OF9BDJtoHdO29QDl6FwRkb9iJ0r2qWDnd5JSfFP
         JJN1OyHLCsaqguRFD15atGjfXxuJANssUccLzEJmXX0qFFzLmxmNFEMHO1dEyAn8A/l6
         jXvEoJ4FbkJsCYJZYQqFikJC2x+1izrVXOnrpnoNG0kT0+ZmLm3p6Fkk2SiK3dXN3hnv
         1U6Q==
X-Gm-Message-State: AOAM533trLjSa5tvTdZf4o/00Loaf30vxzyroAue0F1I7eZJgi1kwyaw
        5HiiYJHFaSxfZXLTuzql7nH0R4X5a3/hMLdhdVtQAfalxFWNgCxR3xM1Exb+kw4jqucoWlf/Rnq
        ACZIBWCsNPm9W8j9Pmg==
X-Received: by 2002:a05:6214:2a87:: with SMTP id jr7mr22419168qvb.56.1643177625784;
        Tue, 25 Jan 2022 22:13:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzW/KPfKWKt3Qd/NQfa+oPNjey3THWJBwhkcIXAGZhxRidV5MSaJsZZZxB8WsdjmRjSnvyKtA==
X-Received: by 2002:a05:6214:2a87:: with SMTP id jr7mr22419158qvb.56.1643177625575;
        Tue, 25 Jan 2022 22:13:45 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f9sm8660379qkp.94.2022.01.25.22.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 22:13:45 -0800 (PST)
Date:   Wed, 26 Jan 2022 14:13:38 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     guaneryu@gmail.com, linux-xfs@vger.kernel.org,
        fstests@vger.kernel.org, guan@eryu.me
Subject: Re: [PATCH 2/2] fstests: skip tests that require XFS_IOC_ALLOCSP
Message-ID: <20220126061338.emwff4usc2pm4fua@zlang-mailbox>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>, guaneryu@gmail.com,
        linux-xfs@vger.kernel.org, fstests@vger.kernel.org, guan@eryu.me
References: <164316310323.2594527.8578672050751235563.stgit@magnolia>
 <164316311463.2594527.15258066711888915917.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164316311463.2594527.15258066711888915917.stgit@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jan 25, 2022 at 06:11:54PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Deprecating this, so turn off the tests that require it.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

Looks good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/rc      |    4 ++--
>  ltp/fsstress.c |    4 ++++
>  tests/xfs/107  |    1 +
>  3 files changed, 7 insertions(+), 2 deletions(-)
> 
> 
> diff --git a/common/rc b/common/rc
> index b3289de9..6a0648ad 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2507,8 +2507,8 @@ _require_xfs_io_command()
>  		rm -f $testcopy > /dev/null 2>&1
>  		param_checked="$param"
>  		;;
> -	"falloc" )
> -		testio=`$XFS_IO_PROG -F -f -c "falloc $param 0 1m" $testfile 2>&1`
> +	"falloc"|"allocsp")
> +		testio=`$XFS_IO_PROG -F -f -c "$command $param 0 1m" $testfile 2>&1`
>  		param_checked="$param"
>  		;;
>  	"fpunch" | "fcollapse" | "zero" | "fzero" | "finsert" | "funshare")
> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> index 5f3126e6..23188467 100644
> --- a/ltp/fsstress.c
> +++ b/ltp/fsstress.c
> @@ -2045,6 +2045,7 @@ afsync_f(opnum_t opno, long r)
>  void
>  allocsp_f(opnum_t opno, long r)
>  {
> +#ifdef XFS_IOC_ALLOCSP64
>  	int		e;
>  	pathname_t	f;
>  	int		fd;
> @@ -2094,6 +2095,7 @@ allocsp_f(opnum_t opno, long r)
>  	}
>  	free_pathname(&f);
>  	close(fd);
> +#endif
>  }
>  
>  #ifdef AIO
> @@ -3733,6 +3735,7 @@ fiemap_f(opnum_t opno, long r)
>  void
>  freesp_f(opnum_t opno, long r)
>  {
> +#ifdef XFS_IOC_FREESP64
>  	int		e;
>  	pathname_t	f;
>  	int		fd;
> @@ -3781,6 +3784,7 @@ freesp_f(opnum_t opno, long r)
>  		       procid, opno, f.path, st, (long long)off, e);
>  	free_pathname(&f);
>  	close(fd);
> +#endif
>  }
>  
>  void
> diff --git a/tests/xfs/107 b/tests/xfs/107
> index 577094b2..1ea9c492 100755
> --- a/tests/xfs/107
> +++ b/tests/xfs/107
> @@ -20,6 +20,7 @@ _begin_fstest auto quick prealloc
>  _supported_fs xfs
>  _require_test
>  _require_scratch
> +_require_xfs_io_command allocsp		# detect presence of ALLOCSP ioctl
>  _require_test_program allocstale
>  
>  # Create a 256MB filesystem to avoid running into mkfs problems with too-small
> 

