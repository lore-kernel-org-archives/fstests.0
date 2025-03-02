Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427BA1172A
	for <fstests@vger.kernel.org>; Sun,  2 Mar 2025 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740929847; cv=none; b=BKGMFS9o5yj3iQR+B/Wqtj4vm+u+ozx2KioI2+CuoV0yjFBDs8NNMXXAgWnt8uPSQ/zLFjQzXmqRxDV42V/RnSF/7S0TYb3WQsrS7/ae7+ei5wfTm2Yk1VKjpVGDqcMiCIfXpp7ultZL8wfGFM0nyYRItUhfScMTGhtIBKhhbeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740929847; c=relaxed/simple;
	bh=3g8wv+us1pnuBXPL0ZBq8XQqZAMFXcGmxfmcIZ5PNMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huprmEi4PvBLgH/TX/nLs+O1CYLIvuZWbqn6jrGOBcH0BfywdsKc7owHKkEPqIk+ePLxu4oPosJw9ImfdlRGC6TCa4ByNoe4HOtmXIAqkIj6DouQlZNghhVZWEeBPZ+FdevtLh8TCBMg6MWtAsJuXfYDJVjHFYgSHPNh3faD6w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPTkp1Md; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPTkp1Md"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42549C4CEE5;
	Sun,  2 Mar 2025 15:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740929846;
	bh=3g8wv+us1pnuBXPL0ZBq8XQqZAMFXcGmxfmcIZ5PNMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZPTkp1MdSs9jQYwueJEp6Mr0O2A5/UkZQ8p41NVsyBW48Ixn0ETGYs65IDYYfezD3
	 IdEEvAhU5rVS+Ypc3uVkWOL8woYtz72KFmfhQVwjP3Zb7ToRtjPIlq54MWH3H2V61j
	 cTKjn5LfqBFKlJTcXfxFhthr0DuN/5ZU1goWEZy81/QMfeQWVY8UOtM5nV/X5hJhev
	 iRfEqxgduRHf8qydWIwb5oG1vjDKta82J2wfZWJSTe6suoXekQh7iKBSr5yeLLrffP
	 mKHvwW6r4dPriBVCF7a2EHCIoabnzTOHv+cTFpYxdSgGDxS7laVUxmSeD86poaJhH2
	 74Wg2DeULJ8Qg==
Date: Sun, 2 Mar 2025 23:37:22 +0800
From: Zorro Lang <zlang@kernel.org>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, David Sterba <dsterba@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	"Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to v2025.02.23
Message-ID: <20250302153722.aevwzs5eisemxmaa@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <c238e76631b086db592f214beaa6fd94@kernel.org>
 <20250228123354.GE5777@twin.jikos.cz>
 <20250301140854.dplxboc3ml52e3ll@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H6Bb+pFjo11X3LAvtrVJLit1RTSg63k+weFDKsHOuYnOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H6Bb+pFjo11X3LAvtrVJLit1RTSg63k+weFDKsHOuYnOw@mail.gmail.com>

