Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400B51F4CB3
	for <fstests@vger.kernel.org>; Fri, 28 Feb 2025 17:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740764000; cv=none; b=c/LT1annbDfjthj4vn2fue0ByMHnG0cYDi1TaM2kEal4P/7tSzwAE0453r75l2FCWh3kI7LMzyKZpQzlLesieB3XDF7GJcTpsZy7w5tkNjCWK0WWeXkQb26Ynpz59fAUzKWvc9pTUy2X2UEOEqy1uZDM5/j9clKv9gc2fc4SN1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740764000; c=relaxed/simple;
	bh=Ifqibn7pZrJPPuP2xClLmontY0zB0t7kPaMPadwvYkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PV5NzrUzEzy3B9eTgsCc/vAAxOxBKPtb5DQs9PvICPeehvsc4CNhrQQypAok1KhswwLdKIBLVBFrJcTDaflYoeQkeLmaoeuMvnQOR+Pe7Z6g5PHBkZFv9yv6iBHsxXG2jz4ypW/6l1PExAQ7a0cwdJ4foTG6gZRJ/FFIcb1Ds0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rz7gE8DN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rz7gE8DN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF261C4CED6;
	Fri, 28 Feb 2025 17:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740763999;
	bh=Ifqibn7pZrJPPuP2xClLmontY0zB0t7kPaMPadwvYkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rz7gE8DNJCeuhUOOO3YKpTTV/zCbI+mtK1P21ioMlpkUc+K8HXtIAIWu4Dd+5XCv+
	 //VttuJE20hxKTbxmUpwo2SH/3eR6/2YIYvFMfe6SZ9dPMmLH4PidYso2zLcGbj+u7
	 uscUjXEijqCCxL6yqvP7K28BZaq1KrHL0o4mdxVgOhY32OS3TzUmUwu57XDTzavrzu
	 YEal4SumvHv19dM/4EtiRNQuvAa257NCk8a08ddLKW9ktoQCgvxASClrYKoehllPhI
	 y43YeRubUN2fNtYJy02nSLjKS5tY9r7wo0pLm30E9K2GaDGxMRT6o+QWJhNSMwQzpq
	 xkzwW3UEI7ztA==
Date: Fri, 28 Feb 2025 09:33:19 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: David Sterba <dsterba@suse.cz>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to v2025.02.23
Message-ID: <20250228173319.GG1124788@frogsfrogsfrogs>
References: <c238e76631b086db592f214beaa6fd94@kernel.org>
 <20250228123354.GE5777@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228123354.GE5777@twin.jikos.cz>

On Fri, Feb 28, 2025 at 01:33:54PM +0100, David Sterba wrote:
> On Sun, Feb 23, 2025 at 08:27:43PM +0800, Zorro Lang wrote:
> > Hi all,
> > 
> > The for-next branch of the xfstests repository at:
> > 
> > 	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> > 
> > has just been updated and tagged as v2025.02.23 release.
> > 
> > Release Notes:
> > 1) There's not new test cases in this release, this's a release for bug fixes
> >    particularly.
> > 2) Reiserfs part is removed from fstests.
> > 3) ltp/growfiles is removed too, I think no one needs it.
> > 
> > I can't list all updates at here, more details please refer to below.
> > Thanks for all these contributions!
> > 
> > Thanks,
> > Zorro
> > 
> > The new head of the for-next branch is commit:
> > 
> > 5b56a2d88819 fstests: remove reiserfs support
> > 
> > New commits:
> > 
> > Christoph Hellwig (1):
> >       [04d0cf3f8909] generic/370: don't exclude XFS
> > 
> > Darrick J. Wong (35):
> >       [cc379f50f3bd] generic/476: fix fsstress process management
> >       [ab459c67c5e0] metadump: make non-local function variables more obvious
> >       [f428edcec2a2] metadump: fix cleanup for v1 metadump testing
> >       [e68a92376165] generic/019: don't fail if fio crashes while shutting down
> >       [48a3731b50ba] fuzzy: do not set _FSSTRESS_PID when exercising fsx
> >       [543795bf67f2] common/rc: revert recursive unmount in _clear_mount_stack
> >       [777732b27e62] common/dump: don't replace pids arbitrarily
> >       [81f28acda2f2] common/populate: correct the parent pointer name creation formulae
> >       [9b177d92dc65] generic/759,760: fix MADV_COLLAPSE detection and inclusion
> >       [241c1c787e5b] generic/759,760: skip test if we can't set up a hugepage for IO
> >       [77548e6066fd] common/rc: create a wrapper for the su command
> >       [ac2d48f81094] fuzzy: kill subprocesses with SIGPIPE, not SIGINT
> >       [c71349150d34] common/rc: hoist pkill to a helper function
> >       [91d2880aa029] tools: add a Makefile
> >       [88d60f434bd9] common: fix pkill by running test program in a separate session
> >       [247ab01fa227] check: run tests in a private pid/mount namespace
> >       [949bdf8eae31] check: deprecate using process sessions to isolate test instances
> 
> I'm using a setup with a minimal VM system without systemd and such and
> dedicate the whole machine to one instance. I'm not interested in the
> check-parallel updates and test case separation. All fine if it is
> supported and lets me continue using single instance.

