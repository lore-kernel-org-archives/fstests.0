Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FAA2F28
	for <fstests@vger.kernel.org>; Sat, 16 Mar 2024 13:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710594576; cv=none; b=P/JcU0pzEW6HnTDwI+SEViWttbiTJ1OJ7ss+zvbiaCKdquOkI8jwaNW7DJG+1xAcyOk2hiLoiLJC5sWPoStjtki9SG+HhgMQb1rRRQW9UN+bnpALzdd77KdZ0RGRLmxlpgAyXUjaMBkhaYSmPzhC2faqGjvO+N8UoUxdxELf1tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710594576; c=relaxed/simple;
	bh=+UjZO//ss50vYahkdsSvUwXCAqkaPuE6J1Ndxxp9qcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T5T1TzcLHC+dU/S/+94KI0BZgp1Dvfy/+HN0xFpYvFM3gpT9HUPjfUM3QYh5kWx1lnuqkp8uzGzEaBNYxrh2R1mwxloTAJRRl7q9x6/wJl5WqK0fboum/pJO4UBW9icuqip0V4kNi+SQgnYxGR56lj8ZqBZgtmsSeEv8HCld6OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uuykaDC6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uuykaDC6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5DDC433C7
	for <fstests@vger.kernel.org>; Sat, 16 Mar 2024 13:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710594576;
	bh=+UjZO//ss50vYahkdsSvUwXCAqkaPuE6J1Ndxxp9qcw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uuykaDC6Vt4Uym1uTefm9YuDtyNUuml1kd80DPZq/V6aToV1UamJffHfL6aXuHo4X
	 ZJfPX7/OFjZwrBvIU4BxJE3lg6KRddzwWQDKwlrSRBzwhVF7KZKawBy+HWZKCK1BpW
	 YVCIgar4upwqF8ZtMwXF6yyZ+eQ0ESQ+ghXjbBlaa147sf6jQruWLlVAi+aXvfulso
	 4vjFgf2LdK+sw+MbyxSQ7k54FzK1aevo5PJBCuKlmOB2CC0geT23pYtkf+W82/pvXh
	 0cOCcX3BQwaYiRBCZlUH0ZDYkwf7rakQD/eIiqIPxN7Hcc6Fbz7nXv5E8Et+tTrpkc
	 mwYm2jfFrba7Q==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513d4559fb4so3263633e87.3
        for <fstests@vger.kernel.org>; Sat, 16 Mar 2024 06:09:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVa23mYf4xd666XStk5qktWIS2rbRont2FO+SBpQrjMoLcjSs7VyxQAHID6SjCRhDvF7hLg+jFFSd1CvzRcH57/gzXln5hZIw==
X-Gm-Message-State: AOJu0YxIIEvPlgkglHubQc7QCy3afDwhHha24rS/mdVGhToYw1OVH34H
	h3RDBcpWxYGAkVVpR8VQzwJEbcyTJ7/q17j+XmGIJiRHPmcEGOx0RUrkazkXXUAISD8XT6w1ugt
	StJFD9Zf+5u5o72OsZIcf4uzH/xo=
X-Google-Smtp-Source: AGHT+IHduPcd9fUo/a+KHxVptuTTTLdPVbjyDHscVMFHKLwYWpiMLKZ7IRU0Dytms/BdbmzAm1Rr7Q6UG759As+lsUY=
X-Received: by 2002:a19:8c1c:0:b0:513:d9bb:8dec with SMTP id
 o28-20020a198c1c000000b00513d9bb8decmr2885643lfd.68.1710594574601; Sat, 16
 Mar 2024 06:09:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6165b0018426e58e7427a26eebea3d63e66fed15.1710373423.git.boris@bur.io>
 <20240315025628.GH6188@frogsfrogsfrogs> <20240315233054.GA3597569@zen.localdomain>
