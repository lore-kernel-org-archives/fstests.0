Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699936;
	b=bmvL2w2YUaXfJJtVVPs0n0IiN5LgdB13Wh7wJqwvSDbMbGOfsrwvFdFKBY6pdurLU4dW
	 Z6rEJLGrVc0TP+2Aeom8BY+ybQJPpuAIqxOXd2mSiVWtM1HfCQ0fCpBZlpIYudZvuFlEP
	 07CJSWTWtAQvnZ+TuW9G466t2JbBQt6dB3pGuyzZoQPGEEbNAG/6aZsB62gWaw9CJZzLY
	 iLnCHgbPz/9AEcLejo3ba2NLyboQnh7FuIzsriQ3TPox5SJBgkHUCNXm/kR8WIflYmana
	 +xcKshie91nsl2/bO9pkyzzaMKqt1bx52yOKjk8qk23x6avhxViBTK1cyRIER+hdw6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699936;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=q3TjgejGnXOKzbcwvOUpi5GPVvFXGxFMZEDAShsb2Ic=;
	b=Sjd591fiGfYbZUgr0neOgKzZkQZnYFjt5hgvEmIprJLJuefy5heG694NMFx0fNYrS/08
	 ZB9EscCWBkJ4CTWG+fGpOFT3JsVz5Zx7AZiRvc4NBALGPXXPHATHOKPVNHr/KRb3YI59x
	 Dnnv1MculLWDxC1icd7/YzSVwSOyiAZWga/N0E6o7uF5dywMu/+nPujATbPdPvT7ZLpgd
	 LnfKXI5rMeUHaKbZXtlaQ2PFux39GS7ahZBvSwnhdohlH6i11z41ot42fV+Zs9L+66D4G
	 44l7rNJLBhX/SguG+EC2V50ph5erTs/+PNtJ+cqR/Aws+UT8mynpJbcaWiGRryAtKVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RxtUe0R8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859B66082BCE
	for <fstests@vger.kernel.org>; Tue,  3 Nov 2026 09:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RxtUe0R8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088E51F000C1;
	Tue,  3 Nov 2026 09:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793699936;
	bh=q3TjgejGnXOKzbcwvOUpi5GPVvFXGxFMZEDAShsb2Ic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RxtUe0R8gxCe4z/6p/eFoUlYGLbv4c/NGX8M6twIlXEV/np9GmQi1gq32kG7ibgJw
	 vtCqYptkKqNd1Mdd7L9jeAB+mh05i2aUs/MIZ8gjVqMUf6RpLbN7zCha7BcyMcz54m
	 mIUjw4hUtZ2HiRU1L/fwa0sGWgIQeEuQF5NmLi74LL1cknKpuDLbs5e7OjyP1mSV7P
	 yEbx9TWdgTypGnUWQDDWkw2xDmwNUwuRasokffF9VGtpWVlDSRcpGMgAfw/6zcPc3q
	 lSTtMm85BNjWRMvp8vJjLy/j1JB4RaMc3yNJetP7jPaYiEyHURZQZxHFEKqA8UpnDJ
	 Ch0Wf2BNscauw==
Date: Tue, 3 Nov 2026 17:58:51 +0800
From: Zorro Lang <zlang@kernel.org>
To: Lukas Herbolt <lukas@herbolt.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] xfstests: Unify the build targets under LINUX_TARGET
Message-ID: <aumwQYIhy5YFXrWH@zlang-mailbox>
Mail-Followup-To: Lukas Herbolt <lukas@herbolt.com>, 
	fstests@vger.kernel.org
References: <20261006103937.276181-3-lukas@herbolt.com>
 <aug5aYetKZ46O-J4@zlang-mailbox>
 <2e84237f24e9c4a5c10d2c129c300b1e@herbolt.com>
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e84237f24e9c4a5c10d2c129c300b1e@herbolt.com>

On Mon, Nov 02, 2026 at 11:01:41AM +0100, Lukas Herbolt wrote:
> On 2026-11-02 08:25, Zorro Lang wrote:
> > On Tue, Oct 06, 2026 at 12:39:39PM +0200, Lukas Herbolt wrote:
> > > As discussed previously, the only supported target for now
> > > is LINUX_TARGET. Merging the TARGET into LINUX_TARGET and
> > > fix indentation in the Makefile.
> > > 
> > > Signed-off-by: Lukas Herbolt <lukas@herbolt.com>
> > > ---
> > >  src/Makefile | 55
> > > ++++++++++++++++++++++++++--------------------------
> > >  1 file changed, 28 insertions(+), 27 deletions(-)
> > > 
> > > diff --git a/src/Makefile b/src/Makefile
> > > index 0ff607ae1593..1f7f9fd61987 100644
> > > --- a/src/Makefile
> > > +++ b/src/Makefile
> > > @@ -6,7 +6,9 @@
> > >  TOPDIR = ..
> > >  include $(TOPDIR)/include/builddefs
> > > 
> > > -TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
> > > +TARGETS =
> > > +
> > > +LINUX_TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
> > 
> > Since Linux is the only supported platform now, why not just use TARGETS
> > directly?
> > 
> > Thanks,
> > Zorro
> I wanted to keep it separate for possible future users.

OK, either works for me, I don't really have a preference.

Reviewed-by: Zorro Lang <zlang@kernel.org>

