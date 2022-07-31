Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D019C00140
	for <linux-fstests@archiver.kernel.org>; Sun, 31 Jul 2022 14:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237055AbiGaOLx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 31 Jul 2022 10:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiGaOLw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 31 Jul 2022 10:11:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65386DFD7
        for <fstests@vger.kernel.org>; Sun, 31 Jul 2022 07:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659276709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7y/kGwuNZuhNea8ELLSKWPhKu+ItpQUop9AnpDES4F8=;
        b=iZZDHCqVQURb+v87v3TP/Op5vmY8Ahvl1k7TzBytg4Q//yTqYi6DgUflXFUEWwQBgny4mg
        rSpfLx9WBv4yu2aDrWeCoepWFT3pX7zqNXCWqNF1O7owjBIpF9+z0TE6btF369iE+9r1PB
        /+CwKPUT0lFcH4zru7mI8p2MxwmLmcU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-Xio_v7SSP06E313DN6doMw-1; Sun, 31 Jul 2022 10:11:47 -0400
X-MC-Unique: Xio_v7SSP06E313DN6doMw-1
Received: by mail-qv1-f70.google.com with SMTP id o9-20020a0cecc9000000b0047491274bb1so3207847qvq.19
        for <fstests@vger.kernel.org>; Sun, 31 Jul 2022 07:11:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7y/kGwuNZuhNea8ELLSKWPhKu+ItpQUop9AnpDES4F8=;
        b=aO4Ug/cBYWTcAHuGarPoyvbxuywe/HA3ciV7Gw/hSmZ7iPdtRAiI2GJWNiWDnBI6/d
         O+UbtG6duC3/1I6kw1nKCtwS5ZrbjiZOJC31e1Rj/uU6MAQIi2F3YhqWKOuOKcHP8C1I
         RG2RHexmEJV/NSlGdmTWK9+ihg/X2yTOpvpbgRVmQl8puMpUfbhyiJYMZ57BejjKWUdW
         yVkCiL/vqM8cRUa5EcOKdtUGsCHDavW58uA7wMnlMmlDfcZ5ndA+jPrxn+p5hm/edWH2
         174OjnTjY/f434ONwcjg9cwkh/SFi1+5Cia3j5PM5rnrrdG4rF4GJw923fSn9QToHhZc
         ospg==
X-Gm-Message-State: AJIora9Rv9/juxdkwqltclX6/aEAivV6AObjmYq2eLp5f5o4eikEpjAJ
        jbilT7z4/MYSYvzo8aLhVdj8wLVezkHrHtO89h8ZPXH3gvD5i4kGbnKS4NCPJbL7louoYnn/sQH
        yy0XNWlcHj27xzry1mg==
X-Received: by 2002:ac8:7fd1:0:b0:31e:e9c0:c071 with SMTP id b17-20020ac87fd1000000b0031ee9c0c071mr10793645qtk.481.1659276707182;
        Sun, 31 Jul 2022 07:11:47 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vWYpv0aNx9+0zLWA3eWUiV4khO37fILmVnRXdDSplbHni1ups2AEBvFo2Tsp8s4S/06Tt+Aw==
X-Received: by 2002:ac8:7fd1:0:b0:31e:e9c0:c071 with SMTP id b17-20020ac87fd1000000b0031ee9c0c071mr10793624qtk.481.1659276706885;
        Sun, 31 Jul 2022 07:11:46 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id dm26-20020a05620a1d5a00b006af147d4876sm6745307qkb.30.2022.07.31.07.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 07:11:46 -0700 (PDT)
Date:   Sun, 31 Jul 2022 22:11:40 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     liuyd.fnst@fujitsu.com, linux-xfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: [PATCH 3/3] seek_sanity_test: use XFS ioctls to determine file
 allocation unit size
Message-ID: <20220731141140.o2fdzusa7f7o5umc@zlang-mailbox>
References: <165903222941.2338516.818684834175743726.stgit@magnolia>
 <165903224646.2338516.11839049913536195078.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165903224646.2338516.11839049913536195078.stgit@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jul 28, 2022 at 11:17:26AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> liuyd.fnst@fujitsu.com reported that my recent change to the seek sanity
> test broke NFS.  I foolishly thought that st_blksize was sufficient to
> find the file allocation unit size so that applications could figure out
> the SEEK_HOLE granularity.  Replace that with an explicit callout to XFS
> ioctls so that xfs realtime will work again.
> 
> Fixes: e861a302 ("seek_sanity_test: fix allocation unit detection on XFS realtime")
> Reported-by: liuyd.fnst@fujitsu.com
> Tested-by: liuyd.fnst@fujitsu.com
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

This patch looks good to me, and I can reproduce the regression on nfs, then
test passed after merge this patch. So I'd like to merge this patch at first,
to fix that regression for nfs. Others 2 patches are still under discussion,
I'll wait.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  src/seek_sanity_test.c |   36 +++++++++++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 9 deletions(-)
> 
> 
> diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
> index 1030d0c5..78f835e8 100644
> --- a/src/seek_sanity_test.c
> +++ b/src/seek_sanity_test.c
> @@ -40,6 +40,28 @@ static void get_file_system(int fd)
>  	}
>  }
>  
> +/* Compute the file allocation unit size for an XFS file. */
> +static int detect_xfs_alloc_unit(int fd)
> +{
> +	struct fsxattr fsx;
> +	struct xfs_fsop_geom fsgeom;
> +	int ret;
> +
> +	ret = ioctl(fd, XFS_IOC_FSGEOMETRY, &fsgeom);
> +	if (ret)
> +		return -1;
> +
> +	ret = ioctl(fd, XFS_IOC_FSGETXATTR, &fsx);
> +	if (ret)
> +		return -1;
> +
> +	alloc_size = fsgeom.blocksize;
> +	if (fsx.fsx_xflags & XFS_XFLAG_REALTIME)
> +		alloc_size *= fsgeom.rtextsize;
> +
> +	return 0;
> +}
> +
>  static int get_io_sizes(int fd)
>  {
>  	off_t pos = 0, offset = 1;
> @@ -47,6 +69,10 @@ static int get_io_sizes(int fd)
>  	int shift, ret;
>  	int pagesz = sysconf(_SC_PAGE_SIZE);
>  
> +	ret = detect_xfs_alloc_unit(fd);
> +	if (!ret)
> +		goto done;
> +
>  	ret = fstat(fd, &buf);
>  	if (ret) {
>  		fprintf(stderr, "  ERROR %d: Failed to find io blocksize\n",
> @@ -54,16 +80,8 @@ static int get_io_sizes(int fd)
>  		return ret;
>  	}
>  
> -	/*
> -	 * st_blksize is typically also the allocation size.  However, XFS
> -	 * rounds this up to the page size, so if the stat blocksize is exactly
> -	 * one page, use this iterative algorithm to see if SEEK_DATA will hint
> -	 * at a more precise answer based on the filesystem's (pre)allocation
> -	 * decisions.
> -	 */
> +	/* st_blksize is typically also the allocation size */
>  	alloc_size = buf.st_blksize;
> -	if (alloc_size != pagesz)
> -		goto done;
>  
>  	/* try to discover the actual alloc size */
>  	while (pos == 0 && offset < alloc_size) {
> 

