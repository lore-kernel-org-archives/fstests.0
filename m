Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5079978C76
	for <fstests@vger.kernel.org>; Tue,  7 May 2024 22:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715121512; cv=none; b=eLJZfULmqlTjkgxxjZD7BRc2m8YVJVA8Hj/j5+eDnNL5QiW0pVcXJpbrNpE2QQw4KMkW6Whu643bVQg6/k7pPPm3ndTgltcjfsehSS3rjya7LkhybbR/Tib9yfGR1v96zR0r7YGyHbCO9WWJBsj5rhvIu68p/oYUO+xJfqQCwNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715121512; c=relaxed/simple;
	bh=7CH/1qYtb3A1zCQx+VwzyZ8CPqDpC67PhKYtR1qY5gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVdVpry6jw13xkGIJtqLdUT6KUNdDUWQGk8ME0t49AlooR5uTAdspTXlo5zgbHy8FoVTVW9pLRf57z56TDhbULPVFlF5YonK9Mq2k1sh2+y6NyMo/L/cjvBFX+o4lQktvj1CPLfKriu9J+g6+x31xO+8s9PgcM6nXsSi1EqKX98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvBG1heI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvBG1heI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FF9C3277B;
	Tue,  7 May 2024 22:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715121510;
	bh=7CH/1qYtb3A1zCQx+VwzyZ8CPqDpC67PhKYtR1qY5gI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QvBG1heIht41e1V6Sx5TyAgZCaFA6eJvvYXjjp/y6Ae/vuSB0JFPoh282L/3FJ8Vm
	 nGLDv3vw6kImbXGw7tVmYZ15AW78AHMQgih6PAHtCj0rukkN1/7CEZIP8U4YH2K/lI
	 D985h6SjVWJNBaYL8ZDPaqrKw1QFkhStuWNy1Yn3wP89hx6P9AoNZDgMUYqqLD43AJ
	 DUjEC6eghbYW4ZS5KaAQIBUOToaiGovn+Ajxj5NBE2kNOxWdESRrVE1RKInrr4zJJq
	 a7htRdyrs9DQcnhVSKD+qgAbCiGYfgxfkbBmY65M4cKv7pgCTwXd9DP5TMI4Thto0z
	 NACgpv074vynQ==
Date: Tue, 7 May 2024 15:38:30 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: David Sterba <dsterba@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 1/4] Move shared/032 to generic/740
Message-ID: <20240507223830.GE360908@frogsfrogsfrogs>
References: <cover.1715108589.git.dsterba@suse.com>
 <8dcb7d564180452eec0c2888740c1b0919e171d3.1715108589.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dcb7d564180452eec0c2888740c1b0919e171d3.1715108589.git.dsterba@suse.com>

On Tue, May 07, 2024 at 09:07:36PM +0200, David Sterba wrote:
> The shared/ directory was supposed to host tests that apply to a subset
> of all supported filesystems but this is not utilized much and creates a
> split from the generic tests. Move the test to generic.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  tests/{shared/032 => generic/740}         | 2 +-
>  tests/{shared/032.out => generic/740.out} | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename tests/{shared/032 => generic/740} (99%)
>  rename tests/{shared/032.out => generic/740.out} (100%)
> 
> diff --git a/tests/shared/032 b/tests/generic/740
> similarity index 99%
> rename from tests/shared/032
> rename to tests/generic/740
> index 131323ab5b0ff8..6ed248617eaa6b 100755
> --- a/tests/shared/032
> +++ b/tests/generic/740
> @@ -2,7 +2,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Copyright (c) 2000-2002 Silicon Graphics, Inc.  All Rights Reserved.
>  #
> -# FS QA Test No. 032
> +# FS QA Test No. 740
>  #
>  # cross check mkfs detection of foreign filesystems
>  #
> diff --git a/tests/shared/032.out b/tests/generic/740.out
> similarity index 100%
> rename from tests/shared/032.out
> rename to tests/generic/740.out

Don't you need to update the "QA output created by 032" in 032.out as
well?

tools/mvtest handles at least the simple cases.

--D

> -- 
> 2.44.0
> 
> 
