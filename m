Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416801ADC94
	for <fstests@vger.kernel.org>; Sun,  2 Mar 2025 19:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740942174; cv=none; b=e3gZZunHy0k/5c3DSPUeBj8zmIrPfMqyQ6oHaPeQNptvaLvHwOPQZ9Yl1/LMN1cDfeLTtgxElzMD/hQ+REL8x5yaYB81W0dvRmWSNpzTdYe7FHpa8IgU1+XJZO6suWzTqK2qYmtJWTiLZ5CWHUJraEm2p0asiHJBOi6yHVy4msc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740942174; c=relaxed/simple;
	bh=YTNUtsdujGgR6FSs6t70lQ9wBFeKflHbrfX0debV9Uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQ5yi1xUchLdlWa76ZV+QFFa6rZTmULS871jMf5qspydk5GBtDdxTJodnmffsuU6oxB0ahUpr+IRVSHnFJd6CFmdECSstbvOIYAj9y5KPqj4ptf3ATC85cRq5MgtZlBIDh+KFz8Eh6tzJ1wzASe8zVWS3NIFxPNA31SJaZwet04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zv+ud5AT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zv+ud5AT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A649EC4CEE7
	for <fstests@vger.kernel.org>; Sun,  2 Mar 2025 19:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740942173;
	bh=YTNUtsdujGgR6FSs6t70lQ9wBFeKflHbrfX0debV9Uw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Zv+ud5AThPZcvESOpgSY3jpltuZqdIsY2ubRDStGzpXbd3VWPIwkouvmTk8JRT2j9
	 67NFBDNZzF4eMUkhwqZEuT6SKEzGt48hcINJvrlJgFsUGMuZdjK0RwvrMYQimPBz/v
	 Li+vybBmycbjzzRBdTZQnMydSrdr+R1niqR9IX7hlzInOiaTtEQHnf84qblu9dLQoq
	 joXcwC1BHokkrxEswXeiOUPqZUHjlh9JJtE+v+G78ncg9yuHDNLbYWJH+4EixG3lv4
	 +IaJhec9mpMZtFn7uLrMIDEaF/bdb8Oi4MZCgkqf2j5euEizg166f3tq1dSQcelG7/
	 /HdnRz/Z/10Nw==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e52c1c3599so1517628a12.2
        for <fstests@vger.kernel.org>; Sun, 02 Mar 2025 11:02:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXqf7TCr1lW/7EBk5srMnOLG4CGxFrW09tr38pFMocaF7PgBC1rZ9mfd3OPDGrhJwmeajmBYtwm@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3gvDdMBQvgws/0N163OSjPDAjcTGLwvC0tqywGBYvRBT2zDjQ
	KHsEM7Ma/PFv5PLvbbNMKGdxw268/GRseeBAdKncoVVUPFKcY1EnQjnhK8VS6YCyFXF6aAEWZno
	JoMAmBevibKYjvF9k840fgUmMF+Q=
X-Google-Smtp-Source: AGHT+IFYUHCpZnS5QcnFIBmGlLh0XUviuuT82r1AVnWaaSf8/6Vz7JHIh1e2QLb1rhjmBTGdcRPQwZVy96HdKYuoIiY=
X-Received: by 2002:a17:906:5da:b0:abf:3f82:1218 with SMTP id
 a640c23a62f3a-abf3f821383mr930059966b.46.1740942172078; Sun, 02 Mar 2025
 11:02:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c238e76631b086db592f214beaa6fd94@kernel.org> <20250228123354.GE5777@twin.jikos.cz>
 <20250301140854.dplxboc3ml52e3ll@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H6Bb+pFjo11X3LAvtrVJLit1RTSg63k+weFDKsHOuYnOw@mail.gmail.com> <20250302153722.aevwzs5eisemxmaa@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20250302153722.aevwzs5eisemxmaa@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sun, 2 Mar 2025 19:02:15 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6=QqNmMy0cr84G+SNAtvsQyvm+O6oimZPW4=y=yTNCGA@mail.gmail.com>
X-Gm-Features: AQ5f1JoUFl4esidtoevsRyPC_iH8pQKCjnylcWSh7m7U7Ho2Wt-mbgqKuo7ZKYw
Message-ID: <CAL3q7H6=QqNmMy0cr84G+SNAtvsQyvm+O6oimZPW4=y=yTNCGA@mail.gmail.com>
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to v2025.02.23
To: Zorro Lang <zlang@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, David Sterba <dsterba@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>, 
	"Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 2, 2025 at 3:37=E2=80=AFPM Zorro Lang <zlang@kernel.org> wrote:
