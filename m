Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4E912C7E6
	for <fstests@vger.kernel.org>; Mon, 26 Feb 2024 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708968683; cv=none; b=TlCT0i57mljO3XuEB19ZQML+nnf8oBKKXoHtbzAR1IbSCOoSc7NUkylB5BcOgrH8MswCam4Y752GcUgw+jLkvVlwxd7HZy656RAs7mRqa7k+caUKKgrXa+34St5BAdo0bH5VWHkWx6SEWnIaM5uPehqscSFaEwBJap2CkDoSE4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708968683; c=relaxed/simple;
	bh=06JVXG2jR3o1KOouxnTrRYD00f77wIVsTjln3OjDKxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vj51iSrtU1FBC9R4c/+J0oqjFnO7AqdomFOBJU9yf8GnsGkeFJpDtTA3XkaxxIcWascqcLHGmuo29cJ3gjoTQTA5YUhxW1F8SxZkhfCte4zc+CC0+mgWZSSz2F0KSHWIwkfLPSAqIBzcw8kUUecdfadRCUlKjMzIUhMpggLsETg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YczbGVxk; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YczbGVxk"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33dc3fe739aso1119189f8f.0
        for <fstests@vger.kernel.org>; Mon, 26 Feb 2024 09:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708968680; x=1709573480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVyFhGqUUhrLiwfqw9wuyUj+wVOapmV81Uu5cR8faB0=;
        b=YczbGVxkyJ7QUW150lDXKSsEUhqYw26YUmLO/INV58nv7URA3f3ymOaHCqwsMI813Q
         13cGaFQtls4FWv4mlAQt3CcL1SFD+M3b6s4x8OXwPfCIL1O8B7q7ulf+0i4iQwxX+VHm
         BiZ+ZezoQz5vvjjMQWMTkXHmYuMz7eVi96we6xeaOZ8ZKActBUcHq9QE+LHhp7koUmtq
         4QI9Ip0bnEzNuc5NEPk5FrHxPYLZH8t0DadZmmoFl96fziqgbbvTodnJGoYpSOLi/xKT
         qfbpfzOs5atNKFRlSI24+a/czPZO0KUUBMzOg4gXH7KCYwY2yuOXv8CLbLS9bSIf1Eb8
         IS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708968680; x=1709573480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tVyFhGqUUhrLiwfqw9wuyUj+wVOapmV81Uu5cR8faB0=;
        b=pQnbtoo7/oB98aWUoa5RrbOpMD6HnIMzRajNySkAhOJvNdt+ApkJqTLK8zXN7YN8NY
         TOq8WrRn4ZMa5PbvtxFbVXSlaDBWpOQrXunbbgKvUuXMmo//Q4WHgCxTg21Q6GooWkrt
         xZSLVi+jGQgKJs8UsfwFxYa+7+p/GscENk8sGpMqTSuPOCjJ1MQGijsCTcMrQ6jnpRz2
         BP3Lug4zAp7AtI4azkC6B36ft0BBFww/+hVNAHrKVlqFr3mjAwFEyBBlsDCXdglx0GcA
         HZ1JqGzy0STTKMsJot18qAB9bRfoxbJHDl+EvX/BYp5oIbYK7b3tyWDsLkAvGK9epNKd
         +KKA==
X-Forwarded-Encrypted: i=1; AJvYcCWLMFDWBjzpxtUy0gpTdIaojkC2DZM5B/sQuKnRSl6+/5UZSXMKB/BQaOQCI+sZ4otLlKhql9R6pujzskcKxlKaqCu015tBOA==
X-Gm-Message-State: AOJu0Yz1SFGSqSozhMOwM/SQ2V6p439LQxHJ2+tzBdNI50L34BCXxCs3
	sSpFjBlmh7rzQ2f7dX6oTciTbZ/t5rzJuVhUn2IwLQ6rPzD1OIqXYiHOG6f27X2zHwFILXpzJY7
	Uo5oiuV8pAXLoLn3yDmyhy+SxrnA=
