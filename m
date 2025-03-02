Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5055D1E5B99
	for <fstests@vger.kernel.org>; Sun,  2 Mar 2025 16:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740932302; cv=none; b=qokI2IR6uAM2ElZ7y24lDq3lxwygH7tACVjyAVHlC0lvGqMpRLoZtmboyvhgnUfSynlm6rYzjeLMDvY3Zf7Dw7kcqO3pr61rfPVmJ2gdYDBR1c/kzCTitOHrIjATM9bYopQgOc2qMcMgZ8IqKHgJwgusxddg786sZZc9cYt2HAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740932302; c=relaxed/simple;
	bh=x922AVn1Vwseiw1yF8n3GO/N04Cr1B0W5hZACSE/hlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhx0z4uDMQu1JhxsQ5joPT/YjLXA+opAxWJ6bgljwGP4RieTyQXwwu/VeNU5shFnvU7HAEq5e/XsHOcjXMD4VkqCf3pXKSTOfPqzbPBdNPntHqu3FL4Dwalm3728MbDAQAanYAIb6oyYT9x6ha8jNzzVBiYvQVrmZUREpz0kiTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1AmSTSy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1AmSTSy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F1EC4CED6;
	Sun,  2 Mar 2025 16:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740932301;
	bh=x922AVn1Vwseiw1yF8n3GO/N04Cr1B0W5hZACSE/hlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A1AmSTSyviKm5gKm4GraVzCf1Dmv0KfgK4qW0kocywqhzDxvTsqPzS/3s1D9C9IuX
	 pk2YLgvRF7GUGToW/gHMhh8jmxUPY62PqHs+gJBYV2X83TAsX4LD1k97oEeycSDl8o
	 tS/c1AzS7Ea8SxrpjUXGLwM3KPn/rypLfI9wMUF7KIccuedYISQuh8RtgPMxSL9AEJ
	 wtIJJVlwKvHV4SJvVMouy2L2Vg2zRp4CtV1PIVTo/qnAu7YXvV+carcccavqin6dZ8
	 cfCu8NaqebaFb+AsS8m/1HY8FIVM0zS48sRBItIN99FlwyuyC+aov+vQ81hoBHb0QP
	 c9+8+z4DQYk2Q==
Date: Mon, 3 Mar 2025 00:18:16 +0800
From: Zorro Lang <zlang@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Filipe Manana <fdmanana@kernel.org>, Zorro Lang <zlang@redhat.com>,
	David Sterba <dsterba@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to v2025.02.23
Message-ID: <20250302161816.bdwgiccbk4lszskw@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <c238e76631b086db592f214beaa6fd94@kernel.org>
 <20250228123354.GE5777@twin.jikos.cz>
 <20250301140854.dplxboc3ml52e3ll@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H6Bb+pFjo11X3LAvtrVJLit1RTSg63k+weFDKsHOuYnOw@mail.gmail.com>
 <20250302145016.GA153209@mit.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250302145016.GA153209@mit.edu>

On Sun, Mar 02, 2025 at 09:50:16AM -0500, Theodore Ts'o wrote:
> On Sun, Mar 02, 2025 at 01:13:43PM +0000, Filipe Manana wrote:
> > Or another example, a fix from Ted, for a generic test case that
> > always failed on ext4:
> > 
> > https://web.git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=for-next&id=023070744cef1fde8a5b4fbd8fa134cd5098843e
> >
> 
> Actually, this fixed a bug which affected file systems for all file
> systems *except* xfs, since the generic bug was injecting an
> XFS-specific mkfs option into _scratch_mkfs.  This was a *really*
> obvious bug, but the problem was that commit 000813899afb ("fstests:
> scale some tests for high CPU count sanity") made *huge* number of
> changes, which made it hard to review the change, and also made it
> harder for Dave to rebase the change, which is why, apparently,
> pressure was applied to merge commit 000813899afb right before Dave
> diappeared on vacation for a month.  This is why I nated that there
> appeared to be a double standarrd in place; I can't help but suspect
> that if anyone *else* had sent in this commit, it would have been
> rejected.
> 
> As far as testing, my understanding is that the huge amount of testing
> happens between the promotion from for-next to the master branch.
> This is why I used to make a point of upgrading my test appliance to
> for-next, so I could help point out problems before most other
> deveopers would see it in the master branch.

Hi Ted,

Sorry, I was hurry to make a big step on xfstests... Although I just
brought in btrfs test into my regular test list recently (RHEL doesn't
support btrfs, I don't have the experience to test it). But ext4
is supported by us, I test ext4/3 with 1k/4k blocksize, fsverity, dax
before each xfstests release. Last ext4 regression test on v2025.02.23
was all passed on my side, except 4 known failures on g/044, g/045, g/046
and g/388:

  XFSTESTS_END/[passed:542][notrun:259][known:4][unknown:0] PASS Score:0

Do I miss anything on extN testing, cause I didn't find most of test
failures on ext4? Please feel free to tell me what is better to be
tested on ext4 side before release xfstests, and what's optional. I'll
try to add it to my test list.

Thanks,
Zorro

> 
> The fixes that you pointed out was all reasons why the master branch
> hadn't been updated in months; it was because for-next still had
> breakages.  There is the challenge that when master hasn't gotten
> updated for 2 or 3 months, it becomes harder to tell whether a test
> failure was caused by a test bug, or a kernel bug.  (It's not
> impossible; for a while I was going to older versions of for-next, and
> the comparing the results to newer versions of for-next, and then
> filtering out new tests, but it's a bit of a pain.)
> 
> Ultimately, like most engineering tradeoffs this was a pain allocation
> exercise.  Dave didn't want to deal with rebasing changes, so the
> check-parallel changes got merged to for-next early.  This inflicted
> pain on other xfstests developers.
> 
> 					- Ted
> 
