Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38E31CAA70
	for <fstests@vger.kernel.org>; Mon, 10 Mar 2025 07:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741591008; cv=none; b=WGohA7FclkKN7ek1GreMZlZY4rYZYAPKeIIoJMESNIGPMLzWlIS/XL496BkhYq/euHkAS4zWTqTYG2V+cVbI+VIlM+BFBSdcDg4Ml+yQz8IRAQSsBbiqLRydB1D3YI11YE7t1g6jG7db7uUPCA+S0afKpzTKowZSXPId2Qbp32I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741591008; c=relaxed/simple;
	bh=406zpo38DO4n/1Jxh1uYSA6tPXlYd9t0amgOQlfgaMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Br/wqIayzeveAzp05xuL4aNVDeDMKTz5n/AOKsgXh0rVs+KnBhq9L6fLlQC2hFXKQBnit3POXGSyT7UAHFhZIlSoaMQNTptRue+B76DpNtD0JESlOEKwStWRQA9uMTR6r7F2rmW30KqdAXT3HblQnLpYDoS8Mr/EWOtNcYcw/+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PHaG/TzO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PHaG/TzO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741591004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OQirfCA9HiZWh1c8EoIvu5VftAyyl1M7tFQE639mTI8=;
	b=PHaG/TzOIhIfJMOBfG4tsSyhXJodj3JgPJ14Ctorl0LpvkF9i5RI1aGJyCwqUrwklZK+h0
	Mjv0a6+wL9J/0dsuSmi5EhKph5gBQ4ACEj1hGY7ZQX1Wvhi6NCAg1eSAefBItcM0UtnImn
	cu8gLo0dEc0ysfC/uVqlubweX1qa69w=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-jj8djlBMNpqdFDpyrazcVA-1; Mon, 10 Mar 2025 03:16:42 -0400
X-MC-Unique: jj8djlBMNpqdFDpyrazcVA-1
X-Mimecast-MFC-AGG-ID: jj8djlBMNpqdFDpyrazcVA_1741591002
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff52e1c56fso11843882a91.2
        for <fstests@vger.kernel.org>; Mon, 10 Mar 2025 00:16:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741591001; x=1742195801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQirfCA9HiZWh1c8EoIvu5VftAyyl1M7tFQE639mTI8=;
        b=AJKvHnQUk7/tWBKR3EAqqe87sBUQlBOvIO6xmTZos0HzjjnlYsG2A53+PF/szNsF8E
         f3tyDIlbWAOhkGgr7Wjd7OR4MfKk+YK2NHxl3HKY4l32PdQxTuhJn6HhNAJd36f2ScYT
         FyoS2xd8AD2c4k/b9eV5/rlYMklEsRzd+LlGCaGAiPOYT5YdPGpLKM/20l9992Y+0npF
         vYYXNygYgMg4gWva3P1C41AKKN0A907nSkXM4FLXftlmA2qQgV3uQwlLJYKL71qbWqCn
         UKClE9+Gty/pY2XjTlou9VyMLJTgvYWix7LdOIitSz4fpqxvVpJeBGUQH0RNQAcXrYRQ
         9aLw==
X-Forwarded-Encrypted: i=1; AJvYcCWbd2BlyCalaCyzprDUCnPhj47qWiiOVMs4bQ0EDj9JNy1M06JuiMbTHayidJ75yiS7DdMS9SHU@vger.kernel.org
X-Gm-Message-State: AOJu0YwygE0sV1+wRI8qhTdaUfwe9T3yGvCBjLHo+y8+tujHIyIA3/hn
	EOZ5YNae2xr/0C9a0bIx58QZkprqY8f848ZyjLQZFDj69hG/bJF+Vl8sNxCdb4M+KWMlYmfZOE3
	77jMeLxx3pptSjQ3F152TrylW4hRoeXFWzfheEIOFW+JqGPNPQhdCo3c=
