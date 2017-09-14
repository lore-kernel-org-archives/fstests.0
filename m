Received: from mx1.redhat.com ([209.132.183.28]:44422 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751132AbdINGY5 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 14 Sep 2017 02:24:57 -0400
Date: Thu, 14 Sep 2017 14:24:54 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] fsync-err: write to different offset on each fd
Message-ID: <20170914062454.GG8034@eguan.usersys.redhat.com>
References: <20170913130624.24028-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170913130624.24028-1-jlayton@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: fstests@vger.kernel.org, neilb@suse.com
List-ID: <fstests@vger.kernel.org>

On Wed, Sep 13, 2017 at 09:06:24AM -0400, Jeff Layton wrote:
> From: Jeff Layton <jlayton@redhat.com>
> 
> NFS currently has slightly different semantics from other fs' and
> fails this test due to the fact that the same range is overwritten
> via each fd.

generic/441 and generic/442 require the SCRATCH_DEV to be a real block
device, tests should be skipped as _notrun on NFS, and I didn't expect a
test failure on NFS..

> 
> Change it so that each fd overwrites a different region, which is
> more representative of a real workload anyway.
> 
> Reported-by: Neil Brown <neilb@suse.com>
> Signed-off-by: Jeff Layton <jlayton@redhat.com>

But the change looks fine to me.

Thanks,
Eryu
> ---
>  src/fsync-err.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/fsync-err.c b/src/fsync-err.c
> index 4b0205cf2fd4..146688ddb01e 100644
> --- a/src/fsync-err.c
> +++ b/src/fsync-err.c
> @@ -106,7 +106,7 @@ int main(int argc, char **argv)
>  	memset(buf, 0x7c, bufsize);
>  
>  	for (i = 0; i < numfds; ++i) {
> -		ret = write(fd[i], buf, bufsize);
> +		ret = pwrite(fd[i], buf, bufsize, i * bufsize);
>  		if (ret < 0) {
>  			printf("First write on fd[%d] failed: %m\n", i);
>  			return 1;
> @@ -149,7 +149,7 @@ int main(int argc, char **argv)
>  	}
>  
>  	for (i = 0; i < numfds; ++i) {
> -		ret = write(fd[i], buf, bufsize);
> +		ret = pwrite(fd[i], buf, bufsize, i * bufsize);
>  		if (ret < 0) {
>  			printf("Second write on fd[%d] failed: %m\n", i);
>  			return 1;
> -- 
> 2.13.5
> 
