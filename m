Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27261DEFF5
	for <fstests@vger.kernel.org>; Sun,  2 Mar 2025 13:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740921262; cv=none; b=l0o4e1CZA6tlATk8DeG8y+gUGFNerwLWdh6JySrkK9q1F05kSslMWy8syC8h6MTzvkmgB4Yx9Q9i1+4/B3acEyM89Uh0B5gzTJ4ym4RXnN7F4Z7veZU0hVjuvIeZJ7dK6bX7ggIzDnwZ64ustUAiIZB8UtzBJ1cZXDk2MSL1x+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740921262; c=relaxed/simple;
	bh=VQ4k1Jnn0W6S4PFg6Nj/azuBWSKbB78oJ4laImV3VXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBPTz0gy6pkea8qDS5DXAtl2RjzbjW6WG37kGzmt5edtlttQQ/pCQU8IU2dOdcdrp/GgzViXnKT5iH2anpVUWzbMYzrmymE6w75lfjw+AUogIbtKNrQvwwbgugzIe2Bzt1Rpt6c6o6pKHJpYLgY6MZQmKs/L0JxaaLRyeVdcZ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Je5bvIrY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Je5bvIrY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8FDC4CEE7
	for <fstests@vger.kernel.org>; Sun,  2 Mar 2025 13:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740921262;
	bh=VQ4k1Jnn0W6S4PFg6Nj/azuBWSKbB78oJ4laImV3VXw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Je5bvIrYyAL4P9w7cfLzzI/06A8erTguBJTWKRIvmDlFIObjFVJ5wBlff0ZggdUK2
	 nPGq3G6OtFcYYcDGPzGYCzShQzTkn8S61hgNAR4dU3MTneCgPWhqsDPf+8BsCkuoiH
	 8Y+VSf9Ioo5sVzdofBlnKJdyHQEDodoAQkqiaaZfAviZdWWgwf3CzqzbLrX0FzBMs/
	 7HpQ5cpY/aLfLGjU/9n9hOBR0j+3y1bz+RAw5IVMis271SLI9qXqEM097IxhDF0bI9
	 D+6nl3tbuWfGucAnUjsHmEQiVnrminljvkTxsSdRmiSRGPw9P0GrGNHzCKl3E/d/2p
	 OkSSFnYq4FY2w==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaec111762bso659846566b.2
        for <fstests@vger.kernel.org>; Sun, 02 Mar 2025 05:14:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWuDNMFpfCMm3+wM1QMOi59ofVifLgbg/vIFWLkqSONd5epHk4syRH8QapjU/PJfhnq4KGR9/nP@vger.kernel.org
X-Gm-Message-State: AOJu0YycrupMKjT3b94O6ICI0bjuD/khOERuxxWGq5A9Mb6FLkaujN+E
	0ylt4hs7ubNQ/WHZj1pbu6xw+94Ze6UKCZS5Zj0vvGugcdyZPfhT5a7fDXV+IQ8Tc30dstnWj2v
	pl7X3KQ60kPniLCS+/q+WbSD6YSY=
X-Google-Smtp-Source: AGHT+IHQuy5lU8GWzgGA8EfXQjio5LtBaQfZUkU6sclui/GCjyCVPfN4/WwSj5Fe1GB+8nBBnk9nKKFoRxv1Qnbt1Ow=
X-Received: by 2002:a17:907:c50a:b0:abe:ea93:2ca3 with SMTP id
 a640c23a62f3a-abf261d3cd5mr1269284566b.29.1740921260611; Sun, 02 Mar 2025
 05:14:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c238e76631b086db592f214beaa6fd94@kernel.org> <20250228123354.GE5777@twin.jikos.cz>
 <20250301140854.dplxboc3ml52e3ll@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20250301140854.dplxboc3ml52e3ll@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sun, 2 Mar 2025 13:13:43 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6Bb+pFjo11X3LAvtrVJLit1RTSg63k+weFDKsHOuYnOw@mail.gmail.com>
X-Gm-Features: AQ5f1Joe0ZJT_0T8ZxE08ZbcF6cAwX6NRZtmwYFHosfyjVsm23FuGqdqH_vfuD8
Message-ID: <CAL3q7H6Bb+pFjo11X3LAvtrVJLit1RTSg63k+weFDKsHOuYnOw@mail.gmail.com>
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to v2025.02.23
To: Zorro Lang <zlang@redhat.com>
Cc: David Sterba <dsterba@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>, 
	"Darrick J. Wong" <djwong@kernel.org>, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 1, 2025 at 2:09=E2=80=AFPM Zorro Lang <zlang@redhat.com> wrote:
>
> On Fri, Feb 28, 2025 at 01:33:54PM +0100, David Sterba wrote:
> > On Sun, Feb 23, 2025 at 08:27:43PM +0800, Zorro Lang wrote:
> > > Hi all,
> > >
> > > The for-next branch of the xfstests repository at:
> > >
> > >     git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> > >
> > > has just been updated and tagged as v2025.02.23 release.
> > >
> > > Release Notes:
> > > 1) There's not new test cases in this release, this's a release for b=
ug fixes
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
> > >       [ab459c67c5e0] metadump: make non-local function variables more=
 obvious
