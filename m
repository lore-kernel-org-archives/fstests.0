Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DF550AC27
	for <fstests@vger.kernel.org>; Wed, 16 Sep 2026 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789575906; cv=none; b=s3Kjn/n4nidwx8IhptHNz0RgXuZutt5+mzExszj02OmedbAs633bdiIR5t8/mkL0v9GIS6MtRWi+rLEz5uU2e3ajF5Gy9LZsaSmI7+Oj2rJKaxjm5QJhjihNvcPJACRwvaNMBVFE1DPahTEjKMQAN0sIy7QpvN8U+Zd70F/ivV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789575906; c=relaxed/simple;
	bh=LTPnB8t+E7TUFMjzqpMcTYA9J5mE9k55Fhv4o1PDZt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gvK/rgyFi7zjhBUVJoZG+nu6oNAkm2HoXPnKlBdGwhuwYMxFOczAbAaJzopRfR/A7GMD7kOm0ZBdNdyPN1uq6gLrFCGc2fPAFzymSKBkxtjHwL5p/TzkvKm5Rmg4g3kWigF12ST+T9WwInyKRqDhkSC//emVKQalAFTzRN0DgnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPTNndSK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPTNndSK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBAB91F0089A
	for <fstests@vger.kernel.org>; Wed, 16 Sep 2026 16:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789575899;
	bh=s2ApJAF3oWOJIbrYLDQ6vkFWqfxJm78UAqyQfrQXezo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=oPTNndSKkeG2b7Cpgh3Uwwqxqse0C1JKCKkz2lrXNgrvQdBO5QBYXKcUX7kA9KfCQ
	 1dOiSu1c0nO9b4kR8NTjw4liNmXLDc20l/PZt5A5NV0H0BfysJSjf/h2LWNSp/+tqQ
	 0/ozjqnkKeii4G0khNRuSKmaPo59H6PoYGdWm2ng/Vsi3HWTxvXF+NXz6OftcF3b38
	 t4PHJInWhSFZ14LYaO3Ynf3RXOO2o/w6mENOC8NNS6jpNjXEji7yOGy5Pb/eriOci2
	 nAnQ+94skUDHq8LSSnz3HkGRBk9ySlzT+Uacib0ymFNwfaq2/jx7Fi+mXMANjBZXwT
	 8K2DuQcqjYJiQ==
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-78a338fe106so1935605137.0
        for <fstests@vger.kernel.org>; Wed, 16 Sep 2026 09:24:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzdlbERV1cjlWEbeKeRulJeoCn1EHMb7+tRsXP6Zj7eUxKPuTrxcYI3dNiV9oIkRrG8wf077A9j@vger.kernel.org
X-Gm-Message-State: AFuF++k5FhACu0ao1JG3VE53lh+dcwYPlBKNdDPjWWAuBkDrlJkvqBwz
	7iGYQc4ns9X2uDsV9CMNlBf0lwzE07awdC7542bpg1nrRGovR5fHKzj0KQLb3ECJ21hQe7yUTVd
	FOxSoFIaHA8QhRKu6Qa3IVkhl7/bnzo8=
X-Received: by 2002:a67:e3a1:0:b0:795:f34e:2f12 with SMTP id
 ada2fe7eead31-7a1ea228239mr153901137.16.1789575898055; Wed, 16 Sep 2026
 09:24:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-btrfs-enomem-v1-1-ca07610ebcad@kernel.org>
 <CAL3q7H4P32sBFHoUkD6NhxhJs=aLGMFKqB9ZGO0716Vx3r5vag@mail.gmail.com> <3c7970372211aaddf5c127e4c3cef0f462b060a6.camel@kernel.org>
In-Reply-To: <3c7970372211aaddf5c127e4c3cef0f462b060a6.camel@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 16 Sep 2026 17:24:21 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7Y0wY8N2=LL_6=hpEmp1piHsa-ef68-DNShwL+5yqMjw@mail.gmail.com>
X-Gm-Features: AcwNN1WF2-gUz_1qEnt7e9TKM2JEiuYGNs5MTr3PqxqIpV2NtzjYR3NinaEevaU
Message-ID: <CAL3q7H7Y0wY8N2=LL_6=hpEmp1piHsa-ef68-DNShwL+5yqMjw@mail.gmail.com>
Subject: Re: [PATCH fstests] btrfs: test graceful ENOMEM handling in
 synchronous dirops
To: Jeff Layton <jlayton@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, Anand Jain <asj@kernel.org>, Filipe Manana <fdmanana@suse.com>, 
	linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 5:21=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Wed, 2026-09-16 at 17:03 +0100, Filipe Manana wrote:
