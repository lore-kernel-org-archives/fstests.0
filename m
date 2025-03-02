Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76F770821
	for <fstests@vger.kernel.org>; Sun,  2 Mar 2025 19:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740945433; cv=none; b=QeNc21gxu4Qaap74HiA8FXx1yVl03iPJM4DNg3pKne/+e/CUesJxrHkZl3WUZEx/eLfrv7lN3upWCfrbszZVU/2OsTPofdhpN3lDndauetU/G/HM3oJjtPIxN6k8S1ItSYsV2glHLB0ZIIAMQ0cK4frWFmH/dIsYVQBrc56UXlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740945433; c=relaxed/simple;
	bh=VzGZnmypGSgs4EdnvbKeIzuontDbD8xREFbj5a+Ct/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OB4VRpUOgvnXJl9q35688cSbaXewl0oHwqeuMfTYdKgHcn6Xuz7kuEbkqHvWlI/dmeQFtV4GwbzrcsPT+C+/B21FhRRuW2dYchwsOcg7PP6EkYn35wd2PX214BP76xilH0zLWrmaB1ECNusgDTKjwHgj3jZtDmJKaLmwEeVSMuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y4mggFW8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y4mggFW8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740945429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iOYBLWwkwAJToaP+1rxZdK5Jspc39kWnE/NFKn3fNwQ=;
	b=Y4mggFW8wg2MdpA32NXnurFjQdNb7U99biErbGYgzJO9m6MIQNW/dS6RLmWCtPh3AcHp1e
	VQ7Z7Oyl086PD7ui8gRWYEI+BD8tIUkSkc6K4gFg6eIx9t8ePbCzuwFaQKrliajzBRSDVV
	P5UcTCZWXeabNlPQLb9SDem1GOvlipk=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-XzBahKOwPPyGX35PCPDyyQ-1; Sun, 02 Mar 2025 14:57:03 -0500
X-MC-Unique: XzBahKOwPPyGX35PCPDyyQ-1
X-Mimecast-MFC-AGG-ID: XzBahKOwPPyGX35PCPDyyQ_1740945422
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-22380c707d3so19723605ad.1
        for <fstests@vger.kernel.org>; Sun, 02 Mar 2025 11:57:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740945421; x=1741550221;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iOYBLWwkwAJToaP+1rxZdK5Jspc39kWnE/NFKn3fNwQ=;
        b=E4h5PAkMGJiAMxVARhQqJEmdDc5vcjyrR+kcKTi1TfIDR9gUFAX3PIOn6Lo73leoZm
         wbIRXVpnol9YgvQjosediBvs8wjp8czOcXsUveKHbGiSX5g9o1WeGe2TqaRoIjScOKvK
         ti9vX5gUZKkG0pJ9xyxxcJX0Ty7TxzE5ljI++GQ1h4v4TByvYJfp6UQXag/jfldxuNf9
         oLTjjeg4SsajGsZy0FdhEJQSoJgYjW6aN8Qbx2XbXlGYp4snerhyYj1R7xeH5x1uwQz1
         C2ny/H5aqCTSCpZPUHkzPFqqcqbDY20ytr4GKOA75ZHbqrEN5r4qQAulybd08C54HC5v
         e4tw==
X-Forwarded-Encrypted: i=1; AJvYcCVJZUzDgjKdC7UOrevgqOHEa8hY/kQ3n5AIX99PvNAO6yvWxfcL8QsDiIEQiTUwD97GuzB1jMpl@vger.kernel.org
X-Gm-Message-State: AOJu0YwTnpdKIv4IYK9d5lw3YUxCMM3M5Pig/XpGmrfczLX6iXh3i48Z
	hom8SqEAYehYrl3JZOrEEqxgnKO5XjWmY1EFtTCKl8yX25tRoojvifcbZR5ByEtq6VWkorw28iD
	y2oV48DDFJuKw/FvcFg5U12Q24iCplT2bhx1p0jQgp7mTfh97Gcrnxjo=
