Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6CE47AF5F
	for <fstests@vger.kernel.org>; Mon, 14 Sep 2026 14:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396545; cv=none; b=ssWxixx4WOkxDZQ65QnjkK1FnyAw2m7qGo1f7zB24IJAwLGj3OLvDCneQwsBw34iwLX5epNfzaj0negfpHN8UfPt2GPyjS52AZ9KWL4lHeuOrjpOE1DKMR2RijIlJzGQLXuLZK35RYAjYv2a1YFqRKfsRGrYji8NPp4xYVhmHjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396545; c=relaxed/simple;
	bh=h/fo/IrQbGaeMmbTf7cePlQd2a4asla0GMRsvDxI8lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=As0wdTRRWd4FhjZDnWQnOfUNZ379wk6D8ElAuAEPsxAHkL4x4FDmUtXDOYntJ91ZMWgyRwd6RFMbxeIvbOOKG04i/kIVbBsO0590zh0L/aPcbzdzq6XLr3ZkkshiTneJi1JEYAT2OAFRXzp6qjpAguax0eRsalR0ouUG5jtktRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6H/IVNU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6H/IVNU"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 101541F000FF;
	Mon, 14 Sep 2026 14:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789396544;
	bh=+ZDcv4o51ANQOqL8jlNGIawqF9DXMAB4jswJ2ob+7+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E6H/IVNUW6IK+HEIySBJiFWXAyDl/0mUx0tMoTxXooIAuFVdmZj+ezIL0UNlBqgEK
	 C1ApKaHoDb6YSqj3X9gVQsiWIHy+7KXp7G6jsRV3MXTB/MfCwRZhiAEwYfd57H19wQ
	 OPYf0x/3ibyGwwRFiwUYKPfRdTYtgv21oj2/bobN0EEyQbBYw2EEDPtmEGD3xW6lGL
	 0QNowx5IyQ9odduvZNJEDbIQQAQglwh+0WeBzhqZaZpI+9wYNZUWyhJB8vVXvhWkIS
	 V33SXMr5Mo+iFseGFQIZhtf4nAyMrC6CsWWCgwY4tmg3xQdG2ihiXZSFVG2s9gOsnt
	 2iUDNxzXyDk+A==
Date: Mon, 14 Sep 2026 07:35:43 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH 1/5] statx.h: update to latest kernel UAPI
Message-ID: <20260914143543.GE6283@frogsfrogsfrogs>
References: <20260914114550.2451308-1-hch@lst.de>
 <20260914114550.2451308-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914114550.2451308-2-hch@lst.de>

On Mon, Sep 14, 2026 at 01:45:43PM +0200, Christoph Hellwig wrote:
> Update the locally provided statx definition to the kernel UAPI as of
> 7.3-rc1.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Zorro Lang <zlang@kernel.org>
> 
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

Nit: no blank line between RVB tags.  Otherwise this still looks ok.

--D

