Received: from mx0.herbolt.com (mx0.herbolt.com [5.59.97.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE38285CB9
	for <fstests@vger.kernel.org>; Wed, 22 Jul 2026 17:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.59.97.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784742553; cv=none; b=bmaiTdbFFHfmA/JRU4fk5S6yAqtbDVonC74xAgKWxpNDTevSBaDw2k84KHPfw85/gd+C7PJlxussBcKIYSyak72L25h8nqBa85A6i0ltXZvqDiBYVbGJ3WTVbF7YuU5hwpnleptHKgbqScI7UlZbJ83k3WmbtCi00JhMNmR7X0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784742553; c=relaxed/simple;
	bh=b21SCp+2BPZBg99UtizR5I3jI/LRNh+N8K+LvsH3MSI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Iq5ipOi4q54mQ5xK05yQNqEetUY14xy1Tynn8J8/ogWcq2uY2LSq9QhpEyaJ6BGKxQPMbNJo8qCb0f0DSXX0nwX/SPR199jlEMyGBzns9o7D+IFyxlTpGOOYu6fgUZ3cZOl628OgQ/U8Y6YRG8RsU5j4bNbmNwo7SpfLiU8rRoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herbolt.com; spf=pass smtp.mailfrom=herbolt.com; arc=none smtp.client-ip=5.59.97.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herbolt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbolt.com
Received: from mx0.herbolt.com (localhost [127.0.0.1])
	by mx0.herbolt.com (Postfix) with ESMTP id 552F9180F2C1;
	Wed, 22 Jul 2026 19:49:03 +0200 (CEST)
Received: from mail.herbolt.com ([172.16.31.10])
	by mx0.herbolt.com with ESMTPSA
	id n7EtEI8CYWqAIAQAKEJqOA
	(envelope-from <lukas@herbolt.com>); Wed, 22 Jul 2026 19:49:03 +0200
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 22 Jul 2026 19:49:03 +0200
From: Lukas Herbolt <lukas@herbolt.com>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org
Subject: Re: [PATCH] fstests Fix build errors on kernels before v5.1
In-Reply-To: <amCMdrK8EscbPTAp@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20260722052256.2406451-3-lukas@herbolt.com>
 <amCMdrK8EscbPTAp@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
Message-ID: <26d5ba218032a5468d359fb598234b99@herbolt.com>
X-Sender: lukas@herbolt.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2026-07-22 11:35, Andrey Albershteyn wrote:
> On 2026-07-22 07:22:58, Lukas Herbolt wrote:
>> The FAN_REPORT_FID and fanotify_event_info_fid were introduced
>> in v5.1. Currently there is no check if the kernel supports it
>> making xfstests build to fail on older kernels.
>> 
>> Fixes: 29d120e41c3d ("generic: test fsnotify filesystem error 
>> reporting")
>> 
>> Signed-off-by: Lukas Herbolt <lukas@herbolt.com>
> 
> Looks good to me
> Reviewed-by: Andrey Albershteyn <aalbersh@kernel.org>
> 
>> ---
>>  configure.ac          |  1 +
>>  include/builddefs.in  |  1 +
>>  m4/package_libcdev.m4 | 14 ++++++++++++++
>>  src/Makefile          |  6 +++++-
>>  4 files changed, 21 insertions(+), 1 deletion(-)
>> 
>> diff --git a/configure.ac b/configure.ac
>> index 441f543c6089..feb24ddd8854 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -74,6 +74,7 @@ AC_NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE
>>  AC_HAVE_FICLONE
>>  AC_HAVE_TRIVIAL_AUTO_VAR_INIT
>>  AC_HAVE_FILE_GETATTR
>> +AC_HAVE_FANOTIFY_FID
>> 
>>  AC_CHECK_FUNCS([renameat2])
>>  AC_CHECK_FUNCS([reallocarray])
>> diff --git a/include/builddefs.in b/include/builddefs.in
>> index 708d75b24d76..8e9e2e3b4113 100644
>> --- a/include/builddefs.in
>> +++ b/include/builddefs.in
>> @@ -75,6 +75,7 @@ HAVE_RLIMIT_NOFILE = @have_rlimit_nofile@
>>  NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE = 
>> @need_internal_xfs_ioc_exchange_range@
>>  HAVE_FICLONE = @have_ficlone@
>>  HAVE_FILE_GETATTR = @have_file_getattr@
>> +HAVE_FANOTIFY_FID = @have_fanotify_fid@
>> 
>>  GCCFLAGS = -std=gnu11 -funsigned-char -fno-strict-aliasing -Wall
>>  SANITIZER_CFLAGS += @autovar_init_cflags@
>> diff --git a/m4/package_libcdev.m4 b/m4/package_libcdev.m4
>> index 17f57f427410..340cdad3faf9 100644
>> --- a/m4/package_libcdev.m4
>> +++ b/m4/package_libcdev.m4
>> @@ -102,3 +102,17 @@ AC_DEFUN([AC_HAVE_FILE_GETATTR],
>>         AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
>>      AC_SUBST(have_file_getattr)
>>    ])
>> +
>> +# Check if we have fanotify FID support (Linux 5.1+)
>> +AC_DEFUN([AC_HAVE_FANOTIFY_FID],
>> +  [ AC_MSG_CHECKING([for fanotify FID support])
>> +    AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
>> +#include <sys/fanotify.h>
>> +    ]], [[
>> +       int x = FAN_REPORT_FID;
>> +       struct fanotify_event_info_fid fid;
>> +       (void)x; (void)fid;
>> +    ]])],[have_fanotify_fid=yes
>> +       AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
>> +    AC_SUBST(have_fanotify_fid)
>> +  ])
>> diff --git a/src/Makefile b/src/Makefile
>> index 31ac43b215e9..847fb168181e 100644
>> --- a/src/Makefile
>> +++ b/src/Makefile
>> @@ -36,7 +36,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize 
>> preallo_rw_pattern_reader \
>>  	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
>>  	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
>>  	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault 
>> min_dio_alignment \
>> -	rw_hint fs-monitor
>> +	rw_hint
>> 
>>  EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
>>  	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
>> @@ -107,6 +107,10 @@ ifeq ($(HAVE_FICLONE),yes)
>>       TARGETS += t_reflink_read_race
>>  endif
>> 
>> +ifeq ($(HAVE_FANOTIFY_FID),yes)
>> +     TARGETS += fs-monitor
> ...
>>       LINUX_TARGETS += t_btrfs_received_uuid_ioctl
> 
> hah just noticed that fstests "supports" different targets (darwin,
> freebsd), not sure if it works at all

Ugh! Indeed that should be LINUX_TARGETS += fs-monitor
I will send v2
-- 
-lhe