X-Gm-Gg: ASbGnct2MzkxRCPgfxYXt6kdSJ+LJdmiQdoGrm3E754fbrZdY9Cl0+mx9yMraBZwlgU
	0u8/XxUrjq3Bh38+c+lDL8At2GtnrRQrup31P5FQvC9CnjZ6sS/F+brpb1b9DDmodZL4LT7ZkoT
	maPb0oo9mBVaw8Uj3gmpvdvf5Py4QBCiUX0zYCh6Na63IGwbBaeJ126/lIOGgXmtNpNzUs6qCB+
	YBe2qmB7mW8YqXflf1kwErZJNwd7laEVnKGHfFdqC4stFgM960ai4SaTse+stMhYa9RZxWmalmV
	tbw7RXmUxEhVDohkD5hjCb7Uun6yP5+qPmOoGrOQPSoFMgmMR0KhQgPh
X-Received: by 2002:a05:6a00:2e23:b0:736:4e67:d631 with SMTP id d2e1a72fcca58-7364e67de23mr3124364b3a.23.1740945421387;
        Sun, 02 Mar 2025 11:57:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmqNmahnuJVom8hHPpYLZeg50YxE5M5xkTg2YsNDSNV+sE/aJ06lnoHoepVMNdLvNNzxr6ww==
X-Received: by 2002:a05:6a00:2e23:b0:736:4e67:d631 with SMTP id d2e1a72fcca58-7364e67de23mr3124335b3a.23.1740945420762;
        Sun, 02 Mar 2025 11:57:00 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe47eb6sm7326125b3a.42.2025.03.02.11.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 11:57:00 -0800 (PST)
Date: Mon, 3 Mar 2025 03:56:56 +0800
From: Zorro Lang <zlang@redhat.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, David Sterba <dsterba@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	"Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to v2025.02.23
Message-ID: <20250302195656.prekf5hzqe46hi2u@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <c238e76631b086db592f214beaa6fd94@kernel.org>
 <20250228123354.GE5777@twin.jikos.cz>
 <20250301140854.dplxboc3ml52e3ll@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H6Bb+pFjo11X3LAvtrVJLit1RTSg63k+weFDKsHOuYnOw@mail.gmail.com>
 <20250302153722.aevwzs5eisemxmaa@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H6=QqNmMy0cr84G+SNAtvsQyvm+O6oimZPW4=y=yTNCGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H6=QqNmMy0cr84G+SNAtvsQyvm+O6oimZPW4=y=yTNCGA@mail.gmail.com>