> > >       [f428edcec2a2] metadump: fix cleanup for v1 metadump testing
> > >       [e68a92376165] generic/019: don't fail if fio crashes while shu=
tting down
> > >       [48a3731b50ba] fuzzy: do not set _FSSTRESS_PID when exercising =
fsx
> > >       [543795bf67f2] common/rc: revert recursive unmount in _clear_mo=
unt_stack
> > >       [777732b27e62] common/dump: don't replace pids arbitrarily
> > >       [81f28acda2f2] common/populate: correct the parent pointer name=
 creation formulae
> > >       [9b177d92dc65] generic/759,760: fix MADV_COLLAPSE detection and=
 inclusion
> > >       [241c1c787e5b] generic/759,760: skip test if we can't set up a =
hugepage for IO
> > >       [77548e6066fd] common/rc: create a wrapper for the su command
> > >       [ac2d48f81094] fuzzy: kill subprocesses with SIGPIPE, not SIGIN=
T
> > >       [c71349150d34] common/rc: hoist pkill to a helper function
> > >       [91d2880aa029] tools: add a Makefile
> > >       [88d60f434bd9] common: fix pkill by running test program in a s=
eparate session
> > >       [247ab01fa227] check: run tests in a private pid/mount namespac=
e
> > >       [949bdf8eae31] check: deprecate using process sessions to isola=
te test instances
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
> > HAVE_PRIVATENS=3D
> > HAVE_SYSTEMD_SCOPES=3D
> >
> > so I don't have to debug changes to the detection of the scope and
> > namespaces and after each for-next update. I understand that with a
> > custom system setup I'm on my own but until recently things have been
> > fine but now after each update either test cases fail or the whole test
> > infrastructure does not work.
> >
> > It's not just me who observes that. It seems that BTRFS is not tested
> > before release as thoroughly as other filesystems (probably just XFS).
>
> I test btrfs (only default), ext4 (+-fsverity, +-dax), ext3, exfat, xfs(1=
k, 4k,
> 64k blocksize, +-dax), tmpfs, nfs(base on xfs), cifs(on xfs), exfat, over=
lay
> (on xfs) on aarch64, x86_64, s390x and ppc64le. But I'm not an expert of =
all
> filesystems, so I just can check there's not big issue from my side for m=
ost of
> fs. But different persons have different test ways, I can't try all diffe=
rent
> test configs/ways on all filesystems by myself, I already take each weeke=
nd
> to do these things, even I'm fever or on holiday. Even though I'm still a=
sked
> to release more fast...
>
> Darrick's patchset has been in the list more than one month (since 2025-0=
1-16)
> to get reviewing. And I've tested Darrick's patchset several weeks, and t=
alked
> with Darrick several times about some issues I found. Darrick has done hi=
s best
> to do that, please don't give him more pressure. But still sorry about I =
didn't
> find the "100% fail" big issue in my test env. Feel free to share the con=
fig
> you use, I'll refer to it to change my test.

A lot of the regressions that broke btrfs tests, or generic tests when
testing btrfs or ext4 for example, were not dependent on any specific
config.
I.e. no required MOUNT_OPTIONS or MKFS_OPTIONS, and failed with any
kind of devices used as scratch and test devices.

For example:

https://web.git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=3Dfor-=
next&id=3Da1d583fa0062f097b54dfb2b9b7ff1d9260c855c

This generic test started to fail on any fs other than xfs.
For me it failed with btrfs and ext4 (all the time).

Another example for another generic test case:

https://web.git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=3Dfor-=
next&id=3D7c5604ec86b82d118a3b84d7e5286740e652720d

Or this one:

https://web.git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=3Dfor-=
next&id=3D9b12a1a8a35bb491076332e21a113c43851ceb69

The dmdust device names changed but the btrfs tests were not updated,
so the tests always failed no matter what your setup config is.

So anyone running btrfs or ext4 with default settings (no mount or
mkfs options) should have run into the same failures.
I can't see how they wouldn't run into those failures in fact.

Or another example, a fix from Ted, for a generic test case that
always failed on ext4:

https://web.git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=3Dfor-=
next&id=3D023070744cef1fde8a5b4fbd8fa134cd5098843e

And there are plenty of other examples.

More recently, from last week's update:

https://lore.kernel.org/fstests/b470cdee538aab91177f8295fb8886ae79f680db.17=
40662683.git.fdmanana@suse.com/

While it's too time consuming to test all major filesystems for all
possible configs, at least some basic testing can be done.
By basic testing I mean run the quick group without any mount and mkfs
options, which is reasonably fast and helps to catch a lot of
problems.


Thanks.

>
> I've gotten lots of pressure recently, I thought this release would be th=
e end,
> but looks like it's not. If you all (xfs, btrfs, ext4 and others) agree, =
I can
> think about reverting the whole check-parallel and its related things, or=
 there's
> a switch to isolate the effect of check-parallel things. I thought there'=
ll be a
> painful period, but won't be too much if you don't use check-parallel dir=
ectly.
> I thought we will fix some bugs, then return to stable status. But I neve=
r thought
> it's such painful. That's my fault...
>
> Thanks,
> Zorro
>
> >
>
>
