Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DABDDC0
	for <fstests@vger.kernel.org>; Tue, 14 May 2024 12:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715689351; cv=none; b=mzQCACCt4GTL/EWYXtrrcSE+SP6RqE6dSRCPfj+HR1D/Nrz//gIC2nUWk6BNbsWF97ccL/WWLD3If5QHrYcdgdzt68oJyuisiVkZxZV7oj8kG0B//SGR3ljsrlMykSJ1Gvd/RLOY6yU6hFgk2L0DJj3LFLh0QwR+1Ql9HW6970c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715689351; c=relaxed/simple;
	bh=fRt6rTcirZfmiWrwFPhkSPwdXNmv1xSJue7pQqy/bH8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=OWDjMZoCsystUCKFM9TySLQDxrIrECKttEgSaGh1qDgbMqvEVDf7wpD6rJNw7d7zgQ/hWajXJ1FTwN1LrhvCrI0YILcNhLDcAt+xQ0QBSF8IgjffKtcUpojHD5YzSv9f62JA902fBzVm/DOvuDK9+aL1rzTOVfyw6s1z5OROaHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3BR33he; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3BR33he"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2450441dd16so770741fac.2
        for <fstests@vger.kernel.org>; Tue, 14 May 2024 05:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715689349; x=1716294149; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N4q46bqZtC3/1KLbolSHwB+0oMt7Pr9aPvqHiUlA0bo=;
        b=k3BR33he/jDnaYhSkXmrdlvMa4R5Az7/+yKHMrMUcQVChrk6AuDg+kwpZSt/ASqGZg
         1G1U+xSU7O/Xw/yVqFRIEyC7l/IodyHiWaVoOQSkcTyMVUzV1pp7etwUtHQVhTy3TjoO
         MQJZyew6C2nY1pwiLSR4Vvc71nlZ4WNADw/Hic4PjsTXUc/REsRDFLnlLi28WaNJOhJp
         OGwOiynzLK7EYZfynI8lED3tt8lbLayJjlMXeZ1RJJDtlv3CnP6ap/1P6bTJks9J4Htn
         zZaQRyzj/U8I8Z/fpo4eDUKMJBJE13zSXqfbH4rPV4l+o8cFwcDqqOVgVzcEPXgkj+d5
         YZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715689349; x=1716294149;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N4q46bqZtC3/1KLbolSHwB+0oMt7Pr9aPvqHiUlA0bo=;
        b=IygsBlMMlZUC9X0QvlbZsM9Xbtr8chWS0VtiEhZ86JbJZHGawil6P8h5o16kJLSNZP
         Rdpxa2jTVlOeYffUQqSj8JnYDIQIHoZ1u33YCeIbG0TQI+fOWKHx0FGMX/YEUxrcNo6+
         iMG47HU1+ev11fb862QmRNACJmkguGdogADZ7CDNbwHIZ0b+PhqNquhCmEuhjct/mXoN
         eu1DvXZpBTJiSE8tVobw1tCxGBea1j3qOCOlE2E6v47nHaPpDsCXU0ihkgfd1O1fF6nd
         54Yg43pE+GMyMRGQEzVbaz4/d70pL/DPoraBXjq2d1C11EKhmq9OUHmuXKr7oP6Fq1Z2
         QUJg==
X-Forwarded-Encrypted: i=1; AJvYcCXzuGxTy1siBiUL79AM511SGxYkdqFPLnLaOM6ozc9UhgnrOFSz7iFy2D9pNZ3SGWm+SSlY8Ch8lDk0Z5wahpwohN3ilyr0zA==
X-Gm-Message-State: AOJu0YyxFHnndD5hpoWu6utMe8seln34mpIIY9gCzeNjGoQaVkPighJb
	TB0XwEx+G67lKNLHjKg1pTiBLVFwC8e7yuq5B841ylloRBV/ymrL
X-Google-Smtp-Source: AGHT+IGhz6wxxRR86OQYHi3L54rBMf7SacnJkjJk6ugYqjm2tSFNuJxPjiE+TV9vWc0pPWfkXfSvUA==
X-Received: by 2002:a05:6870:80c6:b0:22e:b354:f5ee with SMTP id 586e51a60fabf-24172a4d8f5mr15242771fac.15.1715689349174;
        Tue, 14 May 2024 05:22:29 -0700 (PDT)
