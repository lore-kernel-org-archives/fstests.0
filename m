Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F1B12FB0A
	for <fstests@vger.kernel.org>; Mon, 26 Feb 2024 19:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974726; cv=none; b=V7ExWgaoI0lFdjVlHY2BiSu2cRc2orcrpoVQ2emDqEkJZDigBva6t0so+diiHxNVmtv+silsiwlSjbk5OS1H0ZTVGYUBYPJyLxpqh067KnnncPpxoYcC++YGt6mz4fNIwmUjDAjtWMrCrvi+PAimLfRU2O9miDQgsy8tI9/MlHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974726; c=relaxed/simple;
	bh=jD/MvEGNhzwgQOi/41LNV/ndGHM6kYcvdjBlvLwLk2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDHuzqxNEU+JvdeKh/UwGx65WJ8C1466GbLMdGDGzVRZJkoaqA9+2TQbIEFUQGKV6yMhbpZwBB3LhYX9yLSQexvnZYgnQhM8si0FtcI5lojlx2ZfCeraLbYSH5j8C+sh3iGYbP0XhAXyyWaiL1z6c8OJNjFuZpL+tcT6bgLNo08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLgfN88z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLgfN88z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0958C433F1;
	Mon, 26 Feb 2024 19:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708974725;
	bh=jD/MvEGNhzwgQOi/41LNV/ndGHM6kYcvdjBlvLwLk2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mLgfN88zsf4EZqR8eraUEO0WJb1r0DX6+fL5dwlu8wJPHhWpV20NOL3cbCe8+aEaR
	 3l0M5+z+MHOkcSNFSbsfV0zn7p44cebLUTh/eLX5FH1zbaX3PKKg70r7xqj6huTWLy
	 3yJ+8Oc2Vea1hv/UaqdMPfeCOg2i23adKRhVn1ljiFDTtvoXuS0Yh+vemXBb5zBfVb
	 gztalevikTmdJLeFwrvl9WeNs+JGpy1BEMDv4L6aM3o6YEFNB9Dqi339KiOdvylyEP
	 4lhAlzYQrqCQqA5HQWTlP6pARoNquRwa2VG+tyWQGj4HJrtb/YfoGD2DM0DUAFBLLc
	 c5FTRMKY1OFvg==
