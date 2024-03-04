Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCFC15D1
	for <fstests@vger.kernel.org>; Mon,  4 Mar 2024 04:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709526665; cv=none; b=kNjWuKIMXIFVrPz/tImW0leA++RJUaF+YzqMjPBB3uFhylCZic1ah+iB9cwv7zO/XdWMm4TkSCOML5zAFva/QwMSMHKje3niavrMCudZrNqQv+hvSm4ph0VFB0TuN0r8wvr/qlNGGjSIzcLxbGr0xMCOcw7yAnNIuRikChKHxKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709526665; c=relaxed/simple;
	bh=zIr0dt24Ztbewmb8K9zT7165x2xp1p4yJkmxZf3hUdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jI2shWluf2229nA6mqQNuvoKmfQeAB1o4xce/k/VqmRurkfTTPpNuAKSbZQYXS1Fpu9JAdip1kAjYqFpf7c7JMK8rp3a7g2ZCXuXBAbTnWVSGOtc9QDraj5h9dIkEtnDBoS00doPWi0blQ+AsZGgyToLXhhR79Q9+k1OzDElrZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYIlgG88; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYIlgG88"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA24C433C7;
	Mon,  4 Mar 2024 04:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709526664;
	bh=zIr0dt24Ztbewmb8K9zT7165x2xp1p4yJkmxZf3hUdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hYIlgG88HoBGVw2/3YRxlsGrS8okdW0GAL2oBVT2AHnqHTz+SEr/uTsPLzD5l7zYk
	 OOa1mU6bW9G4ZssTxq/s+qwt7W73KCrnh1BsMkZRwtRg/z9RdZEnXnCrrBwINJxMmz
	 pc1zwaxgmhJWnhj4x/hsmGHxoCQ4lcFzGDVQsjYo9l6v8qmn/VI0LXXT2BhgXHAqq8
	 Aa1NxGWJr+s+ZhVV8/webj3koFMS2wu1jSrPEAduW8F35uuoMASuz1VGsgTbAi+OG7
	 kUz5o96BiZvngnfe5fstJwEPXWjr4kXd3YzmVyqYJq4gknQ7PXjlJ7MrfCpb9JAWr3
	 JYyVxJmThR7wg==
Date: Mon, 4 Mar 2024 12:31:00 +0800
From: Zorro Lang <zlang@kernel.org>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] xfs: Fix no executable permission
Message-ID: <20240304043100.r4q56itxuzx6dzn2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240115005913.3829532-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115005913.3829532-1-lizhijian@fujitsu.com>

On Mon, Jan 15, 2024 at 08:59:13AM +0800, Li Zhijian wrote:
> Give them the executable permission, this also make the git status keep clean
> after `./check`
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---

I tried to wait a few weeks to check if we have some patches to touch
these cases, then I can change the permission with that change together.
But looks like I have no chance :) So let's have this patch.

Reviewed-by: Zorro Lang <zlang@redhat.com>

We've changed to mvtest tool, to make sure the permission bit of new case,
I'll also add a testing step to check the permission bits later,
thanks for this fix.

Thanks,
Zorro

>  tests/xfs/557 | 0
>  tests/xfs/567 | 0
>  tests/xfs/568 | 0
>  3 files changed, 0 insertions(+), 0 deletions(-)
>  mode change 100644 => 100755 tests/xfs/557
>  mode change 100644 => 100755 tests/xfs/567
>  mode change 100644 => 100755 tests/xfs/568
> 
> diff --git a/tests/xfs/557 b/tests/xfs/557
> old mode 100644
> new mode 100755
> diff --git a/tests/xfs/567 b/tests/xfs/567
> old mode 100644
> new mode 100755
> diff --git a/tests/xfs/568 b/tests/xfs/568
> old mode 100644
> new mode 100755
> -- 
> 2.29.2
> 
> 
