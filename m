Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A7E819
	for <fstests@vger.kernel.org>; Wed, 19 Mar 2025 20:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742414514; cv=none; b=eU6c4wTj47PhA1bguQ813JSiyGhRV7UMPDr+fruZyc1tM1Hsyd/KrakXc5JGUhdI4k9qFDKg2DfJgpEDTnv40ZYYxT8BYvrOeIlpyAf55BKfWrKfoYkXabC9VHXCPl3JYoYsWHuvPhXMLBtcpDJMHStKdqvZtGhPZlqkt9a472Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742414514; c=relaxed/simple;
	bh=fck/m6pYYMNxSLHjlpWzfWxKFpnMcUTKJIsmoAi4FZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNDSifC9LhztcckVv3ZMl66dw8YsqxcvKnyWb03bWpjmioHFZRYxpaSzkLaFKx5UOfbg7OX0UFed4Ttc7ahNyYltzHZ4zn0EtHMp7EGzHMZ1xYBM2nzCTTixZfSu1xh0RHCsV4/WP2KBTXhVuqrlRpCRyMBqamJZxzrnEUafF+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XSymdVlI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XSymdVlI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742414511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bOoywP7dwo8Hrs4BZNNybN4WQx33xPKJfmzEuREw8nM=;
	b=XSymdVlIkxON/RZtNy+sOIO0FqEqaCH/MCrCeKW0ZY0shYzzx1jGCY+W6UGXWQhTusqHaP
	ZSwjN4JLQzzDF/Ka2TwHyXlogLMXecYkMWEOPyEksJL36fbgit7pziruz2Ce64Fa9D0pkX
	DywHPuXb4MhqSS0VeAAbtuSVEiStMaw=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-uO0i6GDcM3Ce8rDzhvosRA-1; Wed, 19 Mar 2025 16:01:48 -0400
X-MC-Unique: uO0i6GDcM3Ce8rDzhvosRA-1
X-Mimecast-MFC-AGG-ID: uO0i6GDcM3Ce8rDzhvosRA_1742414506
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-22651aca434so12548335ad.1
        for <fstests@vger.kernel.org>; Wed, 19 Mar 2025 13:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742414506; x=1743019306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOoywP7dwo8Hrs4BZNNybN4WQx33xPKJfmzEuREw8nM=;
        b=vEd+rHjVNLsunWENoThlGYmFn0HFCcTjV1HBne2r28jN5sWRDwyCaBjIN44RFXkCkZ
         QjfGIID75SVsN8noTmTiXHHwgIGdT18q2ROLUy2E2F1Eieb/HprjS6l0xMzpstM0iga2
         FJ0gLI8Dz/1o1wP/3TFW/UcLRXq/6a4HIhYIvDBN0ucuOi+eMD0Xn0+vaTb3DTo3/Tba
         /Y6xsWJucFt27sQC3ON9tMUdKhNcmvTRrIjMgGcYmtElah6HOZsqc3tA0OJfSoTOdMPZ
         6IWLdAjVGWce3uA/6vCCVssC41YmaNv9bHzSK+u8X/kDw3MFXYi7gzQiPRBHoFUASnqA
         IykQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpHMAFRGBn0pbyWAlQ72sKOvXXNUlpiMbbvddFmq8cKQbjBwZdoz40KaeYn1pdA9VVfb/jdGv5@vger.kernel.org
X-Gm-Message-State: AOJu0YwfwEHENjwtUvuiXc7Ujs6pA0pTVl/VXg+dv9qNUFlij25sjwPv
	JAoqtHKr409athnlfM2LjyeNrgI1TGgjwZLtKrOUpg/ZO68jPDX9J0Jr+yiLdXkvmhJkYxx3xuI
	9cy0KeyfcarNfOv8mVf7ydN3/TTBDq4MCbPptMiwrCixoK5Vcz+eJ1XDWIswl1CmWuw==