X-Gm-Gg: ASbGnct/FzfJkI1+QO9KKJ5AvexIGwVcJ6+aKdLtw7jSPatM3DG+gMtg4UsZ21zq2nl
	VEyzluovXKX7lIfjKJPpuZrKGwfxiyrhC4I6kOqVmuY4CYUIT5DwNRlo2fi9uwjExFA5GFQ23cC
	gt9jU7ZFZc/4CdnSuclH3vK/mpfaAw6LBUTgpBio8m92lPrzgpHiFXLFTm/qqaFMoRQE6O2usD4
	9Np7mugUWvKZDNVcCz/4kg1ArFOQe1ro8MdSAQF4HBSsdO1+1NNuTqhxdEYwa7LcMUElftnLLhN
	Q4pxqnrzegELiQ4dGeBUKmJaD+9oMg5IDYEsBDe7H6cSPOupnItlpUm3
X-Received: by 2002:a17:90b:3849:b0:2f9:c56b:6ec8 with SMTP id 98e67ed59e1d1-2ff7ce9114dmr20487387a91.10.1741591001701;
        Mon, 10 Mar 2025 00:16:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHc6EQwUtEp4Y8Jzau9HNcPdgmtBv8PQ+Tr4tlgHuhPCkoqZCQdLaK3xn6raeV7MqzyKuJ15g==
X-Received: by 2002:a17:90b:3849:b0:2f9:c56b:6ec8 with SMTP id 98e67ed59e1d1-2ff7ce9114dmr20487365a91.10.1741591001283;
        Mon, 10 Mar 2025 00:16:41 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693e72d1sm7225168a91.34.2025.03.10.00.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 00:16:40 -0700 (PDT)
Date: Mon, 10 Mar 2025 15:16:36 +0800
From: Zorro Lang <zlang@redhat.com>
To: David Disseldorp <ddiss@suse.de>
Cc: Chao Yu <chao@kernel.org>, Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org, jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/4] common/config: remove redundant export of
 F2FS_IO_PROG
Message-ID: <20250310071636.gombdbhdfbqxwib5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250306081809.2397527-1-chao@kernel.org>
 <20250307145629.2b2c6e99.ddiss@suse.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307145629.2b2c6e99.ddiss@suse.de>

On Fri, Mar 07, 2025 at 02:56:29PM +1100, David Disseldorp wrote:
> On Thu,  6 Mar 2025 16:18:06 +0800, Chao Yu wrote:
> 
> > F2FS_IO_PROG was been exported twice, remove the redudant one.
> > 
> > Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> > Signed-off-by: Chao Yu <chao@kernel.org>
> > ---
> >  common/config | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/common/config b/common/config
> > index 2afbda14..8d3047a5 100644
> > --- a/common/config
> > +++ b/common/config
> > @@ -191,7 +191,6 @@ export XFS_COPY_PROG="$(type -P xfs_copy)"
> >  export FSTRIM_PROG="$(type -P fstrim)"
> >  export DUMPE2FS_PROG="$(type -P dumpe2fs)"
> >  export RESIZE2FS_PROG="$(type -P resize2fs)"
> > -export F2FS_IO_PROG="$(type -P f2fs_io)"
> >  export FIO_PROG="$(type -P fio)"
> >  export FILEFRAG_PROG="$(type -P filefrag)"
> >  export E4DEFRAG_PROG="$(type -P e4defrag)"
> 
> Looks good. @Zorro, might as well squash in removal of the duplicate
> TIMEOUT_PROG export too.

Sure, I roughly tried to find all duplication by:

  $ for prog in `sed -n "/export/s/export \(.*_PROG\)=.*/\1/p" common/config `;do n=`grep -E "\b$prog=" common/config|wc -l`;if [ $n -gt 1 ];then grep "\b$prog=" common/config;fi;done

Currently only found F2FS_IO_PROG and TIMEOUT_PROG. So I'll change this patch
commit to:

  common/config: remove redundant export variables

  F2FS_IO_PROG and TIMEOUT_PROG are exported twice, remove the
  redundant one.

Thanks,
Zorro

> 
> Reviewed-by: David Disseldorp <ddiss@suse.de>
> 

