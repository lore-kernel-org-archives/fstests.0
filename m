Received: from mx1.redhat.com ([209.132.183.28]:55586 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932406AbdELFJ0 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 12 May 2017 01:09:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9DA3BC04B30E
        for <fstests@vger.kernel.org>; Fri, 12 May 2017 05:09:25 +0000 (UTC)
Date: Fri, 12 May 2017 13:09:22 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] src/seek_sanity_test: Fix for filesystems without
 unwritten extent support
Message-ID: <20170512050922.GK7250@eguan.usersys.redhat.com>
References: <1494502507-27742-1-git-send-email-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1494502507-27742-1-git-send-email-agruenba@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, May 11, 2017 at 01:35:07PM +0200, Andreas Gruenbacher wrote:
> src/seek_sanity_test (test generic/285) assumes that after preallocating
> space in a file with fallocate, fseek SEEK_HOLE / SEEK_DATA will still
> report the allocated space as a hole.  On filesystems without unwritten
> extent support, that space will be reported as data, though.
> 
> Tested on ext4, xfs, and gfs2 + patches for fseek SEEK_HOLE / SEEK_DATA
> support.

The idea seems fine to me, but I'm not that familiar with SEEK_DATA/HOLE
support, it'd be great if someone else could help review this patch.

Some of my thoughts inline.

> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  src/seek_sanity_test.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
> index a6dd48c..0d7fa0a 100644
> --- a/src/seek_sanity_test.c
> +++ b/src/seek_sanity_test.c
> @@ -37,6 +37,7 @@
>  
>  static blksize_t alloc_size;
>  int default_behavior = 0;
> +int unwritten_extents = 0;
>  char *base_file_path;
>  
>  static void get_file_system(int fd)
> @@ -282,6 +283,11 @@ static int test09(int fd, int testnum)
>  	int bufsz = alloc_size;
>  	int filsz = 8 << 20;
>  
> +	if (!unwritten_extents) {
> +		fprintf(stdout, "Test skipped\n");
> +		goto out;
> +	}
> +
>  	/*
>  	 * HOLE - unwritten DATA in dirty page - HOLE -
>  	 * unwritten DATA in writeback page
> @@ -338,6 +344,11 @@ static int test08(int fd, int testnum)
>  	int bufsz = alloc_size;
>  	int filsz = 4 << 20;
>  
> +	if (!unwritten_extents) {
> +		fprintf(stdout, "Test skipped\n");
> +		goto out;
> +	}
> +
>  	/* HOLE - unwritten DATA in writeback page */
>  	/* Each unit is bufsz */
>  	buf = do_malloc(bufsz);
> @@ -387,6 +398,11 @@ static int test07(int fd, int testnum)
>  	int bufsz = alloc_size;
>  	int filsz = 4 << 20;
>  
> +	if (!unwritten_extents) {
> +		fprintf(stdout, "Test skipped\n");
> +		goto out;
> +	}
> +
>  	/* HOLE - unwritten DATA in dirty page */
>  	/* Each unit is bufsz */
>  	buf = do_malloc(bufsz);
> @@ -776,6 +792,25 @@ static int test_basic_support(void)
>  		fprintf(stderr, "File system supports the default behavior.\n");
>  	}
>  
> +	ftruncate(fd, 0);
> +	if (fallocate(fd, 0, 0, alloc_size) == -1) {
> +		if (errno == EOPNOTSUPP) {
> +			fprintf(stderr, "File system does not support fallocate.");
> +		} else {
> +			fprintf(stderr, "ERROR %d: Failed to preallocate "
> +				"space to %ld bytes.", errno, (long) alloc_size);
> +		}

Use do_fallocate here? It already did the EOPNOTSUPP check. And
introduce another flag, e.g. prealloc, to save the fallocate support
status? So that test0[7-9] don't have to do the EOPNOTSUPP check again.

> +		fprintf(stderr, "  Skipping unwritten extent tests.\n");
> +		goto out;
> +	} else {
> +		pos = lseek(fd, 0, SEEK_DATA);

Hmm, it's hard to tell if it's a bug in lseek or the fs doesn't support
unwritten extents, because we're going to test lseek SEEK_DATA/HOLE
interface.

How about using fiemap and check the FIEMAP_EXTENT_UNWRITTEN flag? Only
falling back to lseek if fiemap is not supported?

Thanks,
Eryu

> +		if (pos == 0) {
> +			fprintf(stderr, "File system does not support unwritten extents.\n");
> +			goto out;
> +		}
> +	}
> +	unwritten_extents = 1;
> +
>  	printf("\n");
>  
>  out:
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
