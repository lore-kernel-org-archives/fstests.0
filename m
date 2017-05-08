Received: from mx1.redhat.com ([209.132.183.28]:46058 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751440AbdEHIwh (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 8 May 2017 04:52:37 -0400
Date: Mon, 8 May 2017 16:52:34 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] src/seek_sanity_test: ensure file size is big enough
Message-ID: <20170508085234.GV7250@eguan.usersys.redhat.com>
References: <20170505145723.13582-1-lhenriques@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170505145723.13582-1-lhenriques@suse.com>
Sender: fstests-owner@vger.kernel.org
To: Luis Henriques <lhenriques@suse.com>
Cc: fstests@vger.kernel.org, "Yan, Zheng" <ukernel@gmail.com>
List-ID: <fstests@vger.kernel.org>

On Fri, May 05, 2017 at 03:57:23PM +0100, Luis Henriques wrote:
> Tests test07, test08, and test09 preallocate a file and assume the file
> size used is bigger than 10xbufsz (100xbufsz for test09).  This patch
> adjusts the file size so this assumption is always true.
> 
> As an example, here's test06 output for cephfs, where the allocation size
                        ^^^^^^ meant test07?
> is set to 4194304, and the output is (4194304 * 10 + 4194304)
> 
>   07. Test file with unwritten extents, only have dirty pages
>   07.01 SEEK_HOLE expected 0 or 4194304, got 46137344.              FAIL
>   07.02 SEEK_HOLE expected 1 or 4194304, got 46137344.              FAIL
> 
> (Note: The test will be skipped if an integer overflow occurs.)
> 
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
>  src/seek_sanity_test.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
> index a6dd48cc257b..41da59801212 100644
> --- a/src/seek_sanity_test.c
> +++ b/src/seek_sanity_test.c
> @@ -282,6 +282,13 @@ static int test09(int fd, int testnum)
>  	int bufsz = alloc_size;
>  	int filsz = 8 << 20;
>  
> +	while ((filsz < (bufsz * 100 + bufsz)) && (filsz > 0))
> +		filsz <<= 1;
> +	if (filsz <= 0) {
> +		fprintf(stdout, "Test skipped due to int overflow.\n");
> +		return ret;
> +	}
> +

Hmm, why not just set filsz to (bufsz * 100 + bufsz)? This works for me
on XFS/ext4/btrfs and NFS, I guess it should work for cepthfs too?

Thanks,
Eryu

>  	/*
>  	 * HOLE - unwritten DATA in dirty page - HOLE -
>  	 * unwritten DATA in writeback page
> @@ -338,6 +345,13 @@ static int test08(int fd, int testnum)
>  	int bufsz = alloc_size;
>  	int filsz = 4 << 20;
>  
> +	while ((filsz < (bufsz * 10 + bufsz)) && (filsz > 0))
> +		filsz <<= 1;
> +	if (filsz <= 0) {
> +		fprintf(stdout, "Test skipped due to int overflow.\n");
> +		return ret;
> +	}
> +
>  	/* HOLE - unwritten DATA in writeback page */
>  	/* Each unit is bufsz */
>  	buf = do_malloc(bufsz);
> @@ -387,6 +401,13 @@ static int test07(int fd, int testnum)
>  	int bufsz = alloc_size;
>  	int filsz = 4 << 20;
>  
> +	while ((filsz < (bufsz * 10 + bufsz)) && (filsz > 0))
> +		filsz <<= 1;
> +	if (filsz <= 0) {
> +		fprintf(stdout, "Test skipped due to int overflow.\n");
> +		return ret;
> +	}
> +
>  	/* HOLE - unwritten DATA in dirty page */
>  	/* Each unit is bufsz */
>  	buf = do_malloc(bufsz);
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
