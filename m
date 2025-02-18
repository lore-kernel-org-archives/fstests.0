Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EAB157E6B
	for <fstests@vger.kernel.org>; Tue, 18 Feb 2025 04:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739852499; cv=none; b=KUasc2dqouSffG+Xxsn3JvPZgqnWpq5sqwYkffH2QMMC6xP2ookar00pslMvRHd44UjpcAgKNVZe4jPqpTjuFY55I9Ss+F5Z3aum/vgHbBRs5x+GuhEtYstTuuuiD2nRJIEGrVGNUjW1M/WsKchhpTgW080odbo/2gXivX4nL1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739852499; c=relaxed/simple;
	bh=7jRmcG+bZAHaZHPDN/sTKl4F764EBuHOAfRb/wsyEhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiyD15JAqwj9dHWlQ8iIMYBLgz0JDCNoen9g4ukq6aHA6AxfmH8k+KpQUq0cdwZL+hbe8jyD4y0Z/P0YuOKe8VQOwq4X3Ev+k1pJON9nmkzuPGmzDMXENeIUdvSYEToskBVgcLcJbS1itrkUQAj/zfZXnM9CGwAqlcPR6s1iihg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LCvUVeWW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LCvUVeWW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739852496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f6DldgkL1Bf7Mcv6AIKnpvYFmz+jRz5HRWLP0ogmnaU=;
	b=LCvUVeWWOOMH6cfm2SecZHF/NzhvwN4zMVp7rN4sfwf0Be7OImh2Hp3chyP2kA1qSY7ld+
	Qe+fVcq/gkrBgrt0IBnbWOKk6v6BU25Rt139mBuqgp23pez+EY/fN0zy/2h8qv+AfQ9Spp
	VnPApN5uNbXNtaypRET8VW3ONUwRGuk=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-Cz4F1lTFO-Gs8ERXher3Lw-1; Mon, 17 Feb 2025 23:21:33 -0500
X-MC-Unique: Cz4F1lTFO-Gs8ERXher3Lw-1
X-Mimecast-MFC-AGG-ID: Cz4F1lTFO-Gs8ERXher3Lw_1739852492
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-21f6cb3097bso137152055ad.3
        for <fstests@vger.kernel.org>; Mon, 17 Feb 2025 20:21:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739852492; x=1740457292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6DldgkL1Bf7Mcv6AIKnpvYFmz+jRz5HRWLP0ogmnaU=;
        b=FNrm1tzA+CamzlCckuIR+f+5kubOPFkDLV4665nthcjDTwJX5lUq0TRRRr59ZePftT
         KMcgQ5SYuVjTck+T9qNBtAhJjew9bDWPPC6hre3VLq5Wl+2Bb7pLjrIHccgclxl5UTQ7
         5Gk6kX/tC0CebWL4vN3vBBfWF4A3Z1MIrR+b9VpAHdHrqf4Bws0fx4JKJKXdWVPc/c2x
         EFSOT2hd+k1H1jMZe29qtYvIasz+FRPNjVOCSRdywl2urtFEGYK2Zie6ugYbg00Er4eh
         hzHO/jOQHZ/wGoSDn9C2yfPNKTJCOeG+bgeq3qIcMuXvWQHa0hDAe7qhWSO3La420Q/R
         FczQ==
X-Forwarded-Encrypted: i=1; AJvYcCXK/SnziUnxouQzDd2YLZlLr0RLe7rsyYkQDxbvwZ1CrYiuWEOwvbaFzQw/XBCYlHACWD/TsXtz@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ZjrQ3Cx9VTs7wTArESpKwagZ1K6S+I0Wwp/s3Lr73KMxbl+F
	s1yNW8BqqfdkH8usmDiNpvzhCMHWNBz3ITe7lQeRte764bqOL+EhfvvToXs0UzpRcYB6QPDOvyz
	ogDddfoXLhCwTSj5tCLu/cPEqsOTGQYBgxt6NHuAIYWX2XCP3flXTTPcRr3tl2lEyKQ==
X-Gm-Gg: ASbGnctVau0BsS4eb0iAjqMqHXD72P7+W3dqVRkesinJcACpon+ukgMH6XihcSWhcHw
	h555MSr8PGZzZ4K/OCm1DLlLr3QYMzQDF4r/KEWwMicjB50vwLCSCoQkrX75PbraC3C5vuPKLro
	EQzoNjkki78aVb0u9sTvgUpEplNr22dvNnV7l2fHkiaKXaNdZwx9Zrgw210pVDX087hTfSKPbxa
	/K32vlLz/+uRVl2lyYuw/6lw+zw/zpexnUnLUxPBnrkuJyYtAIG9XvOOZqYHbG7gcFbWI6cIMnc
	Pb9nd/c3RqsgrcpboFObZMoCrli4wBhk6iD6NxO00vYVoQ==
X-Received: by 2002:a17:903:8c5:b0:215:9642:4d7a with SMTP id d9443c01a7336-22103c5ceaemr214462145ad.0.1739852491712;
        Mon, 17 Feb 2025 20:21:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4kQCEI6NTrjTG3w0XR7+7/nsPO/1ATZNfO8fYUORFL28xdz+yszMyILPxvtHAQC6SRMnU0g==
X-Received: by 2002:a17:903:8c5:b0:215:9642:4d7a with SMTP id d9443c01a7336-22103c5ceaemr214461955ad.0.1739852491442;
        Mon, 17 Feb 2025 20:21:31 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5349306sm79513815ad.48.2025.02.17.20.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 20:21:31 -0800 (PST)
Date: Tue, 18 Feb 2025 12:21:27 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/370: don't exclude XFS
Message-ID: <20250218042127.u5o2nchtayodwi7m@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250217063135.3728305-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217063135.3728305-1-hch@lst.de>

On Mon, Feb 17, 2025 at 07:31:35AM +0100, Christoph Hellwig wrote:
> Skipping tests just because a file system is broken is always a bad idea
> as it hides bugs.

Skipping this test due to I'm not sure if xfs treats it as a bug or a boring
test failure which isn't suit for xfs. So I have to choose to skip it
temporarily with enough explanation, as btrfs was hurry to have this merge
and there was not objection from xfs either at that time.

> 
> (Fortunately despite hiding the bug this is now getting fixed in XFS as
>  well).

Great to hear that:)

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/generic/370 | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/tests/generic/370 b/tests/generic/370
> index 8adffd2e9650..8101ef42724e 100755
> --- a/tests/generic/370
> +++ b/tests/generic/370
> @@ -22,14 +22,6 @@ _cleanup()
>  [ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit 03018e5d8508 \
>      "btrfs: fix swap file activation failure due to extents that used to be shared"
>  
> -# Skip XFS for now because this exposes an issue that is hard to fix.
> -# See the following threads for details about it:
> -#
> -# https://lore.kernel.org/linux-xfs/CAL3q7H7cURmnkJfUUx44HM3q=xKmqHb80eRdisErD_x8rU4+0Q@mail.gmail.com/
> -# https://lore.kernel.org/fstests/dca49a16a7aacdab831b8895bdecbbb52c0e609c.1733928765.git.fdmanana@suse.com/
> -#
> -_exclude_fs xfs
> -
>  _require_scratch_swapfile
>  _require_scratch_reflink
>  _require_cp_reflink
> -- 
> 2.45.2
> 
> 

