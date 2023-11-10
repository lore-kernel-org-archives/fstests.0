Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066031C17
	for <fstests@vger.kernel.org>; Fri, 10 Nov 2023 04:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6Zxhz2x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA25C433CD;
	Fri, 10 Nov 2023 04:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699591801;
	bh=Y8i0xqnq5SDrFz1ZIpYOtQGpqk1UGb5J9Y6i9KcJZCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y6Zxhz2xPOskMr6/fiXBQc9Hz/HMxbb58sQNXpx0uBF5WtzAsP/Zertb+SYuM0fCB
	 WGiDmRDuDjNwQ8uMHH02zZz7GSLW1iWT2ubq/Jc+vSj7WKjQeOd28cVFfbhYPlHH+q
	 rz+E6fMmhYEru65JUmiVbjtVEyWisZ1vcNIuNgCuQ4snS89nmGCDSPgo6qDW3S59wt
	 4iEj+e5abCHN5AsDQGYqKwAHf2In6Y7kORMsorIZD7dZYlz5QO8eWLwTQGmLPFEsXz
	 ThiQzAe+HlD6K0GIPl//ctuaoiVjcykj8NNZP2wRTW3PNo5cjRvgifOlljCLD5mSPG
	 HKZ4PVH+B+eMw==
Date: Thu, 9 Nov 2023 20:50:00 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/146: require fallocate support
Message-ID: <20231110045000.GG1203404@frogsfrogsfrogs>
References: <20231109164947.736069-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109164947.736069-1-hch@lst.de>

On Thu, Nov 09, 2023 at 05:49:47PM +0100, Christoph Hellwig wrote:
> xfs/146 uses the xfs_io falloc subcommand and thus kernel fallocate
> support.  Ensure the support is present.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Ooooops we really ought to get a static checker for this kind of thing.
That would be a much better use of engineer time than someone spinning
up yet another syzkaller instance... <cough>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/xfs/146 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/xfs/146 b/tests/xfs/146
> index 123bdff5..c8268a52 100755
> --- a/tests/xfs/146
> +++ b/tests/xfs/146
> @@ -24,6 +24,7 @@ _begin_fstest auto quick rw realtime
>  _supported_fs xfs
>  _require_scratch
>  _require_realtime
> +_require_xfs_io_command "falloc"
>  _require_test_program "punch-alternating"
>  
>  # Format filesystem to get the block size
> -- 
> 2.39.2
> 
> 
