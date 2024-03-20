Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8D26A02E
	for <fstests@vger.kernel.org>; Wed, 20 Mar 2024 17:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710954124; cv=none; b=GqAMYg4YAZ3kke7s+GeJDDADT+qiYhTgQMAJmKy/PtUw7YhRx5DmoT4XAR0ZrKHaJarRTPJRUPmCKzpkn35wP7RwccOgG713amhCtDK8w9v5oCD3hjxA55+dsUm3aDiQew7IUAiRUGcJTFxCPh9D6lbLcnIxWJyRY0LJcWQIOD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710954124; c=relaxed/simple;
	bh=ZZ8I+wyBgBC027bJVQ7ILmCIzyVomnCp6nqUlbZPsDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cnOKBxvWzZGIso6XAsGcxBlix+JAQnVRwU7Lm+63Qyhm725DV8bQgOlr5v54hEQOm2j/WeTli5u86Ccb/uy+8+uTbgyb40dxfBE1JOYRvCSkXSHS/cBtdkrWtevFIHaUUZ54tKFwB4VFlbdorvbW1vCNCvUR6nL3JdHz41PMcl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcO2qYfm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcO2qYfm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64ECC43394
	for <fstests@vger.kernel.org>; Wed, 20 Mar 2024 17:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710954123;
	bh=ZZ8I+wyBgBC027bJVQ7ILmCIzyVomnCp6nqUlbZPsDY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kcO2qYfmztbnSe/6CKeJ1OOUkp0XypCXVyt82wZlLCjGn6U4SPowpGfBCQ9XzYmND
	 Jy6QGXxr/0NBMMoVGyZT1iE2wCoXKzpsS+sQTevSEx+9UFzdvKW6u/dFkC5p+UfVtr
	 bcWEdlPdP9b8SA3wzPsxAGzkrp3FOSXBdK1xnrOYQN/gpXbW6HofpcV/nfzcdQ0Bwg
	 OTCTU3JXEPNqL4sZYBuKNxPOX1ZohfQKpwFmkx0ab8EPvHZL+KBg+71OGt4pf3Q+Dz
	 13yLMAD4LRe5v6QlkDI7z81UkpylDWDG0x/BjIk9XHLPTy6yeOwn710ugcOygq5s3E
	 +xKlIOELxF0KQ==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56b857bac38so7432a12.0
        for <fstests@vger.kernel.org>; Wed, 20 Mar 2024 10:02:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXatKsvzc0LvP8z+qCTZyCV3Umer+9JuJKIzGhNwt7x0W2UALQXjM7rcmKZ7t6IoXzEUePR8RMEMCHzI97SRnT6uztNu2gcMQ==
X-Gm-Message-State: AOJu0YxD6Mhg6MM/WjOUESmwoq/1yGh3gYD9ow5QbMGo+4l+zaYJ3SNS
	eZ5oMiJGnuXCamJfu+kzuvYQfuhGegmWvQBrevy17MUyNPB/Jd0wmJd+lTOnluRcY9kpKLTHIf1
	IbnRA7yYYnCqrDBc1UteeLxvxUHs=
X-Google-Smtp-Source: AGHT+IHTmmC1o183V+jyDZx4n6hyQ3SRKX5XX1hhOh1BvjylqN+XX3XjP3pAtMhb2AQac53lCFcp/xwyziVBrz2qWUA=
X-Received: by 2002:a05:6402:5d0:b0:565:6e34:da30 with SMTP id
 n16-20020a05640205d000b005656e34da30mr14065106edx.21.1710954121471; Wed, 20
 Mar 2024 10:02:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710871719.git.dsterba@suse.com> <d61b8bd818a8f9403982f532ac21586f6c96269c.1710871719.git.dsterba@suse.com>
 <f9dc2fdf-e468-4525-bb74-47d5bc30dcc0@oracle.com>
In-Reply-To: <f9dc2fdf-e468-4525-bb74-47d5bc30dcc0@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 20 Mar 2024 17:01:24 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7wrATcAKOxy6xSy6USBFULAujfKEkP5Giv23n_5n+zgA@mail.gmail.com>
Message-ID: <CAL3q7H7wrATcAKOxy6xSy6USBFULAujfKEkP5Giv23n_5n+zgA@mail.gmail.com>
Subject: Re: [PATCH 3/5] btrfs/330: add test to validate ro/rw subvol mounting
To: Anand Jain <anand.jain@oracle.com>
Cc: David Sterba <dsterba@suse.com>, fstests@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 11:34=E2=80=AFAM Anand Jain <anand.jain@oracle.com>=
 wrote:
