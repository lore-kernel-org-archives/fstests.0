Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11B81C68A
	for <fstests@vger.kernel.org>; Sat, 16 Mar 2024 17:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710610990; cv=none; b=bFAakMSiK55Gig/vhuIzoXzsQTQ14ugG+wk9oaybyRcjhzU8x9z6JW4kTsaP6SyRqFqwDu1sk6skaaI3QYHNr0cXMzBmhbWHEM56osoatfQMNqNYoGzE1uHrAt8adX8tA3mIVYZea+RbmWaSaqOuwWrxJWOUUrLFACnDLjJl9VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710610990; c=relaxed/simple;
	bh=m7XLuru2fooPPsjhZSpjXcoWc1zH2hYPwDmqADPWhD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NFzAnWN/crpXzEd29COv28JFpHfgqS3jD0B/SErDjmfZmNIrxuOU9MqzkcHMrKZEAk5ib+nwL1kRv2tH9eTwV/NnAywVoifo+3ZCCAAQPW/Cv0055OSZ1/AZKtRMxA+86q0DD9YaD6dZ5RTH+M+mmWbg1TIAUSsC9kgzOpYE6dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTdadxPV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTdadxPV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DEA3C43390
	for <fstests@vger.kernel.org>; Sat, 16 Mar 2024 17:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710610989;
	bh=m7XLuru2fooPPsjhZSpjXcoWc1zH2hYPwDmqADPWhD8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nTdadxPVHuyvFt92sTjoa3dK9NHBGYvYC0sCWNSFBIo2k/bfwDi84jMC67rBRY7Xk
	 SBHftzM1n7B4grPdi5o4kmqf29h6Zr5OO5G7EbLHzlz0ggCJdeYJFi2DbZmBveCQn/
	 eoZEfkAtnnI8gbDYmpSKuqZ4x08XGs5HcZABQeIHM2eAwYwZn4UqwpRip2vOpSkcsv
	 F7gfvrSiYb7OMiQjSp6I6tKaA8Vd/yVX7QgUgl3t+3O2LyyesmdI6uDu6rsvewVvLI
	 3DSk1RUZXKqWd+JrhIiC7vSR5Bokk3vqxYFP53ufGG+RWjhxLyv2QprH72Q2GycakH
	 0p6K5LuQ/fBdQ==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a4682272ff6so201271466b.2
        for <fstests@vger.kernel.org>; Sat, 16 Mar 2024 10:43:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWoq+fo/ZQselt91lcRzOkqXGl/xFw03mWR4/UOSA0Lf0MCWak+z/E3lwA8G/kTmLShBpFkhVuSzuVzexYgthdqK8pUjnAqCA==
X-Gm-Message-State: AOJu0Yw3XmZhLIlqjTxAcavDIjxnKDH5HkzEHiif+VG7WHwwN5DKY70T
	yTPZfdY3vDE8eiiW1ZequaJHXUC9Jsl0/vwDO+0Mc+gfhz7ES+LLdaHTvke9zzzbSJ13uFLfB5T
	Chnxft6MQ5wq8Sq3wUkZYZfedl7s=
X-Google-Smtp-Source: AGHT+IFO4tUBjSqcig3H4Orz4hyfJnHlWGTTHUS9w25h8OvZNuwqjDi64rOtVjnOet6QW7bbFMQGSVH+A0skG1TzmKw=
X-Received: by 2002:a17:907:7214:b0:a46:7323:6ab3 with SMTP id
 dr20-20020a170907721400b00a4673236ab3mr4880678ejc.49.1710610987791; Sat, 16
 Mar 2024 10:43:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6165b0018426e58e7427a26eebea3d63e66fed15.1710373423.git.boris@bur.io>
 <20240315025628.GH6188@frogsfrogsfrogs> <20240315233054.GA3597569@zen.localdomain>
 <CAL3q7H71Roae5kqc0Hh2=CZxCfLd9Kp7bqAfgo5OcUz==opVow@mail.gmail.com> <20240316144008.GA3615790@zen.localdomain>
In-Reply-To: <20240316144008.GA3615790@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sat, 16 Mar 2024 17:42:30 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7=szVzNCVdPQnC5T57TV_HXUyYNTirv9Kz_=zZa-jEQQ@mail.gmail.com>
Message-ID: <CAL3q7H7=szVzNCVdPQnC5T57TV_HXUyYNTirv9Kz_=zZa-jEQQ@mail.gmail.com>
Subject: Re: [PATCH RFC] generic/730: ensure EIO after device delete
To: Boris Burkov <boris@bur.io>
Cc: "Darrick J. Wong" <djwong@kernel.org>, kernel-team@fb.com, fstests@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 16, 2024 at 2:39=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Sat, Mar 16, 2024 at 01:08:57PM +0000, Filipe Manana wrote:
> > On Fri, Mar 15, 2024 at 11:30=E2=80=AFPM Boris Burkov <boris@bur.io> wr=
ote:
> > >
> > > On Thu, Mar 14, 2024 at 07:56:28PM -0700, Darrick J. Wong wrote:
> > > > On Wed, Mar 13, 2024 at 04:47:47PM -0700, Boris Burkov wrote:
> > > > > This test removes a SCSI debug device out from under a mounted
> > > > > filesystem with a (probably) dirty file. This assumes that page c=
ache
> > > > > cannot save us from EIO, for a reason that I can't quite explain.=
 In
