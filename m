Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8837CEB64D9
	for <linux-fstests@archiver.kernel.org>; Wed, 12 Jul 2023 05:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjGLFQL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 12 Jul 2023 01:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjGLFQH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 12 Jul 2023 01:16:07 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E1919A3
        for <fstests@vger.kernel.org>; Tue, 11 Jul 2023 22:16:01 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-44691ebb0e1so242253137.0
        for <fstests@vger.kernel.org>; Tue, 11 Jul 2023 22:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689138960; x=1691730960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dU1WHy6+nP1NYKs1s3RtGwEScrsxNKExaD/X0VQFnuo=;
        b=i6HL4q+4Bf61kXGUHZEiFbsPIAK2zydvHajV6GF/r2ZybdObB4Vy+Zix+54Z+Vo2kF
         LwH9c3OSuuDx7w17ii0qj8KNGGmZj6uhN+r+9zJQjjntYKeaGlY91hL3ixdy7akBcgLT
         p0NSJ5oSJNQOvSFuxaUcH7K0q+TLFpPIMeW9IjfLGgxMKCid/ZYZ0ny2kygFFS+UhpOD
         EwcTBOPPvQSp4asVq+/1HFo210L4xm5BQufIOYzjo0AyFREOFRPVvJGECtgQU1bBfU4E
         2y+o3h9CeWLPREy6BK3h9LN/dgFWV0ZD2LqTu+sPizbOFxSRCDeOmxF7etuPhCkFQYyK
         J1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689138960; x=1691730960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dU1WHy6+nP1NYKs1s3RtGwEScrsxNKExaD/X0VQFnuo=;
        b=e0tW5KJXpg6BMfw5ODvQIUqThifFEWrEYI+FBIo//ldTzukVayjuOmJjG802ivPfQc
         g1Xk3WJUuRt1+K+YshvXeG9c0DG87maC6D6iW6HG1l7ZaWEL+bDBTUeQoWhT0UK/koy2
         LzaHPpOL9kHm2cjb0XUvZpiygXHhXMoxrk82e/zDGW7k0dTpftJbHIZ1LtycQoHH3HKt
         vVbfCT+OoueTlZ5n6/uCxw5DMkhcMNFHHfIPQazmLqr8CdXYW6i7YyKo5pa0YOsCC1m9
         Hx9DerGObKUfB2h2awQxMehLCWw9ERAkso4XXo2iQuvw/gT+nssePzHPwXG+izUAUvyH
         DsqQ==
X-Gm-Message-State: ABy/qLYqKPgR3hWNEs6JoLqYkM2yR90YtVZNQGjiDZL5gaPwn/7yb1v0
        IC0sqPrqN6MHnEoNScniU1AakiljhpFBg/LY+3eZwsXxBy4=
X-Google-Smtp-Source: APBJJlErH3kbjGTwvqIHgcK4M4aTbeOIFetPj2QIt2vovfgC0710+jH+UixISvDwgd1nnrGNi7Q9msLUBfF5WdEMALk=
X-Received: by 2002:a05:6102:20f:b0:443:664f:f15 with SMTP id
 z15-20020a056102020f00b00443664f0f15mr8787061vsp.5.1689138960359; Tue, 11 Jul
 2023 22:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <2bb7705c-9a1a-6185-4554-9121e5cda710@redhat.com>
 <20230711234439.GC11442@frogsfrogsfrogs> <20230712010939.2htp62rd7qvshgiy@moria.home.lan>
In-Reply-To: <20230712010939.2htp62rd7qvshgiy@moria.home.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 12 Jul 2023 08:15:49 +0300
Message-ID: <CAOQ4uxiO_8zYFKXC_9rdF=B7dE+RBmHeNecyu0Gamb6tGo=+8Q@mail.gmail.com>
Subject: Re: [PATCH] generic/558: limit the number of spawned subprocesses
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Eryu Guan <eguan@redhat.com>, Zorro Lang <zlang@kernel.org>,
        fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 12, 2023 at 4:20=E2=80=AFAM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Tue, Jul 11, 2023 at 04:44:39PM -0700, Darrick J. Wong wrote:
> > On Tue, Jul 11, 2023 at 05:51:42PM +0200, Mikulas Patocka wrote:
> > > When I run the test 558 on bcachefs, it works like a fork-bomb and ki=
lls
> > > the machine. The reason is that the "while" loop spawns "create_file"
> > > subprocesses faster than they are able to complete.
> > >

