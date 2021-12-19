Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A004C433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 19 Dec 2021 16:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhLSQCf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 19 Dec 2021 11:02:35 -0500
Received: from out20-74.mail.aliyun.com ([115.124.20.74]:49519 "EHLO
        out20-74.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbhLSQCb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 19 Dec 2021 11:02:31 -0500
X-Alimail-AntiSpam: AC=PASS;BC=0.07436319|-1;BR=01201311R141ee;CH=green;DM=|CONTINUE|false|;DS=SPAM|spam_education_ad|0.858081-0.00123852-0.14068;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.MJftpyG_1639929748;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.MJftpyG_1639929748)
          by smtp.aliyun-inc.com(10.147.42.16);
          Mon, 20 Dec 2021 00:02:29 +0800
Date:   Mon, 20 Dec 2021 00:02:28 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Stefan Roesch <shr@fb.com>
Cc:     fstests@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v4 1/2] fstress: add suport for using liburing setxattr
Message-ID: <Yb9XlIZkjnBlHmGZ@desktop>
References: <20211216184319.851514-1-shr@fb.com>
 <20211216184319.851514-2-shr@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216184319.851514-2-shr@fb.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Dec 16, 2021 at 10:43:18AM -0800, Stefan Roesch wrote:
> Summary:
> 
> Liburing added support for setxattr. This change adds
> support for this this in fsstress when fsstress is built
> with liburing support.
> 
> Signed-off-by: Stefan Roesch <shr@fb.com>
> ---
>  ltp/fsstress.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 57 insertions(+), 2 deletions(-)
> 
> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> index 5f3126e6..48d93436 100644
> --- a/ltp/fsstress.c
> +++ b/ltp/fsstress.c
> @@ -145,12 +145,14 @@ typedef enum {
>  	OP_URING_WRITE,
>  	OP_WRITE,
>  	OP_WRITEV,
> +	OP_URING_SETXATTR,
>  	OP_LAST
>  } opty_t;
>  
>  typedef long long opnum_t;
>  
>  typedef void (*opfnc_t)(opnum_t, long);
> +typedef int (*setxattr_cbk)(const char *, const char *, const void *, size_t, int);
>  
>  typedef struct opdesc {
>  	char	*name;
> @@ -276,6 +278,7 @@ void	uring_read_f(opnum_t, long);
>  void	uring_write_f(opnum_t, long);
>  void	write_f(opnum_t, long);
>  void	writev_f(opnum_t, long);
> +void	uring_setxattr_f(opnum_t, long);

Order it by name?

>  char	*xattr_flag_to_string(int);
>  
>  struct opdesc	ops[OP_LAST]	= {
> @@ -346,6 +349,7 @@ struct opdesc	ops[OP_LAST]	= {
>  	[OP_URING_WRITE]   = {"uring_write",   uring_write_f,	1, 1 },
>  	[OP_WRITE]	   = {"write",	       write_f,		4, 1 },
>  	[OP_WRITEV]	   = {"writev",	       writev_f,	4, 1 },
> +	[OP_URING_SETXATTR] = {"uring_setxattr", uring_setxattr_f, 1, 1 },

Make it aligned with other ops as well?

>  }, *ops_end;
>  
>  flist_t	flist[FT_nft] = {
> @@ -4771,8 +4775,45 @@ setattr_f(opnum_t opno, long r)
>  	close(fd);
>  }
>  
> +static int
> +io_uring_setxattr(const char *path, const char *name, const void *value, size_t size,
> +	  	 int flags)

Space before tab in above line.

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
> +	io_uring_prep_setxattr(sqe, name, value, path, flags, size);

Seems we have to wait for the liburing patches go in first, otherwise
we'll hit compile error.

> +
> +	ret = io_uring_submit_and_wait(&ring, 1);
> +	if (ret != 1) {
> +		printf("io_uring_submit_and_wait failed, ret=%d\n", ret);
> +		ret = -1;
> +		goto out;
> +    	}

Space before tab in above line.

Thanks,
Eryu

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
>  void
> -setfattr_f(opnum_t opno, long r)
> +setfattr_f_cbk(opnum_t opno, long r, setxattr_cbk cbk)
>  {
>  	int		e;
>  	pathname_t	f;
> @@ -4834,7 +4875,7 @@ setfattr_f(opnum_t opno, long r)
>  		goto out;
>  	}
>  
> -	e = setxattr(f.path, name, value, value_len, flag) < 0 ? errno : 0;
> +	e = cbk(f.path, name, value, value_len, flag) < 0 ? errno : 0;
>  	if (e == 0)
>  		fep->xattr_counter++;
>  	if (v)
> @@ -4846,6 +4887,20 @@ out:
>  	free_pathname(&f);
>  }
>  
> +void
> +uring_setxattr_f(opnum_t opno, long r)
> +{
> +#ifdef URING
> +	setfattr_f_cbk(opno, r, io_uring_setxattr);
> +#endif
> +}
> +
> +void
> +setfattr_f(opnum_t opno, long r)
> +{
> +	setfattr_f_cbk(opno, r, setxattr);
> +}
> +
>  void
>  snapshot_f(opnum_t opno, long r)
>  {
> -- 
> 2.30.2