> > > > > fact, this test fails for exactly that reason, at least on btrfs.
> > > > >
> > > > > The original patches:
> > > > >
> > > > >       https://lore.kernel.org/fstests/20230807112100.GB15405@lst.=
de/
> > > > >
> > > > > refer to this passing on xfs and not btrfs, so I suspect I am mis=
sing
> > > > > something. With that said, on my machine this actually fails on x=
fs with
> > > > > and without my patch, so this is clearly not enough.
> > > > >
> > > > > High level, I am trying to understand what is really the expected
> > > > > behavior from a filesystem under this condition and what this tes=
t is
> > > > > getting at. Of btrfs, ext4, and xfs, only ext4 passes it, while b=
trfs
> > > > > does pass with this additional syncing/cache dropping to nudge it=
 to an
> > > > > error.
> > > >
> > > > Does btrfs prefetch pagecache data as soon as a file opens?  Or I g=
uess
> > > > it could be that xfs trips an IO error and shuts down, and
> > > > xfs_file_read_iter will return EIO after that happens.
> > > >
> > > > --D
> > > >
> > >
> > > I might be wildly misunderstanding, since I'm very far from an expert=
 on
> > > the page cache, but didn't we just do a buffered write to the file? S=
o it
> > > would make sense for it to be in cache?
> > >
> > > At any rate, what I observed on my system was that xfs does not pass
> > > this test. Curious if that is only on my system or just the current
> > > state of the test.
> >
> > Instead of xfs, do you mean btrfs?
> >
> > For me xfs and ext4 always pass this test, i.e. the cat command fails
> > with -EIO, both with and without your patch.
> >
> > On the other hand, btrfs and f2fs always fail without your patch, and
> > pass with your patch applied.
>
> $ sudo ./check generic/730
> FSTYP         -- xfs (non-debug)
> PLATFORM      -- Linux/x86_64 v0 6.8.0-rc7+ #205 SMP PREEMPT_DYNAMIC Thu =
Mar 14 16:44:32 PDT 2024
> MKFS_OPTIONS  -- -f /dev/mapper/tst-scr0
> MOUNT_OPTIONS -- /dev/mapper/tst-scr0 /mnt/scratch
>
> generic/730 1s ... [failed, exit status 1]- output mismatch (see /home/vm=
user/fstests/results//generic/730.out.bad)
>     --- tests/generic/730.out   2023-11-01 22:14:50.011000000 +0000
>     +++ /home/vmuser/fstests/results//generic/730.out.bad       2024-03-1=
6 14:38:02.431000000 +0000
>     @@ -1,2 +1 @@
>      QA output created by 730
>     -cat: -: Input/output error
>     ...
>     (Run 'diff -u /home/vmuser/fstests/tests/generic/730.out /home/vmuser=
/fstests/results//generic/730.out.bad'  to see the entire diff)
> Ran: generic/730
> Failures: generic/730
> Failed 1 of 1 tests
>
> I suspect it has something to do with my Kconfig. Perhaps "xfs (non-debug=
)" is a clue?

Mine is also non-debug and yet it always succeeds for me (without your
patch or any other of course):

root 17:40:02 /home/fdmanana/git/hub/xfstests > ./check generic/730
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 debian0 6.8.0-rc7-btrfs-next-153+ #1 SMP
PREEMPT_DYNAMIC Mon Mar  4 17:19:19 WET 2024
MKFS_OPTIONS  -- -f /dev/sdb
MOUNT_OPTIONS -- /dev/sdb /home/fdmanana/btrfs-tests/scratch_1

generic/730 2s ...  2s
Ran: generic/730
Passed all 1 tests


>
> >
> > From a btrfs point of view, it makes sense for the cat command to
> > succeed, since all the file data is in the page cache.
>
> That was my intuition as well, as I mentioned above.
>
> >
> > I don't know why the cat command fails (-EIO) with xfs and ext4, and I
> > haven't looked at any of their source code (my knowledge of those
> > filesystem's internals is too little anyway).
> >
> > An alternative to your patch is just to make the write with direct IO
> > by passing -d to $XFS_IO_PROG. It makes the test succeed on these 4
> > filesystems.
> >
> >
>
> I like this idea a lot more than my patch!
>
> > >
> > > Summary of my test matrix:
> > > ext4: passes with and without this patch
> > > btrfs: fails without this patch, passes with it
> > > xfs: fails with and without this patch
> > >
> > > For that reason, I don't think this a good patch, I just mostly want =
to
> > > figure out where to go with this test!
> > >
> > > Thanks,
> > > Boris
> > >
> > > > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > > > ---
> > > > >  tests/generic/730 | 3 +++
> > > > >  1 file changed, 3 insertions(+)
> > > > >
> > > > > diff --git a/tests/generic/730 b/tests/generic/730
> > > > > index 11308cdaa..ca5037c57 100755
> > > > > --- a/tests/generic/730
> > > > > +++ b/tests/generic/730
> > > > > @@ -47,6 +47,9 @@ exec 3< $SCSI_DEBUG_MNT/testfile
> > > > >  # delete the scsi debug device while it still has dirty data
> > > > >  echo 1 > /sys/block/$(_short_dev $SCSI_DEBUG_DEV)/device/delete
> > > > >
> > > > > +sync
> > > > > +echo 3 > /proc/sys/vm/drop_caches
> > > > > +
> > > > >  # try to read from the file, which should give us -EIO
> > > > >  cat <&3 > /dev/null
> > > > >
> > > > > --
> > > > > 2.43.0
> > > > >
> > > > >
> > >
