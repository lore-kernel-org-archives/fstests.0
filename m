Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8167462
	for <fstests@vger.kernel.org>; Thu,  5 Jun 2025 16:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749139498; cv=none; b=SqqzBGrnz7CBF0nYV1YQHiy5harVlKWs+RoYafNXMTvYJUui66Erh4YiaSYTL7hSaRdCvlueoDsHSQmnzIQM4FCs4B5d8aqegcG0A5FPL+NcKQn8eW0iirV+dORD7TSAjG+xp933J+o4sNMsvx2gWXL4shHp6QwEV1LfHvAi7YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749139498; c=relaxed/simple;
	bh=1ZMYrUk6oQdoHZ84Une2mz68SYT78oTigBcDVF884Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcf8RQWFpTMIhJgteUkTH5zRp5BIQaAm+omEx5ruZ9xWimQLY/8Oto6CNT1/UpGTJLIUNkLpwWJlq9BcJoPlcDGA+kxNrwbmP69Cj1Ifqy6LzZJQ8lpplj58z6CTWpZLF5/daveSh9+9NRs2JdI6zuRw8yHqvA/3Z8DGfH6KmqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SpI2UK0H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SpI2UK0H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749139486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=il46EU6GFqNY2CbsWo+TEQFeQB0q8ljPTVtEK/gjjWI=;
	b=SpI2UK0HD7nO5uI5bxBUJfXFSJx77qO3UrFGIVx9Z3oq0+e2Cah3z736gJ0thYY7YN3KhS
	f2bKfgvCVUDMo6zq996GYdq3lH305b2pRBWJBIQ7Rh+wlTeDBgfLYM3smOw9GM9xIrxR11
	Tcl9OPH77+SQBMyS+3lA1h3OFzuMBZM=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-2uFK_MWjMouCPnvTRatCAw-1; Thu, 05 Jun 2025 12:04:11 -0400
X-MC-Unique: 2uFK_MWjMouCPnvTRatCAw-1
X-Mimecast-MFC-AGG-ID: 2uFK_MWjMouCPnvTRatCAw_1749139447
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2354ba59eb6so16604415ad.1
        for <fstests@vger.kernel.org>; Thu, 05 Jun 2025 09:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749139444; x=1749744244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=il46EU6GFqNY2CbsWo+TEQFeQB0q8ljPTVtEK/gjjWI=;
        b=S30eoJZNc2ZM42Tw1P9FDJCAY726bPS+LcsWM+bWUNivyMf+NmZW1gidnUugHGI8Ye
         QJucqfeFO0/VV0pJblzSULqiFK8PpX7CXhkjG8q/EcCvUJ67TEy/X3Yg/cQioWx5nFnU
         DBN8MD86MG0WbGgUwhPcHYo98oS2gFUcaPtEXS83NgYHavDZU/ytsGU6TyhWFlUPRKR/
         A/zXfURG13eSFaM7hJbXlsZm7rhj8h98YpU9bSi0G/UFA0IN4Qw5GTWdZLo9XJgtsivh
         B0JNk5EqugMuPfHsnRHxtjTGRkk3I4oQeDnU1TKoHIejzVVzaWUI64S8wvlq2DONcWWO
         AoSQ==
X-Gm-Message-State: AOJu0YzH/QAh/aJNwFCS0qg5/297w43aarhM06xwXnlv3UDo0pqnyamw
	35j3FYMji90lviuGEZ+rIVMlRpwrYdUF3CfoiwMfETp5mULkcu72DRrfKAmp1CsPhBLqnCASZJ/
	sjCC8SBvXh6iT9x7DPOK2+T5QHdomFTyh/VxI5hAeOvKtFTyXPZqyVTEh/CQ=
X-Gm-Gg: ASbGncuZCqo3qKycVu6W9ZUvCFGL1xuPtCL1cDtKmPCvrFSNZkCiVz7oqLaEmdJ5wUE
	SqVKU6PkdXT21JALf16lx35RfmkehoF9cTHsPTIlpeZLw1wBus84TtcudvxoXwccGOCmrXRscmr
	3AYiVDTuXGFjSL394dgeBq4sOEmChB7kxLyok6EdvUCNhBNx24XFsk07X8ZMMeOwvRNoVsZgTMv
	dbuqM5F/pyeR+eo1BxwLMoTtOIWVoLMEmmu9UG3UEitZEXn4E1QKXL6TU/P7Z1MrsiEUgLlkxfa
	/wYaGEDBWWEq9j6yMQkeIAvBMbvNS5MRAhMud9P/HIAnj91yYKmE
