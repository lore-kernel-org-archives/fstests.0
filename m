Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C16C433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 12 Dec 2021 15:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhLLPKN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 12 Dec 2021 10:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhLLPKM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 12 Dec 2021 10:10:12 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8599BC061714
        for <fstests@vger.kernel.org>; Sun, 12 Dec 2021 07:10:12 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id t9so23047959wrx.7
        for <fstests@vger.kernel.org>; Sun, 12 Dec 2021 07:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rs0uqx2/T3p/nT4vRiSP9TOPefge7IMrOG0RJ5mrkdc=;
        b=UX3ZIXSuf0i4a63ftagbfJyKuBBXwzoE6nOKK4X1h3cfWuRbBl8bAXkPTqr+UY718D
         rekQoyIfUq0umAROzA/SzKucIO0wlcQC19iQ4x8w+sXwzEh+rg4B7RbF7aL+0bHBnMqX
         YIRM/o5H6N7Fu9pM7RqkmUiQmsmtUZJ4wc8itLNrKju5Jc5L8uRqJkZGTzlq0kL66Bvo
         kZFk4Y+uvo8XB2VZz/YwNCNwSy/eJG1o06SFeHyop69ZPfcNaF7zXTRCy9PkU18gjq/A
         0CZjF5CewXq3TBTdxk/+dYvEBie1mTwHtWlH3pzQlfYvQPWRoCISjY4HV9gpU06732ql
         ryPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rs0uqx2/T3p/nT4vRiSP9TOPefge7IMrOG0RJ5mrkdc=;
        b=u2Ry7VKB/2KFEzn+Qw+BQdOa9De77qmdk+OFLGQDfpvsW6/rHlLlFUZBZOrStDOmZz
         8dxHkmdRgoAtX3NEGLlYcwrycazNFOGKXFTQlD0kY93RaLfvr+K24AYAnSx3g3XPIb8U
         v8llJrbQKihQ9fccc2cdLfDzU7pSMM5AXvrqpP4MIzxsooiJ7AVyJOhiG01hofPN0lwo
         xSDYgUbToj19yQI4YnxAmz6V2XpGpleNk8I0ZSkOKAXZSvMkRz/K1xVdyd53sZDDnsZG
         kRNNmvWjXcUrOO4gXgIeK7XE6WsLm+mMb+GZQhEymsAJ5CgFPoB2q5NPmJPYa/Y+u8P8
         M2+w==
X-Gm-Message-State: AOAM532TzIJlozlfnZpkNVNRi3d+LFS3JX3oF4CKBzn1roDLrKCtS1jA
        +ouPj5jm92+94MmR78yTqaWtuEDhoMA=
X-Google-Smtp-Source: ABdhPJyUVOOqBl23eUQ8uy47Fp8pvo7HHtSf43CXpYhg3pqZIaNYPF8+9T9j/Gkvdeb2oepLsQspWg==
X-Received: by 2002:a5d:47ab:: with SMTP id 11mr26255401wrb.148.1639321811048;
        Sun, 12 Dec 2021 07:10:11 -0800 (PST)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id i15sm4950131wmq.18.2021.12.12.07.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 07:10:10 -0800 (PST)
Date:   Sun, 12 Dec 2021 23:10:06 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Stefan Roesch <shr@fb.com>
Cc:     fstests@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 2/2] fstress: add suport for using liburing getxattr
Message-ID: <YbYQzuCotSQNkLK9@desktop>
References: <20211201055202.3142034-1-shr@fb.com>
 <20211201055202.3142034-3-shr@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201055202.3142034-3-shr@fb.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Nov 30, 2021 at 09:52:02PM -0800, Stefan Roesch wrote:
> Liburing added support for getxattr. This change adds
> support for this this in fsstress when fsstress is built
> with liburing support.
> 
> Signed-off-by: Stefan Roesch <shr@fb.com>
> ---
>  ltp/fsstress.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 59 insertions(+), 4 deletions(-)
> 
> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> index aba7c6f7..5a18701a 100644
> --- a/ltp/fsstress.c
> +++ b/ltp/fsstress.c
> @@ -145,6 +145,7 @@ typedef enum {
>  	OP_URING_WRITE,
>  	OP_WRITE,
>  	OP_WRITEV,
> +	OP_URING_GETXATTR,
>  	OP_URING_SETXATTR,
>  	OP_LAST
>  } opty_t;
> @@ -152,6 +153,7 @@ typedef enum {
>  typedef long long opnum_t;
>  
>  typedef void (*opfnc_t)(opnum_t, long);
> +typedef ssize_t (*getxattr_cbk)(const char *, const char *, void *, size_t);
>  typedef int (*setxattr_cbk)(const char *, const char *, const void *, size_t, int);
>  
>  typedef struct opdesc {
> @@ -279,6 +281,7 @@ void	uring_read_f(opnum_t, long);
>  void	uring_write_f(opnum_t, long);
>  void	write_f(opnum_t, long);
>  void	writev_f(opnum_t, long);
> +void	uring_getxattr_f(opnum_t, long);
>  void	uring_setxattr_f(opnum_t, long);
>  char	*xattr_flag_to_string(int);
>  
> @@ -350,6 +353,7 @@ opdesc_t	ops[] = {
>  	{ OP_URING_WRITE, "uring_write", uring_write_f, 1, 1 },
>  	{ OP_WRITE, "write", write_f, 4, 1 },
>  	{ OP_WRITEV, "writev", writev_f, 4, 1 },
> +	{ OP_URING_GETXATTR, "uring_getxattr", uring_getxattr_f, 1, 0 },
>  	{ OP_URING_SETXATTR, "uring_setxattr", uring_setxattr_f, 1, 1 },
>  }, *ops_end;
>  
> @@ -3899,8 +3903,44 @@ getdents_f(opnum_t opno, long r)
>  	closedir(dir);
>  }
>  
> -void
> -getfattr_f(opnum_t opno, long r)
> +static ssize_t
> +io_uring_getxattr(const char *path, const char *name, void *value, size_t size)
> +{
> +	struct io_uring_sqe *sqe;
> +	struct io_uring_cqe *cqe;
> +	int ret;
> +
> +	sqe = io_uring_get_sqe(&ring);
> +	if (!sqe) {
> +		printf("io_uring_get_sqe failed\n");
> +		ret = -1;
> +		goto out;
> +	}
> +
> +	io_uring_prep_getxattr(sqe, name, value, path, size);
> +
> +	ret = io_uring_submit_and_wait(&ring, 1);
> +	if (ret != 1) {
> +		printf("io_uring_submit_and_wait failed, ret=%d\n", ret);
> +		ret = -1;
> +		goto out;
> +    	}
> +
> +	ret = io_uring_wait_cqe(&ring, &cqe);
> +	if (ret < 0) {
> +		printf("io_uring_wait_cqe failed, ret=%d\n", ret);
> +		goto out;
> +	}
> +
> +	ret = cqe->res;
> +	io_uring_cqe_seen(&ring, cqe);
> +
> +out:
> +	return ret;
> +}
> +
> +static void
> +getfattr_f_cbk(opnum_t opno, long r, getxattr_cbk cbk)
>  {
>  	fent_t	        *fep;
>  	int		e;
> @@ -3936,7 +3976,7 @@ getfattr_f(opnum_t opno, long r)
>  		goto out;
>  	}
>  
> -	value_len = getxattr(f.path, name, NULL, 0);
> +        value_len = cbk(f.path, name, NULL, 0);

Use tab for indention here.

Thanks,
Eryu

>  	if (value_len < 0) {
>  		if (v)
>  			printf("%d/%lld: getfattr file %s name %s failed %d\n",
> @@ -3958,7 +3998,8 @@ getfattr_f(opnum_t opno, long r)
>  		goto out;
>  	}
>  
> -	e = getxattr(f.path, name, value, value_len) < 0 ? errno : 0;
> +	e = cbk(f.path, name, value, value_len) < 0 ? errno : 0;
> +
>  out_log:
>  	if (v)
>  		printf("%d/%lld: getfattr file %s name %s value length %d %d\n",
> @@ -3968,6 +4009,20 @@ out:
>  	free_pathname(&f);
>  }
>  
> +void
> +uring_getxattr_f(opnum_t opno, long r)
> +{
> +#ifdef URING
> +	getfattr_f_cbk(opno, r, io_uring_getxattr);
> +#endif
> +}
> +
> +void
> +getfattr_f(opnum_t opno, long r)
> +{
> +	getfattr_f_cbk(opno, r, getxattr);
> +}
> +
>  void
>  link_f(opnum_t opno, long r)
>  {
> -- 
> 2.30.2
