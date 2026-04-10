Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506CF3E276C
	for <fstests@vger.kernel.org>; Fri, 10 Apr 2026 16:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775839842; cv=none; b=XoA+RnbePF9qe6/dp7VEkBxOQtVMVJsjGkDT3m45VLjzXv9NVc++rNlqo1sCtKmLr9l4AJE70ACy2+ihkSP2odxWK7ABbZhS2YSmGrgDQyrTYENUsatbd0CUYG/VElOfQdc00WbbBp9pn2Ad0B+xLCWh1XuNbFUzntJ8nEShQKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775839842; c=relaxed/simple;
	bh=nkNuaN4mDLSsgQmXJu0Urlmb+5jJ0wN1+JFN9Vft2mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W07yQfVgAFWszx3cMcgwyd4PPsttk2aihelgIQL3Vr8hYaKgI/joppQHf8+Z+5S2FpJ3+iZbkrdbnArtivyL+lzhYYyX3DGN20P811YlvAKxBLI+zcAfsCXLZtUqS4nmVg779O0mYXfSKnprd8ouReXqYWEZXvadiUNl7b/OOV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W55DMbEP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W55DMbEP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25EAC2BCAF;
	Fri, 10 Apr 2026 16:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775839841;
	bh=nkNuaN4mDLSsgQmXJu0Urlmb+5jJ0wN1+JFN9Vft2mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W55DMbEPf9wILrLSzkRTmb8x//1FAzgzZNrIQP2BPLFP3uHRIhp0WxZJ2CgLMsf+X
	 s+fnFr/CwFkrWKOL/GGhOUSXQDV7u5NsoQydora9ldTdI12Xz93NnkFKYZcOWSb05B
	 ENClbyjU9aA8Ne4l4aZ9z7NYQ2ZcA/pv6mIT1by7U1sAa71p+8xrL/CYD9DL/Ka9hW
	 ZfY4Up7ABzTom2eurPKH8MdO1+vSuEzKiasl6hIOloIRodZUE5Ql0KaAh47tAfh+4S
	 gDwVe5rIaOJKgXnoL57Hijhrg6hoWMHbtH+883S2Ynvhk6Oj/DKzIjywjGaydiwyx4
	 BB9FIf5Z01/bQ==
Date: Fri, 10 Apr 2026 09:50:41 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	fdmanana@suse.com, ritesh.list@gmail.com, naohiro.aota@wdc.com,
	wqu@suse.com, Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH 3/6] generic/765: Fix sysfs queue path for nvme partitions
Message-ID: <20260410165041.GR6212@frogsfrogsfrogs>
References: <cover.1775802601.git.ojaswin@linux.ibm.com>
 <43211d99fd66d3e8a956e1336b800962392c1df5.1775802601.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43211d99fd66d3e8a956e1336b800962392c1df5.1775802601.git.ojaswin@linux.ibm.com>

On Fri, Apr 10, 2026 at 12:06:03PM +0530, Ojaswin Mujoo wrote:
> This tests checks atomic write limits reported by statx() are same as
> the ones reported by sysfs, however nvme partitions don't have the
> /sys/block/nvme0n1p1 style entry and also use the namespace's queue
> limits for atomic writes. This causes the test to fail because it
> expects /sys/block/nvme0n*p* to be present.
> 
> Hence, use the new _sysfs_queue_path() helper to get the correct
> atomic write limits
> 
> Also, fix a small typo (s/awu_min/awu_max) when printing awu limits to
> seqres.full
> 
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Nicely cleaned up!
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/generic/765 | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/generic/765 b/tests/generic/765
> index 8c4e0bd0..09be53db 100755
> --- a/tests/generic/765
> +++ b/tests/generic/765
> @@ -94,16 +94,17 @@ test_atomic_writes()
>      _scratch_unmount
>  }
>  
> -sys_min_write=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/atomic_write_unit_min_bytes")
> -sys_max_write=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/atomic_write_unit_max_bytes")
> +queue_path=$(_sysfs_queue_path $SCRATCH_DEV)
> +sys_min_write=$(cat "$queue_path/atomic_write_unit_min_bytes")
> +sys_max_write=$(cat "$queue_path/atomic_write_unit_max_bytes")
>  
>  bdev_min_write=$(_get_atomic_write_unit_min $SCRATCH_DEV)
>  bdev_max_write=$(_get_atomic_write_unit_max $SCRATCH_DEV)
>  
>  echo "sysfs awu_min $sys_min_write" >> $seqres.full
> -echo "sysfs awu_min $sys_max_write" >> $seqres.full
> +echo "sysfs awu_max $sys_max_write" >> $seqres.full
>  echo "bdev awu_min $bdev_min_write" >> $seqres.full
> -echo "bdev awu_min $bdev_max_write" >> $seqres.full
> +echo "bdev awu_max $bdev_max_write" >> $seqres.full
>  
>  # Test that statx atomic values are the same as sysfs values
>  if [ "$sys_min_write" -ne "$bdev_min_write" ]; then
> -- 
> 2.53.0
> 
> 