In-Reply-To: <20240315233054.GA3597569@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sat, 16 Mar 2024 13:08:57 +0000
X-Gmail-Original-Message-ID: <CAL3q7H71Roae5kqc0Hh2=CZxCfLd9Kp7bqAfgo5OcUz==opVow@mail.gmail.com>
Message-ID: <CAL3q7H71Roae5kqc0Hh2=CZxCfLd9Kp7bqAfgo5OcUz==opVow@mail.gmail.com>
Subject: Re: [PATCH RFC] generic/730: ensure EIO after device delete
To: Boris Burkov <boris@bur.io>
Cc: "Darrick J. Wong" <djwong@kernel.org>, kernel-team@fb.com, fstests@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 11:30=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Thu, Mar 14, 2024 at 07:56:28PM -0700, Darrick J. Wong wrote:
> > On Wed, Mar 13, 2024 at 04:47:47PM -0700, Boris Burkov wrote:
> > > This test removes a SCSI debug device out from under a mounted
> > > filesystem with a (probably) dirty file. This assumes that page cache
> > > cannot save us from EIO, for a reason that I can't quite explain. In
> > > fact, this test fails for exactly that reason, at least on btrfs.
> > >
> > > The original patches:
> > >
> > >       https://lore.kernel.org/fstests/20230807112100.GB15405@lst.de/
> > >
> > > refer to this passing on xfs and not btrfs, so I suspect I am missing
> > > something. With that said, on my machine this actually fails on xfs w=
ith
> > > and without my patch, so this is clearly not enough.
> > >
> > > High level, I am trying to understand what is really the expected
> > > behavior from a filesystem under this condition and what this test is
> > > getting at. Of btrfs, ext4, and xfs, only ext4 passes it, while btrfs
> > > does pass with this additional syncing/cache dropping to nudge it to =
an
> > > error.
> >
> > Does btrfs prefetch pagecache data as soon as a file opens?  Or I guess
> > it could be that xfs trips an IO error and shuts down, and
> > xfs_file_read_iter will return EIO after that happens.
> >
> > --D
> >
>
> I might be wildly misunderstanding, since I'm very far from an expert on
> the page cache, but didn't we just do a buffered write to the file? So it
> would make sense for it to be in cache?
>
> At any rate, what I observed on my system was that xfs does not pass
> this test. Curious if that is only on my system or just the current
> state of the test.

Instead of xfs, do you mean btrfs?

For me xfs and ext4 always pass this test, i.e. the cat command fails
with -EIO, both with and without your patch.

On the other hand, btrfs and f2fs always fail without your patch, and
pass with your patch applied.

From a btrfs point of view, it makes sense for the cat command to
succeed, since all the file data is in the page cache.

I don't know why the cat command fails (-EIO) with xfs and ext4, and I
haven't looked at any of their source code (my knowledge of those
filesystem's internals is too little anyway).

An alternative to your patch is just to make the write with direct IO
by passing -d to $XFS_IO_PROG. It makes the test succeed on these 4
filesystems.


>
> Summary of my test matrix:
> ext4: passes with and without this patch
> btrfs: fails without this patch, passes with it
> xfs: fails with and without this patch
>
> For that reason, I don't think this a good patch, I just mostly want to
> figure out where to go with this test!
>
> Thanks,
> Boris
>
> > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > ---
> > >  tests/generic/730 | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/tests/generic/730 b/tests/generic/730
> > > index 11308cdaa..ca5037c57 100755
> > > --- a/tests/generic/730
> > > +++ b/tests/generic/730
> > > @@ -47,6 +47,9 @@ exec 3< $SCSI_DEBUG_MNT/testfile
> > >  # delete the scsi debug device while it still has dirty data
> > >  echo 1 > /sys/block/$(_short_dev $SCSI_DEBUG_DEV)/device/delete
> > >
> > > +sync
> > > +echo 3 > /proc/sys/vm/drop_caches
> > > +
> > >  # try to read from the file, which should give us -EIO
> > >  cat <&3 > /dev/null
> > >
> > > --
> > > 2.43.0
> > >
> > >
>
