Received: from aserp2130.oracle.com ([141.146.126.79]:40842 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfBUQOx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 Feb 2019 11:14:53 -0500
Date: Thu, 21 Feb 2019 08:14:42 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] src/Makefile: Link clock_gettime(2) with -lrt
Message-ID: <20190221161442.GK6477@magnolia>
References: <1550734741-4375-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550734741-4375-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Feb 21, 2019 at 03:39:01PM +0800, Xiao Yang wrote:
> Compiling t_open_tmpfiles.c failed on older glibc(before glibc v2.17)
> because clock_gettime(2) was not linked with -lrt, as below:
> --------------------------------------------------------------------
> /home/yangxiao/xfstests/src/t_open_tmpfiles.c:36: undefined reference to `clock_gettime'
> --------------------------------------------------------------------
> 
> According to clock_gettime(2) manpage, we should link clock_gettime(2)
> with -lrt on older glibc.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Looks good to me, sorry about that...

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  src/Makefile |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/src/Makefile b/src/Makefile
> index dbba7c7..4057d7b 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -31,7 +31,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  
>  SUBDIRS = log-writes perf
>  
> -LLDLIBS = $(LIBATTR) $(LIBHANDLE) $(LIBACL) -lpthread
> +LLDLIBS = $(LIBATTR) $(LIBHANDLE) $(LIBACL) -lpthread -lrt
>  
>  ifeq ($(HAVE_XLOG_ASSIGN_LSN), true)
>  LINUX_TARGETS += loggen
> -- 
> 1.7.1
> 
> 
> 