> > On Tue, Sep 15, 2026 at 5:33=E2=80=AFPM Jeff Layton <jlayton@kernel.org=
> wrote:
> > >
> > > Recently, we added some patches to allow btrfs to handle -ENOMEM erro=
rs
> > > in dir-morphing codepaths [1]. As part of that, we added fault inject=
ion
> > > knobs to a few functions so we could test that error handling.
> > >
> > > Add btrfs/354, which uses the fail_function facility to inject -ENOME=
M
> >
> > Please don't add here the test number, as this is very likely to be
> > changed at commit time as we have already 2 other pending test cases
> > with that number.
> > Just say "Add a test case...".
> >
>
> ACK, will do.
>
> > > into btrfs_prealloc_delayed_dir_index() and confirms that a
> > > dir-modifying operation returns ENOMEM to userspace without aborting =
the
> > > filesystem:
> > >
> > > - mkdir fails with ENOMEM (not EROFS),
> > > - a subsequent create succeeds (fs is not read-only/aborted),
> > > - a mount cycle runs orphan cleanup and the automatic fsck confirms
> > >   consistency.
> > >
> > > The injection is global, so any other btrfs dir-entry creation can
> > > consume it first -- including the test's own $tmp redirection when /t=
mp
> > > is itself on btrfs. Pre-create that file and retry until the mkdir ta=
kes
> > > the error.
> > >
> > > Add generic _require_function_error_injection / _inject_function_erro=
r /
> > > _uninject_function_error helpers to common/inject for driving the ker=
nel
> > > fail_function interface.
> > >
> > > [1]: https://lore.kernel.org/linux-btrfs/20260825-btrfs-enomem-v4-0-b=
9363fa8714a@kernel.org/
> > >
> > > Assisted-by: LLM
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  common/inject       | 50 ++++++++++++++++++++++++++++++++
> > >  tests/btrfs/354     | 83 +++++++++++++++++++++++++++++++++++++++++++=
++++++++++
> > >  tests/btrfs/354.out |  2 ++
> > >  3 files changed, 135 insertions(+)
> > >
> > > diff --git a/common/inject b/common/inject
> > > index 6b590804d1ea..da78c1931135 100644
> > > --- a/common/inject
> > > +++ b/common/inject
> > > @@ -111,3 +111,53 @@ _scratch_inject_error()
> > >                 _fail "Cannot inject error ${type} value ${value}."
> > >         fi
> > >  }
> > > +
> > > +# Requires the kernel fail_function facility (CONFIG_FUNCTION_ERROR_=
INJECTION
> > > +# and CONFIG_FAIL_FUNCTION) and, if a function name is given, that t=
he function
> > > +# is annotated with ALLOW_ERROR_INJECTION().
> > > +_require_function_error_injection()
> > > +{
> > > +       local func=3D"$1"
> > > +
> > > +       test -d "$DEBUGFS_MNT/fail_function" || \
> > > +               _notrun "$DEBUGFS_MNT/fail_function not found; CONFIG=
_FAIL_FUNCTION not enabled"
> > > +
> > > +       if [ -n "$func" ]; then
> > > +               grep -qw "$func" "$DEBUGFS_MNT/error_injection/list" =
2>/dev/null || \
> > > +                       _notrun "$func is not registered for error in=
jection"
> > > +       fi
> > > +}
> > > +
> > > +# Inject a fixed return value into a kernel function via fail_functi=
on.
> > > +#   $1 - function name (must be ALLOW_ERROR_INJECTION annotated)
> > > +#   $2 - return value to inject (e.g. -12 for -ENOMEM)
> > > +#   $3 - number of times to fail (default 1)
> > > +_inject_function_error()
> > > +{
> > > +       local func=3D"$1"
> > > +       local retval=3D"$2"
> > > +       local times=3D"${3:-1}"
> > > +
> > > +       # Writing the function name to "inject" creates its per-funct=
ion dir.
> > > +       echo "$func" > "$DEBUGFS_MNT/fail_function/inject"
> > > +       # The retval file is an unsigned hex attribute (DEFINE_DEBUGF=
S_ATTRIBUTE
> > > +       # "%llx"), so a negative errno like -12 must be written as it=
s unsigned
> > > +       # 64-bit (two's-complement) hex form; a bare "-12" is rejecte=
d with EINVAL.
> > > +       printf '%#x\n' "$retval" > "$DEBUGFS_MNT/fail_function/$func/=
retval"
> > > +       echo 100 > "$DEBUGFS_MNT/fail_function/probability"
> > > +       echo 0 > "$DEBUGFS_MNT/fail_function/interval"
> > > +       echo 0 > "$DEBUGFS_MNT/fail_function/space"
> > > +       echo 0 > "$DEBUGFS_MNT/fail_function/verbose"
> > > +       echo "$times" > "$DEBUGFS_MNT/fail_function/times"
> > > +}
> > > +
> > > +# Stop injecting errors into a kernel function set up by
> > > +# _inject_function_error().
> > > +_uninject_function_error()
> > > +{
> > > +       local func=3D"$1"
> > > +
> > > +       echo 0 > "$DEBUGFS_MNT/fail_function/times" 2>/dev/null
> > > +       echo 0 > "$DEBUGFS_MNT/fail_function/probability" 2>/dev/null
> > > +       echo "!$func" > "$DEBUGFS_MNT/fail_function/inject" 2>/dev/nu=
ll
> > > +}
> > > diff --git a/tests/btrfs/354 b/tests/btrfs/354
> > > new file mode 100755
> > > index 000000000000..9b9e601d6405
> > > --- /dev/null
> > > +++ b/tests/btrfs/354
> > > @@ -0,0 +1,83 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2026 Jeff Layton.  All Rights Reserved.
> > > +#
> > > +# FS QA Test No. 354
> > > +#
> > > +# Verify that an -ENOMEM in the synchronous directory entry insertio=
n path is
> > > +# returned to userspace without aborting the filesystem.
> > > +#
> > > +# btrfs pre-allocates the delayed dir index before modifying the btr=
ee, so a
> > > +# failure in btrfs_prealloc_delayed_dir_index() must surface as -ENO=
MEM from
> > > +# mkdir()/create()/etc. rather than a transaction abort. Use the fai=
l_function
> > > +# facility to force that allocation to fail and confirm the fs survi=
ves.
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick
> > > +
> > > +. ./common/inject
> > > +. ./common/filter
> > > +
> > > +_require_scratch
> > > +# For the automatic fsck at unmount, which confirms the orphaned ino=
de left by
> > > +# the failed operation is cleaned up and the fs is consistent.
> > > +_require_check_dmesg
> > > +_require_function_error_injection btrfs_prealloc_delayed_dir_index
> >
> > Please add here somewhere a call to  _fixed_by_kernel_commit so that
> > when test case fails on an unpatched kernel we get an informative
> > message.
> >
> > Otherwise it looks good, thanks.
> >
>
> Thanks!
>
> Should I wait until v7.4 merge window opens before resending this so
> that the kernel commit IDs are stable?