X-Gm-Gg: ASbGncuLQgSW5Vvru/wz2dMfYXsUqTOz8tNJoKFnK/9kKzHS1q+NUnoR7tRfgyP+fQ2
	Rf1Se/J9rkEl2Dw2dVU6pKR4g1kjnH1GSApkLN0iiZvMS1+afvHZ47QKYqr7GSK7+jCODTiE655
	PPrOqO4oisLDJfkKKlxkNNh4ChP0FdvGfAl5btJh4krNk4Mpa9lat5ZiwJKmXoCOq9th6JY0gCT
	CgWeAZKBapF1464Memt7NoUgYKNPlfr5Dv2X+uHka800fDkBkO/VazDEwcrMa1FfWRahwl5X/2B
	zqqC3/BZQxuEOyl17b34BxgjiFuuqP7p3L/xCh6DvB+2CKSAcqF7ITmY
X-Received: by 2002:a17:903:2985:b0:224:1943:c5c with SMTP id d9443c01a7336-2265edbbb2bmr9933365ad.15.1742414506124;
        Wed, 19 Mar 2025 13:01:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlSsJi5FaJYbgkcfAKC934XFzdCxuWIYO6ipNbmCZSd0vFJjAaLZ+CZG7zgNVb/ncFF169+Q==
X-Received: by 2002:a17:903:2985:b0:224:1943:c5c with SMTP id d9443c01a7336-2265edbbb2bmr9933135ad.15.1742414505716;
        Wed, 19 Mar 2025 13:01:45 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737116b35a0sm12493725b3a.175.2025.03.19.13.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 13:01:45 -0700 (PDT)
Date: Thu, 20 Mar 2025 04:01:42 +0800
From: Zorro Lang <zlang@redhat.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Eric Sandeen <sandeen@sandeen.net>,
	Christian Brauner <brauner@kernel.org>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: generic/699 fails on ext4 due to using ext4 mount options w/
 overlayfs
Message-ID: <20250319200142.dmt2sz2jnotmyjeo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <c46d8caf-053a-4af1-b562-7ca7203cb926@sandeen.net>
 <20250318235116.GE787758@mit.edu>
 <ffed04f3-5743-4a92-9b2c-20887c04a4cf@sandeen.net>
 <20250319151144.3r27tjgenbzty5tr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20250319153902.vn3xcttrrytrkfx3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20250319164410.GB1061595@mit.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319164410.GB1061595@mit.edu>

On Wed, Mar 19, 2025 at 12:44:10PM -0400, Theodore Ts'o wrote:
> On Wed, Mar 19, 2025 at 11:39:02PM +0800, Zorro Lang wrote:
> > 
> > I've forgotten why I left g/699 to generic, not in overlay. Maybe
> > Christian hope to run these two cases together in one FSTYP test
> > round (don't need to run overlay test once). I'm good to move this
> > case to tests/overlay/, cc Christian to check his review point.
> 
> I had assumed it was because we might want to test the combination of
> overlayfs with a variety of different underlying file systems?
> 
> If we move this to tests/overlay, I'd still be able to do this kind of
> testing via:
> 
>   {gce,kvm}-xfstests --primary-fstype {ext4,xfs} -c overlay/default -g auto
> 
> This allows me to test overlayfs with the underlying upper and lower
> directories being either ext4 or xfs.  (I could and should extend this
> to support other base file system types, via some minor changes to
> test-appliance/files/root/fs/overlay/config, but I had never gotten
> around to it.)
> 
> How do other people who are testing overlayfs handle this?

Hi Ted,

Fstests supports overlayfs testing with different underlying fs, for example
if you want to test overlay with ext4, you can set local.config as:

 FSTYP=ext4
 TEST_DEV=/dev/sdb
 TEST_DIR=/mnt/test
 SCRATCH_DEV=/dev/sdc
 SCRATCH_MNT=/mnt/scratch

then does:
# mkfs.ext4 -F $TEST_DEV
# mkfs.ext4 -F $SCRACH_DEV
# mkdir /mnt/test
# mkdir /mnt/scratch
# ./check -overlay -g auto

For more details you can refer to xfstests/README.overlay.

Currently fstests only supports overlayfs testing as this, other fs, e.g. nfs,
has to prepare nfs SCRATCH_DEV and TEST_DEV by the user. I'm thinking about
supporting other upper fs testing likes overlay (if it's helpful).

Thanks,
Zorro

> 
> 						- Ted
> 							
> 

