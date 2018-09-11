Received: from bombadil.infradead.org ([198.137.202.133]:42308 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbeIKMAh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 11 Sep 2018 08:00:37 -0400
Date: Tue, 11 Sep 2018 00:02:44 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] cloner: add support for clone_file_range for cifs
Message-ID: <20180911070244.GA13711@infradead.org>
References: <20180911052806.1302-1-lsahlber@redhat.com>
 <20180911052806.1302-2-lsahlber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911052806.1302-2-lsahlber@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Ronnie Sahlberg <lsahlber@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Sep 11, 2018 at 03:28:06PM +1000, Ronnie Sahlberg wrote:
> Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
> ---
>  src/cloner.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/src/cloner.c b/src/cloner.c
> index ffad82f0..9f9156e5 100644
> --- a/src/cloner.c
> +++ b/src/cloner.c
> @@ -120,6 +120,18 @@ clone_file_range_btrfs(int src_fd, int dst_fd, uint64_t src_off,
>  }
>  
>  static int
> +clone_file_range_cifs(int fd_in, int fd_out, loff_t off_in,
> +		      loff_t off_out, size_t len)
> +{
> +	int ret;
> +
> +	ret = copy_file_range(fd_in, &off_in, fd_out, &off_out, len, 0);
> +	if (ret < 0)
> +		ret = errno;
> +	return 0;
> +}

This is weird.  cloner seems to test clone, in which case it should
test FICLONE (BTRFS_IOC_CLONE) / FICLONERANGE(BTRFS_IOC_CLONE_RANGE).

But it seems to check file system magic numbers which is rather bogus
to start with.  I think the right fix here is to remove all the magic
number checks, always try FICLONE, and also remove support for the
odd legacy cifs ioctl.

>  {
> @@ -128,7 +140,9 @@ clone_file_range(unsigned int fs_type, int src_fd, int dst_fd, uint64_t src_off,
>  		return clone_file_range_btrfs(src_fd, dst_fd, src_off, dst_off,
>  					      len);
>  		break;
> -	case CIFS_MAGIC_NUMBER:	/* only supports full file server-side copies */
> +	case CIFS_MAGIC_NUMBER:
> +		return clone_file_range_cifs(src_fd, dst_fd, src_off, dst_off,
> +					     len);
>  	default:
>  		return ENOTSUP;
>  		break;

And independent break after a return is just insane.  Someone needs
to fix this program to stop the eye bleeding..
