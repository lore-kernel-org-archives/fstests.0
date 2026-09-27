Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E4A2E2663
	for <fstests@vger.kernel.org>; Sun, 27 Sep 2026 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790509823; cv=none; b=IfJHhzf+2RNyU9k3w4rQF4kT9oNrqZ4xk92KcjXauyPxmShTy1agbZ1moX3PL+tMcrwsb+B88vdRDeAfwD5sry3JjJSLGm6T1M7F/kKS6LNokn8tg+wisqOBt0wZgRsW5EH7ommPZK3s+01DKOz1Y0QBZRbUwzjeJnFxO4xkwYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790509823; c=relaxed/simple;
	bh=GMrGwF3fHYGSdPg/z8YiD76NQQvSFGUjfdziE91SRKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWeLMWCuLxz6L7QtNXluVFKuMDnVNjRuUXsV96VIWpQ7boHUzWOdZF9pHD9Ucbg7fI11+70tiRelKt4k+X5XNtXmKHXVD+NCfW9BcOKCu8bogPoRdk+xej17WtsYN5pcfbSpYywU9YywsCPAelUeDdirt7mp9c64Gwa3Jtslc0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5qHIj/1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5qHIj/1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5623C1F000FF;
	Sun, 27 Sep 2026 11:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790509822;
	bh=1pRw3ovBfT7hJACOpx8nZVxK/0/d6YiuXDeIJw9552w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C5qHIj/1lbkBHM3nKvZk5HhyRH6Cwm2met5es1JpIiBc/k9yKRoKJlQtFqkDUto33
	 MTdVxAl5Dsg9Tskah87zDdIh8uxakYBg9h3v1XUmtLqxY2up996wfHWGf+MmOyRgNk
	 u3u1re7g3+UmI7lJVrds06Th4CfTxOVT90eXrVKl+YKDxCpVW+67Qd/EofEINJKlQ3
	 G5fpd0bgH/G6q2eB+KK9uaIUJZ9g72M61tUruri0bSuZBS64wlhIUBmSIpf56p05FR
	 OFADyRzx0gtI1EXojN5isvq2ddM31ivI/uQmWBvCDZj+C9PfRVF5IZWHZqtPDtO5Rz
	 9dXSamP5JmHvw==
Date: Sun, 27 Sep 2026 19:50:18 +0800
From: Zorro Lang <zlang@kernel.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH v3 0/4] xfstests: random fixes
Message-ID: <arkCzpcJlBYCU3yh@zlang-mailbox>
Mail-Followup-To: Andrey Albershteyn <aalbersh@kernel.org>, 
	fstests@vger.kernel.org
References: <20260925104514.664260-1-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925104514.664260-1-aalbersh@kernel.org>

On Fri, Sep 25, 2026 at 12:45:08PM +0200, Andrey Albershteyn wrote:
> Hi folks,
> 
> This series contain a few random fixes I apply for xfstests in my
> immutable test machines. These make it easier to work with read-only
> xfstests package.
> 
> Changes from v2:
> - Remove .out.good before running the test
> - Fix "diff ..." message for tests with .out.good
> Changes from v1:
> - Add RvB
> - Add comment in generic/452

Thanks, this patchset is good to me now. I'll merge it.

Reviewed-by: Zorro Lang <zlang@kernel.org>

> 
> Andrey Albershteyn (4):
>   xfs/071: use _link_out_link instead of opencoding file picking
>   common: link .out file to the output directory
>   generic/452: make coping work with multi-call binary
>   xfstests: fix permissions on system file installed by libtoolize
> 
>  Makefile                                  |  3 +++
>  check                                     | 14 +++++++++-----
>  common/rc                                 |  4 ++--
>  tests/generic/452                         |  7 +++++--
>  tests/generic/452.out                     |  4 ++--
>  tests/xfs/071                             |  7 +++----
>  tests/xfs/071.cfg                         |  1 +
>  tests/xfs/{071.out.64 => 071.out.default} |  0
>  8 files changed, 25 insertions(+), 15 deletions(-)
>  create mode 100644 tests/xfs/071.cfg
>  rename tests/xfs/{071.out.64 => 071.out.default} (100%)
> 
> -- 
> 2.54.0
> 
