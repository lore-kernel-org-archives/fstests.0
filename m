Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.59.97.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613716;
	b=x29q5qpVv47ckjY9Q79i2FDqMS2XbfYgKVV0z6z1FZmD02j0yLxQJMgQcf68zSyOizyM
	 L4Lll8RagtyUONdAPP5gQ3KKngQHrLBAEAOplxdxC5VQbCoGFx96Cjs9bMw6zZrSjCKCV
	 MWhNJ6we9vdUdVov1N+gGXs/SoPyxau0W85AY2okqIeQzEU0oODqfUdOsyCxQh+GyQvk3
	 jA9aZmXOigPm61DzUQOZq8NsySd3DogjMbi6zsyGs2RM1dAuZCZNEt8x95cHLUriWDpZ1
	 RVFlgZo/FXHsdS0LmxuHmCG71HXm9ZqonHB2DsigsXcg0Y9XFS9fejssKuPU92cjlpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613716;
	h=DMARC-Filter:Received:Received:MIME-Version:Date:From:To:Cc:Subject:
	 In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
	bh=KSyeM/o0CKfIEEE6Grl3WVeVUc0/iD1tuuXHIBxK6n8=;
	b=IKID3Bua3mgV9TFgSsIb9pUlalP8MR3eYS4EwjoOSF/bmcnfIvBgK7L0Z2FwVWouUHfG
	 oujAUlJqad6fUylhbGV1KYriJpZM5oKGADqicSTmlW0xXtcH3e7BO8fiSIcN3+i/oiwUq
	 WZrmvC443Y4t7jn9LwHWrcmwBTFZH5tPlwV6a7CHqjsb1MI1nKNUyODZIxWFhpXN2NjUm
	 Oxql4vVu4yPIQHIRmWib65PPPcV/h+WLQJsWhOoD9tsGBoe/QO35woOLJjaihIGfDhINO
	 AuZwpuYWNsPwkGq5D9L1thReff6BdIpdoZ1te0yNbfxkUKt5F1pOzzuGjt/unrqupmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=herbolt.com;
	spf=pass smtp.mailfrom=herbolt.com;
	arc=none smtp.remote-ip=5.59.97.199