>
> On Sun, Mar 02, 2025 at 01:13:43PM +0000, Filipe Manana wrote:
> > On Sat, Mar 1, 2025 at 2:09=E2=80=AFPM Zorro Lang <zlang@redhat.com> wr=
ote:
> > >
> > > On Fri, Feb 28, 2025 at 01:33:54PM +0100, David Sterba wrote:
> > > > On Sun, Feb 23, 2025 at 08:27:43PM +0800, Zorro Lang wrote:
> > > > > Hi all,
> > > > >
> > > > > The for-next branch of the xfstests repository at:
> > > > >
> > > > >     git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> > > > >
> > > > > has just been updated and tagged as v2025.02.23 release.
> > > > >
> > > > > Release Notes:
> > > > > 1) There's not new test cases in this release, this's a release f=
or bug fixes
> > > > >    particularly.
> > > > > 2) Reiserfs part is removed from fstests.
> > > > > 3) ltp/growfiles is removed too, I think no one needs it.
> > > > >
> > > > > I can't list all updates at here, more details please refer to be=
low.
> > > > > Thanks for all these contributions!
> > > > >
> > > > > Thanks,
> > > > > Zorro
> > > > >
> > > > > The new head of the for-next branch is commit:
> > > > >
> > > > > 5b56a2d88819 fstests: remove reiserfs support
> > > > >
> > > > > New commits:
> > > > >
> > > > > Christoph Hellwig (1):
> > > > >       [04d0cf3f8909] generic/370: don't exclude XFS
> > > > >
> > > > > Darrick J. Wong (35):
> > > > >       [cc379f50f3bd] generic/476: fix fsstress process management
> > > > >       [ab459c67c5e0] metadump: make non-local function variables =
more obvious
> > > > >       [f428edcec2a2] metadump: fix cleanup for v1 metadump testin=
g
> > > > >       [e68a92376165] generic/019: don't fail if fio crashes while=
 shutting down
> > > > >       [48a3731b50ba] fuzzy: do not set _FSSTRESS_PID when exercis=
ing fsx
> > > > >       [543795bf67f2] common/rc: revert recursive unmount in _clea=
r_mount_stack
> > > > >       [777732b27e62] common/dump: don't replace pids arbitrarily
> > > > >       [81f28acda2f2] common/populate: correct the parent pointer =
name creation formulae
> > > > >       [9b177d92dc65] generic/759,760: fix MADV_COLLAPSE detection=
 and inclusion
> > > > >       [241c1c787e5b] generic/759,760: skip test if we can't set u=
p a hugepage for IO
> > > > >       [77548e6066fd] common/rc: create a wrapper for the su comma=
nd
> > > > >       [ac2d48f81094] fuzzy: kill subprocesses with SIGPIPE, not S=
IGINT
> > > > >       [c71349150d34] common/rc: hoist pkill to a helper function
> > > > >       [91d2880aa029] tools: add a Makefile
> > > > >       [88d60f434bd9] common: fix pkill by running test program in=
 a separate session
> > > > >       [247ab01fa227] check: run tests in a private pid/mount name=
space
> > > > >       [949bdf8eae31] check: deprecate using process sessions to i=
solate test instances
> > > >
> > > > I'm using a setup with a minimal VM system without systemd and such=
 and
> > > > dedicate the whole machine to one instance. I'm not interested in t=
he
> > > > check-parallel updates and test case separation. All fine if it is
> > > > supported and lets me continue using single instance.
> > > >
> > > > But as I read it and the deprecation it's not going to be the suppo=
rted
> > > > use case. After last week update of fstests 100% of cases failed in=
 the
> > > > test setup (_seq_run). My workaround is to simply disable it by
> > > >
> > > > check:
> > > > HAVE_PRIVATENS=3D
> > > > HAVE_SYSTEMD_SCOPES=3D
> > > >
> > > > so I don't have to debug changes to the detection of the scope and
> > > > namespaces and after each for-next update. I understand that with a
> > > > custom system setup I'm on my own but until recently things have be=
en
> > > > fine but now after each update either test cases fail or the whole =
test
> > > > infrastructure does not work.
> > > >
> > > > It's not just me who observes that. It seems that BTRFS is not test=
ed
> > > > before release as thoroughly as other filesystems (probably just XF=
S).
> > >
> > > I test btrfs (only default), ext4 (+-fsverity, +-dax), ext3, exfat, x=
fs(1k, 4k,
> > > 64k blocksize, +-dax), tmpfs, nfs(base on xfs), cifs(on xfs), exfat, =
overlay
> > > (on xfs) on aarch64, x86_64, s390x and ppc64le. But I'm not an expert=
 of all
