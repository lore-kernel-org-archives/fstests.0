Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27694364
	for <fstests@vger.kernel.org>; Sat, 30 Mar 2024 06:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711781668; cv=none; b=jTUSb/8D89MugLyyGT5DD6LF68sDj3OBupeRfi6UchkfbzWk5jeBsqZxkJ6ZhKXzVU9eTc/Yi4PBSpAt67U3SYz9BBqWYteAXoTiR0YYfJ947DhWN6IWPJBvrEqXIIhkveV7EhKlEVZ34czHl0KcxRptew6zfPb+gHrcIl0WVmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711781668; c=relaxed/simple;
	bh=Ti5m5CuK5boJWI4xD88cPTdMXn8GK5A2ZOr6xJEj4wA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lA7gIg97o38u3UtexmcT+rMfxSt9H8AGlYm/arxKN3mo6lukv+iQsIvABQ4EMpPxSoEdUhCsQzbS4DXY95c7reRLIASlTfguF6theN03DljdXlz+Lpyt6awEZPeaJ3+wTZKZeuRKEbA+inGjOh+lQ4JRI+Cyn3jN6SPvh/QFfHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AEWqgrTq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AEWqgrTq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711781664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YqBjXKOCpL8+4rn2fSL4hhej26enaJYjUe0RZB2mq8M=;
	b=AEWqgrTqbLhf7rBdeIv9acvySwJVBV8+V8OLeN+8tfgE/3yQZEEdb2Ffq9k/+3G3DIqmsu
	jE0V36P8AP+f1MWD9W1JhBF5FQvuTr3CJARm/pdgJm7jacGApOaKmlGwrIQR4u6nLYpKY3
	Sx8M1/bkCnukH9Yh2DraDpzfuL3Eai8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-iqLcT_jXMt2w58le-ln9cw-1; Sat, 30 Mar 2024 02:54:22 -0400
X-MC-Unique: iqLcT_jXMt2w58le-ln9cw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-29dfa2c256fso2047014a91.3
        for <fstests@vger.kernel.org>; Fri, 29 Mar 2024 23:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711781661; x=1712386461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YqBjXKOCpL8+4rn2fSL4hhej26enaJYjUe0RZB2mq8M=;
        b=VehMnP9XpgabfH4SdltS66RFnpYK7EQJUNvC4BTgjHOlXTcperKg6F3iltR5OANybS
         JVEG+Hu5jIr8kceWiDpyjlpr/bE74fhWoHEU4FuWPCtBKVQlkxwAElWxi5xFBQbd47N/
         cL/459wkbAfNr4QFpYO9qw2Lxf4Y8dmyU5MW2vaX/j2GvndPCuDdExyEuPYzRsqEXYqm
         DRbR6jfVbeBrp1e9l3r5mjDgy/ulpIcLC+57ebZNOyTVJFsT3bTMKug4o8aqWbBPHTMh
         FwQVWEW5iPbQG/GZwwbH/Vp0+o+k/VgSiBiWISzyi7Rfz2eIM9ThoyT2g/IzxEvlJCO3
         Itzg==
X-Gm-Message-State: AOJu0Yy0HCv4wAgxfT2HR6UJpphHGVAwK3rRfisdq8gJ4BBegZm4mVtT
	ANky0xQa3daaoyyCDNmLWqwGaUYZwg4oXVvdnKtb0x9Q7cSV2huSpn08PMtoQIhxqRdhJQSz7Ka
	6VeGuzPYWUjS5l07G0TT16gQb+tmkJ4ZWd76zgkIStJBmKQCDEb20Htq0F/CiZhHwVw==
X-Received: by 2002:a17:902:da89:b0:1e1:a74:4e17 with SMTP id j9-20020a170902da8900b001e10a744e17mr5043618plx.30.1711781661396;
        Fri, 29 Mar 2024 23:54:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtBFSekn4eSbd1jQAFa5Lt3GsERaRIToV+VusIL3CGyvTmtHXXx/ZANTq3TkkLcc7UioGttg==
X-Received: by 2002:a17:902:da89:b0:1e1:a74:4e17 with SMTP id j9-20020a170902da8900b001e10a744e17mr5043604plx.30.1711781660922;
        Fri, 29 Mar 2024 23:54:20 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id mo4-20020a1709030a8400b001dd8d298693sm4535535plb.23.2024.03.29.23.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 23:54:20 -0700 (PDT)