On Sun, Mar 02, 2025 at 07:02:15PM +0000, Filipe Manana wrote:
> On Sun, Mar 2, 2025 at 3:37 PM Zorro Lang <zlang@kernel.org> wrote:
> >
> > On Sun, Mar 02, 2025 at 01:13:43PM +0000, Filipe Manana wrote:
> > > On Sat, Mar 1, 2025 at 2:09 PM Zorro Lang <zlang@redhat.com> wrote:
> > > >
> > > > On Fri, Feb 28, 2025 at 01:33:54PM +0100, David Sterba wrote:
> > > > > On Sun, Feb 23, 2025 at 08:27:43PM +0800, Zorro Lang wrote:
> > > > > > Hi all,
> > > > > >
> > > > > > The for-next branch of the xfstests repository at:
> > > > > >
> > > > > >     git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> > > > > >
> > > > > > has just been updated and tagged as v2025.02.23 release.
> > > > > >
> > > > > > Release Notes:
> > > > > > 1) There's not new test cases in this release, this's a release for bug fixes
> > > > > >    particularly.
> > > > > > 2) Reiserfs part is removed from fstests.
> > > > > > 3) ltp/growfiles is removed too, I think no one needs it.
> > > > > >
> > > > > > I can't list all updates at here, more details please refer to below.
> > > > > > Thanks for all these contributions!
> > > > > >
> > > > > > Thanks,
> > > > > > Zorro
> > > > > >
> > > > > > The new head of the for-next branch is commit:
> > > > > >
> > > > > > 5b56a2d88819 fstests: remove reiserfs support
> > > > > >
> > > > > > New commits:
> > > > > >
> > > > > > Christoph Hellwig (1):
> > > > > >       [04d0cf3f8909] generic/370: don't exclude XFS
> > > > > >
> > > > > > Darrick J. Wong (35):
> > > > > >       [cc379f50f3bd] generic/476: fix fsstress process management
> > > > > >       [ab459c67c5e0] metadump: make non-local function variables more obvious
> > > > > >       [f428edcec2a2] metadump: fix cleanup for v1 metadump testing
> > > > > >       [e68a92376165] generic/019: don't fail if fio crashes while shutting down
> > > > > >       [48a3731b50ba] fuzzy: do not set _FSSTRESS_PID when exercising fsx
> > > > > >       [543795bf67f2] common/rc: revert recursive unmount in _clear_mount_stack
> > > > > >       [777732b27e62] common/dump: don't replace pids arbitrarily
> > > > > >       [81f28acda2f2] common/populate: correct the parent pointer name creation formulae
> > > > > >       [9b177d92dc65] generic/759,760: fix MADV_COLLAPSE detection and inclusion
> > > > > >       [241c1c787e5b] generic/759,760: skip test if we can't set up a hugepage for IO
> > > > > >       [77548e6066fd] common/rc: create a wrapper for the su command
> > > > > >       [ac2d48f81094] fuzzy: kill subprocesses with SIGPIPE, not SIGINT
> > > > > >       [c71349150d34] common/rc: hoist pkill to a helper function
> > > > > >       [91d2880aa029] tools: add a Makefile
> > > > > >       [88d60f434bd9] common: fix pkill by running test program in a separate session
> > > > > >       [247ab01fa227] check: run tests in a private pid/mount namespace
> > > > > >       [949bdf8eae31] check: deprecate using process sessions to isolate test instances
> > > > >
> > > > > I'm using a setup with a minimal VM system without systemd and such and
> > > > > dedicate the whole machine to one instance. I'm not interested in the
> > > > > check-parallel updates and test case separation. All fine if it is
> > > > > supported and lets me continue using single instance.
> > > > >
> > > > > But as I read it and the deprecation it's not going to be the supported
> > > > > use case. After last week update of fstests 100% of cases failed in the
> > > > > test setup (_seq_run). My workaround is to simply disable it by
> > > > >
> > > > > check:
> > > > > HAVE_PRIVATENS=
> > > > > HAVE_SYSTEMD_SCOPES=
> > > > >
> > > > > so I don't have to debug changes to the detection of the scope and
> > > > > namespaces and after each for-next update. I understand that with a
> > > > > custom system setup I'm on my own but until recently things have been
> > > > > fine but now after each update either test cases fail or the whole test
> > > > > infrastructure does not work.
> > > > >
> > > > > It's not just me who observes that. It seems that BTRFS is not tested
> > > > > before release as thoroughly as other filesystems (probably just XFS).
> > > >
> > > > I test btrfs (only default), ext4 (+-fsverity, +-dax), ext3, exfat, xfs(1k, 4k,
> > > > 64k blocksize, +-dax), tmpfs, nfs(base on xfs), cifs(on xfs), exfat, overlay
> > > > (on xfs) on aarch64, x86_64, s390x and ppc64le. But I'm not an expert of all
> > > > filesystems, so I just can check there's not big issue from my side for most of
> > > > fs. But different persons have different test ways, I can't try all different
> > > > test configs/ways on all filesystems by myself, I already take each weekend
> > > > to do these things, even I'm fever or on holiday. Even though I'm still asked
> > > > to release more fast...
> > > >
> > > > Darrick's patchset has been in the list more than one month (since 2025-01-16)
> > > > to get reviewing. And I've tested Darrick's patchset several weeks, and talked
> > > > with Darrick several times about some issues I found. Darrick has done his best
> > > > to do that, please don't give him more pressure. But still sorry about I didn't
> > > > find the "100% fail" big issue in my test env. Feel free to share the config
> > > > you use, I'll refer to it to change my test.
> > >
> > > A lot of the regressions that broke btrfs tests, or generic tests when
> > > testing btrfs or ext4 for example, were not dependent on any specific
> > > config.
> > > I.e. no required MOUNT_OPTIONS or MKFS_OPTIONS, and failed with any
> > > kind of devices used as scratch and test devices.
> > >
> > > For example:
> > >
> > > https://web.git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=for-next&id=a1d583fa0062f097b54dfb2b9b7ff1d9260c855c
> > >
> > > This generic test started to fail on any fs other than xfs.
> > > For me it failed with btrfs and ext4 (all the time).
> > >
> > > Another example for another generic test case:
> > >
> > > https://web.git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=for-next&id=7c5604ec86b82d118a3b84d7e5286740e652720d
> > >
> > > Or this one:
> > >
> > > https://web.git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=for-next&id=9b12a1a8a35bb491076332e21a113c43851ceb69
> > >
> > > The dmdust device names changed but the btrfs tests were not updated,
> > > so the tests always failed no matter what your setup config is.
> > >
> > > So anyone running btrfs or ext4 with default settings (no mount or
> > > mkfs options) should have run into the same failures.
> > > I can't see how they wouldn't run into those failures in fact.
> > >
> > > Or another example, a fix from Ted, for a generic test case that
> > > always failed on ext4:
> > >
> > > https://web.git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=for-next&id=023070744cef1fde8a5b4fbd8fa134cd5098843e
> > >
> > > And there are plenty of other examples.
> > >
> > > More recently, from last week's update:
> > >
> > > https://lore.kernel.org/fstests/b470cdee538aab91177f8295fb8886ae79f680db.1740662683.git.fdmanana@suse.com/
> > >
> > > While it's too time consuming to test all major filesystems for all
> > > possible configs, at least some basic testing can be done.
> > > By basic testing I mean run the quick group without any mount and mkfs
> > > options, which is reasonably fast and helps to catch a lot of
> > > problems.
> >
> > Sure :) I've added btrfs regression test to my regular test list recently.
> 
> Ok, so until very recently there was no testing at all?

