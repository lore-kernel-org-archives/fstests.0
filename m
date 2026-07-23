Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DDF33E37A
	for <fstests@vger.kernel.org>; Thu, 23 Jul 2026 05:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784784444; cv=none; b=cpg8d+abrgRdyEEL6d8ekQ0t/Znd83sR3qOC/mo5OEsQ83dmxIPNplxrbaYQIMUopxRvK3MCahIFkzKXQYyBJ3T5w2GZo8a0eh/hUEY4px2Kbr1M+FwvjIhONygv8l3zVdBu3INthxFXlb6ndnFh9VN0avaX80rMEqL4umRWy2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784784444; c=relaxed/simple;
	bh=gLJ+L4xa2f+wZoVkxx+vfFtpBm9ZsD7GOHtUY7e55qA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ADu5qELoobcR2n3cCj/9aBvgXgpZfo0MZ+cixHhMwb1JqNZ6m7Fy+iKNo1daG4FmYdIRYb4NR3YTM+ZbP/v1RduX5BsCYxQISW23EUKf2RT0gNiADYthqXq/bh0GZBLucchm8U6B/oCrz8UDtB1ThRNsSkUd2ubiQMSJiEUo4DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oxh2YGHg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oXWyERa0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oxh2YGHg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oXWyERa0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784784441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cHZeYPFcEqb39HtUJyN6UTKG0SZk32BlII830B0xlUU=;
	b=Oxh2YGHgptFAH3yxKp5lHm39BLhLpM4zJov4PieXxOh8tCHhcd8yaMCKDCpQLA+WUC6yqx
	h06VkAQbNdYgFBjgpmq/xoRDG6wnkNYf3cOQxZkBXgSl4Hm0h2kpZHfYHXKGYWl+4isb5p
	wTlrVsK2iGUEb+8vT/Dc3MX2DQJ6MH8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-bUHhBU4ePmK7MyitE3Ah1w-1; Thu, 23 Jul 2026 01:27:18 -0400
X-MC-Unique: bUHhBU4ePmK7MyitE3Ah1w-1
X-Mimecast-MFC-AGG-ID: bUHhBU4ePmK7MyitE3Ah1w_1784784437
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cceabd70f5so8930015ad.1
        for <fstests@vger.kernel.org>; Wed, 22 Jul 2026 22:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784784437; x=1785389237; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cHZeYPFcEqb39HtUJyN6UTKG0SZk32BlII830B0xlUU=;
        b=oXWyERa0XD7JSppe4Y++nkNUo6e9/iS1H3mmdqrHYVSs34wydyNevstCawRSkfcQpp
         Q3MhlJy3dhJ8WGOV31BNhCPs/5G9eyAqyziI+lpvPct7ZJRubP0/vxF73Ffb25jTzE7+
         YaLAuygoCa+oiiaosunLuF9TJsrgChmFsXcdLXYna62hzfh3aeSKvJofRzt1jkgGB4BQ
         Si20YtPZsdnyMCpm9fs6iS5C4cBurHO9Sa6j31iLvkjPNiZCi3vNafZfX0lj88TV7J7m
         MS1HCtmtvBMhFGUgSgojg78SqcHo1VebEJg/+TgIt0CxHdDPv9gjLAWwEFb+WKrC3mm1
         WM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784784437; x=1785389237;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cHZeYPFcEqb39HtUJyN6UTKG0SZk32BlII830B0xlUU=;
        b=mMarI10Y/GTZlQPyP5azbPthh63lJcmphXYhiqBjIM8bI+GfdUW1d8X26sxMBfCYZB
         5RtUpxVGEgvnG9Bk5GCTXmSmkJN4BmUpU7m2DOGAqCL00aYvHl1eGTgoFyyPtDaX4WVI
         YbKuSDxP8dzoOW0teLkBaMEHJ3ttXiM66ppmUbfgHDILNPssic1bYSPLmhgFTe2QtGbn
         qmh4XArl6T37cpSN47qyZW1E15dzDfWxuKZpjBjEuN0cD8qiXWZGS4wq65v08UJ5FoWF
         1P3HjQaigYnBthMWxA3e2pMQxurCJYMp6T3gxJvoPogV+CXvzcIV9NdF0sWde0cZfPDm
         f3RQ==