Date: Sat, 30 Mar 2024 14:54:16 +0800
From: Zorro Lang <zlang@redhat.com>
To: Disha Goel <disgoel@linux.ibm.com>
Cc: fstests@vger.kernel.org, ojaswin@linux.ibm.com
Subject: Re: [PATCH] generic/735: improve test by incorporating extra hints
Message-ID: <20240330065416.snzqks526eh7yqse@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240319111613.11029-1-disgoel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319111613.11029-1-disgoel@linux.ibm.com>

On Tue, Mar 19, 2024 at 04:46:13PM +0530, Disha Goel wrote:
> On power systems with 64k block size (where default page size is 64k) we
> encountered a kernel oops due to an integer overflow issue when writing
> near the last logical block of a file. The allocator could allocate a
> range where the end exceeds the maximum supported logical block
> (UINT32_MAX), leading to a subsequent BUG_ON. This issue has been
> addressed in the upstream kernel with commit 2dcf5fde6dff
> ("ext4: prevent the normalized size from exceeding EXT_MAX_BLOCKS").
> 
> 	==================================================
> 	kernel BUG at fs/ext4/mballoc.c:4448!
> 	Oops: Exception in kernel mode, sig: 5 [#1]
> 	CPU: 8 PID: 2880554 Comm: xfs_io
> 	NIP ext4_mb_use_inode_pa+0x110/0x160 [ext4]
> 	LR ext4_mb_use_inode_pa+0xac/0x160 [ext4]
> 	Call Trace:
> 		ext4_mb_new_inode_pa+0x134/0x3a0 [ext4]
> 		ext4_mb_try_best_found+0x158/0x280 [ext4]
> 		ext4_mb_regular_allocator+0x16c/0x940 [ext4]
> 		ext4_mb_new_blocks+0x610/0x960 [ext4]
> 		ext4_ext_map_blocks+0x858/0xa90 [ext4]
> 		ext4_map_blocks+0x218/0x800 [ext4]
> 		ext4_iomap_alloc+0x10c/0x260 [ext4]
> 		ext4_iomap_begin+0xfc/0x1f0 [ext4]
> 		iomap_iter+0xf0/0x190
> 		__iomap_dio_rw+0x208/0x690
> 		iomap_dio_rw+0x20/0x80
> 		ext4_dio_write_iter+0x210/0x4d0 [ext4]
> 		vfs_write+0x364/0x4e0
> 		sys_pwrite64+0xd4/0x120
> 		system_call_exception+0x164/0x310
> 		system_call_vectored_common+0xe8/0x278
> 	==================================================
> 
> This test has been extended to provide a hint about the relevant fix
> in case of failure.
> 
> Signed-off-by: Disha Goel <disgoel@linux.ibm.com>
> ---

Looks good to me, will merge it if no more review points from ext4 list.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/735 | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/generic/735 b/tests/generic/735
> index 75b23d5e..0ba111a6 100755
> --- a/tests/generic/735
> +++ b/tests/generic/735
> @@ -6,16 +6,19 @@
>  #
>  # Append writes to a file with logical block numbers close to 0xffffffff
>  # and observe if a kernel crash is caused by ext4_lblk_t overflow triggering
> -# BUG_ON at ext4_mb_new_inode_pa(). This is a regression test for commit
> -# bc056e7163ac ("ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow")
> -#
> +# BUG_ON at ext4_mb_new_inode_pa(). This is a regression test for
> +# commit bc056e7163ac ("ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow")
> +# commit 2dcf5fde6dff ("ext4: prevent the normalized size from exceeding EXT_MAX_BLOCKS")
> +
>  . ./common/preamble
>  . ./common/populate
>  _begin_fstest auto quick insert prealloc
>  
>  # real QA test starts here
> -[[ "$FSTYP" =~ ext[0-9]+ ]] && _fixed_by_kernel_commit bc056e7163ac \
> -	"ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow"
> +if [[ "$FSTYP" =~ ext[0-9]+ ]]; then
> +	_fixed_by_kernel_commit bc056e7163ac "ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow"
> +	_fixed_by_kernel_commit 2dcf5fde6dff "ext4: prevent the normalized size from exceeding EXT_MAX_BLOCKS"
> +fi
>  
>  _require_odirect
>  _require_xfs_io_command "falloc"
> -- 
> 2.39.1
> 
> 