Hi Dave (Sterba),

Agreed.  I would very much have liked to continue single-instance
testing in peace the same way I always have.  There are things that
excite me that I would like to move onto; refactoring a large pile of
bash is NOT one of them.

Before anyone gets any ideas -- there is no grand plan or collaboration
here.  Chinner posted an RFC[1] and wrote:

"This will probably take a bit of time, so I'd like to get the bug
fixes, improvements and infrastructure changes underway so I'm not
left carrying a huge patchset for months...."

[1] https://lore.kernel.org/fstests/20241127045403.3665299-1-david@fromorbit.com/

and later roared[2] at me that he isn't some n00b as a response to my
question about whether he'd had problems with xfs_scrub:

"Thank you for finding this, Darrick, but there is absolutely no need to
treat me like a n00b who doesn't know how kernel development works."

[2] https://lore.kernel.org/fstests/Z0pBKWBlXLBxwK3D@dread.disaster.area/

Yeah, I know he's a senior developer.

Apparently Zorro felt pressured into merging it to for-next over my
misgivings and the obviously inadequate testing by the author.  I don't
know why he made the decision to merge it.  If Zorro wants to discuss
that publicly, he can do so.

So it went in, and everything broke.  Ted and Amir and I (and probably
more people) noticed and started comparing notes and complaining, but
Chinner didn't respond by trying to fix anything.  Instead, he told me
to go fix the stuff his changes broke:

"Changing existing infrastructure behaviour to better suit *your* test
environments is *your* responsibility to address, not mine.  I don't
care if MKFS_OPTIONS get dropped in occasional tests, it's more
important to me that the tests run fast so I can iterate my
modify-build-test development cycle faster."

[3] https://lore.kernel.org/fstests/Z2SG2HsqgA46kuAz@dread.disaster.area/

I've been told that Chinner was on vacation from mid December to mid
January.  If that's true then I feel sad that someone would come back
from vacation just to talk condescendingly to me.  If it's not true then
wow.

Anyway, I only took on fixing fstests so that I could push *tested* XFS
code towards cem and linus for 6.14-rc1.  That was my only motivation in
adjusting the recent killall->pkill code changes.  But this is bash, so
there are a lot of subtleties and (as we have all seen) a high risk of
breakage.

I'm doing this under duress.  I don't want to be wrangling what used to
be well-worn bash.  I don't know what Chinner's future plans are.  I
don't know if he and Zorro have discussed this further.  I'm only doing
this because I feel obligated to enable testing in the community.

I'm sorry that things have gotten really messed up for you and Felipe.
This whole situation is messed up.  I don't want to be here.

</defensive blathering>

> But as I read it and the deprecation it's not going to be the supported
> use case. After last week update of fstests 100% of cases failed in the
> test setup (_seq_run). My workaround is to simply disable it by
> 
> check:
> HAVE_PRIVATENS=
> HAVE_SYSTEMD_SCOPES=

If you don't have systemd, then HAVE_SYSTEMD_SCOPES should never be set
to "yes", correct?  I'm wondering if there's a detection bug somewhere,
or are you simply overriding the upstream logic with a large hammer?

> so I don't have to debug changes to the detection of the scope and
> namespaces and after each for-next update. I understand that with a
> custom system setup I'm on my own but until recently things have been
> fine but now after each update either test cases fail or the whole test
> infrastructure does not work.

I'm willing to *undeprecate* tools/run_setsid.  Clearly you have a use
case for that.

Thinking slightly further, if check-parallel is going to require
tools/run_privatens to work, then we could just revert all the pkill
changes in the test suite.  That would have been a useful design
discussion to have had before merging.

> It's not just me who observes that. It seems that BTRFS is not tested
> before release as thoroughly as other filesystems (probably just XFS).

Admittedly, I only run ext4/btrfs in the default configurations.  I only
learned yesterday about SCRATCH_DEV_POOL because Felipe called that out.

--D
