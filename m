Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940BC23EA97
	for <fstests@vger.kernel.org>; Thu, 18 Jun 2026 09:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781773928; cv=none; b=fCPRc/vu0whjJIFzVH68Zgqeafq+YaQrVQkG0CR1ErZpkiy+tz8WShkSun9e4F4HxfsohEAXtwaUa5/VZT22IXDpx2mCewsETJJRSTLFJMxEBq9R1F7e7HBa3tqv+uM8gQZd3DE0TedxmVXPRkgZZ+94ePSv+x47U1ovTqTedls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781773928; c=relaxed/simple;
	bh=WeEm2qhtjVl0tU8VNN88DrwgNiYnEvgA1ID4yiWdOhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iO5geLWf16o2sNGbZR6peKvB+4lp54vlx2JNAOpb0zJiVaO/SORPZGLE0vBA2F4XYTLqFwqJ/Ufm0n+lIWIC65pb+bRZudtb8d6wUJtNw4Wr19vbnxHq8Apxs++tBmLhlaU9G+qChpjIK34HHEWtfRNP+Y/UOBG2hRBCnaa54qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7E63F68C4E; Thu, 18 Jun 2026 11:11:54 +0200 (CEST)
Date: Thu, 18 Jun 2026 11:11:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yao Sang <sangyao@kylinos.cn>
Cc: fstests@vger.kernel.org, hch@lst.de, zlang@kernel.org
Subject: Re: [RFC] common: skip data write EIO tests on fatal configs
Message-ID: <20260618091154.GA17530@lst.de>
References: <20260618034756.615426-1-sangyao@kylinos.cn>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618034756.615426-1-sangyao@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jun 18, 2026 at 11:47:56AM +0800, Yao Sang wrote:
> The auto detection is intentionally XFS-specific for now. It checks the XFS
> per-mount sysfs attribute zoned/max_open_zones, not the block layer
> /sys/block/.../queue/zoned attribute. A zoned block device alone does not
> prove that the mounted XFS instance is using zoned filesystem semantics.

Yeah, make sense.

> One test-number detail is worth calling out. The maintainer report first
> mentions generic/441 and xfs/665, but the following fserror/healthmon
> description refers to xfs/656. I checked both tests: xfs/656 is the dmerror
> plus healthmon data I/O error test and matches the reported failure; xfs/665 is

Sorry, I fat-fingered the number.

> +_scratch_data_write_eio_is_fatal()
> +{
> +	local dev="${1:-$SCRATCH_DEV}"

I'll defer to Zorro, but normally either requiring an argument
always or neve seems nice.  And my preference here would be to
always pass the device, and not have _scratch in the name.

> +
> +	case "${FS_DATA_WRITE_EIO_SHUTDOWN:-auto}" in
> +	yes|true|1)
> +		return 0
> +		;;
> +	no|false|0)
> +		return 1
> +		;;
> +	auto|"")
> +		;;
> +	*)
> +		_fail "invalid FS_DATA_WRITE_EIO_SHUTDOWN=$FS_DATA_WRITE_EIO_SHUTDOWN"
> +		;;
> +	esac

I don't understand what this part is about at all.

> +
> +	case "$FSTYP" in
> +	xfs)
> +		# This is an XFS per-mount sysfs attribute, not a block queue
> +		# attribute.  Its existence means XFS mounted this instance with
> +		# zoned filesystem semantics.
> +		_has_fs_sysfs_attr "$dev" "zoned/max_open_zones" && return 0
> +		;;
> +	esac
> +
> +	return 1

This part looks fine.

> +}
> +
> +# Require that data write errors are reported through the regular error
> +# reporting path instead of shutting down the filesystem.
> +_require_scratch_survives_data_write_errors()
> +{
> +	local dev="${1:-$SCRATCH_DEV}"
> +
> +	_scratch_data_write_eio_is_fatal "$dev" || return
> +
> +	_notrun "$FSTYP treats data write errors as fatal"
> +}

Do we need both survives and fatal versions of this?  Or decide
on one polarity and be done with it?