Please take a step back and ask why is the test spawning processes at all?
If all the test needs to do is "using up all inodes" a C helper would be
a much better way to accomplish that.

> > > This patch fixes the crash by limiting the number of subprocesses to =
128.
> > >
> > > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > >
> > > ---
> > >  tests/generic/558 |    1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > Index: xfstests-dev/tests/generic/558
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > --- xfstests-dev.orig/tests/generic/558
> > > +++ xfstests-dev/tests/generic/558
> > > @@ -48,6 +48,7 @@ echo "Create $((loop * file_per_dir)) fi
> > >  while [ $i -lt $loop ]; do
> > >     create_file $SCRATCH_MNT/testdir $file_per_dir $i >>$seqres.full =
2>&1 &
> > >     let i=3D$i+1
> > > +   if [ $((i % 128)) =3D 0 ]; then wait; fi
> >
> > Hm.  $loop is (roughly) the number of free inodes divided by 1000.  Thi=
s
> > test completes nearly instantly on XFS; how many free inodes does
> > bcachefs report after _scratch_mount?
> >
> > XFS reports ~570k inodes, so it's "only" starting 570 processes.
> >
> > I think it's probably wise to clamp $loop to something sane, but let's
> > get to the bottom of how the math went wrong and we got a forkbomb.
>
> It's because:
>  - bcachefs doesn't even report a maximum number of inodes (IIRC);
>    inodes are small and variable size (most fields are varints, typical
>    inode size is 50-100 bytes).
>

The purpose of this test is to "Stress test fs by using up all inodes",
so it seems that the test may not be appropriate for bcachefs?
_require_inode_limits should have detected that, but the expectation
of "no inode limit" to be reported as 0 free inodes is obviously not
a standard. I am not sure which fs, if any, meets this rule?

And yet, it is important for fstests to be able to tell if FSTYP should run
this test or not, so either we make _require_inode_limits be aware
of specific FSTYP, like _fstyp_has_non_default_seek_data_hole
where there was no standard way of detecting expected behavior,
or we agree on a generic heuristic that is good enough for
_require_inode_limits.

>  - and the kernel has a sysctl to limit the maximum number of open
>    files, and it's got a sane default; this is what's supposed to save
>    us from pinned inodes eating up all ram), but systemd conveniently
>    overwrites it to some absurd value...
>
> I'd prefer to see this fixed properly, rather than just "fixing" the
> test; userspace being able to pin all kernel memory this easily is a
> real bug.
>
> We could put a second hard cap on the maximum number of open files, and
> base that on a percentage of total memory; a VFS inode is somewhere in
> the ballpack of a kilobyte, so easy enough to calculate. And we could
> make that percentage itself a sysctl, for the people who are really
> crazy...

Maybe it's not a bad idea, but I don't think it would have solved the repor=
ted
fork bomb issue, so the test needs to be fixed anyway.

Specifically regarding the memory overuse issue,
the t_open_tmpfiles tests do have this problem.

These were two attempts to fix the tests:

dd2c7266 fstests: don't oom the box opening tmpfiles
c42c8e6c fstests: don't oom the box opening tmpfiles (take 2)

But for me, generic/531 still OOMs.

Kent, on a personal note, I've been following the heated discussion
lately on fsdevel, one specified argument was also ignited over
"fixing the test" vs. "fixing the kernel bug" argument as you raised above.

One of the good points raised also by yourself was to stick to technical
arguments.

I would simply like to point out that you use the terminology "sane" and "c=
razy"
quite often in arguments, as you just did in this reply.
Those are obviously not objective technical arguments and yes, I know that
you use them as a figure of speech and I use them often myself, but from
the outside, know that they may sound dismissive of any other opinion
other than the "sane" opinion.

Personally, I think that the suggestion to fix the kernel to enforce
the resource automatically, "_rather_ than just "fixing" the test", is well=
,
for lack of better words, crazy ;)

I am all for trying to protect the kernel from DoS, but this is far from
being a trivial project, so it does not make sense to ask for that from
the contributor of this simple test patch.

You did say "I'd prefer to see this.." so perhaps you did not mean
that the fix for the test should be blocked, but again, to the outside
(to me) this is how it sounds.

Bottom line - this test does not even need to open a single file
to create inodes (i.e. mknod()) and certainly does not need to
spawn more than one process, so I think the test should be fixed.

Thanks,
Amir.