X-Gm-Message-State: AOJu0Yx0BNr4gUZxlpwP+qoFmvBdyNfVPpA8mmRLGbedmvbX5Hn1o/Z/
	Uq5Gvso9yoY3VqeJwwuJOXsKENeb00nkEuSVfQqMHynXDRFqW18frItWMDw0TatGrWWwQYop7uk
	TnJNCfakgXV7XIyHISp2+CC4yIGc3q7zhV0ddbEQjhJ6YBXHSy0ybeXU12UU=
X-Gm-Gg: AR+sD11rUWcAsn3LqzudmXvO+V3eLHwAcIGqwx+Kem9Q8SnIv6IgvMneWgd5mMpaFOu
	mU+mTlEEOdXsfLTc3meBWHI3OSH9pvdBRnaZJA2CVt1wqH0Ebc4T7x5S1CLn0LGB/bZPqIabc6+
	b+LiIMfs3/5R7AHErokBYlABmBpdMC/sm2Nt8sicDn/tSNmNdqJdFNa+bmNhjNaoJTmRZBBTcC8
	kBsILArLWqXfNPG5Wdl7T3Sf7JkTo9PrhMR8XKNgBSIjI1KXq1UP5oI/LTnBMMzljRVqj3ynvoR
	036dbxDXjWS6JsvJCHx3GJcHwwo4rW0QIC3cbrjGXsRNtoIhl+0U5vgGLBD0IPcfRTP0ab6fqV+
	nWJvqGJAFXpXLM1tRh9uk6psMJ+FrPHAJdaQtY7ZDwS/dNnw=
X-Received: by 2002:a17:902:eccb:b0:2c9:c46b:1286 with SMTP id d9443c01a7336-2cfa74ada2dmr20345425ad.34.1784784437322;
        Wed, 22 Jul 2026 22:27:17 -0700 (PDT)
X-Received: by 2002:a17:902:eccb:b0:2c9:c46b:1286 with SMTP id d9443c01a7336-2cfa74ada2dmr20345205ad.34.1784784436805;
        Wed, 22 Jul 2026 22:27:16 -0700 (PDT)
