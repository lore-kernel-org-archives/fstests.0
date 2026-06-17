Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488EE3AEF35
	for <fstests@vger.kernel.org>; Wed, 17 Jun 2026 06:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781676493; cv=none; b=lF1TqB68A+DbND9RxzDXvbiq+lOHGQBCKtivnoCTyAX26HXIgqIHIpvfBPlRIiGvEZNJZmbcgRz4GaD4Vrz7YhTN61Lp/UFWUHjnG+y7xdWP0M/40UTYB/zypmScrLSdYfXfBB8Eh4Paor3FFhTPsVj3GpUkb2y/SIR1vq/JRKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781676493; c=relaxed/simple;
	bh=/vv6WcHJyPpSSWvmukyqkp7tRjM8HmpHvkyHrBqEZwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPQ7TlGS4i6cyriOEDdKprLa/GmSEGrzFIYNyBEIRABwl3BbzzHDDSlpvkjXq5EqwXj+fowyRKjpAb8U08LVusLtQXIvLGUoZLpSD+5fhAHMgYEa9ZP9FtI9p0OZ6hGdnGo/4VHgR2eejsZFvR06tN4qIAckaxVKvlvmW3fjsXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 71EDC68AFE; Wed, 17 Jun 2026 08:08:08 +0200 (CEST)
Date: Wed, 17 Jun 2026 08:08:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Timber <dxdt@dev.snart.me>
Cc: Zorro Lang <zlang@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: Re: [PATCH] generic/740: set env for mkfs.exfat and mkfs.ntfs
Message-ID: <20260617060808.GA19702@lst.de>
References: <20260616165731.379595-1-dxdt@dev.snart.me>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616165731.379595-1-dxdt@dev.snart.me>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jun 17, 2026 at 01:57:31AM +0900, David Timber wrote:
> +case "$FSTYP" in
> +	exfat)

Please don't indent the matches in case statements (yes, we probably
have a few legacy cases that do it, but copy the right ones :))

> +		# Some fsprogs were slow to implement foreign fs detection.
> +		# For backward compatibility, mkfs.exfat refuses to format only
> +		# when run from a tty. This env var should override the
> +		# behaviour if supported.

I don't get the 'Some fsprogs' part here.  Maybe just drop that line?

>  	ntfs)
> -		# "quick" format that doesn't zero the entire device
> -		postargs="--quick"
> +		# "quick" format that doesn't zero the entire device. Use -F so
> +		# that NTFS-3G mkfs formats the volume even if the scratch
> +		# blockdev is not a partition.
> +		postargs="-QF"

Why does this switch from the long to the short form quick argument?

>  		echo "=== Attempting $FSTYP overwrite of $fs..." >>$seqres.full
> -		${MKFS_PROG} -t $FSTYP $SCRATCH_DEV >>$seqres.full 2>&1
> +		eval $mkfs_preop ${MKFS_PROG} -t $FSTYP $mkfs_preargs $SCRATCH_DEV $mkfs_postargs >>$seqres.full 2>&1

Maybe add a line break to keep the line at a reasonable length.

Also in doubt split the exfat and ntfs changes as they seem entirely
unrelated.

