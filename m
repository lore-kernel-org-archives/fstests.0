Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD131FF7CC
	for <fstests@vger.kernel.org>; Thu,  6 Mar 2025 09:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741255140; cv=none; b=NiQxwkOG/Y6veGqhKmFl3yw+/mpZpwjHiHIqHoKLvcCylMl4sPSlFDmkY/SuyJcdAzQgccBtx6mNs00cobGLvMIgPdP03MulDCKEa+fU3h2GUQ2zRXcNzaXuvUfAtFE6/ZTVhStrHzDgswL2/rH5QfTKhXpAEMd09nf8EZTr/uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741255140; c=relaxed/simple;
	bh=5QVFF8d4iy27c7SlyHwxg15vDDZ2BEBqPBqasZsGhBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ni00GNiPxIvHWiVzmSCBR/xfYIDnc7GcfFFr1WWCHj1z1Q6clUA96F/VyAomVcWw94jWpyVcqBn6z1wLRaHONX5sm77T3HS4mOeZikCrmIXfXN1cmT0KQEi1Zcp+DusdVgwXKhSB7DvzfhbnIcwJrx1xH7Ryj2S7QKqrJGp2cNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UIbaR+yJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UIbaR+yJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741255137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dbteuj65FfUi6QAnLeaiqumk91jolQkbE1/iJYqntz8=;
	b=UIbaR+yJz4SFpjgo0dFZB2yH2w4QEObvkRcKZpRL8sTz3maXkFpu2tGRALjusVpn6MAHCg
	BYF55KGijPa4sdKM1xZiQdPEXm58HCMndePEbjXWs1uy7/8RgnWCMVAX33YKIhCZLagp88
	AoVCKG5VTmV02ZccNXPVE/DVwKam+ME=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-wfVqA0iiMFKH5BoClFoPhQ-1; Thu, 06 Mar 2025 04:58:50 -0500
X-MC-Unique: wfVqA0iiMFKH5BoClFoPhQ-1
X-Mimecast-MFC-AGG-ID: wfVqA0iiMFKH5BoClFoPhQ_1741255130
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-22379c2e96aso16524875ad.1
        for <fstests@vger.kernel.org>; Thu, 06 Mar 2025 01:58:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741255130; x=1741859930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbteuj65FfUi6QAnLeaiqumk91jolQkbE1/iJYqntz8=;
        b=lpp5+iTyWOhoCgAILfbixD+cH/JOQKKlTcJ7Ng5TT/u+ZJiwDxGcw1dFPgZGCX4cW8
         VxKwf2YdUA7nXxIQqdK+pvxT62G1Co+hg3Pm6TUbri0LixbrYEDPo1u1MbbB58QTI9+g
         sjzV8rJ22rX7mmAi67ydPP0Q82kSJV5XtRtbXVDjvdT+68oLvv6O79kkOM6ydBZXOEno
         Yr5tAFyjYCqhfb7jq1wXhyAjvxMKzI3vOFUhaitii6d15KkAu1m3JeUOv/hYaWxzi3Y2
         V5BqnXkY+Z5JnGGfXZUdKOeNmY42Iy3XDm1hNjtY7VIB6AsI/IpJXzI4VolISTmSPm52
         uiog==
X-Forwarded-Encrypted: i=1; AJvYcCWpIhLyio0EG1K7bXVqjHRF9lRCyAjtdbbnkkhSm1c6fz1B9vNSWFV1X46qfau6hKaHQQ8mcJVK@vger.kernel.org
X-Gm-Message-State: AOJu0YzVdHncQ9f+1sPsjQgWh551bWLMQsYFowciefZVnCgnZgPReH05
	R//RkFyi1DDFESX6K+PaWRx4HfZnfe3eDB48ZFewpGYxY+Kz0q0qyHjyxE6EjGCgMAKnZ3Zc+mq
	rYYDtIwmHAFUQj9D82uC11YRTv2CUcyP5EnHs7lhlmONBO2Y1BScbxqs=
X-Gm-Gg: ASbGncubbOn2QwD6WrO6ZC8H4tJNzWYUCFG4zO6TzNlfotvDh4eCzsq5BEnX+T17qo2
	E7cIt0GrE302s5DYWdN4TRaxWGHkhrzc/mGCpuswH6z0CqJ/8VpBlnl04RPInZRF+tsX4kqJIQE
	WvXLvjGYx34+OIuaLdnsmDpfzUM02oEHb5ZW1ykf/i+CRupbha+/CQ1SEeuZ9WwnsryaAHD4n7T
	nsR/GK8Er/HPhNPTSJhiOMbB7+TaS5+x7zNM1aq5wZMtMGG0o/c4qR6S/gE/gzv0jweO+/2AYHG
	AMYtrHg0/i/BriSMIx5dD10IiGCsvzjZPenVkt561bWC1/6id6yxRXIC
X-Received: by 2002:a17:902:f541:b0:21f:52e:939e with SMTP id d9443c01a7336-223f1caf82amr114154035ad.28.1741255129755;
        Thu, 06 Mar 2025 01:58:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7XeL6oQ4E8kk4R8wG+MWRiyYduuR0qcZMKqCcFPQrg4RJLpYaXRYVfZ3x+jjaAUVaxR6g+A==
X-Received: by 2002:a17:902:f541:b0:21f:52e:939e with SMTP id d9443c01a7336-223f1caf82amr114153825ad.28.1741255129446;
        Thu, 06 Mar 2025 01:58:49 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73698518e21sm949957b3a.148.2025.03.06.01.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 01:58:48 -0800 (PST)
Date: Thu, 6 Mar 2025 17:58:45 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anthony Iliopoulos <ailiop@suse.com>
Cc: David Disseldorp <ddiss@suse.de>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/633: add _require_idmapped_mounts check
Message-ID: <20250306095845.4x2bt4gb7zwqt43g@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250304234819.783-1-ailiop@suse.com>
 <20250305141043.31c3eb95.ddiss@suse.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305141043.31c3eb95.ddiss@suse.de>

On Wed, Mar 05, 2025 at 02:10:43PM +1100, David Disseldorp wrote:
> On Wed,  5 Mar 2025 00:48:19 +0100, Anthony Iliopoulos wrote:
> 
> > Skip the test on older kernels that don't implement mount_setattr and
> > open_tree syscalls, instead of failing.
> > 
> > Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
> > ---
> >  tests/generic/633 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tests/generic/633 b/tests/generic/633
> > index 3bd18df68ba5..f58dbbf5f222 100755
> > --- a/tests/generic/633
> > +++ b/tests/generic/633
> > @@ -12,7 +12,7 @@ _begin_fstest auto quick atime attr cap idmapped io_uring mount perms rw unlink
> >  # Import common functions.
> >  . ./common/filter
> >  
> > -
> > +_require_idmapped_mounts
> >  _require_test
> >  
> >  echo "Silence is golden"
> 
> Looks good, although generic/696 and generic/697 probably should be
> covered too.
> 
> Reviewed-by: David Disseldorp <ddiss@suse.de>

Thanks David points out that:)

Hi Anthony, if you'd like to fix missed "_require_idmapped_mounts", could you
help to fix above two cases together. With that change:

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 