Received: from dw-tp ([106.196.23.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2a37sm8947220b3a.161.2024.05.14.05.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 05:22:28 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, fstests@vger.kernel.org
Cc: kernel@pankajraghav.com, gost.dev@samsung.com, mcgrof@kernel.org, djwong@kernel.org, zlang@redhat.com, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 1/3] xfs/161: adapt the test case for 64k FS blocksize
In-Reply-To: <20240513131254.92412-2-kernel@pankajraghav.com>
Date: Tue, 14 May 2024 17:49:12 +0530
Message-ID: <87ttj0bn7j.fsf@gmail.com>
References: <20240513131254.92412-1-kernel@pankajraghav.com> <20240513131254.92412-2-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>

"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com> writes:

> From: Pankaj Raghav <p.raghav@samsung.com>
>
> This test fails when xfs is formatted with 64k filesystem block size*.
> It fails because the soft quota is not exceeded with the hardcoded 64k
> pwrite, thereby, the grace time is not set. Even though soft quota is
> set to 12k for uid1, it is rounded up to the nearest blocksize.
>
> *** Report for user quotas on device /dev/sdb3
> Block grace time: 7days; Inode grace time: 7days
>                         Block limits                File limits
> User            used    soft    hard  grace    used  soft  hard  grace
> ----------------------------------------------------------------------
> 0        --       0       0       0      0       3     0     0      0
> 1        --      64      64    1024      0       1     0     0      0
> 2        --      64       0       0      0       1     0     0      0
>
> Adapt the pwrite to do twice the FS block size and set the soft limit
> to be 1 FS block and hard limit to be 100 FS blocks. This also gets rid
> of harcoded quota limit values.
>
> * This happens even on a 64k pagesize system and it is not related to
>   LBS effort.
>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Looks good to me. Small nit below.
(I can verify on Power once I am back)

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

> ---
>  tests/xfs/161 | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/tests/xfs/161 b/tests/xfs/161
> index 486fa6ca..5bda7019 100755
> --- a/tests/xfs/161
> +++ b/tests/xfs/161
> @@ -38,15 +38,23 @@ _qmount_option "usrquota"
>  _scratch_xfs_db -c 'version' -c 'sb 0' -c 'p' >> $seqres.full
>  _scratch_mount >> $seqres.full
>  
> +
> +blksz=$(_get_file_block_size "$SCRATCH_MNT")
> +# Write more than one block to exceed the soft block quota limit via
> +# xfs_quota.
> +filesz=$(( 2 * $blksz))
> +lim_bsoft=$blksz
> +lim_bhard=$(( 100 * blksz ))
> +
>  # Force the block counters for uid 1 and 2 above zero
> -_pwrite_byte 0x61 0 64k $SCRATCH_MNT/a >> $seqres.full
> -_pwrite_byte 0x61 0 64k $SCRATCH_MNT/b >> $seqres.full
> +_pwrite_byte 0x61 0 $filesz $SCRATCH_MNT/a >> $seqres.full
> +_pwrite_byte 0x61 0 $filesz $SCRATCH_MNT/b >> $seqres.full
>  sync
>  chown 1 $SCRATCH_MNT/a
>  chown 2 $SCRATCH_MNT/b
>  
>  # Set quota limits on uid 1 before upgrading
> -$XFS_QUOTA_PROG -x -c 'limit -u bsoft=12k bhard=1m 1' $SCRATCH_MNT
> +$XFS_QUOTA_PROG -x -c 'limit -u bsoft='"$lim_bsoft"' bhard='"$lim_bhard"' 1' $SCRATCH_MNT

Small nit: I am not sure if we really need so many quotes for '"$lim_bsoft"' and
"'$lim_bhard"'. 
>  
>  # Make sure the grace period is at /some/ point in the future.  We have to
>  # use bc because not all bashes can handle integer comparisons with 64-bit
> @@ -71,7 +79,7 @@ _scratch_mount
>  
>  # Set a very generous grace period and quota limits on uid 2 after upgrading
>  $XFS_QUOTA_PROG -x -c 'timer -u -b -d 2147483647' $SCRATCH_MNT
> -$XFS_QUOTA_PROG -x -c 'limit -u bsoft=10000 bhard=150000 2' $SCRATCH_MNT
> +$XFS_QUOTA_PROG -x -c 'limit -u bsoft='"$lim_bsoft"' bhard='"$lim_bhard"' 2' $SCRATCH_MNT
>  
>  # Query the grace periods to see if they got set properly after the upgrade.
>  repquota -upn $SCRATCH_MNT > $tmp.repquota
> -- 
> 2.34.1