> 
> Lukas
> 
> > 
> > >  	nametest permname randholes runas truncfile usemem \
> > >  	mmapcat append_reader append_writer dirperf metaperf \
> > >  	devzero feature alloc fault fstest t_access_root \
> > > @@ -21,9 +23,8 @@ TARGETS = dirstress fill fill2 getpagesize holes
> > > lstat64 \
> > >  	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
> > >  	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault
> > > rewinddir-test \
> > >  	readdir-while-renames dio-append-buf-fault dio-write-fsync-same-fd \
> > > -	dio-writeback-race unlink-fsync truncate dio-read-into-mmap
> > > -
> > > -LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize
> > > preallo_rw_pattern_reader \
> > > +	dio-writeback-race unlink-fsync truncate dio-read-into-mmap \
> > > +	xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
> > >  	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> > >  	locktest unwritten_mmap bulkstat_unlink_test deduperace \
> > >  	bulkstat_unlink_test_modified t_dir_offset t_futimens t_immutable \
> > > @@ -48,68 +49,64 @@ SUBDIRS = log-writes perf
> > >  LLDLIBS = $(LIBHANDLE) $(LIBACL) -lpthread -lrt -luuid
> > > 
> > >  ifeq ($(HAVE_XLOG_ASSIGN_LSN), true)
> > > -LINUX_TARGETS += loggen
> > > +    LINUX_TARGETS += loggen
> > >  endif
> > > 
> > >  ifeq ($(HAVE_FIEMAP), true)
> > > -LINUX_TARGETS += fiemap-tester t_stripealign
> > > +    LINUX_TARGETS += fiemap-tester t_stripealign
> > >  endif
> > > 
> > >  ifeq ($(HAVE_OPEN_BY_HANDLE_AT), true)
> > > -LINUX_TARGETS += open_by_handle
> > > +    LINUX_TARGETS += open_by_handle
> > >  endif
> > > 
> > >  ifeq ($(HAVE_FALLOCATE), true)
> > > -LCFLAGS += -DHAVE_FALLOCATE
> > > +    LCFLAGS += -DHAVE_FALLOCATE
> > >  endif
> > > 
> > >  ifeq ($(HAVE_FILE_GETATTR), yes)
> > > -LINUX_TARGETS += file_attr
> > > -LCFLAGS += -DHAVE_FILE_GETATTR
> > > -endif
> > > -
> > > -ifeq ($(PKG_PLATFORM),linux)
> > > -TARGETS += $(LINUX_TARGETS)
> > > +    LINUX_TARGETS += file_attr
> > > +    LCFLAGS += -DHAVE_FILE_GETATTR
> > >  endif
> > > 
> > >  ifeq ($(HAVE_DB), true)
> > > -TARGETS += dbtest
> > > -LLDLIBS += $(LIBGDBM)
> > > +    TARGETS += dbtest
> > > +    LLDLIBS += $(LIBGDBM)
> > >  endif
> > > 
> > >  ifeq ($(HAVE_AIO), true)
> > > -TARGETS += t_mmap_dio
> > > -SUBDIRS += aio-dio-regress
> > > -LLDLIBS += -laio
> > > +    LINUX_TARGETS += t_mmap_dio
> > > +    SUBDIRS += aio-dio-regress
> > > +    LLDLIBS += -laio
> > >  endif
> > > 
> > >  ifeq ($(HAVE_URING), true)
> > > -LINUX_TARGETS += btrfs_encoded_read btrfs_encoded_write
> > > -TARGETS += uring_read_fault
> > > -LLDLIBS += -luring
> > > +    LINUX_TARGETS += btrfs_encoded_read btrfs_encoded_write \
> > > +		     uring_read_fault
> > > +    LLDLIBS += -luring
> > >  endif
> > > 
> > >  SUBDIRS += vfs
> > >  ifeq ($(HAVE_LIBCAP), true)
> > > -LLDLIBS += -lcap
> > > +    LLDLIBS += -lcap
> > >  endif
> > > 
> > >  ifeq ($(HAVE_SEEK_DATA), yes)
> > >   ifeq ($(HAVE_NFTW), yes)
> > >    ifeq ($(HAVE_BMV_OF_SHARED), yes)
> > >     ifeq ($(HAVE_RLIMIT_NOFILE), yes)
> > > -     TARGETS += xfsfind
> > > +     LINUX_TARGETS += xfsfind
> > >     endif
> > >    endif
> > >   endif
> > >  endif
> > > 
> > >  ifeq ($(HAVE_FICLONE),yes)
> > > -     TARGETS += t_reflink_read_race
> > > +     LINUX_TARGETS += t_reflink_read_race
> > >  endif
> > > 
> > >  ifeq ($(HAVE_FANOTIFY_FID),yes)
> > > -     TARGETS += fs-monitor
> > > +     LINUX_TARGETS += fs-monitor
> > >  endif
> > > 
> > >  ifeq ($(HAVE_LIBBTRFSUTIL), true)
> > > @@ -117,7 +114,11 @@ ifeq ($(HAVE_LIBBTRFSUTIL), true)
> > >  endif
> > > 
> > >  ifeq ($(NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE),yes)
> > > -LCFLAGS += -DNEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE
> > > +     LCFLAGS += -DNEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE
> > > +endif
> > > +
> > > +ifeq ($(PKG_PLATFORM),linux)
> > > +     TARGETS += $(LINUX_TARGETS)
> > >  endif
> > > 
> > >  CFILES = $(TARGETS:=.c)
> > > --
> > > 2.55.0
> > > 
> 
> -- 
> -lhe
> 