No, we just leave the commit ID as xxxxxxxxxxxx and update it later
once the patch is in Linus' tree.

Thanks.


>
> > > +
> > > +func=3Dbtrfs_prealloc_delayed_dir_index
> > > +
> > > +_scratch_mkfs >> $seqres.full 2>&1
> > > +_scratch_mount
> > > +
> > > +# Pre-create the stderr file. fail_function has no usable task filte=
r, so the
> > > +# injection is global, and $tmp may well live on a btrfs filesystem =
itself. If
> > > +# the shell had to create this file it would insert a dir entry and =
swallow the
> > > +# injected failure before mkdir() ever ran.
> > > +touch $tmp.err
> > > +
> > > +# For the same reason any other btrfs dir-entry creation on the syst=
em can
> > > +# consume the one-shot failure, so retry until our mkdir is the oper=
ation that
> > > +# takes it.
> > > +err=3D""
> > > +for i in $(seq 1 20); do
> > > +       rm -rf "$SCRATCH_MNT/dir"
> > > +
> > > +       # Force a single -ENOMEM (-12) into the prealloc path.
> > > +       _inject_function_error $func -12 1
> > > +       mkdir "$SCRATCH_MNT/dir" 2>$tmp.err
> > > +       res=3D$?
> > > +       _uninject_function_error $func
> > > +
> > > +       # mkdir succeeded, so something else consumed the injected fa=
ilure.
> > > +       # Note we must not leave the directory behind, or the next at=
tempt
> > > +       # would fail with EEXIST rather than the injected error.
> > > +       if [ $res -eq 0 ]; then
> > > +               continue
> > > +       fi
> > > +
> > > +       err=3D$(cat $tmp.err)
> > > +       break
> > > +done
> > > +
> > > +if [ -z "$err" ]; then
> > > +       _notrun "injected error did not reach mkdir"
> > > +fi
> > > +
> > > +# The error returned to userspace must be ENOMEM, not EROFS (which w=
ould mean
> > > +# the transaction was aborted and the fs went read-only).
> > > +echo "$err" | grep -qi "cannot allocate memory" || \
> > > +       { echo "unexpected error from mkdir:"; echo "$err" | _filter_=
scratch; }
> > > +
> > > +# The filesystem must still be usable: a create with injection disab=
led must
> > > +# succeed. On an aborted (read-only) fs this would fail with EROFS.
> > > +mkdir "$SCRATCH_MNT/dir2" || _fail "filesystem unusable after inject=
ed ENOMEM"
> > > +
> > > +# Cycle the mount to run orphan cleanup for the inode left behind by=
 the failed
> > > +# mkdir, then keep using the fs to be sure it is healthy.
> > > +_scratch_cycle_mount
> > > +touch "$SCRATCH_MNT/dir2/file"
> > > +
> > > +echo "silence is golden"
> > > +
> > > +status=3D0
> > > +exit
> > > diff --git a/tests/btrfs/354.out b/tests/btrfs/354.out
> > > new file mode 100644
> > > index 000000000000..afe30ed36fea
> > > --- /dev/null
> > > +++ b/tests/btrfs/354.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 354
> > > +silence is golden
> > >
> > > ---
> > > base-commit: a370dcbed43563f0462801e889e0eceb93c7cfad
> > > change-id: 20260915-btrfs-enomem-e70077862117
> > >
> > > Best regards,
> > > --
> > > Jeff Layton <jlayton@kernel.org>
> > >
> > >
>
> --
> Jeff Layton <jlayton@kernel.org>
