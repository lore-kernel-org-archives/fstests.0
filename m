Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA39A3168F6
	for <fstests@vger.kernel.org>; Sat, 21 Feb 2026 16:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771691230; cv=none; b=uPEi9HJf3jC0ARHZXwm9p9IMmHAeZqR0YX2uQkNOcVxhEqqiM8Hn7FFEYZaLuoUhZkwY4T0boHdIK9vSmpiMfurZoVtung+f9eKOszg2uj8tSq4+K5wcstsLXRpw10Hn0sDdRaM6VZ9jt5dBs8FG6/OIlwhUfqMbNENw79KN/Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771691230; c=relaxed/simple;
	bh=j4/laoNKnl1Vln7TJV+5wtCEgdevdib0O7BNo39AH8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0ZXHb/dtkycZCZU+UojdToHf5pJZeCttYtztQCX7CJR7PWTCR8dkWmq02SKLc8nUj4zucGBXTeMod2mibuPSbptIvp80dxzDkOHmyKWh78Bj4A9g3o8FY8iiVV1WOWZVA1zQ+NsJyB/mpaBKV6fbt4oqZ1pZcvDB+iVmk/D4mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gauGVnf9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WUFUVc1x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gauGVnf9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WUFUVc1x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771691227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PhhBuA9xaIrSRvoTMUsIJxCHnvJtqOnn290ATAev2eo=;
	b=gauGVnf9tuwzbCW+PUvjCujzLR4xopjCsa38lm6m3QV7WGAkpO4bs5ltZkFcVbVgfRODdx
	VjnRVQZuK+Tyui02RSSzGiG80OSzqYTzJZUfPpV4cPTdlkquJJBlYHkTQtT6JO7WvedrWh
	LcpDhAe4QMh3DC/b9C187sHvyRA9FHM=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-LmpwdVEhNY-TlYSH4wJDHg-1; Sat, 21 Feb 2026 11:27:05 -0500
X-MC-Unique: LmpwdVEhNY-TlYSH4wJDHg-1
X-Mimecast-MFC-AGG-ID: LmpwdVEhNY-TlYSH4wJDHg_1771691224
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2aad6045810so32067695ad.3
        for <fstests@vger.kernel.org>; Sat, 21 Feb 2026 08:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771691224; x=1772296024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PhhBuA9xaIrSRvoTMUsIJxCHnvJtqOnn290ATAev2eo=;
        b=WUFUVc1xyHh1Dm+8W4Ryu40fxoO9EUi9TAfmFv3WpflTDqaejxSJwXu7QzCIVwwFxb
         BTSGGuruZ9ozh/yAybWrP4SOl1DAajTx4DPRcba40ffHXvQaEn82PXDhR9WBY6yws+vo
         8xFXQQSxf+OVlRh33BXVeAUgKxXL8sKbrCRLdzAdZ8pJjp0dKEsKXI82mzKnI4q7CQao
         4fS53K/cDN8PL3VHPj9xidG/x7CnskbjeQj53d+NjRMNXTRZcUrFCz6DI2880A0aTZ6v
         qqd6FPyWDiHnhdZsMcpcCYv9noxbVMMWR7uk5+zgocjSpbLrfkADC5dURPLENQyotjHf
         VOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771691224; x=1772296024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhhBuA9xaIrSRvoTMUsIJxCHnvJtqOnn290ATAev2eo=;
        b=LEFHlb5XiHbl/Te/l/SlmisnKyb+tVso9ALysptRjnHucZAr6t9isi5I4EvwNO9L1k
         e605XXOgtXgwlVjF3MgUoOGhbVwLBxdujWgUf2A6ywmVqAIWLqvtn7TZnW+1kvh4g/cw
         Xgi6h7wiSg5wYJ8CRekQUeM8f9DlxmdiAQIG1rp3iYjL5dgTszL8Gs+OLAf/zWpi6lX4
         nkObrkpARhvEhmZ493juVPX/qwEK2FDpzJPRBKCJ1LkQegpMeK5nzZr0/stPUKXJOKfo
         geHesSFxcejllPZY4hVxgG+RPFK9opRoMwv8j9O0EOXli2QbFLNbUkp6YEOGw4nYVHte
         xhEQ==
