Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45034215F7D
	for <fstests@vger.kernel.org>; Tue,  4 Mar 2025 18:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741114685; cv=none; b=rrMG3cKTmLqAXjavE0ZCWCj+qRrlFqTKhTjRSnqZZOB0X2WyahOmX7kUqgiQi2cSTlEJkTkCbN2PPCGQkdKXHeCuhWNSbZOGHROtB22v61etIaKe1LaGUL4yKYm4IP8hS+tV6o9FGof3nKfXsFGHeZ7Q1LtutA2qlGIdVrFZW+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741114685; c=relaxed/simple;
	bh=Jvl5Iae3HqWI6VrYahmk3LaC4lakCsXMA2FKN5EH96s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcCcvwihn+4F1nffFC9tVovDT25OjUXqWBgioUSwIaHyI87vKC2D92wKX7BauuDyiqMJDE4X0L9sE7P62G5xYm79YfgId7+wGa8Io1yWtobZ3tki0NHg3Y1Jhp+b+HLkp6oB+q6O9ALUG9Gl3tTqGBtL93hOCGFm1hDCvLblBlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3S8DxOU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3S8DxOU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B0AC4CEE5;
	Tue,  4 Mar 2025 18:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741114684;
	bh=Jvl5Iae3HqWI6VrYahmk3LaC4lakCsXMA2FKN5EH96s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F3S8DxOUPUh4KeTG1vQRh2lUeN4pZiCp7iM523b5Gy5jHC0YV41qKPgZX3E0m8OkG
	 IVdnAzW4UX8BCbeOz82OuyiqTpLifG2IO8RdN7Lu82AHob4d3nMVRIYraL/Pl/255O
	 VXi8snsFENXFNggxcJX8cexMeXL0AlovIYfo8Qjz9w+LjSmD5FrrSkl8yPpyGf6kaU
	 Fvk/1hhLamwFdVJNLubWbqLMYQdzkFQqIWUIFrKHOM06YMiMTaVinIPI+yg5wWLt5R
	 Brrq7ADNccU6Q3tI9vOPhOUw4SzLsKtTrrYwK1DGxmE/9BxzSfoT1OoPdTdsWgZNQz
	 ALB0PCk0yJ7KQ==
Date: Tue, 4 Mar 2025 10:58:04 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: David Sterba <dsterba@suse.cz>, Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to v2025.02.23
Message-ID: <20250304185804.GE2803740@frogsfrogsfrogs>
References: <c238e76631b086db592f214beaa6fd94@kernel.org>
 <20250228123354.GE5777@twin.jikos.cz>
 <20250301165012.mm2yuyobrh2cogg5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250301165012.mm2yuyobrh2cogg5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Sun, Mar 02, 2025 at 12:50:12AM +0800, Zorro Lang wrote:
> On Fri, Feb 28, 2025 at 01:33:54PM +0100, David Sterba wrote:
> > On Sun, Feb 23, 2025 at 08:27:43PM +0800, Zorro Lang wrote:
> > > Hi all,
> > > 
> > > The for-next branch of the xfstests repository at:
> > > 
> > > 	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> > > 
> > > has just been updated and tagged as v2025.02.23 release.
> > > 
> > > Release Notes:
> > > 1) There's not new test cases in this release, this's a release for bug fixes
> > >    particularly.
> > > 2) Reiserfs part is removed from fstests.
> > > 3) ltp/growfiles is removed too, I think no one needs it.
> > > 
> > > I can't list all updates at here, more details please refer to below.
> > > Thanks for all these contributions!
> > > 
> > > Thanks,
> > > Zorro
> > > 
> > > The new head of the for-next branch is commit:
> > > 
> > > 5b56a2d88819 fstests: remove reiserfs support
> > > 
> > > New commits:
> > > 
> > > Christoph Hellwig (1):
> > >       [04d0cf3f8909] generic/370: don't exclude XFS
> > > 
> > > Darrick J. Wong (35):
> > >       [cc379f50f3bd] generic/476: fix fsstress process management
> > >       [ab459c67c5e0] metadump: make non-local function variables more obvious
> > >       [f428edcec2a2] metadump: fix cleanup for v1 metadump testing
> > >       [e68a92376165] generic/019: don't fail if fio crashes while shutting down
> > >       [48a3731b50ba] fuzzy: do not set _FSSTRESS_PID when exercising fsx
> > >       [543795bf67f2] common/rc: revert recursive unmount in _clear_mount_stack
> > >       [777732b27e62] common/dump: don't replace pids arbitrarily
> > >       [81f28acda2f2] common/populate: correct the parent pointer name creation formulae
> > >       [9b177d92dc65] generic/759,760: fix MADV_COLLAPSE detection and inclusion
> > >       [241c1c787e5b] generic/759,760: skip test if we can't set up a hugepage for IO
> > >       [77548e6066fd] common/rc: create a wrapper for the su command
> > >       [ac2d48f81094] fuzzy: kill subprocesses with SIGPIPE, not SIGINT
> > >       [c71349150d34] common/rc: hoist pkill to a helper function
> > >       [91d2880aa029] tools: add a Makefile
> > >       [88d60f434bd9] common: fix pkill by running test program in a separate session
> > >       [247ab01fa227] check: run tests in a private pid/mount namespace
> > >       [949bdf8eae31] check: deprecate using process sessions to isolate test instances
> > 
> > I'm using a setup with a minimal VM system without systemd and such and
> > dedicate the whole machine to one instance. I'm not interested in the
> > check-parallel updates and test case separation. All fine if it is
> > supported and lets me continue using single instance.
> > 
> > But as I read it and the deprecation it's not going to be the supported
> > use case. After last week update of fstests 100% of cases failed in the
> > test setup (_seq_run). My workaround is to simply disable it by
> > 
> > check:
> > HAVE_PRIVATENS=
> > HAVE_SYSTEMD_SCOPES=
> 
> BTW, HAVE_SYSTEMD_SCOPES has been there several years, so if it works for
> you before, it's not the problem of HAVE_SYSTEMD_SCOPES, even if your VM
> doesn't have systemd.
> 
> So if it works for you by setting HAVE_PRIVATENS=(null), then the problem
> maybe from the `./tools/run_privatens "./$seq"` part, and also means the
> `./tools/run_setsid "./$seq"` part is good to you. Sorry I didn't hit
> this failure even with btrfs, so if you can provide some details, we'll
> look into it.

Yes, the exact output of the test failure would help debug this.  Did
the initial detection of private namespace support succeed, but then
actually running a test failed?  Did something get screwed up once the
test was running?  There have been other reports about odd problems if
TEST_DIR/SCRATCH_MNT point to something under /tmp.

(This is exactly why I didn't want to get involved in a land war
in^W^W^Wrefactoring of working bash code.)

--D

> Zorro
> 
> > 
> > so I don't have to debug changes to the detection of the scope and
> > namespaces and after each for-next update. I understand that with a
> > custom system setup I'm on my own but until recently things have been
> > fine but now after each update either test cases fail or the whole test
> > infrastructure does not work.
> > 
> > It's not just me who observes that. It seems that BTRFS is not tested
> > before release as thoroughly as other filesystems (probably just XFS).
> > 
> 
> 