On Sun, Mar 02, 2025 at 01:13:43PM +0000, Filipe Manana wrote:
> On Sat, Mar 1, 2025 at 2:09 PM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Fri, Feb 28, 2025 at 01:33:54PM +0100, David Sterba wrote:
> > > On Sun, Feb 23, 2025 at 08:27:43PM +0800, Zorro Lang wrote:
> > > > Hi all,
> > > >
> > > > The for-next branch of the xfstests repository at:
> > > >
> > > >     git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> > > >
> > > > has just been updated and tagged as v2025.02.23 release.
> > > >
> > > > Release Notes:
> > > > 1) There's not new test cases in this release, this's a release for bug fixes
> > > >    particularly.
> > > > 2) Reiserfs part is removed from fstests.
> > > > 3) ltp/growfiles is removed too, I think no one needs it.
> > > >
> > > > I can't list all updates at here, more details please refer to below.
> > > > Thanks for all these contributions!
> > > >
> > > > Thanks,
> > > > Zorro
> > > >
> > > > The new head of the for-next branch is commit:
> > > >
> > > > 5b56a2d88819 fstests: remove reiserfs support
> > > >
> > > > New commits:
> > > >
> > > > Christoph Hellwig (1):
> > > >       [04d0cf3f8909] generic/370: don't exclude XFS
> > > >
> > > > Darrick J. Wong (35):
> > > >       [cc379f50f3bd] generic/476: fix fsstress process management
> > > >       [ab459c67c5e0] metadump: make non-local function variables more obvious
> > > >       [f428edcec2a2] metadump: fix cleanup for v1 metadump testing
> > > >       [e68a92376165] generic/019: don't fail if fio crashes while shutting down
> > > >       [48a3731b50ba] fuzzy: do not set _FSSTRESS_PID when exercising fsx
> > > >       [543795bf67f2] common/rc: revert recursive unmount in _clear_mount_stack
> > > >       [777732b27e62] common/dump: don't replace pids arbitrarily
> > > >       [81f28acda2f2] common/populate: correct the parent pointer name creation formulae
> > > >       [9b177d92dc65] generic/759,760: fix MADV_COLLAPSE detection and inclusion
> > > >       [241c1c787e5b] generic/759,760: skip test if we can't set up a hugepage for IO
> > > >       [77548e6066fd] common/rc: create a wrapper for the su command
> > > >       [ac2d48f81094] fuzzy: kill subprocesses with SIGPIPE, not SIGINT
> > > >       [c71349150d34] common/rc: hoist pkill to a helper function
> > > >       [91d2880aa029] tools: add a Makefile
> > > >       [88d60f434bd9] common: fix pkill by running test program in a separate session
> > > >       [247ab01fa227] check: run tests in a private pid/mount namespace
> > > >       [949bdf8eae31] check: deprecate using process sessions to isolate test instances
> > >
> > > I'm using a setup with a minimal VM system without systemd and such and
> > > dedicate the whole machine to one instance. I'm not interested in the
> > > check-parallel updates and test case separation. All fine if it is
> > > supported and lets me continue using single instance.
> > >
> > > But as I read it and the deprecation it's not going to be the supported
> > > use case. After last week update of fstests 100% of cases failed in the
> > > test setup (_seq_run). My workaround is to simply disable it by
> > >
> > > check:
> > > HAVE_PRIVATENS=
> > > HAVE_SYSTEMD_SCOPES=
> > >
> > > so I don't have to debug changes to the detection of the scope and
> > > namespaces and after each for-next update. I understand that with a
> > > custom system setup I'm on my own but until recently things have been
> > > fine but now after each update either test cases fail or the whole test
> > > infrastructure does not work.
> > >
> > > It's not just me who observes that. It seems that BTRFS is not tested
> > > before release as thoroughly as other filesystems (probably just XFS).
> >
> > I test btrfs (only default), ext4 (+-fsverity, +-dax), ext3, exfat, xfs(1k, 4k,
> > 64k blocksize, +-dax), tmpfs, nfs(base on xfs), cifs(on xfs), exfat, overlay
> > (on xfs) on aarch64, x86_64, s390x and ppc64le. But I'm not an expert of all
> > filesystems, so I just can check there's not big issue from my side for most of
> > fs. But different persons have different test ways, I can't try all different
> > test configs/ways on all filesystems by myself, I already take each weekend
> > to do these things, even I'm fever or on holiday. Even though I'm still asked
> > to release more fast...
> >
> > Darrick's patchset has been in the list more than one month (since 2025-01-16)
> > to get reviewing. And I've tested Darrick's patchset several weeks, and talked
> > with Darrick several times about some issues I found. Darrick has done his best
> > to do that, please don't give him more pressure. But still sorry about I didn't
> > find the "100% fail" big issue in my test env. Feel free to share the config
> > you use, I'll refer to it to change my test.
> 
> A lot of the regressions that broke btrfs tests, or generic tests when
> testing btrfs or ext4 for example, were not dependent on any specific
> config.
> I.e. no required MOUNT_OPTIONS or MKFS_OPTIONS, and failed with any
> kind of devices used as scratch and test devices.
> 
> For example:
> 
> https://web.git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=for-next&id=a1d583fa0062f097b54dfb2b9b7ff1d9260c855c
> 
> This generic test started to fail on any fs other than xfs.
> For me it failed with btrfs and ext4 (all the time).
> 
> Another example for another generic test case:
> 
> https://web.git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=for-next&id=7c5604ec86b82d118a3b84d7e5286740e652720d
> 
> Or this one:
> 
> https://web.git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=for-next&id=9b12a1a8a35bb491076332e21a113c43851ceb69
> 
> The dmdust device names changed but the btrfs tests were not updated,
> so the tests always failed no matter what your setup config is.
> 
> So anyone running btrfs or ext4 with default settings (no mount or
> mkfs options) should have run into the same failures.
> I can't see how they wouldn't run into those failures in fact.
> 
> Or another example, a fix from Ted, for a generic test case that
> always failed on ext4:
> 
> https://web.git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=for-next&id=023070744cef1fde8a5b4fbd8fa134cd5098843e
> 
> And there are plenty of other examples.
> 
> More recently, from last week's update:
> 
> https://lore.kernel.org/fstests/b470cdee538aab91177f8295fb8886ae79f680db.1740662683.git.fdmanana@suse.com/
> 
> While it's too time consuming to test all major filesystems for all
> possible configs, at least some basic testing can be done.
> By basic testing I mean run the quick group without any mount and mkfs
> options, which is reasonably fast and helps to catch a lot of
> problems.