No, I test with RHEL system, RHEL doesn't have btrfs support, it doesn't build btrfs
module and progs. So our test related things don't support btrfs test either.
And btrfs related patches are tested by Anand at first, so I paid more attention
to other fs test. Everything looks good, until recently, btrfs related bugs are
reported more, then I started to change our internal test scripts to support upstream
btrfs test.

> 
> > For now,
> > only default btrfs is tested by xfstests "auto" group. Sorry I'm not familar with
> > btrfs test currently, I hit several test failures, need time to figure out which
> > is test issue, which is progs' issue, which is kernel issue and which is known and
> > unknown issue and so on.
> 
> You don't need to be an expert on btrfs, not much less figure out
> which kernels have fixes, btrfs-progs versions, for which configs,
> etc.
> That's even hard for us btrfs developers when dealing with stable
> releases, distros, etc.
> 
> All that needs to be done, and this would have catched all the recent
> bugs from the last 2+ months, is:
> 
> 1) Create a branch based on for-next;
> 
> 2) Apply all the patches you want from the mailing list;
> 
> 3) Run the quick group for btrfs (or ext4, or whatever) without any
> mount and mkfs options;
> 
> 4) For any test that fails, verify if they fail too on for-next
> without the new patches.
>     If they fail too, then it's unlikely to be a regression.
>     If they pass on for-next, bisect which new patch introduces the
> regression and notify the author.
> 
> This would have caught all the recent regressions we had.

Yeah, I planned to do that later. But I have to say, some random failures are
hard to be compared. I don't test in similar VMs with similar hardware. We have
many different kinds of test machines with different hardwares. There might be
some failures be triggered randomly. I can't promise I'll find all real bugs,
just try my best to give btrfs a basic cover.

And if we have *big* changes on fstests infrastructure later, I'll notice btrfs
and ext4, to check if you'd like to give it a test (not only xfs), then I push
it after getting your feedback. Actually it's not I'm only care about xfs, I
only do half of xfs tests, for example I don't test xfs RT and don't run hundreds
of xfs cases not in auto group. Just Darrick really would like to help to test
from his side and feedback sometimes.

Thanks,
Zorro

