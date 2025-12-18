Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB93238C03
	for <fstests@vger.kernel.org>; Thu, 18 Dec 2025 07:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766043188; cv=none; b=W6PGfdVQWlTKiLp5sJZkyXLCs9ahrZEGwT4aHwUynNqt5FLAbSnSfok2tp44XeyP0crh26z/4nJfZPgWJGAFZpxCeGma2TkDllatgnz43JMpr39FU1YnLc4zo5fvxXZjsK4It8mn81NTVZ33CrmJllC6wXpgY9hP8tX1OvpYENI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766043188; c=relaxed/simple;
	bh=wZxQFtk6InkN8uHwnHPWqXQBTDSxrFZ7XJoWPrET++M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXNL8z1UWVUeE0QoSv9HtDwwtZrYYPkoWlGfkqSRsl3fVUJL2oU6kRyaRl4WJ7JLRWzXsiRN7VZUOlJZ7PTg4LmPuKBeHE0ma8yL9/cjgXOQ0BMhQNOqds4bsfmL7Mc5ajf9W8BxOzRsXpouTx4ydDMFqMnIQi0426bFpbzqA90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ht/KJPEC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ht/KJPEC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aM4DalfUBwtqmf4ypjdLzKw0+szTaibZjWJpzqFSTno=; b=ht/KJPEC9Xfmf+pnjBjCGJx1Cf
	30TEl3YN/MnUx5SoOOY90aCMndXYe73jLOCqzjwXlyOoOH9+Q+EPIOKmd/8gYli4PPfg67+Gj8i9G
	Y3YVLu3uD+758vwYGRKRFbjfP9/4Npq9Z/gsNRi5pUhKlDQE9jEMnMLRoZXXXrpso7bCQ8bWWjhW7
	+p2ChBmm2kG6prPtzZfQzr95J82S14k+pOa9UmorPazXGO5AKmUwMrCLlNsiMq0boOQwF0uPVSfKR
	Sw2tbnvFymgjM2yzbgiXdXjkV/YkZxGXv3hW9fOZea0wdj/lT86GqAzr5YWCvBGDfHUgrazH9CjvV
	cW9QUksw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW8VW-00000007xii-081x;
	Thu, 18 Dec 2025 07:33:06 +0000
Date: Wed, 17 Dec 2025 23:33:06 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Chang <joannechien@google.com>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v1] generic/735: disable for f2fs
Message-ID: <aUOuMmZnw3tij2nj@infradead.org>
References: <20251218071717.2573035-1-joannechien@google.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218071717.2573035-1-joannechien@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Dec 18, 2025 at 07:17:17AM +0000, Joanne Chang wrote:
> generic/735 attempts to create a file with nearly 2^32 blocks. However,
> the maximum block count per file in F2FS is limited by the capacity of
> the inode. This limit is roughly 2^30 blocks, which is significantly
> lower than the test's requirement.
> 
> Signed-off-by: Joanne Chang <joannechien@google.com>
> ---
>  tests/generic/735 | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/generic/735 b/tests/generic/735
> index 9bbdf3a1..d5ba5673 100755
> --- a/tests/generic/735
> +++ b/tests/generic/735
> @@ -19,6 +19,9 @@ if [[ "$FSTYP" =~ ext[0-9]+ ]]; then
>  	_fixed_by_kernel_commit 2dcf5fde6dff "ext4: prevent the normalized size from exceeding EXT_MAX_BLOCKS"
>  fi
>  
> +# Block number 0xffffffff is too big for a file in f2fs.
> +_exclude_fs f2fs

Please don't add random file system excludes.  This should be
abstracted into a _require_max_file_size helper or similar.

