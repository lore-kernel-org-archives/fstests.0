Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD8A3E3159
	for <fstests@vger.kernel.org>; Fri, 10 Apr 2026 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775840077; cv=none; b=dJ3ZDjWiQQiAgh0T0GbmJKQ6hweEJ0otsCo45rZFI8See9CU6eYpCNexHWOCZFoREANLHxsmZi4bMbteepYXE0tSpGvkqX2fdAW5Mup46V1BD3KdeRgR7+6SYjVT9NG24XVl7iPOvIA+VMfmpnySDdquqMrHPuZdvGn5hB5m7kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775840077; c=relaxed/simple;
	bh=DPERe+gXRKDwdGFe4dadP8vCmTJf4x3lHD/trRjGY5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWaW03OGXCdJoiuFhlt5tnL4B8wtEFhuGR30y8fZ7COXEHN6GyMe2dTesLYLyEI6DPgI5M21q1Y161FFPF6s4dR2/yGzdV+hk7/5AfK0HFji5xprwXp0FI43KZhvVWlWYmNrOVEJTpUzBgC6iOB+H8siDItq/8Sbb5WDUHod7qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUISYRDz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUISYRDz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2CCC19421;
	Fri, 10 Apr 2026 16:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775840076;
	bh=DPERe+gXRKDwdGFe4dadP8vCmTJf4x3lHD/trRjGY5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lUISYRDzNxR0TRl7Qw6mpiodqr1BBRFVxSubPKasBpEouJgq5DFuUIgu/5s6NVZlq
	 bzmJjG526Mgraon9g14xZ5PmAkuPbCKcMZcJh27AfxyA+dHWsrmt+/x/rKnPfPJGaF
	 fU5DvzSVbNl8Db/IfgaGYPxeG03472ezYaciqMZgjPezWb8/n/U+YDFKcKANG2ksci
	 STw4iUdeYveeDN8CCMEf1tRcnB+zZKMUSXAJ5a86rCCezyarXL8M3IOaJ08zU7Rujb
	 sLMyMO5+UHmYycqc0J5wV+4bxBggzv7/BKb0gaVBiujq9QqacFSTSb50K8kf/eXrYM
	 JqOACP45aoIRA==
Date: Fri, 10 Apr 2026 09:54:35 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	fdmanana@suse.com, ritesh.list@gmail.com, naohiro.aota@wdc.com,
	wqu@suse.com, Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH 4/6] generic/765: Ignore mkfs warning
Message-ID: <20260410165435.GU6212@frogsfrogsfrogs>
References: <cover.1775802601.git.ojaswin@linux.ibm.com>
 <afee4fedcc9b3685df0e05800d82b88d27f977f8.1775802601.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afee4fedcc9b3685df0e05800d82b88d27f977f8.1775802601.git.ojaswin@linux.ibm.com>

On Fri, Apr 10, 2026 at 12:06:04PM +0530, Ojaswin Mujoo wrote:
> This test validates atomic writes for all possible block sizes. In ext4, for
> smaller block sizes with configurations like:
> 
> export MKFS_OPTIONS="-O bigalloc,quota -b 65536 -C 131072"
> 
> The output can get corrupted with warnings like below because clustersize
> more than 16xbs is experimental:
> 
> + 16 times the block size is considered experimental
> 
> Hence pipe these to seqres.full to avoid false negatives.
> 
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Seems fine, though I think I'd rather mke2fs get patched to fix this.

I'd let the maintainer decide if he wants this, but ... I'm not sure if
he's actually going to receive this message. :/

--D

> ---
>  tests/generic/765 | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/765 b/tests/generic/765
> index 09be53db..b7cc70f1 100755
> --- a/tests/generic/765
> +++ b/tests/generic/765
> @@ -64,7 +64,8 @@ test_atomic_writes()
>      local bsize=$1
>  
>      get_mkfs_opts $bsize
> -    _scratch_mkfs $mkfs_opts >> $seqres.full
> +    _scratch_mkfs $mkfs_opts &>> $seqres.full || \
> +        echo "mkfs $mkfs_opts failed"
>      _scratch_mount
>  
>      test "$FSTYP" = "xfs" && _xfs_force_bdev data $SCRATCH_MNT
> -- 
> 2.53.0
> 
> 