>
> On 3/19/24 23:42, David Sterba wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> >
> > Btrfs has had the ability for almost a decade to allow ro and rw
> > mounting of subvols.  This behavior specifically
> >
> > mount -o subvol=3Dfoo,ro /some/dir
> > mount -o subvol=3Dbar,rw /some/other/dir
> >
> > This seems simple, but because of the limitations of how we did mountin=
g
> > in ye olde days we would mark the super block as RO and the mount if we
> > mounted RO first.  In the case above /some/dir would instantiate the
> > super block as read only and the mount point.  So the second mount
> > command under the covers would convert the super block to RW, and then
> > allow the mount to continue.
> >
> > The results were still consistent, /some/dir was still read only becaus=
e
> > the mount was marked read only, but /some/other/dir could be written to=
.
> >
> > This is a test to make sure we maintain this behavior, as I almost
> > regressed this behavior while converting us to the new mount API.
> >
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>
> looks good.
>
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
>
> Nits below.
>
> > ---
> >   tests/btrfs/330     | 54 ++++++++++++++++++++++++++++++++++++++++++++=
+
> >   tests/btrfs/330.out |  6 +++++
> >   2 files changed, 60 insertions(+)
> >   create mode 100755 tests/btrfs/330
> >   create mode 100644 tests/btrfs/330.out
> >
> > diff --git a/tests/btrfs/330 b/tests/btrfs/330
> > new file mode 100755
> > index 00000000000000..3ce9840e76d028
> > --- /dev/null
> > +++ b/tests/btrfs/330
> > @@ -0,0 +1,54 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
> > +#
> > +# FS QA Test No. btrfs/330
> > +#
> > +# Test mounting one subvolume as ro and another as rw
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick subvol
> > +
> > +_cleanup()
> > +{
> > +     rm -rf $TEST_DIR/$seq
> > +}
> > +
> > +# Import common functions.
>
> > +. ./common/filter
>
> This can be deleted, as the filter.btrfs also calls the filter.
>
> > +. ./common/filter.btrfs
>
>
> > +
> > +# real QA test starts here
> > +_supported_fs btrfs
> > +_require_scratch
> > +
> > +$MOUNT_PROG -V | grep -q 'fd-based-mount'
> > +[ "$?" -eq 0 ] && _notrun "mount uses the new mount api"
> > +
> > +_scratch_mkfs > /dev/null 2>&1
>
> _scratch_mkfs >> $seqres.full
>
> Errors, if any, go to stdout.

We typically redirect stderr to stdout because in the past mkfs.btrfs
used to output to stderr a message when it performed trim.
See this old commit:

https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=3Dafadb6e=
5958c5acf2425d6a8a9372b63afcb4f2a

And nowadays we're encouraged to do:

_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"

So in case mkfs fails the test doesn't continue and silently passes by
using the filesystem SCRATCH_MNT belongs to.
This has been discussed and pointed out several times, but I don't
have a link to such discussion.

>
> Thanks, Anand
>
> > +_scratch_mount
> > +
> > +# Create our subvolumes to mount
> > +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/foo | _filter_scratch
> > +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/bar | _filter_scratch
> > +
> > +_scratch_unmount
> > +
> > +mkdir -p $TEST_DIR/$seq/foo
> > +mkdir -p $TEST_DIR/$seq/bar
> > +
> > +_mount -t btrfs -o subvol=3Dfoo,ro $SCRATCH_DEV $TEST_DIR/$seq/foo
> > +_mount -t btrfs -o subvol=3Dbar,rw $SCRATCH_DEV $TEST_DIR/$seq/bar
> > +
> > +echo "making sure foo is read only"
> > +touch $TEST_DIR/$seq/foo/baz > /dev/null 2&>1
> > +ls $TEST_DIR/$seq/foo
> > +
> > +echo "making sure bar allows writes"
> > +touch $TEST_DIR/$seq/bar/qux
> > +ls $TEST_DIR/$seq/bar
> > +
> > +$UMOUNT_PROG $TEST_DIR/$seq/foo
> > +$UMOUNT_PROG $TEST_DIR/$seq/bar
> > +
> > +status=3D0 ; exit
> > diff --git a/tests/btrfs/330.out b/tests/btrfs/330.out
> > new file mode 100644
> > index 00000000000000..4795a2ccc8cb62
> > --- /dev/null
> > +++ b/tests/btrfs/330.out
> > @@ -0,0 +1,6 @@
> > +QA output created by 330
> > +Create subvolume 'SCRATCH_MNT/foo'
> > +Create subvolume 'SCRATCH_MNT/bar'
> > +making sure foo is read only
> > +making sure bar allows writes
> > +qux
>
>
