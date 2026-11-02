Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604326;
	b=DMjRRdOvBfxCrw3EaKsT4QDiQcUajvNZIrDPwayKS+s6OMIA3h/EB+cutpBsmnhd5Foa
	 qZRSZDx+oBVXJW/OCaXr258zp2E+E8wtTpp4T6ELLYYGW90+REAVy5iH8E9SiAlcFakxb
	 GJUowUubAhe9Oaebm4SWRMq4ntXfrY38utdxdpMMDx2YaXzGjE4WbZUw7R1fW0wPOAq9e
	 j/1rfzeGDi8Uk5vxZV+URlIDD5fSHzA02LMiO4+C2wzniaCLQuifVZSbIOAPMQ2v3BEFs
	 8z0I90KJ65S6ERB8Prrvfbnajug86yMaEwTqEnc1CZlIG8Ba10EH0bHflqaqCAL9Uxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604326;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=NbA0kDNqPiXckhs8noTGcFxFWOPxzuhpHlR/zDjIdW8=;
	b=c2e2C8KXLfkp4hxi+sO6SRWDy5VMAykCyKyFAR+kKDN62JJDwmhqmvYzt/V9WmT36UZN
	 v7AF//dx3r8i7qg7D1C3t8Vo0njS6MClC51WceLco/2D3hNDiJQekjFwjE5McInMCjbzQ
	 bjHQH5k5ReRoWvfWmWkqkL3+0hB9pvLtCoCW8q1x+Ej/XTWqKCWx7UGH8tIqZkeMI5g2P
	 NimL/olIPE5i9M2bs3VUcRBR+wPslVi0XQjv1pHNQiYE/4kX2XKmon1rmx32kxRVuPpn2
	 o1PLJFmSHJYLZJMRtZamvco0lNGjJ9V71TD0uCYh5q/3UyUnhd63u9Tyivc09NL+VxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=daKOCbM1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D223606A326
	for <fstests@vger.kernel.org>; Mon,  2 Nov 2026 07:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=daKOCbM1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DAE1F00919;
	Mon,  2 Nov 2026 07:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793604326;
	bh=NbA0kDNqPiXckhs8noTGcFxFWOPxzuhpHlR/zDjIdW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=daKOCbM1JaOkwJDfLnrle6KVatAiWXPbt1zCvugSvlvPojRLlSUP4DSwDgYN9shUo
	 hPAic/CPwJPBuEAS8ahI2MJ45m+lgFmrwv9/h5u+eugjLq5TZe/q0P/yXRhZdlNPdx
	 2AxE3Y2Z5KKaUCwq7OBufOD/KzgtHSRllMQxwl/hiHNBHj8jU4euVcPqhd+dh7bllE
	 zC0CqmGQKI2ayt3DsNkRPlNnUGqdPYzmKAgfnIAWGqZhAJyxtmj70DuPR3slkwjVr6
	 Gp85Qna3Wkeamf9/JiTKdxq8itUi6DjBWo4FN/f3CyxWEJGV+bnTXnfPt+L3cmLNm1
	 gJd74aJHiv/Xg==
Date: Mon, 2 Nov 2026 15:25:21 +0800
From: Zorro Lang <zlang@kernel.org>
To: Lukas Herbolt <lukas@herbolt.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] xfstests: Unify the build targets under LINUX_TARGET
Message-ID: <aug5aYetKZ46O-J4@zlang-mailbox>
Mail-Followup-To: Lukas Herbolt <lukas@herbolt.com>, 
	fstests@vger.kernel.org
References: <20261006103937.276181-3-lukas@herbolt.com>
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
In-Reply-To: <20261006103937.276181-3-lukas@herbolt.com>

On Tue, Oct 06, 2026 at 12:39:39PM +0200, Lukas Herbolt wrote:
> As discussed previously, the only supported target for now
> is LINUX_TARGET. Merging the TARGET into LINUX_TARGET and
> fix indentation in the Makefile.
> 
> Signed-off-by: Lukas Herbolt <lukas@herbolt.com>
> ---
>  src/Makefile | 55 ++++++++++++++++++++++++++--------------------------
>  1 file changed, 28 insertions(+), 27 deletions(-)
> 
> diff --git a/src/Makefile b/src/Makefile
> index 0ff607ae1593..1f7f9fd61987 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -6,7 +6,9 @@
>  TOPDIR = ..
>  include $(TOPDIR)/include/builddefs
>  
> -TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
> +TARGETS =
> +
> +LINUX_TARGETS = dirstress fill fill2 getpagesize holes lstat64 \

Since Linux is the only supported platform now, why not just use TARGETS
directly?

Thanks,
Zorro