Date: Mon, 26 Feb 2024 11:12:05 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Martin Jansa <martin.jansa@gmail.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] tests/*/Makefile: make sure group.list DIRT exists
 before install
Message-ID: <20240226191205.GT6188@frogsfrogsfrogs>
References: <20240208225241.644701-1-martin.jansa@gmail.com>
 <20240225163042.rrb6djrhbs6e2fk5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CA+chaQdFJkmc540nzz0PKJLtXMGg4yCfHYkMZaxCooCZ6PdaLw@mail.gmail.com>
 <20240226165703.GQ6188@frogsfrogsfrogs>
 <CA+chaQfpUUBqP_ai_4UPWYBztGvdxAU+V0OfmTKG9t7_nrb1rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+chaQfpUUBqP_ai_4UPWYBztGvdxAU+V0OfmTKG9t7_nrb1rw@mail.gmail.com>

On Mon, Feb 26, 2024 at 06:31:04PM +0100, Martin Jansa wrote:
> On Mon, Feb 26, 2024 at 5:57 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Sun, Feb 25, 2024 at 07:01:48PM +0100, Martin Jansa wrote:
> > > On Sun, Feb 25, 2024 at 5:35 PM Zorro Lang <zlang@redhat.com> wrote:
> > > >
> > > > On Thu, Feb 08, 2024 at 11:52:41PM +0100, Martin Jansa wrote:
> > > > > * sometimes make install was failing with:
> > > > >   cp: cannot stat 'group.list': No such file or directory
> > > > >   and bunch of non-fatal messages:
> > > > >   mv: failed to preserve ownership for 'group.list': Invalid argument
> > > >
> > > > I'm wondering ... isn't that expected?
> > > >
> > > > Why not let "make install" fail directly, if there's not a completed "make" ?
> > > > Isn't that more familiar?
> > >
> > > It might if it fails reliably, but in OpenEmbedded builds where I was
> > > seeing this in some CI builds it failed in about 1% of the builds, which is
> > > enough to make the failure annoying and if this is meant to be expected
> > > behavior than not failing reliably, for context see:
> > > https://git.openembedded.org/meta-openembedded/commit/?id=e8a1c9823b7e55dd2ca7f19a3fd3a05ae676bfe2
> >
> > Aha, that explains the weird language in the commit message about
> > "removing tests/*/group.list" and "adding some sleep" even though the
> > patch doesn't actually do that.
> 
> That's what I was using to reliably trigger the "make install" failure as in:
> https://git.openembedded.org/meta-openembedded-contrib/commit/?h=jansa/master-xfstests-debug&id=d3fecf856850645762a9dcad5160686b2445729d
> 
> > > so here it calls make in do_compile task (defined in autotools-brokensep),
> > > then make install in do_install task and do_install was failing
> > > _sometimes_, and I haven't seen single failure since this change was
> > > applied.
> > >
> > > I'm not very familiar with xfstests, I wasn't even building it
> > > intentionally (it's just part of one CI job which builds everything
> > > available), so I might be missing something.
> >
> > Huh, that looks like the result of make trying to run the 'default' and
> > 'install' targets in parallel because there's no "install: default"
> > clause in the Makefile.
> >
> > Soooo... are you folks using 'make -jXX default install' in your CI
> > system?
> 
> -jXX is used in 2 separate steps (bitbake tasks) which don't run in parallel.
> 
> do_compile tasks runs:
> do_compile() {
>     make -j 70 -l 140
> }
> 
> and only after do_compile is finished do_install task runs:
> do_install() {
>     # otherwise install-sh duplicates DESTDIR prefix
>     export DIST_ROOT="/" DIST_MANIFEST=""
> DESTDIR="/OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/image"
>     make -j 70 -l 140 install
> 
>     unionmount_target_dir=/OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/image/usr/xfstests/unionmount-testsuite
>     install -d $unionmount_target_dir/tests
>     install /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/unionmount-testsuite/tests/*
> -t $unionmount_target_dir/tests
>     install /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/unionmount-testsuite/*.py
> -t $unionmount_target_dir
>     install /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/unionmount-testsuite/run
> -t $unionmount_target_dir
>     install /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/unionmount-testsuite/README
> -t $unionmount_target_dir
> }
> 
> And with this I see 15 calls to buildgrouplist in do_compile and then
> the 2 calls for each of these 15 group.list files again in do_install
> 
> grep GROUP temp/log.do_install temp/log.do_compile | sort | uniq -c
>       1 temp/log.do_compile: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/btrfs/group.list
>       1 temp/log.do_compile: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/ceph/group.list
>       1 temp/log.do_compile: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/cifs/group.list
>       1 temp/log.do_compile: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/ext4/group.list
>       1 temp/log.do_compile: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/f2fs/group.list
>       1 temp/log.do_compile: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/generic/group.list
>       1 temp/log.do_compile: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/nfs/group.list
>       1 temp/log.do_compile: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/ocfs2/group.list
>       1 temp/log.do_compile: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/overlay/group.list
>       1 temp/log.do_compile: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/perf/group.list
>       1 temp/log.do_compile: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/selftest/group.list
>       1 temp/log.do_compile: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/shared/group.list
>       1 temp/log.do_compile: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/tmpfs/group.list
>       1 temp/log.do_compile: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/udf/group.list
>       1 temp/log.do_compile: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/xfs/group.list
> 
>       2 temp/log.do_install: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/btrfs/group.list
>       2 temp/log.do_install: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/ceph/group.list
>       2 temp/log.do_install: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/cifs/group.list
>       2 temp/log.do_install: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/ext4/group.list
>       2 temp/log.do_install: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/f2fs/group.list
>       2 temp/log.do_install: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/generic/group.list
>       2 temp/log.do_install: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/nfs/group.list
>       2 temp/log.do_install: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/ocfs2/group.list
>       2 temp/log.do_install: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/overlay/group.list
>       2 temp/log.do_install: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/perf/group.list
>       2 temp/log.do_install: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/selftest/group.list
>       2 temp/log.do_install: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/shared/group.list
>       2 temp/log.do_install: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/tmpfs/group.list
>       2 temp/log.do_install: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/udf/group.list
>       2 temp/log.do_install: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/xfs/group.list
> 
> I guess for you it doesn't run buildgrouplist again if you run "make
> && make install"?

It does if you run "make && make install", but it doesn't if you 'make
default install'.  The top level Makefile has:

install: default $(addsuffix -install,$(SUBDIRS))

If you run "make -j70 default install" then it'll kick off default
and tests-install.  tests-install starts tests/xfs-install, and now
the parallel make is trying to install tests/xfs/group.list while
default might also be regenerating it.

So yeah, I think this patch is correct,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> Regards,
> 