> > > filesystems, so I just can check there's not big issue from my side f=
or most of
> > > fs. But different persons have different test ways, I can't try all d=
ifferent
> > > test configs/ways on all filesystems by myself, I already take each w=
eekend
> > > to do these things, even I'm fever or on holiday. Even though I'm sti=
ll asked
> > > to release more fast...
> > >
> > > Darrick's patchset has been in the list more than one month (since 20=
25-01-16)
> > > to get reviewing. And I've tested Darrick's patchset several weeks, a=
nd talked
> > > with Darrick several times about some issues I found. Darrick has don=
e his best
> > > to do that, please don't give him more pressure. But still sorry abou=
t I didn't
> > > find the "100% fail" big issue in my test env. Feel free to share the=
 config
> > > you use, I'll refer to it to change my test.
> >
> > A lot of the regressions that broke btrfs tests, or generic tests when
> > testing btrfs or ext4 for example, were not dependent on any specific
> > config.
> > I.e. no required MOUNT_OPTIONS or MKFS_OPTIONS, and failed with any
> > kind of devices used as scratch and test devices.
> >
> > For example:
> >
> > https://web.git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=3D=
for-next&id=3Da1d583fa0062f097b54dfb2b9b7ff1d9260c855c
> >
> > This generic test started to fail on any fs other than xfs.
> > For me it failed with btrfs and ext4 (all the time).
> >
> > Another example for another generic test case:
> >
> > https://web.git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=3D=
for-next&id=3D7c5604ec86b82d118a3b84d7e5286740e652720d
> >
> > Or this one:
> >
> > https://web.git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=3D=
for-next&id=3D9b12a1a8a35bb491076332e21a113c43851ceb69
> >
> > The dmdust device names changed but the btrfs tests were not updated,
> > so the tests always failed no matter what your setup config is.
> >
> > So anyone running btrfs or ext4 with default settings (no mount or
> > mkfs options) should have run into the same failures.
> > I can't see how they wouldn't run into those failures in fact.
> >
> > Or another example, a fix from Ted, for a generic test case that
> > always failed on ext4:
> >
> > https://web.git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=3D=
for-next&id=3D023070744cef1fde8a5b4fbd8fa134cd5098843e
> >
> > And there are plenty of other examples.
> >
> > More recently, from last week's update:
> >
> > https://lore.kernel.org/fstests/b470cdee538aab91177f8295fb8886ae79f680d=
b.1740662683.git.fdmanana@suse.com/
> >
> > While it's too time consuming to test all major filesystems for all
> > possible configs, at least some basic testing can be done.
> > By basic testing I mean run the quick group without any mount and mkfs
> > options, which is reasonably fast and helps to catch a lot of
> > problems.
>
> Sure :) I've added btrfs regression test to my regular test list recently=
.

Ok, so until very recently there was no testing at all?

> For now,
> only default btrfs is tested by xfstests "auto" group. Sorry I'm not fami=
lar with
> btrfs test currently, I hit several test failures, need time to figure ou=
t which
> is test issue, which is progs' issue, which is kernel issue and which is =
known and
> unknown issue and so on.

You don't need to be an expert on btrfs, not much less figure out
which kernels have fixes, btrfs-progs versions, for which configs,
etc.
That's even hard for us btrfs developers when dealing with stable
releases, distros, etc.

All that needs to be done, and this would have catched all the recent
bugs from the last 2+ months, is:

1) Create a branch based on for-next;

2) Apply all the patches you want from the mailing list;

3) Run the quick group for btrfs (or ext4, or whatever) without any
mount and mkfs options;

4) For any test that fails, verify if they fail too on for-next
without the new patches.
    If they fail too, then it's unlikely to be a regression.
    If they pass on for-next, bisect which new patch introduces the
regression and notify the author.

This would have caught all the recent regressions we had.