Sure :) I've added btrfs regression test to my regular test list recently. For now,
only default btrfs is tested by xfstests "auto" group. Sorry I'm not familar with
btrfs test currently, I hit several test failures, need time to figure out which
is test issue, which is progs' issue, which is kernel issue and which is known and
unknown issue and so on.

For example:
btrfs/007 fails as:

   QA output created by 007
   *** test send / receive
  -*** done
  +failed: '2097152000 200'
  +(see /var/lib/xfstests/results//btrfs/007.full for details)

btrfs/060 blocks the whole test. Then btrfs/066 hang there after I
skip btrfs/060.

generic/363 fails as:

     QA output created by 363
     fsx -q -S 0 -e 1 -N 100000
    +READ BAD DATA: offset = 0x1fb5d, size = 0xc502, fname = /mnt/test/junk
    +OFFSET      GOOD    BAD     RANGE
    +0x2716c     0x0000  0x7f91  0x0
    +operation# (mod 256) for the bad data may be 127
    +0x2716d     0x0000  0x917f  0x1
    ...
    (Run 'diff -u /root/git/xfstests/tests/generic/363.out /root/git/xfstests/results//default/generic/363.out.bad'  to see the entire diff)

generic/427 fails as:

     QA output created by 427
    -Success, all done.
    +pwrite: No space left on device
    ...
    (Run 'diff -u /root/git/xfstests/tests/generic/427.out /root/git/xfstests/results//default/generic/427.out.bad'  to see the entire diff)

generic/730 fails as:

     QA output created by 730
    -cat: -: Input/output error
    ...
    (Run 'diff -u /root/git/xfstests/tests/generic/730.out /root/git/xfstests/results//default/generic/730.out.bad'  to see the entire diff)

and some random failures on different test env. and so on ...

After I'm familar with known failures, I think things will get better. Please
feel free to share known issues (that you know) to me.

Besides btrfs, there're lots of filesystems, they all have different known/unknown
failures. It's not easy for someone to check most of filesystems' test failures
before release. I'll try to avoid critical issue, likes can't be built or installed,
whole or most of tests broken, system destroy, and so on. But for some test
failures, I might notice and remind in ANNOUNCE email, might not. Each release
might have bugs, likes RHEL, likes SUSE, Debian ... *each release might have
bugs, but we have to release, have to move on if there's not critical blocker
bugs.*

I'm sorry for the recent mess. I'll try my best to get xfstests back to track.
I think things is getting better, last release is the first fix release for that.
We'll have next fix release. Please be patient, if things is out of control, I'll
think about reverting the whole feature.

Thanks,
Zorro

> 
> 
> Thanks.
> 
> >
> > I've gotten lots of pressure recently, I thought this release would be the end,
> > but looks like it's not. If you all (xfs, btrfs, ext4 and others) agree, I can
> > think about reverting the whole check-parallel and its related things, or there's
> > a switch to isolate the effect of check-parallel things. I thought there'll be a
> > painful period, but won't be too much if you don't use check-parallel directly.
> > I thought we will fix some bugs, then return to stable status. But I never thought
> > it's such painful. That's my fault...
> >
> > Thanks,
> > Zorro
> >
> > >
> >
> >
> 