X-Google-Smtp-Source: AGHT+IHjHnVmpvAqFPzvuvU8S1VKUs5op9NcYFqQGr9Tept4oWGwQlD+/XbMY1n9415JqC2Cxr0VVeRHFkvkehhcEvM=
X-Received: by 2002:a5d:69ce:0:b0:33d:68df:71c0 with SMTP id
 s14-20020a5d69ce000000b0033d68df71c0mr6857165wrw.26.1708968680047; Mon, 26
 Feb 2024 09:31:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208225241.644701-1-martin.jansa@gmail.com>
 <20240225163042.rrb6djrhbs6e2fk5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CA+chaQdFJkmc540nzz0PKJLtXMGg4yCfHYkMZaxCooCZ6PdaLw@mail.gmail.com> <20240226165703.GQ6188@frogsfrogsfrogs>
In-Reply-To: <20240226165703.GQ6188@frogsfrogsfrogs>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Mon, 26 Feb 2024 18:31:04 +0100
Message-ID: <CA+chaQfpUUBqP_ai_4UPWYBztGvdxAU+V0OfmTKG9t7_nrb1rw@mail.gmail.com>
Subject: Re: [PATCH] tests/*/Makefile: make sure group.list DIRT exists before install
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 5:57=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Sun, Feb 25, 2024 at 07:01:48PM +0100, Martin Jansa wrote:
> > On Sun, Feb 25, 2024 at 5:35=E2=80=AFPM Zorro Lang <zlang@redhat.com> w=
rote:
> > >
> > > On Thu, Feb 08, 2024 at 11:52:41PM +0100, Martin Jansa wrote:
> > > > * sometimes make install was failing with:
> > > >   cp: cannot stat 'group.list': No such file or directory
> > > >   and bunch of non-fatal messages:
> > > >   mv: failed to preserve ownership for 'group.list': Invalid argume=
nt
> > >
> > > I'm wondering ... isn't that expected?
> > >
> > > Why not let "make install" fail directly, if there's not a completed =
"make" ?
> > > Isn't that more familiar?
> >
> > It might if it fails reliably, but in OpenEmbedded builds where I was
> > seeing this in some CI builds it failed in about 1% of the builds, whic=
h is
> > enough to make the failure annoying and if this is meant to be expected
> > behavior than not failing reliably, for context see:
> > https://git.openembedded.org/meta-openembedded/commit/?id=3De8a1c9823b7=
e55dd2ca7f19a3fd3a05ae676bfe2
>
> Aha, that explains the weird language in the commit message about
> "removing tests/*/group.list" and "adding some sleep" even though the
> patch doesn't actually do that.

That's what I was using to reliably trigger the "make install" failure as i=
n:
https://git.openembedded.org/meta-openembedded-contrib/commit/?h=3Djansa/ma=
ster-xfstests-debug&id=3Dd3fecf856850645762a9dcad5160686b2445729d

> > so here it calls make in do_compile task (defined in autotools-brokense=
p),
> > then make install in do_install task and do_install was failing
> > _sometimes_, and I haven't seen single failure since this change was
> > applied.
> >
> > I'm not very familiar with xfstests, I wasn't even building it
> > intentionally (it's just part of one CI job which builds everything
> > available), so I might be missing something.
>
> Huh, that looks like the result of make trying to run the 'default' and
> 'install' targets in parallel because there's no "install: default"
> clause in the Makefile.
>
> Soooo... are you folks using 'make -jXX default install' in your CI
> system?

-jXX is used in 2 separate steps (bitbake tasks) which don't run in paralle=
l.

do_compile tasks runs:
do_compile() {
    make -j 70 -l 140
}