>  	nametest permname randholes runas truncfile usemem \
>  	mmapcat append_reader append_writer dirperf metaperf \
>  	devzero feature alloc fault fstest t_access_root \
> @@ -21,9 +23,8 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
>  	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
>  	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test \
>  	readdir-while-renames dio-append-buf-fault dio-write-fsync-same-fd \
> -	dio-writeback-race unlink-fsync truncate dio-read-into-mmap
> -
> -LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
> +	dio-writeback-race unlink-fsync truncate dio-read-into-mmap \
> +	xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
>  	locktest unwritten_mmap bulkstat_unlink_test deduperace \
>  	bulkstat_unlink_test_modified t_dir_offset t_futimens t_immutable \
> @@ -48,68 +49,64 @@ SUBDIRS = log-writes perf
>  LLDLIBS = $(LIBHANDLE) $(LIBACL) -lpthread -lrt -luuid
>  
>  ifeq ($(HAVE_XLOG_ASSIGN_LSN), true)
> -LINUX_TARGETS += loggen
> +    LINUX_TARGETS += loggen
>  endif
>  
>  ifeq ($(HAVE_FIEMAP), true)
> -LINUX_TARGETS += fiemap-tester t_stripealign
> +    LINUX_TARGETS += fiemap-tester t_stripealign
>  endif
>  
>  ifeq ($(HAVE_OPEN_BY_HANDLE_AT), true)
> -LINUX_TARGETS += open_by_handle
> +    LINUX_TARGETS += open_by_handle
>  endif
>  
>  ifeq ($(HAVE_FALLOCATE), true)
> -LCFLAGS += -DHAVE_FALLOCATE
> +    LCFLAGS += -DHAVE_FALLOCATE
>  endif
>  
>  ifeq ($(HAVE_FILE_GETATTR), yes)
> -LINUX_TARGETS += file_attr
> -LCFLAGS += -DHAVE_FILE_GETATTR
> -endif
> -
> -ifeq ($(PKG_PLATFORM),linux)
> -TARGETS += $(LINUX_TARGETS)
> +    LINUX_TARGETS += file_attr
> +    LCFLAGS += -DHAVE_FILE_GETATTR
>  endif
>  
>  ifeq ($(HAVE_DB), true)
> -TARGETS += dbtest
> -LLDLIBS += $(LIBGDBM)
> +    TARGETS += dbtest
> +    LLDLIBS += $(LIBGDBM)
>  endif
>  
>  ifeq ($(HAVE_AIO), true)
> -TARGETS += t_mmap_dio
> -SUBDIRS += aio-dio-regress
> -LLDLIBS += -laio
> +    LINUX_TARGETS += t_mmap_dio
> +    SUBDIRS += aio-dio-regress
> +    LLDLIBS += -laio
>  endif
>  
>  ifeq ($(HAVE_URING), true)
> -LINUX_TARGETS += btrfs_encoded_read btrfs_encoded_write
> -TARGETS += uring_read_fault
> -LLDLIBS += -luring
> +    LINUX_TARGETS += btrfs_encoded_read btrfs_encoded_write \
> +		     uring_read_fault
> +    LLDLIBS += -luring
>  endif
>  
>  SUBDIRS += vfs
>  ifeq ($(HAVE_LIBCAP), true)
> -LLDLIBS += -lcap
> +    LLDLIBS += -lcap
>  endif
>  
>  ifeq ($(HAVE_SEEK_DATA), yes)
>   ifeq ($(HAVE_NFTW), yes)
>    ifeq ($(HAVE_BMV_OF_SHARED), yes)
>     ifeq ($(HAVE_RLIMIT_NOFILE), yes)
> -     TARGETS += xfsfind
> +     LINUX_TARGETS += xfsfind
>     endif
>    endif
>   endif
>  endif
>  
>  ifeq ($(HAVE_FICLONE),yes)
> -     TARGETS += t_reflink_read_race
> +     LINUX_TARGETS += t_reflink_read_race
>  endif
>  
>  ifeq ($(HAVE_FANOTIFY_FID),yes)
> -     TARGETS += fs-monitor
> +     LINUX_TARGETS += fs-monitor
>  endif
>  
>  ifeq ($(HAVE_LIBBTRFSUTIL), true)
> @@ -117,7 +114,11 @@ ifeq ($(HAVE_LIBBTRFSUTIL), true)
>  endif
>  
>  ifeq ($(NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE),yes)
> -LCFLAGS += -DNEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE
> +     LCFLAGS += -DNEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE
> +endif
> +
> +ifeq ($(PKG_PLATFORM),linux)
> +     TARGETS += $(LINUX_TARGETS)
>  endif
>  
>  CFILES = $(TARGETS:=.c)
> -- 
> 2.55.0
> 
