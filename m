Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AC437FF50
	for <fstests@vger.kernel.org>; Tue, 15 Sep 2026 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789491305; cv=none; b=We1QavGnNamznCAmuqFsuZYVyiLPzlLzELvxXuFjYUODziTdqNDBZPcYezcLwuc2Im7DvcS6yjAOlkQKfHwpxifdwmt4ld7UDYKn7PBK3sacXQj8lOXIARGRbDEHaWPTKOF+Ta/Vz2jUHMXNusNI6ZbP0EKBwfvGLfGY7mGdjyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789491305; c=relaxed/simple;
	bh=CtBVroNHr47aIFBhMO9MSWfcmqJWNu07cM+uY3UtJYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuUBH8wUC9pgcNkmZ9nRyuuN3cVFytdFOvJqm67ntsGsvP08yU2mRa24Pr7NlTmluGefa3HSpPCw/D/p/btwezQHGaJ08pn64ZSjuGQPpyZvNnapbOweO37woeFqjX8sDUAPXlFMuAmsjW2Bq8m7IZt8Hjm9EcAsNMnM+5f7GY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kzc3RNsu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kzc3RNsu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997B41F000FF;
	Tue, 15 Sep 2026 16:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789491304;
	bh=ars7nRp8/nCdKzFmz7Z6e0oytsPfVlI3aAvjDSyPwRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Kzc3RNsuc35mDUK+Uwlpku+VMj1a3bF4V04RocDi1M4NGIXJ/ALrxNESsge5DG/zr
	 owGMK41aqpmYUjdtzJ6awB5+88jybzJx4Ak1MQgelSYiuCHfmvb/rq6bkXK1vdfmIY
	 akGeu5V1hhfSa0mvHyVHf4v9uXaeIpMGYVK3owB8dFENwbcguDcKGlPFPvwSSZ1SvF
	 cQXwrzp3ZFS9VAXYibVn/kdggkTXcihqOWIG7X8P5oVr4MaXBXkk8Mb2vMKR7pY3sD
	 zurMfI0igNcQTpfzcBeEPYnUsGoeGqHDTCtGs43dTtv23k2iEqASgpJz6GmUx18Bp+
	 qUR0hZ2kZyRlg==
Date: Wed, 16 Sep 2026 00:54:59 +0800
From: Zorro Lang <zlang@kernel.org>
To: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
Cc: fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v3 2/6] generic/795: add missing _require_scratch check
Message-ID: <aql1sUTD230zrLtT@zlang-mailbox>
Mail-Followup-To: Prabhakar Pujeri <prabhakar.pujeri@dell.com>, 
	fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
References: <20260915141745.4299-1-prabhakar.pujeri@dell.com>
 <20260915141745.4299-3-prabhakar.pujeri@dell.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915141745.4299-3-prabhakar.pujeri@dell.com>

On Tue, Sep 15, 2026 at 02:17:41PM +0000, Prabhakar Pujeri wrote:
> The test runs _scratch_mkfs and _scratch_mount without first requiring
> a scratch device, so it fails messily instead of skipping when no
> scratch device is configured.
> 
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
> ---

Thanks for consolidating the scattered patches! As mentioned in my previous
review comment, I think patches 1/6 and 2/6 can be squashed together at least.
Anyway, let me take care of squashing them upon merging. Overall, the patchset
looks good to me.

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  tests/generic/795 | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/generic/795 b/tests/generic/795
> index fa5474c5..4c0e7bdb 100755
> --- a/tests/generic/795
> +++ b/tests/generic/795
> @@ -27,6 +27,8 @@ _cleanup()
>  
>  . ./common/filter
>  
> +_require_scratch
> +
>  fsv_file_size=10000000
>  nproc_enabler=$((4 * LOAD_FACTOR))
>  nproc_reader=$((6 * LOAD_FACTOR))
> -- 
> 2.55.0
> 
