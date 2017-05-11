Received: from mx1.redhat.com ([209.132.183.28]:45792 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751843AbdEKF6p (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 11 May 2017 01:58:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 48863804EF
        for <fstests@vger.kernel.org>; Thu, 11 May 2017 05:58:44 +0000 (UTC)
Date: Thu, 11 May 2017 13:58:42 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] src/seek_sanity_test: Fix for filesystems without
 delayed allocation
Message-ID: <20170511055842.GF7250@eguan.usersys.redhat.com>
References: <1494416764-22528-1-git-send-email-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1494416764-22528-1-git-send-email-agruenba@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, May 10, 2017 at 01:46:04PM +0200, Andreas Gruenbacher wrote:
> src/seek_sanity_test (test generic/285) assumes that after fallocating
> space in a file, fseek SEEK_HOLE / SEEK_DATA will still report the
> allocated space as a hole.  This isn't true on filesystems that don't
> support delayed allocation, so skip the affected tests in that case.
> 
> Tested on xfs and gfs2 + patches for fseek SEEK_HOLE / SEEK_DATA.

I'm not sure if this is really about delayed allocation, I tried
nodelalloc mounted ext4, test still passed. And the following test
reported fallocated space as HOLE, on both delalloc and nodelalloc
mounted ext4:

[root@bootp-73-5-205 xfstests]# grep vda6 /proc/mounts 
/dev/vda6 /mnt/ext4 ext4 rw,seclabel,relatime,nodelalloc,data=ordered 0 0
[root@bootp-73-5-205 xfstests]# rm /mnt/ext4/testfile 
[root@bootp-73-5-205 xfstests]# xfs_io -fc "falloc 0 1m" -c "seek -h 0" -c "seek -d 0" /mnt/ext4/testfile
Whence  Result
HOLE    0
Whence  Result
DATA    EOF
[root@bootp-73-5-205 xfstests]# mount -o remount,delalloc /mnt/ext4
[root@bootp-73-5-205 xfstests]# grep vda6 /proc/mounts 
/dev/vda6 /mnt/ext4 ext4 rw,seclabel,relatime,data=ordered 0 0
[root@bootp-73-5-205 xfstests]# rm /mnt/ext4/testfile 
[root@bootp-73-5-205 xfstests]# xfs_io -fc "falloc 0 1m" -c "seek -h 0" -c "seek -d 0" /mnt/ext4/testfile
Whence  Result
HOLE    0
Whence  Result
DATA    EOF

I noticed that test07/8/9 are the only three that test unwritten
extents, perhaps not supporting unwritten extents are the reason?

Thanks,
Eryu

> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  src/seek_sanity_test.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
> index a6dd48c..86ddf1c 100644
> --- a/src/seek_sanity_test.c
> +++ b/src/seek_sanity_test.c
> @@ -37,6 +37,7 @@
>  
>  static blksize_t alloc_size;
>  int default_behavior = 0;
> +int delayed_allocation = 1;
>  char *base_file_path;
>  
>  static void get_file_system(int fd)
> @@ -282,6 +283,12 @@ static int test09(int fd, int testnum)
>  	int bufsz = alloc_size;
>  	int filsz = 8 << 20;
>  
> +	if (!delayed_allocation) {
> +		/* Report success if fs doesn't support delayed allocation */
> +		fprintf(stdout, "Test skipped as fs doesn't support delayed allocation\n");
> +		goto out;
> +	}
> +
>  	/*
>  	 * HOLE - unwritten DATA in dirty page - HOLE -
>  	 * unwritten DATA in writeback page
> @@ -338,6 +345,12 @@ static int test08(int fd, int testnum)
>  	int bufsz = alloc_size;
>  	int filsz = 4 << 20;
>  
> +	if (!delayed_allocation) {
> +		/* Report success if fs doesn't support delayed allocation */
> +		fprintf(stdout, "Test skipped as fs doesn't support delayed allocation\n");
> +		goto out;
> +	}
> +
>  	/* HOLE - unwritten DATA in writeback page */
>  	/* Each unit is bufsz */
>  	buf = do_malloc(bufsz);
> @@ -387,6 +400,12 @@ static int test07(int fd, int testnum)
>  	int bufsz = alloc_size;
>  	int filsz = 4 << 20;
>  
> +	if (!delayed_allocation) {
> +		/* Report success if fs doesn't support delayed allocation */
> +		fprintf(stdout, "Test skipped as fs doesn't support delayed allocation\n");
> +		goto out;
> +	}
> +
>  	/* HOLE - unwritten DATA in dirty page */
>  	/* Each unit is bufsz */
>  	buf = do_malloc(bufsz);
> @@ -776,6 +795,14 @@ static int test_basic_support(void)
>  		fprintf(stderr, "File system supports the default behavior.\n");
>  	}
>  
> +	ftruncate(fd, 0);
> +	fallocate(fd, 0, 0, 1 << 20);
> +	pos = lseek(fd, 0, SEEK_DATA);
> +	if (pos == 0) {
> +		fprintf(stderr, "File system does not support delayed allocation.\n");
> +		delayed_allocation = 0;
> +	}
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
