Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDE73A9870
	for <fstests@vger.kernel.org>; Thu,  3 Sep 2026 13:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443644; cv=none; b=InPOvSE2Jb+O1wE+G+pVr4pyKkuI2yFSIMzm5/EM1Fzf0PkuBGMSoRVFlVRTJOPApG6WBzjQ+hCo+pVw0q73YEEX0Il94MoMAu45/iP23gSNaMfn8sHMGOfdiL+lBNGJJRo0vtv3K2PPnn7jUQcPuG2KpRNXIN3SBxm5PySpzsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443644; c=relaxed/simple;
	bh=FqeyNZEssjYG4315AwkCV9nCywE0yyVUaQvFESEAYX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ikqRWKPmaF/3InXtXFi+zwit/cscwytrxgOQLiG0i1gyKXMvu6S5Zbx2Mop3BOum2f/7BOCXptH7M2DU82I0mnV3D/pg6L38zyHbxx5TgDeFM3s+sRVcaB9tvGkm21rRwCorWvwpCtVyFI5czKz3LY5iskYLDoGi+vcZm22YIFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7EhgQTx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7EhgQTx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7401F00ACA;
	Thu,  3 Sep 2026 13:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788443627;
	bh=ubpiXP9zeY6nisNbCcAy6QTgfx5te8bKLPjfwaRbbSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L7EhgQTxHjykEO3rkq+Ngk1hG/LI6d5jCcaGEWaQX7WJOdOQB9+5aZ0nn6eVOqrKd
	 tzxRBQAtmUG9qkkbNK/+OcBcyfD6qiJSS8XiR4ZDpg2edAYsRoqI+JCEGI5MRrcy52
	 TuX+ennaH/PLJ/DZknVRKN1BPx7RZoutDcp4zjnS8uJR8XgD9Ic6sAqUVoTCFBs7uQ
	 nt+dI/6N8q3ovcE9AJeK1Ss99ONKKCypn8eNnYj4tFiYVSycr2TwC2Po6qaQL5h95Q
	 mavBdpltO3HesbVHZp8B2YzOKYt+TBy43F6Byf074uk/35o/Rog05oaabkWDOMczB2
	 vk6mNrEYw/ZAg==
Date: Thu, 3 Sep 2026 21:53:39 +0800
From: Zorro Lang <zlang@kernel.org>
To: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
Cc: fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v2 0/3] xfstests: add missing _require_scratch checks
Message-ID: <apl53bE5aZMJmZII@zlang-mailbox>
Mail-Followup-To: Prabhakar Pujeri <prabhakar.pujeri@dell.com>, 
	fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
References: <20260903035344.752-1-prabhakar.pujeri@dell.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903035344.752-1-prabhakar.pujeri@dell.com>

On Thu, Sep 03, 2026 at 03:53:41AM +0000, Prabhakar Pujeri wrote:
> Consolidated resend of the remaining _require_scratch fixes, as
> requested by Zorro.  The first three of this batch (btrfs/333 v3,
> overlay/081 v2, btrfs/273 v2) are already in his local tree.
> 
> v2:
> - Resent as a single series, per Zorro's request.
> - Carry Darrick J. Wong's Reviewed-by (generic/590,735 and generic/795)
>   and Zorro Lang's Reviewed-by (f2fs/015,016); besides message
>   re-formatting there is no code change.
> 
> v1 pieces for reference:
> - generic/590,735: https://lore.kernel.org/fstests/20260831104148.2243-1-prabhakar.pujeri@dell.com/
> - generic/795:     https://lore.kernel.org/fstests/20260902050139.2426-1-prabhakar.pujeri@dell.com/
> - f2fs/015,016:    https://lore.kernel.org/fstests/20260902050133.2413-1-prabhakar.pujeri@dell.com/
> 
> 
> Prabhakar Pujeri (3):
>   generic/590,735: add missing _require_scratch check
>   generic/795: add missing _require_scratch check
>   f2fs/015,016: add missing _require_scratch checks

Hi,

Thanks for this work, I'm wondering why generic/590 and generic/735 are
combined into one patch while generic/795 is split out?

Given that they all just add a single line of _require_scratch. While I think
this could easily be a single patch, if you prefer splitting them up, grouping
them per-directory (generic, f2fs, btrfs, overlay ...) would make sense.

Also, I recall you had a few other similar patches, such as:
  btrfs/333: require scratch before checking encoded reads
  btrfs/273: add missing _require_scratch check
  overlay/081: add missing _require_scratch check

Please bundle all of them into a single patch series (keeping any existing
Reviewed-by tags) so they can be reviewed and merged together.

Thanks,
Zorro

>
>  tests/f2fs/015    | 1 +
>  tests/f2fs/016    | 1 +
>  tests/generic/590 | 1 +
>  tests/generic/735 | 1 +
>  tests/generic/795 | 2 ++
>  5 files changed, 6 insertions(+)
> 
> -- 
> 2.55.0
> 