>
> For example:
> btrfs/007 fails as:
>
>    QA output created by 007
>    *** test send / receive
>   -*** done
>   +failed: '2097152000 200'
>   +(see /var/lib/xfstests/results//btrfs/007.full for details)

This sounds like what was fixed in:

https://web.git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=3Dfor-=
next&id=3D1f32af6a4ce98f8185ca62c31e3bd014f0690898

>
> btrfs/060 blocks the whole test. Then btrfs/066 hang there after I
> skip btrfs/060.

They run fine for me, and afaik no one else is running into that.
When you get such failure, please report them, provide dmesg if there
are stack traces there.

>
> generic/363 fails as:
>
>      QA output created by 363
>      fsx -q -S 0 -e 1 -N 100000
>     +READ BAD DATA: offset =3D 0x1fb5d, size =3D 0xc502, fname =3D /mnt/t=
est/junk
>     +OFFSET      GOOD    BAD     RANGE
>     +0x2716c     0x0000  0x7f91  0x0
>     +operation# (mod 256) for the bad data may be 127
>     +0x2716d     0x0000  0x917f  0x1
>     ...
>     (Run 'diff -u /root/git/xfstests/tests/generic/363.out /root/git/xfst=
ests/results//default/generic/363.out.bad'  to see the entire diff)

This was fixed recently in 6.14-rc3 :

https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Dda2dccd7451de62b175fb8f0808d644959e964c7

>
> generic/427 fails as:
>
>      QA output created by 427
>     -Success, all done.
>     +pwrite: No space left on device
>     ...
>     (Run 'diff -u /root/git/xfstests/tests/generic/427.out /root/git/xfst=
ests/results//default/generic/427.out.bad'  to see the entire diff)

Works for me, with a 10g and 100g scratch/test devices:

$ ./check generic/427
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 debian0 6.14.0-rc4-btrfs-next-188+ #1
SMP PREEMPT_DYNAMIC Wed Feb 26 17:38:41 WET 2025
MKFS_OPTIONS  -- /dev/sdc
MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

generic/427 4s ...  2s
Ran: generic/427
Passed all 1 tests

>
> generic/730 fails as:
>
>      QA output created by 730
>     -cat: -: Input/output error
>     ...
>     (Run 'diff -u /root/git/xfstests/tests/generic/730.out /root/git/xfst=
ests/results//default/generic/730.out.bad'  to see the entire diff)

This one is known to fail.

>
> and some random failures on different test env. and so on ...
>
> After I'm familar with known failures, I think things will get better. Pl=
ease
> feel free to share known issues (that you know) to me.
>
> Besides btrfs, there're lots of filesystems, they all have different know=
n/unknown
> failures. It's not easy for someone to check most of filesystems' test fa=
ilures
> before release. I'll try to avoid critical issue, likes can't be built or=
 installed,
> whole or most of tests broken, system destroy, and so on. But for some te=
st
> failures, I might notice and remind in ANNOUNCE email, might not. Each re=
lease
> might have bugs, likes RHEL, likes SUSE, Debian ... *each release might h=
ave
> bugs, but we have to release, have to move on if there's not critical blo=
cker
> bugs.*

Sure, and no one is on track with known bugs for every filesystem on
every upstream kernel, distro kernel, tool versions, etc.
As said before, even for us developers it's hard to keep track of things.

Just try the suggestion mentioned before - it's enough to catch most
regressions, and it would have caught all the recent regressions.
It's what I do when I make changes to generic tests and shared code -
it's not bulletproof for sure, but it catches many obvious bugs and is
infinitely better than not doing any testing at all.

Don't stress on not being an expert of all filesystems, because no one
is and no one expects you to be.

Thanks.

>
> I'm sorry for the recent mess. I'll try my best to get xfstests back to t=
rack.
> I think things is getting better, last release is the first fix release f=
or that.
> We'll have next fix release. Please be patient, if things is out of contr=
ol, I'll
> think about reverting the whole feature.
>
> Thanks,
> Zorro
>
> >
> >
> > Thanks.
> >
> > >
> > > I've gotten lots of pressure recently, I thought this release would b=
e the end,
> > > but looks like it's not. If you all (xfs, btrfs, ext4 and others) agr=
ee, I can
> > > think about reverting the whole check-parallel and its related things=
, or there's
> > > a switch to isolate the effect of check-parallel things. I thought th=
ere'll be a
> > > painful period, but won't be too much if you don't use check-parallel=
 directly.
> > > I thought we will fix some bugs, then return to stable status. But I =
never thought
> > > it's such painful. That's my fault...
> > >
> > > Thanks,
> > > Zorro
> > >
> > > >
> > >
> > >
> >