and only after do_compile is finished do_install task runs:
do_install() {
    # otherwise install-sh duplicates DESTDIR prefix
    export DIST_ROOT=3D"/" DIST_MANIFEST=3D""
DESTDIR=3D"/OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024=
.01.14/image"
    make -j 70 -l 140 install

    unionmount_target_dir=3D/OE/build/oe-core/tmp-glibc/work/core2-64-oe-li=
nux/xfstests/2024.01.14/image/usr/xfstests/unionmount-testsuite
    install -d $unionmount_target_dir/tests
    install /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/202=
4.01.14/unionmount-testsuite/tests/*
-t $unionmount_target_dir/tests
    install /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/202=
4.01.14/unionmount-testsuite/*.py
-t $unionmount_target_dir
    install /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/202=
4.01.14/unionmount-testsuite/run
-t $unionmount_target_dir
    install /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/202=
4.01.14/unionmount-testsuite/README
-t $unionmount_target_dir
}

And with this I see 15 calls to buildgrouplist in do_compile and then
the 2 calls for each of these 15 group.list files again in do_install

grep GROUP temp/log.do_install temp/log.do_compile | sort | uniq -c
      1 temp/log.do_compile: [GROUP]
/OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/=
tests/btrfs/group.list
      1 temp/log.do_compile: [GROUP]
/OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/=
tests/ceph/group.list
      1 temp/log.do_compile: [GROUP]
/OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/=
tests/cifs/group.list
      1 temp/log.do_compile: [GROUP]
/OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/=
tests/ext4/group.list
      1 temp/log.do_compile: [GROUP]
/OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/=
tests/f2fs/group.list
      1 temp/log.do_compile: [GROUP]
/OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/=
tests/generic/group.list
      1 temp/log.do_compile: [GROUP]
/OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/=
tests/nfs/group.list
      1 temp/log.do_compile: [GROUP]
/OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/=
tests/ocfs2/group.list
      1 temp/log.do_compile: [GROUP]
/OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/=
tests/overlay/group.list
      1 temp/log.do_compile: [GROUP]
/OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/=
tests/perf/group.list
      1 temp/log.do_compile: [GROUP]
/OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/=
tests/selftest/group.list
      1 temp/log.do_compile: [GROUP]
/OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/=
tests/shared/group.list
      1 temp/log.do_compile: [GROUP]
/OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/=
tests/tmpfs/group.list
      1 temp/log.do_compile: [GROUP]
/OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/=
tests/udf/group.list
      1 temp/log.do_compile: [GROUP]
/OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/=
tests/xfs/group.list

      2 temp/log.do_install: [GROUP]
/OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/=
tests/btrfs/group.list
      2 temp/log.do_install: [GROUP]
/OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/=
tests/ceph/group.list
      2 temp/log.do_install: [GROUP]
/OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/=
tests/cifs/group.list
      2 temp/log.do_install: [GROUP]
/OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/=
tests/ext4/group.list
      2 temp/log.do_install: [GROUP]
/OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/=
tests/f2fs/group.list
      2 temp/log.do_install: [GROUP]
/OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/=
tests/generic/group.list
      2 temp/log.do_install: [GROUP]
/OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/=
tests/nfs/group.list
      2 temp/log.do_install: [GROUP]
/OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/=
tests/ocfs2/group.list
      2 temp/log.do_install: [GROUP]
/OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/=
tests/overlay/group.list
      2 temp/log.do_install: [GROUP]
/OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/=
tests/perf/group.list
      2 temp/log.do_install: [GROUP]
/OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/=
tests/selftest/group.list
      2 temp/log.do_install: [GROUP]
/OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/=
tests/shared/group.list
      2 temp/log.do_install: [GROUP]
/OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/=
tests/tmpfs/group.list
      2 temp/log.do_install: [GROUP]
/OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/=
tests/udf/group.list
      2 temp/log.do_install: [GROUP]
/OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/=
tests/xfs/group.list

I guess for you it doesn't run buildgrouplist again if you run "make
&& make install"?

Regards,