X-Received: by 2002:a17:903:2f85:b0:235:ecf2:397 with SMTP id d9443c01a7336-235ecf20ecemr74123475ad.33.1749139444427;
        Thu, 05 Jun 2025 09:04:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdCJEykVbcD5HaKtvN7OCNa3pPRicn1BpDHm8htfAy3SkEAt9RKtETG4E4kitKlE9Pv2uZNA==
X-Received: by 2002:a17:903:2f85:b0:235:ecf2:397 with SMTP id d9443c01a7336-235ecf20ecemr74123055ad.33.1749139444019;
        Thu, 05 Jun 2025 09:04:04 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506d14a85sm121578835ad.232.2025.06.05.09.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 09:04:03 -0700 (PDT)
Date: Fri, 6 Jun 2025 00:03:59 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] fstests: add kernel commit IDs to some tests
Message-ID: <20250605160359.xjo35wqku67yblsw@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <df0a4c7749812f3dec49c2ec05c6da5c7b7e822f.1748517133.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df0a4c7749812f3dec49c2ec05c6da5c7b7e822f.1748517133.git.fdmanana@suse.com>

On Thu, May 29, 2025 at 12:13:41PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The kernel fixes exercised by some tests have already landed in Linus'
> tree, so update the tests with the respective commit IDs.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Thanks for this update.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/f2fs/011    | 2 +-
>  tests/generic/370 | 2 +-
>  tests/generic/761 | 3 ++-
>  tests/generic/764 | 2 +-
>  4 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/f2fs/011 b/tests/f2fs/011
> index ec3d39ec..c21cb586 100755
> --- a/tests/f2fs/011
> +++ b/tests/f2fs/011
> @@ -23,7 +23,7 @@ _begin_fstest auto quick
>  
>  _fixed_by_kernel_commit 48ea8b200414 \
>  	"f2fs: fix to avoid panic once fallocation fails for pinfile"
> -_fixed_by_kernel_commit xxxxxxxxxxxx \
> +_fixed_by_kernel_commit f7f8932ca6bb \
>  	"f2fs: fix to avoid running out of free segments"
>  
>  _require_scratch
> diff --git a/tests/generic/370 b/tests/generic/370
> index cbc18644..d9ba6c57 100755
> --- a/tests/generic/370
> +++ b/tests/generic/370
> @@ -21,7 +21,7 @@ _cleanup()
>  
>  [ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit 03018e5d8508 \
>      "btrfs: fix swap file activation failure due to extents that used to be shared"
> -[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit XXXXXXXXXXXX \
> +[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit 2d873efd174b \
>  	"xfs: flush inodegc before swapon"
>  
>  _require_scratch_swapfile
> diff --git a/tests/generic/761 b/tests/generic/761
> index 9406a4b8..bd7b02a9 100755
> --- a/tests/generic/761
> +++ b/tests/generic/761
> @@ -18,7 +18,8 @@ _begin_fstest auto quick
>  _require_scratch
>  _require_odirect
>  _require_test_program dio-writeback-race
> -_fixed_by_kernel_commit XXXXXXXX \
> +
> +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit 968f19c5b1b7 \
>  	"btrfs: always fallback to buffered write if the inode requires checksum"
>  
>  _scratch_mkfs > $seqres.full 2>&1
> diff --git a/tests/generic/764 b/tests/generic/764
> index 1b21bc02..55937fc0 100755
> --- a/tests/generic/764
> +++ b/tests/generic/764
> @@ -20,7 +20,7 @@ _cleanup()
>  
>  . ./common/dmflakey
>  
> -[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit 5e85262e542d \
>  	"btrfs: fix fsync of files with no hard links not persisting deletion"
>  
>  _require_scratch
> -- 
> 2.47.2
> 
> 

