Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B5B42378F
	for <fstests@vger.kernel.org>; Mon, 27 Jul 2026 18:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785175648; cv=none; b=mc0h2bGZG3+R3rXm/DF+8aZiEAuG4JaFX4KZs+dVpUZroUvaYQiTWquUgsLU6alSK6FpIf7kNc5+qwAEKU8hLG6vpVVBqDWhXFoVXko8FsWfK/BMjKWR6ms9/X49OELsuat22X+QW8uUmF73Nnd54MTKYMYh5HHwSbR16p3UiyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785175648; c=relaxed/simple;
	bh=a+ihK/d8+Nj3DNaVMJe2a56nZrs6WOIljTHSFJ/ptxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4nBlkz8Ww6k10CmckrZyzq1s+AivrVnNZjk9kGY8Ex9j+va+sfWvzKUcl+jspglE0VOIzITcqY4GySnDv77H1+OzeF1fE+VtsfCJ/2jl01w9DRGhqTpG0/a+niuk6GDbdbvE8Qwc2qP1jzRGIajqSwUnSuKSYEjIUu4i0i8uDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtAI7WSg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtAI7WSg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 577D11F000E9;
	Mon, 27 Jul 2026 18:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785175646;
	bh=iVfIjmVVUEwi+/o0l7VvMaqFeQkJqs6tct5U8RYERa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VtAI7WSgC16uvxGCkYBYfr59+fpoaSSRMKiqxa8kuKirXQrmLPPfZ/9ty9dgL3QXa
	 HU+RckgQFjomAMbtvc2h2thqhsHxoA/PK8zWZayXUhiMNj0avjo1pVBgo6BTr1saRM
	 YgJV7/3NBBRWm4fX2WCb9ykFlAFUv+CViy9vWUUVJBrcgIo22g07eCzht0jPxuQm4C
	 DkmeFB1GIve+69uFRAxq+gktlEtv+IjVm6Gj8prmEx0pbBtmdM1AtqfIXcEcgEr6Hp
	 32LfB/z3Jks5GuXvW9G2yzrxw2437v7zS3xEXiiBKfaJcZ8iSCDQpZSxUI0coD3ZZZ
	 qNOSLlGv2LBZA==
Date: Tue, 28 Jul 2026 02:07:21 +0800
From: Zorro Lang <zlang@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Lukas Herbolt <lukas@herbolt.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests Fix build errors on kernels before v5.1
Message-ID: <amecXWf73m93Vgf0@zlang-mailbox>
Mail-Followup-To: Andrey Albershteyn <aalbersh@redhat.com>, 
	Lukas Herbolt <lukas@herbolt.com>, fstests@vger.kernel.org
References: <20260722052256.2406451-3-lukas@herbolt.com>
 <amCMdrK8EscbPTAp@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amCMdrK8EscbPTAp@aalbersh-thinkpadx1carbongen13.rmtcz.csb>

On Wed, Jul 22, 2026 at 11:35:44AM +0200, Andrey Albershteyn wrote:
> On 2026-07-22 07:22:58, Lukas Herbolt wrote:
> > The FAN_REPORT_FID and fanotify_event_info_fid were introduced
> > in v5.1. Currently there is no check if the kernel supports it
> > making xfstests build to fail on older kernels.
> > 
> > Fixes: 29d120e41c3d ("generic: test fsnotify filesystem error reporting")
> > 
> > Signed-off-by: Lukas Herbolt <lukas@herbolt.com>
> 
> Looks good to me
> Reviewed-by: Andrey Albershteyn <aalbersh@kernel.org>
> 
> > ---
> >  configure.ac          |  1 +
> >  include/builddefs.in  |  1 +
> >  m4/package_libcdev.m4 | 14 ++++++++++++++
> >  src/Makefile          |  6 +++++-
> >  4 files changed, 21 insertions(+), 1 deletion(-)
> > 
> > diff --git a/configure.ac b/configure.ac
> > index 441f543c6089..feb24ddd8854 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -74,6 +74,7 @@ AC_NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE
> >  AC_HAVE_FICLONE
> >  AC_HAVE_TRIVIAL_AUTO_VAR_INIT
> >  AC_HAVE_FILE_GETATTR
> > +AC_HAVE_FANOTIFY_FID
> >  
> >  AC_CHECK_FUNCS([renameat2])
> >  AC_CHECK_FUNCS([reallocarray])
> > diff --git a/include/builddefs.in b/include/builddefs.in
> > index 708d75b24d76..8e9e2e3b4113 100644
> > --- a/include/builddefs.in
> > +++ b/include/builddefs.in
> > @@ -75,6 +75,7 @@ HAVE_RLIMIT_NOFILE = @have_rlimit_nofile@
> >  NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE = @need_internal_xfs_ioc_exchange_range@
> >  HAVE_FICLONE = @have_ficlone@
> >  HAVE_FILE_GETATTR = @have_file_getattr@
> > +HAVE_FANOTIFY_FID = @have_fanotify_fid@
> >  
> >  GCCFLAGS = -std=gnu11 -funsigned-char -fno-strict-aliasing -Wall
> >  SANITIZER_CFLAGS += @autovar_init_cflags@
> > diff --git a/m4/package_libcdev.m4 b/m4/package_libcdev.m4
> > index 17f57f427410..340cdad3faf9 100644
> > --- a/m4/package_libcdev.m4
> > +++ b/m4/package_libcdev.m4
> > @@ -102,3 +102,17 @@ AC_DEFUN([AC_HAVE_FILE_GETATTR],
> >         AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
> >      AC_SUBST(have_file_getattr)
> >    ])
> > +
> > +# Check if we have fanotify FID support (Linux 5.1+)
> > +AC_DEFUN([AC_HAVE_FANOTIFY_FID],
> > +  [ AC_MSG_CHECKING([for fanotify FID support])
> > +    AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
> > +#include <sys/fanotify.h>
> > +    ]], [[
> > +       int x = FAN_REPORT_FID;
> > +       struct fanotify_event_info_fid fid;
> > +       (void)x; (void)fid;
> > +    ]])],[have_fanotify_fid=yes
> > +       AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
> > +    AC_SUBST(have_fanotify_fid)
> > +  ])
> > diff --git a/src/Makefile b/src/Makefile
> > index 31ac43b215e9..847fb168181e 100644
> > --- a/src/Makefile
> > +++ b/src/Makefile
> > @@ -36,7 +36,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
> >  	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
> >  	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
> >  	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault min_dio_alignment \
> > -	rw_hint fs-monitor
> > +	rw_hint
> >  
> >  EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
> >  	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
> > @@ -107,6 +107,10 @@ ifeq ($(HAVE_FICLONE),yes)
> >       TARGETS += t_reflink_read_race
> >  endif
> >  
> > +ifeq ($(HAVE_FANOTIFY_FID),yes)
> > +     TARGETS += fs-monitor
> ...
> >       LINUX_TARGETS += t_btrfs_received_uuid_ioctl
> 
> hah just noticed that fstests "supports" different targets (darwin,
> freebsd), not sure if it works at all

As far as I know, fstests is currently a Linux filesystem testing suite. I don't
recall us ever being asked to support FreeBSD or other operating systems, though
I'm not sure if anyone is actually using it that way :)

> 
> -- 
> - Andrey
> 