X-Gm-Message-State: AOJu0Yzz3+CI94xVCkB9Yvg5JvBGNnbwt4hFp/RfzLkP1XC2W5CdCyN+
	eYk6S9ZJUjjX8H1nQWopOp/Kg1UFzM76Hrulntx1MbmuX/ToGsuhLSG+9I8I5vyv+O0NxlvB67d
	lBsiaEv98bctvPGTGnUjifLlzcMKEWVxKkyUODy2Iw0t8FuMucPqkGtaNluc=
X-Gm-Gg: AZuq6aKDcdnijuQMg1+7KCbz7BXt3kLHOnEubZxKBaMI6jDtumqgYoK9d5DE8uok71I
	Xb3JLi4kLHO3+7sjN/ywcw0oc/0RMqbAC84oZmaMg4MD7xRCtJdU4HcImKyCOtKMfvwepoBC6tY
	Z1qHONRURdI4IrVjLP5LawM7UAsGyeyDH32j+JlbuyxO9edG5y7L+i1uzhBzafKCUrZZsNW4ywe
	Hz67TThEFWsD4BsfRnvDwBt449DFFsb/dAveol3q3Ko9++qUMZuTEi+b3cIdAwzLaWEnuh1OU9e
	jlBSUxeEpxPH/8MhftMcBNNLr6eYCOIO1AolyNzv2qpb/JiFOfy5V5kH7TBSLvjPv6uQsfltGlY
	2PnXGp6hYyuLigG7cV/+ltcE++y1pDUvv25nQOUODX3yrh0ltQde34vNMqflnVA==
X-Received: by 2002:a17:903:4b30:b0:2aa:e415:589c with SMTP id d9443c01a7336-2ad745675admr27327665ad.55.1771691224499;
        Sat, 21 Feb 2026 08:27:04 -0800 (PST)
X-Received: by 2002:a17:903:4b30:b0:2aa:e415:589c with SMTP id d9443c01a7336-2ad745675admr27327535ad.55.1771691223993;
        Sat, 21 Feb 2026 08:27:03 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74e34452sm25526375ad.7.2026.02.21.08.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 08:27:03 -0800 (PST)
Date: Sun, 22 Feb 2026 00:26:59 +0800
From: Zorro Lang <zlang@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] tests: Fix failure in nojournal mode
Message-ID: <20260221162659.cu4exkuhjm2m5l5y@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20260220203308.6256-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220203308.6256-1-jack@suse.cz>

