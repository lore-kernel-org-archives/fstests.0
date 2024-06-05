Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B06C624
	for <fstests@vger.kernel.org>; Wed,  5 Jun 2024 04:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717561661; cv=none; b=Cic52v9nWM/QSVCEUYKcjIyBBujcHLu8XkaIL+kbJE4F3ypugMWo2nLRJOdDtHDjv6iTvicXU0MxCibC4HZZZnRBXay2Z+RHwpXhCeI/wRJYADY7uCMnih1RK2EycTEwcEX0uaGgXi5biBGP60ugxCs6BqPI5o/qBb4pYlTchqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717561661; c=relaxed/simple;
	bh=2kSwN8P0HTDmqeXWyB5Su8OU4C5RBchqwGqrvJHLw0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+lmgSTff70N6hDepiGhyDZZfosbNqdbZX6EGr+UAH+peYgvdDlc6733fcsq1OuhUQ/7FqrRjXLBudqIDv1NNl+1VyfWJx4AntwHlezMVdqCCNSIhrFb90Wi+DQo8ga9mgZjk252hFWPrZ4WEchlpf5JCQSYMBAboAkhswxOzRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=okjpsD9O; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="okjpsD9O"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=k2uJjf9TbBvrTMcPmWs/4lb8ITERvRIqq5OUEwZAKcI=; b=okjpsD9OYLrveBL+nhLln9ZfLn
	LeTBv2RNpnrr9mNDoFVWJTZ8/sv/S3W9Bv3CS1yIf2WUnxgBzd6+Px+Zsi7GLnlJolr/0xN6xAdRf
	ec4P8sB+jVJTyj4ZCzyW4b8SlZO7hMIyfbM+rUrlz4YZsuvqFAZbVeNaQpbZW91iKGoNm1PWI2PvN
	mtpVquVa5adNAjY/S95U03vOkHwkJkGFwiY99PX4tKdfLQbuOOXo+Q42awQjVzD1EKHiO5GpV9xps
	U2H+IgLv+qhKmjPFJha0lE7aXMUxTZ9AEnsOatZwfMdq0u3C/PsaYbUTOiFztWQRj7PzMMjRBUmue
	C6f1fMXQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEiFP-00000004biQ-3Ap1;
	Wed, 05 Jun 2024 04:27:39 +0000
Date: Tue, 4 Jun 2024 21:27:39 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: fix _require_debugfs and call it properly
Message-ID: <Zl_pO3nHTDWABxrd@bombadil.infradead.org>
References: <20240429060906.465135-1-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429060906.465135-1-zlang@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Mon, Apr 29, 2024 at 02:09:06PM +0800, Zorro Lang wrote:
> The old _require_debugfs helper doesn't work now, fix it to check
> a system supports debugfs. And then call this helper in cases which
> need $DEBUGFS_MNT.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
>  common/rc       | 10 ++++++++--
>  tests/btrfs/150 |  1 +
>  tests/ceph/001  |  2 +-
>  tests/xfs/499   |  1 +
>  4 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 56f1afb6..6f0bdf60 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2978,8 +2978,14 @@ _require_sparse_files()
>  
>  _require_debugfs()
>  {
> -    #boot_params always present in debugfs
> -    [ -d "$DEBUGFS_MNT/boot_params" ] || _notrun "Debugfs not mounted"
> +	local type
> +
> +	if [ -d "$DEBUGFS_MNT" ];then
> +		type=$(findmnt -rncv -T $DEBUGFS_MNT -S debugfs -o FSTYPE)

With:

-S debugfs

On debian this returns nothing. Removing that fixes it on debian. I'll
send patch.

  Luis
