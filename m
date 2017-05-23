Received: from mx1.redhat.com ([209.132.183.28]:46798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933923AbdEWP45 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 23 May 2017 11:56:57 -0400
Date: Tue, 23 May 2017 23:56:54 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] src/seek_sanity_test: fix test15 SEEK_HOLE expected
 results
Message-ID: <20170523155654.GG7250@eguan.usersys.redhat.com>
References: <20170523140618.24387-1-lhenriques@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170523140618.24387-1-lhenriques@suse.com>
Sender: fstests-owner@vger.kernel.org
To: Luis Henriques <lhenriques@suse.com>
Cc: fstests@vger.kernel.org, Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

On Tue, May 23, 2017 at 03:06:18PM +0100, Luis Henriques wrote:
> Filesystesm with the "default behaviour" will always return the offset of
> the end of the file when lseek'ing with SEEK_HOLE.  This test does the
> following:
> 
>  - fallocate 4 << 20 bytes
>  - write PAGE_SIZE bytes at offset 0
>  - writes PAGE_SIZE bytes at offset 4 << 20
> 
> Thus, using lseek in an FS with the "default behaviour" will set the
> position at 4 << 20 + PAGE_SIZE.

Thanks for fixing it! I've tested it on a "default behavior" filesystem
(gfs2) this time, and test passed.

> 
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
>  src/seek_sanity_test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
> index d52e2b6dab79..b35a324c749c 100644
> --- a/src/seek_sanity_test.c
> +++ b/src/seek_sanity_test.c
> @@ -335,8 +335,8 @@ static int test15(int fd, int testnum)
>  		goto out;
>  
>  	/* offset at the beginning */
> -	ret += do_lseek(testnum,  1, fd, filsz, SEEK_HOLE, 0, bufsz);
> -	ret += do_lseek(testnum,  2, fd, filsz, SEEK_HOLE, 1, bufsz);
> +	ret += do_lseek(testnum,  1, fd, filsz + bufsz, SEEK_HOLE, 0, bufsz);
> +	ret += do_lseek(testnum,  2, fd, filsz + bufsz, SEEK_HOLE, 1, bufsz);

I think we should update filsz after the last write, before any
do_lseek() test, because filsz was extended by bufsz and the 4th arg of
do_lseek expects the actual file size.

>  	ret += do_lseek(testnum,  3, fd, filsz, SEEK_DATA, 0, 0);
>  	ret += do_lseek(testnum,  4, fd, filsz, SEEK_DATA, 1, 1);
>  	ret += do_lseek(testnum,  5, fd, filsz, SEEK_DATA, bufsz, filsz);

And the expected result of the 5th test should be 'filsz - bufsz' then.

Thanks,
Eryu

> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