> ---
>  src/statx.h | 126 +++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 96 insertions(+), 30 deletions(-)
> 
> diff --git a/src/statx.h b/src/statx.h
> index bae1c86f6201..0a27bf030b1d 100644
> --- a/src/statx.h
> +++ b/src/statx.h
> @@ -95,44 +95,97 @@ struct statx_timestamp {
>   */
>  struct statx {
>  	/* 0x00 */
> -	__u32	stx_mask;	/* What results were written [uncond] */
> -	__u32	stx_blksize;	/* Preferred general I/O size [uncond] */
> -	__u64	stx_attributes;	/* Flags conveying information about the file [uncond] */
> +	/* What results were written [uncond] */
> +	__u32	stx_mask;
> +
> +	/* Preferred general I/O size [uncond] */
> +	__u32	stx_blksize;
> +
> +	/* Flags conveying information about the file [uncond] */
> +	__u64	stx_attributes;
> +
>  	/* 0x10 */
> -	__u32	stx_nlink;	/* Number of hard links */
> -	__u32	stx_uid;	/* User ID of owner */
> -	__u32	stx_gid;	/* Group ID of owner */
> -	__u16	stx_mode;	/* File mode */
> +	/* Number of hard links */
> +	__u32	stx_nlink;
> +
> +	/* User ID of owner */
> +	__u32	stx_uid;
> +
> +	/* Group ID of owner */
> +	__u32	stx_gid;
> +
> +	/* File mode */
> +	__u16	stx_mode;
>  	__u16	__spare0[1];
> +
>  	/* 0x20 */
> -	__u64	stx_ino;	/* Inode number */
> -	__u64	stx_size;	/* File size */
> -	__u64	stx_blocks;	/* Number of 512-byte blocks allocated */
> -	__u64	stx_attributes_mask; /* Mask to show what's supported in stx_attributes */
> +	/* Inode number */
> +	__u64	stx_ino;
> +
> +	/* File size */
> +	__u64	stx_size;
> +
> +	/* Number of 512-byte blocks allocated */
> +	__u64	stx_blocks;
> +
> +	/* Mask to show what's supported in stx_attributes */
> +	__u64	stx_attributes_mask;
>  
>  	/* 0x40 */
> -	struct statx_timestamp	stx_atime;	/* Last access time */
> -	struct statx_timestamp	stx_btime;	/* File creation time */
> -	struct statx_timestamp	stx_ctime;	/* Last attribute change time */
> -	struct statx_timestamp	stx_mtime;	/* Last data modification time */
> +	/* Last access time */
> +	struct statx_timestamp	stx_atime;
> +
> +	/* File creation time */
> +	struct statx_timestamp	stx_btime;
> +
> +	/* Last attribute change time */
> +	struct statx_timestamp	stx_ctime;
> +
> +	/* Last data modification time */
> +	struct statx_timestamp	stx_mtime;
> +
>  	/* 0x80 */
> -	__u32	stx_rdev_major;	/* Device ID of special file [if bdev/cdev] */
> +	/* Device ID of special file [if bdev/cdev] */
> +	__u32	stx_rdev_major;
>  	__u32	stx_rdev_minor;
> -	__u32	stx_dev_major;	/* ID of device containing file [uncond] */
> +
> +	/* ID of device containing file [uncond] */
> +	__u32	stx_dev_major;
>  	__u32	stx_dev_minor;
> +
>  	/* 0x90 */
>  	__u64	stx_mnt_id;
> -	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
> -	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
> +
> +	/* Memory buffer alignment for direct I/O */
> +	__u32	stx_dio_mem_align;
> +
> +	/* File offset alignment for direct I/O */
> +	__u32	stx_dio_offset_align;
> +
>  	/* 0xa0 */
> -	__u64	stx_subvol;	/* Subvolume identifier */
> -	__u32	stx_atomic_write_unit_min;	/* Min atomic write unit in bytes */
> -	__u32	stx_atomic_write_unit_max;	/* Max atomic write unit in bytes */
> +	/* Subvolume identifier */
> +	__u64	stx_subvol;
> +
> +	/* Min atomic write unit in bytes */
> +	__u32	stx_atomic_write_unit_min;
> +
> +	/* Max atomic write unit in bytes */
> +	__u32	stx_atomic_write_unit_max;
> +
>  	/* 0xb0 */
> -	__u32   stx_atomic_write_segments_max;	/* Max atomic write segment count */
> -	__u32   __spare1[1];
> -	/* 0xb8 */
> -	__u64	__spare3[9];	/* Spare space for future expansion */
> +	/* Max atomic write segment count */
> +	__u32   stx_atomic_write_segments_max;
> +
> +	/* File offset alignment for direct I/O reads */
> +	__u32	stx_dio_read_offset_align;
> +
> +	/* Optimised max atomic write unit in bytes */
> +	__u32	stx_atomic_write_unit_max_opt;
> +	__u32	__spare2[1];
> +
> +	/* 0xc0 */
> +	__u64	__spare3[8];	/* Spare space for future expansion */
> +
>  	/* 0x100 */
>  };
>  
> @@ -162,19 +215,32 @@ struct statx {
>  #define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */
>  #define STATX_SUBVOL		0x00008000U	/* Want/got stx_subvol */
>  #define STATX_WRITE_ATOMIC	0x00010000U	/* Want/got atomic_write_* fields */
> +#define STATX_DIO_READ_ALIGN	0x00020000U	/* Want/got dio read alignment info */
>  
> -#define STATX_ALL		0x00000fffU	/* All currently supported flags */
> +#define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
>  
> +#ifndef __KERNEL__
>  /*
> - * Attributes to be found in stx_attributes
> + * This is deprecated, and shall remain the same value in the future.  To avoid
> + * confusion please use the equivalent (STATX_BASIC_STATS | STATX_BTIME)
> + * instead.
> + */
> +#define STATX_ALL		0x00000fffU
> +#endif
> +
> +/*
> + * Attributes to be found in stx_attributes and masked in stx_attributes_mask.
>   *
>   * These give information about the features or the state of a file that might
>   * be of use to ordinary userspace programs such as GUIs or ls rather than
>   * specialised tools.
>   *
> - * Note that the flags marked [I] correspond to generic FS_IOC_FLAGS
> + * Note that the flags marked [I] correspond to the FS_IOC_SETFLAGS flags
>   * semantically.  Where possible, the numerical value is picked to correspond
> - * also.
> + * also.  Note that the DAX attribute indicates that the file is in the CPU
> + * direct access state.  It does not correspond to the per-inode flag that
> + * some filesystems support.
> + *
>   */
>  #define STATX_ATTR_COMPRESSED		0x00000004 /* [I] File is compressed by the fs */
>  #define STATX_ATTR_IMMUTABLE		0x00000010 /* [I] File is marked immutable */
> -- 
> 2.53.0
> 
