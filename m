Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DB6C8C7
	for <fstests@vger.kernel.org>; Fri, 15 Mar 2024 02:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710471389; cv=none; b=ZmNCTw9Mjk4iS70dJPRtpUWvLFndgm3mmF3U9euBbwnFB97JMtbkC+i743srqf6YyZuYs4MLYX1f3RkxtYs8RQAgH69e8Vq/g085KoG9WFp9FHd5pgIRIxwGwWch8t64PL1zLTEgWzS8PImicnt6LJ8935j8TjWWPdnPcSZi8ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710471389; c=relaxed/simple;
	bh=bcDLujOV/lme0y+QFcecOBWSf9tY30UgCMamSvzylmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t20ZLmWgYoXb1KJIMW7SF4ZoVDANWcTCSxenEGzneLr3dJfIySOI4e+dc71fi5krLkU9LjTenW7xvte+mhHIcrrFDEZlAL/qOSn0h1c7H1ap44xZb91Pa6l8SGlFfBou+oIaU9SxyiBal1/ju+elaCFVN67nQzJkFakMx00rxcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTr8znmY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTr8znmY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C663C433C7;
	Fri, 15 Mar 2024 02:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710471388;
	bh=bcDLujOV/lme0y+QFcecOBWSf9tY30UgCMamSvzylmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kTr8znmYB+JIbUj2xjC9I0bTtXR4l/ULee2hewi539YjbmwPGZJUEZVlipsn5XIbo
	 PUhy3LCNf6/PRnhL8kUgrWnE7owz5Bk6N6I+pWQavil63t5qHftHqOOpMzqUhxb5Xa
	 v0/H1awzNb9wP1d3clrzF6UJwp6qYOBv+wWsLNCkURnhJhrQVcZf1h0qca0p9wOstY
	 7pehrKtKywP2Y3Ch5UtyPvWayoRN4SQ4GtdUVKulmBLibOBlfbVUL2WdLjziG+Z0Is
	 470iNSdb+/Z81nGv6IYTy83jiqlig2MZmrIwKioFLbNB9Gdse588z/s6goODzTonpM
	 v4/z0Up8CPPxA==
Date: Thu, 14 Mar 2024 19:56:28 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Boris Burkov <boris@bur.io>
Cc: kernel-team@fb.com, fstests@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH RFC] generic/730: ensure EIO after device delete
Message-ID: <20240315025628.GH6188@frogsfrogsfrogs>
References: <6165b0018426e58e7427a26eebea3d63e66fed15.1710373423.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6165b0018426e58e7427a26eebea3d63e66fed15.1710373423.git.boris@bur.io>

On Wed, Mar 13, 2024 at 04:47:47PM -0700, Boris Burkov wrote:
> This test removes a SCSI debug device out from under a mounted
> filesystem with a (probably) dirty file. This assumes that page cache
> cannot save us from EIO, for a reason that I can't quite explain. In
> fact, this test fails for exactly that reason, at least on btrfs.
> 
> The original patches:
> 
>       https://lore.kernel.org/fstests/20230807112100.GB15405@lst.de/
> 
> refer to this passing on xfs and not btrfs, so I suspect I am missing
> something. With that said, on my machine this actually fails on xfs with
> and without my patch, so this is clearly not enough.
> 
> High level, I am trying to understand what is really the expected
> behavior from a filesystem under this condition and what this test is
> getting at. Of btrfs, ext4, and xfs, only ext4 passes it, while btrfs
> does pass with this additional syncing/cache dropping to nudge it to an
> error.

Does btrfs prefetch pagecache data as soon as a file opens?  Or I guess
it could be that xfs trips an IO error and shuts down, and
xfs_file_read_iter will return EIO after that happens.

--D

> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  tests/generic/730 | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/generic/730 b/tests/generic/730
> index 11308cdaa..ca5037c57 100755
> --- a/tests/generic/730
> +++ b/tests/generic/730
> @@ -47,6 +47,9 @@ exec 3< $SCSI_DEBUG_MNT/testfile
>  # delete the scsi debug device while it still has dirty data
>  echo 1 > /sys/block/$(_short_dev $SCSI_DEBUG_DEV)/device/delete
>  
> +sync
> +echo 3 > /proc/sys/vm/drop_caches
> +
>  # try to read from the file, which should give us -EIO
>  cat <&3 > /dev/null
>  
> -- 
> 2.43.0
> 
> 
