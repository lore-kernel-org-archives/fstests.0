Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4D32931EE;
	Mon, 12 Oct 2026 14:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816178; cv=none; b=apNM5ZXcD7rnM2hhFINrjI47UdjEkG29do16/9Be/hJz4HaGaLcHJYXWhHnf617XLZcmVlUN4bwH0xF/kMzqDy/tacVFhVWAwlYULXted1m1+EMJY78xvReB8TuG8UgrQMgpqXuQrEdIp/4SxuXc3UyNT1inWuQ4c6uHhD28utU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816178; c=relaxed/simple;
	bh=KVbEiWwysjQWusF2JU6OhD088LERiyV/zZ7cuOz3Tgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfoXDJ+hP33M6MmQHxyMO6BjX109FDLRK9dWx43KWkeZoPJUMiAsqyk7f0IpEGlG9x0hUhTjvXCoCN+KcNrhXuxOmf1En55UrDakqo7LyKmAQJ7gqKFigE31sXLc0LnsQAJtpzjtKycqnFsaOArxzLaZ/Yi35DQ3s0fFxb3Czgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEAlM/Kj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEAlM/Kj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9691C1F0089B;
	Mon, 12 Oct 2026 14:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791816177;
	bh=BgN6ieNRJXO4xtx7ABVudda8hNvF/8BKfaVLG1zDr3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gEAlM/KjYJx+bBGK0OyFfJO+0y3QxZPEQI2No4uczdH/VRkHfE2mZcDcI5CMmWfeU
	 Jx5umRIpYVc7tfq+JiLot/FjzLFslzPW+auESrETVhGUt1XVcRDN+kRTJduqOIIHdh
	 MAjY16ounm7uLN29ZQ226RRugD18T1QLAkR1icoRjt4Z/BVkbPr7fs6vlS0fs9r533
	 vICNU4CC2BaWmdNE7wjH4w8fpWsHSciDWvQ7q9yU4WMXgw2/ug8DmkMaGxhUafg/92
	 Sch53pS0SMHN+zsmoGYoyNJlvm4msSVmVSL3/ncwvAmYSQwz3Epou1mB7W/OnEeeZB
	 lAwB6nYO2uaZg==
Date: Mon, 12 Oct 2026 22:42:50 +0800
From: Zorro Lang <zlang@kernel.org>
To: Lukas Herbolt <lukas@herbolt.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] src/locktest.c: fix build failure of struct delegation
Message-ID: <aszxpKDR3-Ktb0dE@zlang-mailbox>
Mail-Followup-To: Lukas Herbolt <lukas@herbolt.com>, 
	fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20260813150846.280498-1-zlang@kernel.org>
 <aqaxjGZ6rSR1mZCf@zlang-mailbox>
 <dabaefbef09950a167e315b05c6c2fe7@herbolt.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dabaefbef09950a167e315b05c6c2fe7@herbolt.com>