Received: from ?IPV6:2001:8003:4b1b:d900:266e:8be8:569:ffa6? ([2001:8003:4b1b:d900:266e:8be8:569:ffa6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f32cec5sm25893795ad.64.2026.07.22.22.27.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 22:27:16 -0700 (PDT)
Message-ID: <d5f276e5-a3ef-4f5e-aa68-aafeec595ee4@redhat.com>
Date: Thu, 23 Jul 2026 15:27:13 +1000
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests Fix build errors on kernels before v5.1
To: Lukas Herbolt <lukas@herbolt.com>,
 Andrey Albershteyn <aalbersh@redhat.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org
References: <20260722052256.2406451-3-lukas@herbolt.com>
 <amCMdrK8EscbPTAp@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
 <26d5ba218032a5468d359fb598234b99@herbolt.com>
Content-Language: en-US, en-AU
From: Donald Douwsma <ddouwsma@redhat.com>
In-Reply-To: <26d5ba218032a5468d359fb598234b99@herbolt.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/7/26 03:49, Lukas Herbolt wrote:
> On 2026-07-22 11:35, Andrey Albershteyn wrote:
>> On 2026-07-22 07:22:58, Lukas Herbolt wrote:
>>> The FAN_REPORT_FID and fanotify_event_info_fid were introduced
>>> in v5.1. Currently there is no check if the kernel supports it
>>> making xfstests build to fail on older kernels.
>>>
>>> Fixes: 29d120e41c3d ("generic: test fsnotify filesystem error reporting")
>>>
>>> Signed-off-by: Lukas Herbolt <lukas@herbolt.com>
>>
>> Looks good to me
>> Reviewed-by: Andrey Albershteyn <aalbersh@kernel.org>
>>
>>> ---
>>>  configure.ac          |  1 +
>>>  include/builddefs.in  |  1 +
>>>  m4/package_libcdev.m4 | 14 ++++++++++++++
>>>  src/Makefile          |  6 +++++-
>>>  4 files changed, 21 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/configure.ac b/configure.ac
>>> index 441f543c6089..feb24ddd8854 100644
>>> --- a/configure.ac
>>> +++ b/configure.ac
>>> @@ -74,6 +74,7 @@ AC_NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE
>>>  AC_HAVE_FICLONE
>>>  AC_HAVE_TRIVIAL_AUTO_VAR_INIT
>>>  AC_HAVE_FILE_GETATTR
>>> +AC_HAVE_FANOTIFY_FID
>>>
>>>  AC_CHECK_FUNCS([renameat2])
>>>  AC_CHECK_FUNCS([reallocarray])
>>> diff --git a/include/builddefs.in b/include/builddefs.in
>>> index 708d75b24d76..8e9e2e3b4113 100644
>>> --- a/include/builddefs.in
>>> +++ b/include/builddefs.in
>>> @@ -75,6 +75,7 @@ HAVE_RLIMIT_NOFILE = @have_rlimit_nofile@
>>>  NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE = @need_internal_xfs_ioc_exchange_range@
>>>  HAVE_FICLONE = @have_ficlone@
>>>  HAVE_FILE_GETATTR = @have_file_getattr@
>>> +HAVE_FANOTIFY_FID = @have_fanotify_fid@
>>>
>>>  GCCFLAGS = -std=gnu11 -funsigned-char -fno-strict-aliasing -Wall
>>>  SANITIZER_CFLAGS += @autovar_init_cflags@
>>> diff --git a/m4/package_libcdev.m4 b/m4/package_libcdev.m4
>>> index 17f57f427410..340cdad3faf9 100644
>>> --- a/m4/package_libcdev.m4
>>> +++ b/m4/package_libcdev.m4
>>> @@ -102,3 +102,17 @@ AC_DEFUN([AC_HAVE_FILE_GETATTR],
>>>         AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
>>>      AC_SUBST(have_file_getattr)
>>>    ])
>>> +
>>> +# Check if we have fanotify FID support (Linux 5.1+)
>>> +AC_DEFUN([AC_HAVE_FANOTIFY_FID],
>>> +  [ AC_MSG_CHECKING([for fanotify FID support])
>>> +    AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
>>> +#include <sys/fanotify.h>
>>> +    ]], [[
>>> +       int x = FAN_REPORT_FID;
>>> +       struct fanotify_event_info_fid fid;
>>> +       (void)x; (void)fid;
>>> +    ]])],[have_fanotify_fid=yes
>>> +       AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
>>> +    AC_SUBST(have_fanotify_fid)
>>> +  ])
>>> diff --git a/src/Makefile b/src/Makefile
>>> index 31ac43b215e9..847fb168181e 100644
>>> --- a/src/Makefile
>>> +++ b/src/Makefile
>>> @@ -36,7 +36,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>>>      fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
>>>      detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
>>>      uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault min_dio_alignment \
>>> -    rw_hint fs-monitor
>>> +    rw_hint
>>>
>>>  EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
>>>            btrfs_crc32c_forged_name.py popdir.pl popattr.py \
>>> @@ -107,6 +107,10 @@ ifeq ($(HAVE_FICLONE),yes)
>>>       TARGETS += t_reflink_read_race
>>>  endif
>>>
>>> +ifeq ($(HAVE_FANOTIFY_FID),yes)
>>> +     TARGETS += fs-monitor
>> ...
>>>       LINUX_TARGETS += t_btrfs_received_uuid_ioctl
>>
>> hah just noticed that fstests "supports" different targets (darwin,
>> freebsd), not sure if it works at all
> 
> Ugh! Indeed that should be LINUX_TARGETS += fs-monitor
> I will send v2

I think this was mainly to allow for IRIX back when fstests ran there, the 
last of which were removed by 

bc2568f9 fstests: remove IRIX test program open_unlink

A lot of the more recent programs in TARGETS look like they wouldn't apply 
to anything outside of linux, i.e. t_ext4_dax_journal_corruption and 
t_ext4_dax_inline_corruption.

Given the use of configure to decide what to compile in it may be clearer
if this was just simplified to use TARGETS in the long term.