On Fri, Feb 20, 2026 at 09:33:08PM +0100, Jan Kara wrote:
> Several tests use fs shutdown. Without journalling the filesystem isn't
> guaranteed to be consistent after shutdown. So for tests that don't make
> sure data makes it to the disk using fsync/sync we cannot really test
> much. Skip such tests without journalling.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Thanks Jan! As we discussed in:
https://lore.kernel.org/fstests/20260216131308.atxnkqehyke4conu@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/T/#t
this patch is good to me now, if no more review points I'll push it to next
release.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/ext4/051    | 1 +
>  tests/generic/536 | 1 +
>  tests/generic/622 | 1 +
>  tests/generic/635 | 1 +
>  tests/generic/646 | 1 +
>  tests/generic/705 | 1 +
>  tests/generic/722 | 1 +
>  tests/overlay/087 | 1 +
>  8 files changed, 8 insertions(+)
> 
> diff --git a/tests/ext4/051 b/tests/ext4/051
> index 728ad19bfcec..9fbf0404fec9 100755
> --- a/tests/ext4/051
> +++ b/tests/ext4/051
> @@ -16,6 +16,7 @@ _exclude_fs ext2
>  _exclude_fs ext3
>  _require_scratch
>  _require_scratch_shutdown
> +_require_metadata_journaling
>  _require_command "$TUNE2FS_PROG" tune2fs
>  
>  echo "Silence is golden"
> diff --git a/tests/generic/536 b/tests/generic/536
> index 726120e67c8e..56a8ced2f8da 100755
> --- a/tests/generic/536
> +++ b/tests/generic/536
> @@ -17,6 +17,7 @@ _begin_fstest auto quick rw shutdown
>  # Modify as appropriate.
>  _require_scratch
>  _require_scratch_shutdown
> +_require_metadata_journaling
>  
>  # create a small fs and initialize free blocks with a unique pattern
>  _scratch_mkfs_sized $((1024 * 1024 * 100)) >> $seqres.full 2>&1
> diff --git a/tests/generic/622 b/tests/generic/622
> index a67931ad877f..e8ead300e362 100755
> --- a/tests/generic/622
> +++ b/tests/generic/622
> @@ -78,6 +78,7 @@ _cleanup()
>  # rather than the test filesystem.
>  _require_scratch
>  _require_scratch_shutdown
> +_require_metadata_journaling
>  _require_xfs_io_command "pwrite"
>  _require_xfs_io_command "fsync"
>  _require_xfs_io_command "syncfs"
> diff --git a/tests/generic/635 b/tests/generic/635
> index 4a811630a621..018b868cb6ce 100755
> --- a/tests/generic/635
> +++ b/tests/generic/635
> @@ -26,6 +26,7 @@ _begin_fstest auto quick atime bigtime shutdown
>  
>  _require_scratch
>  _require_scratch_shutdown
> +_require_metadata_journaling
>  
>  _scratch_mkfs > $seqres.full
>  _scratch_mount
> diff --git a/tests/generic/646 b/tests/generic/646
> index b3b0ab0ace56..1e3f0cd54087 100755
> --- a/tests/generic/646
> +++ b/tests/generic/646
> @@ -19,6 +19,7 @@ _begin_fstest auto quick recoveryloop shutdown
>  
>  _require_scratch
>  _require_scratch_shutdown
> +_require_metadata_journaling
>  _scratch_mkfs > $seqres.full 2>&1
>  
>  _scratch_mount
> diff --git a/tests/generic/705 b/tests/generic/705
> index 9c27fbbc389b..23f06d699dfa 100755
> --- a/tests/generic/705
> +++ b/tests/generic/705
> @@ -12,6 +12,7 @@ _begin_fstest auto shutdown
>  
>  _require_scratch
>  _require_scratch_shutdown
> +_require_metadata_journaling
>  _require_command "$FILEFRAG_PROG" filefrag
>  _scratch_mkfs > $seqres.full 2>&1
>  _scratch_mount
> diff --git a/tests/generic/722 b/tests/generic/722
> index b9c608713c37..10869bc7aabf 100755
> --- a/tests/generic/722
> +++ b/tests/generic/722
> @@ -18,6 +18,7 @@ _require_test_program "punch-alternating"
>  _require_xfs_io_command exchangerange
>  _require_scratch
>  _require_scratch_shutdown
> +_require_metadata_journaling
>  
>  _scratch_mkfs >> $seqres.full
>  _scratch_mount
> diff --git a/tests/overlay/087 b/tests/overlay/087
> index 2ad069dbf78f..25d021095b6f 100755
> --- a/tests/overlay/087
> +++ b/tests/overlay/087
> @@ -34,6 +34,7 @@ _begin_fstest auto quick mount shutdown
>  # Modify as appropriate.
>  _require_scratch_nocheck
>  _require_scratch_shutdown_and_syncfs
> +_require_metadata_journaling
>  
>  [ "$OVL_BASE_FSTYP" == "xfs" ] || \
>  	_notrun "base fs $OVL_BASE_FSTYP has unknown behavior with syncfs after shutdown"
> -- 
> 2.51.0
> 

