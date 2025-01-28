Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D911D61B1
	for <fstests@vger.kernel.org>; Tue, 28 Jan 2025 19:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738092108; cv=none; b=b/61lF2FFeal8t6WtekJGiuS98du/ieLQvD/pe132L0PkkWY7TQBtNrlYMB5dvLnIvsvxvQpuPCeIf9O5NydWT/4UoAbj8Id+J6jJ51ESnf8o+tHeg63g7zU+pt2tPSc8D12cz1YRZK4J40h6txP9YKu7gkisvsbJEauJzEEszc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738092108; c=relaxed/simple;
	bh=bBfSCjKPOvcDNp69mQ98M22Rpu8fmtZHp75GHYtayq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DI2nNvLoNfDzSGv+WyUQPokFpsFN3WQlp2Lc7YwGlajCuFzpxNPgUXTFGxrF6WnUCNBmZKj8CG9Lg4MMHmpAiTgfssA2GWUvd/UYMjAle6zQ/yX/mWtiC2ANkLshfRH7EyIhskReeM9DVsvK2gzeZREnInLRUednqeCnzRMeYy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQ/PjVln; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQ/PjVln"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A930C4CED3;
	Tue, 28 Jan 2025 19:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738092108;
	bh=bBfSCjKPOvcDNp69mQ98M22Rpu8fmtZHp75GHYtayq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AQ/PjVlnA4fQQOOq8JuqFFIl1PFGetr1NVFkLtp4eBUN6S8VPaBO27Yujy7lPLiDL
	 oDQUgHpCBfxFF4Ug1uoPujP2H517lfJnU7xs7J6VMHBkZfHuNtoll7u24BCdRkE72+
	 PnvTJDOphgqDLKTZnEbcO7J7XsXJy7QtrPbUQYCaS9P4JhiNvFoi4EMvWHUxKHOfp5
	 A5DShb9gb5ExaT7uAQkK0/NSWHGzW1KCFJTLvqFJJ27hUVT29XFPDXSzxP/WpfY9mG
	 aKVi60d1AK6oifN7szorx0iXLn27asru71ANBBYvIuWzg/sfnVa75dbs0ssjcs75OQ
	 5Ty/AH1ORcahQ==
Date: Tue, 28 Jan 2025 11:21:47 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/418: use min_dio_alignment
Message-ID: <20250128192147.GS3557695@frogsfrogsfrogs>
References: <20250128071412.676396-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128071412.676396-1-hch@lst.de>

On Tue, Jan 28, 2025 at 08:14:12AM +0100, Christoph Hellwig wrote:
> Otherwise this test uses the wrong sector size on the RT device.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/generic/418 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/418 b/tests/generic/418
> index 4321e2984663..36789198c88e 100755
> --- a/tests/generic/418
> +++ b/tests/generic/418
> @@ -28,7 +28,7 @@ _require_test_program "feature"
>  
>  diotest=$here/src/dio-invalidate-cache
>  testfile=$TEST_DIR/$seq-diotest
> -sectorsize=`blockdev --getss $TEST_DEV`
> +sectorsize=`$here/src/min_dio_alignment $TEST_DIR $TEST_DEV`

BTW is min_dio_alignment going to get an upgrade to report
STATX_DIO_READ_ALIGN ?

The changes here look correct to me
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

>  pagesize=`$here/src/feature -s`
>  
>  # test case array, test different write/read combinations
> -- 
> 2.45.2
> 
> 