On Wed, Oct 07, 2026 at 07:30:12PM +0200, Lukas Herbolt wrote:
> On 2026-09-13 16:29, Zorro Lang wrote:
> > On Thu, Aug 13, 2026 at 11:08:46PM +0800, Zorro Lang wrote:
> > > Since glibc commit f2e3dacbff88 ("Add new constants from Linux 6.12,
> > > 6.18 and 6.19 to bits/fcntl-linux.h"), the F_GETDELEG and F_SETDELEG
> > > constants from Linux 6.19 have been added directly into <fcntl.h>.
> > > However, the corresponding full definition for 'struct delegation'
> > > was not included in glibc's userspace wrapper. That causes below
> > > build error:
> > > 
> > >  locktest.c:1065:16: error: variable 'deleg' has initializer but
> > > incomplete type
> > >   1065 |         struct delegation deleg = { .d_type = F_UNLCK };
> > >  ...
> > > 
> > > Fix this by isolating the definition of 'struct delegation' from the
> > > command macros via autoconf capability probing:
> > > 
> > > 1. Add an AC_CHECK_TYPES check for 'struct delegation' in
> > > configure.ac.
> > > 2. In locktest.c, unbind 'struct delegation' from the '#ifndef
> > > F_GETDELEG'
> > >    guard and wrap it with '#ifndef HAVE_STRUCT_DELEGATION' instead.
> > > 
> > > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > > ---
> > > 
> > > Hi,
> > > 
> > > fstests currently fails to build against the latest glibc, with the
> > > root
> > > cause detailed in the commit log above.
> > > 
> > > The glibc now defines F_GETDELEG and F_SETDELEG, but leaves out the
> > > actual
> > > 'struct delegation' definition. The complete struct is available in
> > > <linux/fcntl.h>,
> > > but we cannot simply include both <fcntl.h> and <linux/fcntl.h> due
> > > to nasty
> > > namespace redefinition conflicts.
> > > 
> > > I am not entirely sure if glibc will bring in 'struct delegation',
> > > so for now,
> > > I chose to decouple and handle the structure definition
> > > independently via
> > > autoconf.
> > > 
> > > Any thoughts or better suggestions on how we should handle this
> > > transition?
> > 
> > Friendly ping...
> > 
> > Am I the only one seeing this? Without this patch, xfstests won't
> > compile on
> > the latest Fedora：
> >   glibc-devel-2.44.9000-1.fc46.x86_64
> >   gcc-16.2.1-2.fc46.x86_64
> > 
> > I keep running into the build error below [1].
> > 
> > Thanks,
> > Zorro
> > 
> > [1]
> > locktest.c: In function 'initialize':
> > locktest.c:1018:17: warning: variable 'offset' set but not used
> > [-Wunused-but-set-variable=]
> >  1018 |     int         offset = 0;
> >       |                 ^~~~~~
> > locktest.c: In function 'release_lease':
> > locktest.c:1065:16: error: variable 'deleg' has initializer but
> > incomplete type
> >  1065 |         struct delegation deleg = { .d_type = F_UNLCK };
> >       |                ^~~~~~~~~~
> > locktest.c:1065:38: error: 'struct delegation' has no member named
> > 'd_type'
> >  1065 |         struct delegation deleg = { .d_type = F_UNLCK };
> >       |                                      ^~~~~~
> > locktest.c:1065:47: warning: excess elements in struct initializer
> >  1065 |         struct delegation deleg = { .d_type = F_UNLCK };
> >       |                                               ^~~~~~~
> > locktest.c:1065:47: note: (near initialization for 'deleg')
> > locktest.c:1065:27: error: storage size of 'deleg' isn't known
> >  1065 |         struct delegation deleg = { .d_type = F_UNLCK };
> >       |                           ^~~~~
> > locktest.c:1065:27: warning: unused variable 'deleg' [-Wunused-variable]
> > locktest.c: In function 'do_deleg':
> > locktest.c:1365:12: error: variable 'deleg' has initializer but
> > incomplete type
> >  1365 |     struct delegation deleg = { .d_type = arg };
> >       |            ^~~~~~~~~~
> > locktest.c:1365:34: error: 'struct delegation' has no member named
> > 'd_type'
> >  1365 |     struct delegation deleg = { .d_type = arg };
> >       |                                  ^~~~~~
> > locktest.c:1365:43: warning: excess elements in struct initializer
> >  1365 |     struct delegation deleg = { .d_type = arg };
> >       |                                           ^~~
> > locktest.c:1365:43: note: (near initialization for 'deleg')
> > locktest.c:1365:23: error: storage size of 'deleg' isn't known
> >  1365 |     struct delegation deleg = { .d_type = arg };
> >       |                       ^~~~~
> > locktest.c:1365:23: warning: unused variable 'deleg' [-Wunused-variable]
> > locktest.c: In function 'main':
> > locktest.c:1615:16: error: variable 'deleg' has initializer but
> > incomplete type
> >  1615 |         struct delegation deleg = { .d_type = F_UNLCK };
> >       |                ^~~~~~~~~~
> > locktest.c:1615:38: error: 'struct delegation' has no member named
> > 'd_type'
> >  1615 |         struct delegation deleg = { .d_type = F_UNLCK };
> >       |                                      ^~~~~~
> > locktest.c:1615:47: warning: excess elements in struct initializer
> >  1615 |         struct delegation deleg = { .d_type = F_UNLCK };
> >       |                                               ^~~~~~~
> > locktest.c:1615:47: note: (near initialization for 'deleg')
> > locktest.c:1615:27: error: storage size of 'deleg' isn't known
> >  1615 |         struct delegation deleg = { .d_type = F_UNLCK };
> >       |                           ^~~~~
> > locktest.c:1615:27: warning: unused variable 'deleg' [-Wunused-variable]
> >     [CC]    chprojid_fail
> >     [CC]    detached_mounts_propagation
> > gmake[2]: *** [Makefile:139: locktest] Error 1
> > gmake[2]: *** Waiting for unfinished jobs....
> > gmake[1]: *** [include/buildrules:30: src] Error 2
> > make: *** [Makefile:65: default] Error 2
> > 
> > > 
> > > Thanks,
> > > Zorro
> > > 
> > >  configure.ac   | 4 ++++
> > >  src/locktest.c | 2 ++
> > >  2 files changed, 6 insertions(+)
> > > 
> > > diff --git a/configure.ac b/configure.ac
> > > index feb24ddd..6d7ff3ba 100644
> > > --- a/configure.ac
> > > +++ b/configure.ac
> > > @@ -111,6 +111,10 @@ AC_CHECK_TYPES([struct
> > > btrfs_ioctl_received_subvol_args], [], [], [[
> > >  #include <stddef.h>
> > >  #include <linux/btrfs.h>
> > >  ]])
> > > +AC_CHECK_TYPES([struct delegation], [], [], [[
> > > +#include <stddef.h>
> > > +#include <fcntl.h>
> > > +]])
> > >  AC_CHECK_HEADERS([linux/btrfs.h linux/btrfs_tree.h])
> > >  AC_CHECK_MEMBERS([struct btrfs_ioctl_vol_args_v2.subvolid], [], [],
> > > [[
> > >  #include <stddef.h>
> > > diff --git a/src/locktest.c b/src/locktest.c
> > > index 54ee1f07..d0264c94 100644
> > > --- a/src/locktest.c
> > > +++ b/src/locktest.c
> > > @@ -80,7 +80,9 @@ extern int h_errno;
> > >  #ifndef F_GETDELEG
> > >  #define F_GETDELEG	(1024 + 15)
> > >  #define F_SETDELEG	(1024 + 16)
> > > +#endif
> > > 
> > > +#ifndef HAVE_STRUCT_DELEGATION
> > >  struct delegation {
> > >  	uint32_t d_flags;
> > >  	uint16_t d_type;
> > > --
> > > 2.55.0
> > > 
> > > 
> 
> Hit the same on fedora-rawhide looks good to me.
> Reviewed-by: "Lukas Herbolt" <lukas@herbolt.com>

Thanks! I finally don't have to keep rebasing this patch locally :)

> 
> -- 
> -lhe
> 
