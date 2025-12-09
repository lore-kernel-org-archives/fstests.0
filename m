Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9515A303C8B
	for <fstests@vger.kernel.org>; Tue,  9 Dec 2025 18:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765306515; cv=none; b=ePKjtfl/wCOcB2MshbJtrPeB+YaoZFTqfpfl5WOrdeAYjaCQUkUQqwn+OvhqumRZqBBdJkefO5RJkxW/dbInhiVSyG7BOvWHTxy52hwPoPGytCn9O8X9pwZJ8rexehD6GKhYeDb07ZJpZLH9UCJLpd/SRDYidyMRL1cNWVct7dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765306515; c=relaxed/simple;
	bh=3WrozUFqPGB8+e4lk3pq31YrQsM8LNegYZnVEuog13M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUFDeC1zZWeAlMUdVDZ2Ds/Ve/+54rXiUwlUq4aEVVbVWdKG9Zzp3e8GtHGLglafnzSbKUaPSPUH1LIRepQTYXDLFeX4/QywWpZyWEotZqvY73GEAHFpoIY0Qt6ssPUtueE5ZQd4q6XJFyOg1+x8PB3xBlboMq7p653uqJ0Fnxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+mztOHe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+mztOHe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF51C4CEFB;
	Tue,  9 Dec 2025 18:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765306515;
	bh=3WrozUFqPGB8+e4lk3pq31YrQsM8LNegYZnVEuog13M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D+mztOHe+FeCSu07tHaEVA2ee4K4K44jgtN3WE2LTv7ovqkbzpO8o90oJJBwMM0rO
	 0Uf/XEq2DDKnBp0rvs8BSwAH/4PxQCIem1QnkVXHUopUtlaj/TwObyYXgcYoQbC9JS
	 ohvLChsr4noa/9gLCSpCBQl7rMKANWcq34kipuFFaiqxcIc2OQmsS2Kht3v2XPlZNl
	 DTb66PGHHXf5io/UPlXvKU1RJ/eGY+Yp1mvQYy/kSZdj4WikyqxAgx9jhunn6FWQJU
	 fKK9gz4enjsHLC44wowQbRRRD769rcjLmqxN+GgsLpePFaX3KnWBbA3pw732ofDDsA
	 tL/hIYMkYpLVA==
Date: Tue, 9 Dec 2025 10:55:14 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v3] common/quota: fix to wait for all inodes been evicted
 in _check_quota_usage()
Message-ID: <20251209185514.GK89492@frogsfrogsfrogs>
References: <20251209075028.909869-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209075028.909869-1-chao@kernel.org>

On Tue, Dec 09, 2025 at 03:50:28PM +0800, Chao Yu wrote:
> generic/233  3s ... - output mismatch (see /share/git/fstests/results//generic/233.out.bad)
>     --- tests/generic/233.out   2025-01-12 21:57:40.259440359 +0800
>     +++ /share/git/fstests/results//generic/233.out.bad 2025-12-04 03:02:26.000000000 +0800
>     @@ -4,4 +4,12 @@
> 
>      seed = S
>      Comparing user usage
>     +4c4
>     +< #1000     --   31476   32000   32000            994  1000  1000
>     +---
>     +> #1000     --   31476   32000   32000            944  1000  1000
>     ...
>     (Run 'diff -u /share/git/fstests/tests/generic/233.out /share/git/fstests/results//generic/233.out.bad'  to see the entire diff)
> Ran: generic/233
> Failures: generic/233
> Failed 1 of 1 tests
> 
> Sometimes, generic/233 will fail due to it founds inode count is mismatched
> in between quota system and filesystem.
> 
> The reason is cgroup v2 implementation will increase inode reference first,
> and then, attach it to thread related cgroup writeback structure, once it
> needs to switch write owner of target inode, a kernel thread will process
> it, and finally release inode reference via evict_inode().
> 
> So, sync & drop_cache may not guarantee all inodes being evicted, as cgroup
> has one more referenece on inodes during the time.
> 
> If inode has not been evicted, dquot inode reference will not be release, it
> will lead to inode count mismatch.
> 
> Let's add a delay to wait for cgroup switching completion before quota check.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>

Looks fine to me now,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
> v3:
> - sleep in existed case statement rather than in newly added check condition
>  common/quota | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/common/quota b/common/quota
> index a51386b1..5d351fdf 100644
> --- a/common/quota
> +++ b/common/quota
> @@ -335,7 +335,14 @@ _check_quota_usage()
>  
>  	VFS_QUOTA=0
>  	case $FSTYP in
> -	ext2|ext3|ext4|f2fs|gfs2|bcachefs)
> +	ext2|ext3|ext4|gfs2|bcachefs)
> +		VFS_QUOTA=1
> +		quotaon -f -u -g $SCRATCH_MNT 2>/dev/null
> +		;;
> +	f2fs)
> +		# wait for inode_switch_wbs_wor_fn() to release inodes
> +		sleep 3
> +
>  		VFS_QUOTA=1
>  		quotaon -f -u -g $SCRATCH_MNT 2>/dev/null
>  		;;
> -- 
> 2.49.0
> 