> 
> >
> > For example:
> > btrfs/007 fails as:
> >
> >    QA output created by 007
> >    *** test send / receive
> >   -*** done
> >   +failed: '2097152000 200'
> >   +(see /var/lib/xfstests/results//btrfs/007.full for details)
> 
> This sounds like what was fixed in:
> 
> https://web.git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=for-next&id=1f32af6a4ce98f8185ca62c31e3bd014f0690898
> 
> >
> > btrfs/060 blocks the whole test. Then btrfs/066 hang there after I
> > skip btrfs/060.
> 
> They run fine for me, and afaik no one else is running into that.
> When you get such failure, please report them, provide dmesg if there
> are stack traces there.
> 
> >
> > generic/363 fails as:
> >
> >      QA output created by 363
> >      fsx -q -S 0 -e 1 -N 100000
> >     +READ BAD DATA: offset = 0x1fb5d, size = 0xc502, fname = /mnt/test/junk
> >     +OFFSET      GOOD    BAD     RANGE
> >     +0x2716c     0x0000  0x7f91  0x0
> >     +operation# (mod 256) for the bad data may be 127
> >     +0x2716d     0x0000  0x917f  0x1
> >     ...
> >     (Run 'diff -u /root/git/xfstests/tests/generic/363.out /root/git/xfstests/results//default/generic/363.out.bad'  to see the entire diff)
> 
> This was fixed recently in 6.14-rc3 :
> 
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=da2dccd7451de62b175fb8f0808d644959e964c7
> 
> >
> > generic/427 fails as:
> >
> >      QA output created by 427
> >     -Success, all done.
> >     +pwrite: No space left on device
> >     ...
> >     (Run 'diff -u /root/git/xfstests/tests/generic/427.out /root/git/xfstests/results//default/generic/427.out.bad'  to see the entire diff)
> 
> Works for me, with a 10g and 100g scratch/test devices:
> 
> $ ./check generic/427
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 debian0 6.14.0-rc4-btrfs-next-188+ #1
> SMP PREEMPT_DYNAMIC Wed Feb 26 17:38:41 WET 2025
> MKFS_OPTIONS  -- /dev/sdc
> MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> 
> generic/427 4s ...  2s
> Ran: generic/427
> Passed all 1 tests
> 
> >
> > generic/730 fails as:
> >
> >      QA output created by 730
> >     -cat: -: Input/output error
> >     ...
> >     (Run 'diff -u /root/git/xfstests/tests/generic/730.out /root/git/xfstests/results//default/generic/730.out.bad'  to see the entire diff)
> 
> This one is known to fail.
> 
> >
> > and some random failures on different test env. and so on ...
> >
> > After I'm familar with known failures, I think things will get better. Please
> > feel free to share known issues (that you know) to me.
> >
> > Besides btrfs, there're lots of filesystems, they all have different known/unknown
> > failures. It's not easy for someone to check most of filesystems' test failures
> > before release. I'll try to avoid critical issue, likes can't be built or installed,
> > whole or most of tests broken, system destroy, and so on. But for some test
> > failures, I might notice and remind in ANNOUNCE email, might not. Each release
> > might have bugs, likes RHEL, likes SUSE, Debian ... *each release might have
> > bugs, but we have to release, have to move on if there's not critical blocker
> > bugs.*
> 
> Sure, and no one is on track with known bugs for every filesystem on
> every upstream kernel, distro kernel, tool versions, etc.
> As said before, even for us developers it's hard to keep track of things.
> 
> Just try the suggestion mentioned before - it's enough to catch most
> regressions, and it would have caught all the recent regressions.
> It's what I do when I make changes to generic tests and shared code -
> it's not bulletproof for sure, but it catches many obvious bugs and is
> infinitely better than not doing any testing at all.
> 
> Don't stress on not being an expert of all filesystems, because no one
> is and no one expects you to be.
> 
> Thanks.
> 
> >
> > I'm sorry for the recent mess. I'll try my best to get xfstests back to track.
> > I think things is getting better, last release is the first fix release for that.
> > We'll have next fix release. Please be patient, if things is out of control, I'll
> > think about reverting the whole feature.
> >
> > Thanks,
> > Zorro
> >
> > >
> > >
> > > Thanks.
> > >
> > > >
> > > > I've gotten lots of pressure recently, I thought this release would be the end,
> > > > but looks like it's not. If you all (xfs, btrfs, ext4 and others) agree, I can
> > > > think about reverting the whole check-parallel and its related things, or there's
> > > > a switch to isolate the effect of check-parallel things. I thought there'll be a
> > > > painful period, but won't be too much if you don't use check-parallel directly.
> > > > I thought we will fix some bugs, then return to stable status. But I never thought
> > > > it's such painful. That's my fault...
> > > >
> > > > Thanks,
> > > > Zorro
> > > >
> > > > >
> > > >
> > > >
> > >
> 

