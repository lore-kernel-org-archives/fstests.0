Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A44952F77
	for <fstests@vger.kernel.org>; Tue, 27 Feb 2024 05:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709010910; cv=none; b=NO6Tr/Mua5g8rbAL11yLvRUdM1tfcuUOCe/84mdMozCKtCxSJfGYTGLrDK24JQXMRSJ2TlTdR2sRaiXjX2JOO6zCYC/HSF4onDw6uI+ArbVKFSrMCyIK7dj0mficN2WsWgcD5hMKqYdnsVZuZlPvoFIMBfRwjHVED9VzAKtjebQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709010910; c=relaxed/simple;
	bh=DrLpN6ng2aMOGRNg1QAj1X/q9SNuOgYRclDkbOr+hKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTEKp/PApULrA6+f1we+FLS7JnCJJ5EenqHY9lFTXj2bGXOqJPKR/HlJhVC5rrXtpGTIseXE7H4sOcbbyY64vvM/MFC9TbbsIzjLEB5KWtHlPYzPc9t7bOzphax3wJ6Y6ajGRhqPjpRh3mdtVBar0SOKVh2NapSm/5Xfdp4GlUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DROLFJ4F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DROLFJ4F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709010907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=94RnUBU789GCXN3tAcemptI74oqgzIecnmT6YemaLoA=;
	b=DROLFJ4FikYUEEKVxb16sdYVvnH5HinLj80DBfvEaeMm1Vz5N2Lr7ky0Bw/fRDyTgmJaNj
	6eZZWKDToX1vDiu9cEpGads/9Zxudrk9AWSW6i7EnGcgkK4bTesVFNKJeKN4ln0SaqGyN2
	vwUxwhxEa4qJJHp23s6d1JXYG22Fbxs=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-9LrJlcVXM1ebwrUDRvZ3gg-1; Tue, 27 Feb 2024 00:15:04 -0500
X-MC-Unique: 9LrJlcVXM1ebwrUDRvZ3gg-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6e5382e18e8so1342008b3a.3
        for <fstests@vger.kernel.org>; Mon, 26 Feb 2024 21:15:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709010904; x=1709615704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94RnUBU789GCXN3tAcemptI74oqgzIecnmT6YemaLoA=;
        b=CvMnqDlf1akroh2g42UjmSWSd70LTQz/SicfgTXXsQ+OLIwro2pbRaBmxDLDVuuz3l
         J5nvYqBDq7sqlkiF4ZWIP8SbBeyuivDp80J5uJukIkIA3XZUDlNcVW0wKdryf66HBT5N
         +TOrPmdXgnlvDvRNmW8RvRGO46S0imCgJL6B//LN2CCbjRVSeROKr+dKBMtRQc9a51He
         9GrSqfhbgFLZZTFRJf6/khYaVIiw5vPvIw3aMDQgSVwkKjxZHRZ0dzqBOaKWbvRbP7JV
         9GORD/EL0F+fUIofV8v6exj7QRUtI0s0lfbLsIPQZUYbdPx4NSaDjhXGgNEMDKl+Ha9r
         AjPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTQEcPSDOzpqEYjdlu8R7aaCmIXeIw/JJbT1tSEUfQJIFpBsIFMQ404SfcdcwINBtcJQTuMM2zjaLUa2uA4RSwcEk/9Md0hA==
X-Gm-Message-State: AOJu0YzfJ4AhRhbR9H+Ar4zbdaxiBlIK8ynGHUe3SAQay1lHuuuOOOE0
	npp9P0XJ++/IuzPGEJbg+RkT7sTsT+ugE8zXivVNaB3+FrJJNGS2Ljw9v8ofbDnJgJ3AuKeMey4
	mgPSQtDBTUVzE/cSK2mc8CgDkSyoR+NR3FlhmFL4xy32x0Z2g1pXimAM=
X-Received: by 2002:a05:6a20:9c9b:b0:1a0:b414:a53f with SMTP id mj27-20020a056a209c9b00b001a0b414a53fmr1457259pzb.23.1709010903816;
        Mon, 26 Feb 2024 21:15:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGu0sCnzvxirkLDaEfFm2TasO6uXB/xlu3iPkoiqNAV+eDb3IOjKAzKEaymSygIkyUNZN9n/g==
X-Received: by 2002:a05:6a20:9c9b:b0:1a0:b414:a53f with SMTP id mj27-20020a056a209c9b00b001a0b414a53fmr1457253pzb.23.1709010903533;
        Mon, 26 Feb 2024 21:15:03 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id cv17-20020a17090afd1100b00299947ed2efsm5477001pjb.2.2024.02.26.21.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 21:15:03 -0800 (PST)
Date: Tue, 27 Feb 2024 13:15:00 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v1.1 1/8] generic/604: try to make race occur reliably
Message-ID: <20240227051500.5zjn6w4fs7nhyqyx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <170899915207.896550.7285890351450610430.stgit@frogsfrogsfrogs>
 <170899915233.896550.17140520436176386775.stgit@frogsfrogsfrogs>
 <20240227044021.GT616564@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227044021.GT616564@frogsfrogsfrogs>

On Mon, Feb 26, 2024 at 08:40:21PM -0800, Darrick J. Wong wrote:
> This test will occasionaly fail like so:
> 
>   --- /tmp/fstests/tests/generic/604.out	2024-02-03 12:08:52.349924277 -0800
>   +++ /var/tmp/fstests/generic/604.out.bad	2024-02-05 04:35:55.020000000 -0800
>   @@ -1,2 +1,5 @@
>    QA output created by 604
>   -Silence is golden
>   +mount: /opt: /dev/sda4 already mounted on /opt.
>   +       dmesg(1) may have more information after failed mount system call.
>   +mount -o usrquota,grpquota,prjquota, /dev/sda4 /opt failed
>   +(see /var/tmp/fstests/generic/604.full for details)
> 
> As far as I can tell, the cause of this seems to be _scratch_mount
> getting forked and exec'd before the backgrounded umount process has a
> chance to enter the kernel.  When this occurs, the mount() system call
> will return -EBUSY because this isn't an attempt to make a bind mount.
> Slow things down slightly by stalling the mount by 10ms.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
> v1.1: indent commit message, fix busted comment
> ---

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/604 |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/generic/604 b/tests/generic/604
> index cc6a4b214f..00da56dd70 100755
> --- a/tests/generic/604
> +++ b/tests/generic/604
> @@ -24,10 +24,12 @@ _scratch_mount
>  for i in $(seq 0 500); do
>  	$XFS_IO_PROG -f -c "pwrite 0 4K" $SCRATCH_MNT/$i >/dev/null
>  done
> -# For overlayfs, avoid unmouting the base fs after _scratch_mount
> -# tries to mount the base fs
> +# For overlayfs, avoid unmouting the base fs after _scratch_mount tries to
> +# mount the base fs.  Delay the mount attempt by a small amount in the hope
> +# that the mount() call will try to lock s_umount /after/ umount has already
> +# taken it.
>  $UMOUNT_PROG $SCRATCH_MNT &
> -_scratch_mount
> +sleep 0.01s ; _scratch_mount
>  wait
>  
>  echo "Silence is golden"
> 