Received: from mx0.herbolt.com (mx0.herbolt.com [5.59.97.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4345E606A324
	for <fstests@vger.kernel.org>; Mon,  2 Nov 2026 10:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4345E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herbolt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbolt.com
Received: from mx0.herbolt.com (localhost [127.0.0.1])
	by mx0.herbolt.com (Postfix) with ESMTP id 0A669180F2D3;
	Mon, 02 Nov 2026 11:01:42 +0100 (CET)
Received: from mail.herbolt.com ([172.16.31.10])
	by mx0.herbolt.com with ESMTPSA
	id LzH2OIVf6GqcbAYAKEJqOA
	(envelope-from <lukas@herbolt.com>); Mon, 02 Nov 2026 11:01:42 +0100
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 02 Nov 2026 11:01:41 +0100
From: Lukas Herbolt <lukas@herbolt.com>
To: Lukas Herbolt <lukas@herbolt.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] xfstests: Unify the build targets under LINUX_TARGET
In-Reply-To: <aug5aYetKZ46O-J4@zlang-mailbox>
References: <20261006103937.276181-3-lukas@herbolt.com>
 <aug5aYetKZ46O-J4@zlang-mailbox>
Message-ID: <2e84237f24e9c4a5c10d2c129c300b1e@herbolt.com>
X-Sender: lukas@herbolt.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2026-11-02 08:25, Zorro Lang wrote:
> On Tue, Oct 06, 2026 at 12:39:39PM +0200, Lukas Herbolt wrote:
>> As discussed previously, the only supported target for now
>> is LINUX_TARGET. Merging the TARGET into LINUX_TARGET and
>> fix indentation in the Makefile.
>> 
>> Signed-off-by: Lukas Herbolt <lukas@herbolt.com>
>> ---
>>  src/Makefile | 55 
>> ++++++++++++++++++++++++++--------------------------
>>  1 file changed, 28 insertions(+), 27 deletions(-)
>> 
>> diff --git a/src/Makefile b/src/Makefile
>> index 0ff607ae1593..1f7f9fd61987 100644
>> --- a/src/Makefile
>> +++ b/src/Makefile
>> @@ -6,7 +6,9 @@
>>  TOPDIR = ..
>>  include $(TOPDIR)/include/builddefs
>> 
>> -TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
>> +TARGETS =
>> +
>> +LINUX_TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
> 
> Since Linux is the only supported platform now, why not just use 
> TARGETS
> directly?
> 
> Thanks,
> Zorro
I wanted to keep it separate for possible future users.

Lukas

> 
>>  	nametest permname randholes runas truncfile usemem \
>>  	mmapcat append_reader append_writer dirperf metaperf \
>>  	devzero feature alloc fault fstest t_access_root \
>> @@ -21,9 +23,8 @@ TARGETS = dirstress fill fill2 getpagesize holes 
>> lstat64 \
>>  	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
>>  	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault 
>> rewinddir-test \
>>  	readdir-while-renames dio-append-buf-fault dio-write-fsync-same-fd \
>> -	dio-writeback-race unlink-fsync truncate dio-read-into-mmap
>> -
>> -LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize 
>> preallo_rw_pattern_reader \
>> +	dio-writeback-race unlink-fsync truncate dio-read-into-mmap \
>> +	xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>>  	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
>>  	locktest unwritten_mmap bulkstat_unlink_test deduperace \
>>  	bulkstat_unlink_test_modified t_dir_offset t_futimens t_immutable \
>> @@ -48,68 +49,64 @@ SUBDIRS = log-writes perf
>>  LLDLIBS = $(LIBHANDLE) $(LIBACL) -lpthread -lrt -luuid
>> 
>>  ifeq ($(HAVE_XLOG_ASSIGN_LSN), true)
>> -LINUX_TARGETS += loggen
>> +    LINUX_TARGETS += loggen
>>  endif
>> 
>>  ifeq ($(HAVE_FIEMAP), true)
>> -LINUX_TARGETS += fiemap-tester t_stripealign
>> +    LINUX_TARGETS += fiemap-tester t_stripealign
>>  endif
>> 
>>  ifeq ($(HAVE_OPEN_BY_HANDLE_AT), true)
>> -LINUX_TARGETS += open_by_handle
>> +    LINUX_TARGETS += open_by_handle
>>  endif
>> 
>>  ifeq ($(HAVE_FALLOCATE), true)
>> -LCFLAGS += -DHAVE_FALLOCATE
>> +    LCFLAGS += -DHAVE_FALLOCATE
>>  endif
>> 
>>  ifeq ($(HAVE_FILE_GETATTR), yes)
>> -LINUX_TARGETS += file_attr
>> -LCFLAGS += -DHAVE_FILE_GETATTR
>> -endif
>> -
>> -ifeq ($(PKG_PLATFORM),linux)
>> -TARGETS += $(LINUX_TARGETS)
>> +    LINUX_TARGETS += file_attr
>> +    LCFLAGS += -DHAVE_FILE_GETATTR
>>  endif
>> 
>>  ifeq ($(HAVE_DB), true)
>> -TARGETS += dbtest
>> -LLDLIBS += $(LIBGDBM)
>> +    TARGETS += dbtest
>> +    LLDLIBS += $(LIBGDBM)
>>  endif
>> 
>>  ifeq ($(HAVE_AIO), true)
>> -TARGETS += t_mmap_dio
>> -SUBDIRS += aio-dio-regress
>> -LLDLIBS += -laio
>> +    LINUX_TARGETS += t_mmap_dio
>> +    SUBDIRS += aio-dio-regress
>> +    LLDLIBS += -laio
>>  endif
>> 
>>  ifeq ($(HAVE_URING), true)
>> -LINUX_TARGETS += btrfs_encoded_read btrfs_encoded_write
>> -TARGETS += uring_read_fault
>> -LLDLIBS += -luring
>> +    LINUX_TARGETS += btrfs_encoded_read btrfs_encoded_write \
>> +		     uring_read_fault
>> +    LLDLIBS += -luring
>>  endif
>> 
>>  SUBDIRS += vfs
>>  ifeq ($(HAVE_LIBCAP), true)
>> -LLDLIBS += -lcap
>> +    LLDLIBS += -lcap
>>  endif
>> 
>>  ifeq ($(HAVE_SEEK_DATA), yes)
>>   ifeq ($(HAVE_NFTW), yes)
>>    ifeq ($(HAVE_BMV_OF_SHARED), yes)
>>     ifeq ($(HAVE_RLIMIT_NOFILE), yes)
>> -     TARGETS += xfsfind
>> +     LINUX_TARGETS += xfsfind
>>     endif
>>    endif
>>   endif
>>  endif
>> 
>>  ifeq ($(HAVE_FICLONE),yes)
>> -     TARGETS += t_reflink_read_race
>> +     LINUX_TARGETS += t_reflink_read_race
>>  endif
>> 
>>  ifeq ($(HAVE_FANOTIFY_FID),yes)
>> -     TARGETS += fs-monitor
>> +     LINUX_TARGETS += fs-monitor
>>  endif
>> 
>>  ifeq ($(HAVE_LIBBTRFSUTIL), true)
>> @@ -117,7 +114,11 @@ ifeq ($(HAVE_LIBBTRFSUTIL), true)
>>  endif
>> 
>>  ifeq ($(NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE),yes)
>> -LCFLAGS += -DNEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE
>> +     LCFLAGS += -DNEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE
>> +endif
>> +
>> +ifeq ($(PKG_PLATFORM),linux)
>> +     TARGETS += $(LINUX_TARGETS)
>>  endif
>> 
>>  CFILES = $(TARGETS:=.c)
>> --
>> 2.55.0
>> 

-- 
-lhe
