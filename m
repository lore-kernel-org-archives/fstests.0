Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCDBC433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Nov 2021 20:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbhK3UhH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 30 Nov 2021 15:37:07 -0500
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:43136 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233340AbhK3UhH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 30 Nov 2021 15:37:07 -0500
Received: from dread.disaster.area (pa49-195-103-97.pa.nsw.optusnet.com.au [49.195.103.97])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id DB997605D88;
        Wed,  1 Dec 2021 07:33:45 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ms9ou-00FArl-Ar; Wed, 01 Dec 2021 07:33:44 +1100
Date:   Wed, 1 Dec 2021 07:33:44 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Stefan Roesch <shr@fb.com>
Cc:     fstests@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v1 1/2] fstress: add suport for using liburing setxattr
Message-ID: <20211130203344.GC3447530@dread.disaster.area>
References: <20211129221542.2549306-1-shr@fb.com>
 <20211129221542.2549306-2-shr@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129221542.2549306-2-shr@fb.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=61a68aaa
        a=fP9RlOTWD4uZJjPSFnn6Ew==:117 a=fP9RlOTWD4uZJjPSFnn6Ew==:17
        a=kj9zAlcOel0A:10 a=IOMw9HtfNCkA:10 a=FOH2dFAWAAAA:8 a=7-415B0cAAAA:8
        a=_FsNpWjsdR8Lwq7os7kA:9 a=CjuIK1q_8ugA:10 a=i3VuKzQdj-NEYjvDI-p3:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Nov 29, 2021 at 02:15:41PM -0800, Stefan Roesch wrote:
> Summary:
> 
> Liburing added support for setxattr. This change adds
> support for this this in fsstress when fsstress is built
> with liburing support.
> 
> Signed-off-by: Stefan Roesch <shr@fb.com>
> ---
>  ltp/fsstress.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> index 003e0e49..4a5c4afe 100644
> --- a/ltp/fsstress.c
> +++ b/ltp/fsstress.c
> @@ -4779,6 +4779,43 @@ setattr_f(opnum_t opno, long r)
>  	close(fd);
>  }
>  
> +static int
> +io_uring_setxattr(const char *path, const char *name, const void *value, size_t size,
> +	  	  int flags)
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
>  void
>  setfattr_f(opnum_t opno, long r)
>  {
> @@ -4842,7 +4879,11 @@ setfattr_f(opnum_t opno, long r)
>  		goto out;
>  	}
>  
> -	e = setxattr(f.path, name, value, value_len, flag) < 0 ? errno : 0;
> +	if (have_io_uring)
> +		e = io_uring_setxattr(f.path, name, value, value_len, flag);
> +	else
> +		e = setxattr(f.path, name, value, value_len, flag) < 0 ? errno : 0;

While this is technically correct, it is architecturally wrong.
This replaces testing of the existing setxattr() syscall path on
systems that have io_uring enabled (which is most modern, upstream
test instances). That's a significant regression in test coverage,
especially given that most applications using xattrs do not use
io_uring...

The io_uring functionality should be added in the same way that
OP_URING_READ/OP_URING_WRITE were added. That is, new
operations were added in addition to the existing syscall based
OP_READ/OP_WRITE, OP_READV/OP_WRITEV and the AIO based versions
OP_AREAD/OP_AWRITE.

This way fsstress adds the io_uring mechanisms in addition to all
the normal syscall methods it already uses rather than replacing
them. This also allow io_uring operations to race with existing
syscall operations running the same operations on the same files
concurrently...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
