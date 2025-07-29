Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73244501A
	for <fstests@vger.kernel.org>; Tue, 29 Jul 2025 14:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753799393; cv=none; b=l8EBvyMLKl2UPQRiTRByT7X7RPlOBWeopldAuXbnY4dLx1SUW45ArOxYPdCzWd5tDPoGk4ydyTA/+Ym9KIXKkdtpBxnnT7pG1CdZRq7WmmbNOuS/HkguiBqAfYd7/Z/9FbxmdSF4tVlrE03KXx4A1FXthW0oRWta0nA5YW0lW2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753799393; c=relaxed/simple;
	bh=Mx0Adq1WF9Ydt2ynnvqY8rbbM10xYrjY0yzWUhQSBaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qeZ3J+dFy+xWeN10h4QtGeILWz1HW0RjUKHlLxSICXMdaRPPmCpTa8vjv4cbfEE+3e8yAtA0OX5X+wvEXZWjLbL9Y6m/rLJnugYW6gQ3j0f39QQ1OlXbxga3UU9hjnQNBGH5To/sK6FuFOe14tFRMGR5QMwbvMuFx9VtQEyIza8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNM8CiOu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNM8CiOu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798EAC4CEEF;
	Tue, 29 Jul 2025 14:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753799392;
	bh=Mx0Adq1WF9Ydt2ynnvqY8rbbM10xYrjY0yzWUhQSBaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YNM8CiOupQtyXRhEJr1Afth9YQiIjE+Jb29T8MOiUCSzvnLOpXG4yJszhpWZNyOdY
	 tGmkbyyL0SKj7YYeGORRYh7mDrPD54MqPo7kPu74MfkQowzp96ampgjOJmfbpYMgKL
	 9+LYbRRQOqmjkroom6LSnPS6jQwKvsIIYwWvH3p0JcpqNDicr48sO/wy5XH8kGMWw5
	 CJvs2oCphoZSDCjiuDGbrWIS+ApJu8DueDPPzH6CRI9+IZ8iJ03XJmXNjMq648E2BI
	 zXnXDF2Fzc2lA/k2v9uHW0dOfVSxZMa0lCU2UFcY0kPSjc6XkLfx1+//mZb2Mpxk+3
	 sSCEeuACQwX4Q==
Date: Tue, 29 Jul 2025 07:29:51 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: fstests@vger.kernel.org
Subject: Re: lots of mounts/remounts of the test file system?
Message-ID: <20250729142951.GR2672039@frogsfrogsfrogs>
References: <aH87hl9NUmiqqvU-@infradead.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aH87hl9NUmiqqvU-@infradead.org>

On Tue, Jul 22, 2025 at 12:19:34AM -0700, Christoph Hellwig wrote:
> Hi all,
> 
> I've been hacking on some (XFS) code that in this state of development
> requires a mount options to be passed for every mount, and I noticed
> that even when running without a SCRATCH_DEV I have to add the required
> option to MOUNT_OPTIONS and not just TEST_FS_MOUNT_OPTS, which is a bit
> odd.  I've been trying to track it down and despite multiple attempts
> failed to find my way through the bash code for it.
> 
> But what is even more odd is that when running just a single test (e.g.
> generic/001), the test fs gets mounted four times, with the second
> and fourth time failing to apply the mount options.

Huh, I observe the same thing.  I wonder why it does that, but bash is
pretty awful for tracing and there's no obvious explanation. :(

--D
