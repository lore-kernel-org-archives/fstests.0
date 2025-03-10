Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC069223302
	for <fstests@vger.kernel.org>; Mon, 10 Mar 2025 08:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741593790; cv=none; b=Fy6PJb3OcWjpuHW2RYMJUG4v0eTMYOI/AS2Uijt0jC7n5X8wZV2/b9A6eWC9IY9mQ0B6fB5ygUyguGQj3qL7yD2DpnmhRvGWNLubwgfFALaA2ma6HNAYLwNUQMEsaYyE9Fb/JGmAHCkCxNqV9RQDlc6Lr70kMyUndYETpvc7jYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741593790; c=relaxed/simple;
	bh=Mc3Ol7qT24BrzSkcrpvB1khbU6uyQizilgo1DtZ0qt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tioi+VBYk3pteMUi8k1UerSodFFcykFTFuP0OIalysLlGYvYB7gjQDqy/wV4Bthx2ogQ/76fzThF4r58fLlbx5jyXDCNmz88F6bz1ojf0e+ne+IBc+5ITyoxnYUHU/i5hlBfGkJT0NkRHrhGAVfvHImuP5+3URv3S+CaUxen8Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZLue011P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLue011P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741593787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KUXALxltmaZpj+QULpZ9mOYplNM+oXSkx8amdFd68t0=;
	b=ZLue011P3YPaWbUZfWggWrQ1rCc7z9FF8+vXWHOGWvPspDiM1makUCjPa/lFFjShPB8Qnz
	n97XVRHoAsPycN7rGVUF6AeJmyyC8gxciGzd8UYHS7vZ/0s8vSWtHuVbryFX9msdzCstx3
	/xnuGcZl1PUpovSC/NTJmRYq3zemleA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-2FwlcsC5N8KSUesgrBs6KA-1; Mon, 10 Mar 2025 04:03:06 -0400
X-MC-Unique: 2FwlcsC5N8KSUesgrBs6KA-1
X-Mimecast-MFC-AGG-ID: 2FwlcsC5N8KSUesgrBs6KA_1741593785
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff52e1c56fso11946284a91.2
        for <fstests@vger.kernel.org>; Mon, 10 Mar 2025 01:03:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741593785; x=1742198585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUXALxltmaZpj+QULpZ9mOYplNM+oXSkx8amdFd68t0=;
        b=hi/J76i8iuClxdK7ayshfSXFUgUnWBuip8czkSEKfE5WroeEqYvpOXlH3o9OIzBXCf
         YqcdtC/TfRLG6zhkOFzyXPL7L+oyXaGStMV30IH3ahfSBSDhE4ekThvXNk8/nDovIZfg
         BDYvigfdF/XFfxuSQNtdas3WKXRuY+P8ymS5QXjaxb9MpzIq18i2vUTIabgH8JiC6BFN
         br+ZkM5mwFqpWeuS2tyVQCp7+Tms18jUtPNecexn8BLestvrQB0/fKA5CUYyG9rNeUjr
         ejM6czaLueQZwYNFy4EZ5oQSrslmMoSOr/FymTXvf36GIBkjUQYWyzF3RNMBhucurdgN
         4h3g==
X-Forwarded-Encrypted: i=1; AJvYcCX6NlNaQIHMgWMe+sfu9Ry0dkjVFWCWhUMbNHG0LoBe/XDMFzLvv2MmsyzDAY7D6ApDmhB9dLco@vger.kernel.org
X-Gm-Message-State: AOJu0YzFh7kMNKnFjjNIARRCVSr9m6JXoJh+w27EoB+XgAg0mGKDIg7b
	FourpToDGiZUYoUBb/I2VC6wHP7JBshqRU2z3qKg20riGqnqrUkJIcZ3oqH1M3J/lmNQL2bQscZ
	LOTOwtflwH5bVs+flWR8UDf3lB+GnVxESwQNYdOalB2m4xVIJ/FjgljT1F+Uaa64u4g==
X-Gm-Gg: ASbGncu2BZj01fhdgjI/mNvwHoyKz8SfGGcrFUjIlH6hQ4q8QQFeuLF3RvvMAFbm/q7
	TcmPfuWQxmC5KrYPJ7nnriSfjnWvUPZzJkeZK+1nDzxGbfa5govlN9XaBrLbhwVfA1kLvnyOdot
	wyHBy2HB6BZQmgSBtRoR4S04jsdqW0hUM2QGij0F2Ug5Xj4QvZ0JrFuz80zK4BoBP8hs8ztQggx
	cJLrFzs1kpM10DL8QeOYmTg/gV4y9l412SRb/bfamGuY+Lb12w8WTXjIyDkFHm1xx3tWKzOBSs1
	aqfEpiqlFe5+0o0jjREqoECxVvqSOBfwMtgSaapTU2NPpf+6mWA+Aw3a
X-Received: by 2002:a17:90b:4c44:b0:2fc:a3b7:1096 with SMTP id 98e67ed59e1d1-2ff7cf128c2mr19974608a91.27.1741593785168;
        Mon, 10 Mar 2025 01:03:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/fPGQPoLD3g3f5weSujfZfGcb7ysyP5LcmQV0AwZdXmgjt59/dkPBihuAiaciymYjD7qtTw==
X-Received: by 2002:a17:90b:4c44:b0:2fc:a3b7:1096 with SMTP id 98e67ed59e1d1-2ff7cf128c2mr19974570a91.27.1741593784695;
        Mon, 10 Mar 2025 01:03:04 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693e7393sm7272399a91.31.2025.03.10.01.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 01:03:04 -0700 (PDT)
Date: Mon, 10 Mar 2025 16:02:59 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: David Disseldorp <ddiss@suse.de>, Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org, jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/4] common/config: remove redundant export of
 F2FS_IO_PROG
Message-ID: <20250310080259.6ormkanynd7l2yrd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250306081809.2397527-1-chao@kernel.org>
 <20250307145629.2b2c6e99.ddiss@suse.de>
 <20250310071636.gombdbhdfbqxwib5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310071636.gombdbhdfbqxwib5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Mon, Mar 10, 2025 at 03:16:36PM +0800, Zorro Lang wrote:
> On Fri, Mar 07, 2025 at 02:56:29PM +1100, David Disseldorp wrote:
> > On Thu,  6 Mar 2025 16:18:06 +0800, Chao Yu wrote:
> > 
> > > F2FS_IO_PROG was been exported twice, remove the redudant one.
> > > 
> > > Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > ---
> > >  common/config | 1 -
> > >  1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/common/config b/common/config
> > > index 2afbda14..8d3047a5 100644
> > > --- a/common/config
> > > +++ b/common/config
> > > @@ -191,7 +191,6 @@ export XFS_COPY_PROG="$(type -P xfs_copy)"
> > >  export FSTRIM_PROG="$(type -P fstrim)"
> > >  export DUMPE2FS_PROG="$(type -P dumpe2fs)"
> > >  export RESIZE2FS_PROG="$(type -P resize2fs)"
> > > -export F2FS_IO_PROG="$(type -P f2fs_io)"
> > >  export FIO_PROG="$(type -P fio)"
> > >  export FILEFRAG_PROG="$(type -P filefrag)"
> > >  export E4DEFRAG_PROG="$(type -P e4defrag)"
> > 
> > Looks good. @Zorro, might as well squash in removal of the duplicate
> > TIMEOUT_PROG export too.
> 
> Sure, I roughly tried to find all duplication by:
> 
>   $ for prog in `sed -n "/export/s/export \(.*_PROG\)=.*/\1/p" common/config `;do n=`grep -E "\b$prog=" common/config|wc -l`;if [ $n -gt 1 ];then grep "\b$prog=" common/config;fi;done
> 
> Currently only found F2FS_IO_PROG and TIMEOUT_PROG. So I'll change this patch
> commit to:
> 
>   common/config: remove redundant export variables
> 
>   F2FS_IO_PROG and TIMEOUT_PROG are exported twice, remove the
>   redundant one.

Hi Chao,

As you need to change patch 4/4 more. I thought you might change others, so
please change this patch refer to below:)

Thanks,
Zorro

Author: Chao Yu <chao@kernel.org>
Date:   Thu Mar 6 16:18:06 2025 +0800

    common/config: remove redundant export variables
    
    F2FS_IO_PROG and TIMEOUT_PROG are exported twice, remove the redudant
    one.
    
    Cc: Jaegeuk Kim <jaegeuk@kernel.org>
    Signed-off-by: Chao Yu <chao@kernel.org>
    Reviewed-by: David Disseldorp <ddiss@suse.de>


diff --git a/common/config b/common/config
index 2afbda141..aa5258250 100644
--- a/common/config
+++ b/common/config
@@ -191,7 +191,6 @@ export XFS_COPY_PROG="$(type -P xfs_copy)"
 export FSTRIM_PROG="$(type -P fstrim)"
 export DUMPE2FS_PROG="$(type -P dumpe2fs)"
 export RESIZE2FS_PROG="$(type -P resize2fs)"
-export F2FS_IO_PROG="$(type -P f2fs_io)"
 export FIO_PROG="$(type -P fio)"
 export FILEFRAG_PROG="$(type -P filefrag)"
 export E4DEFRAG_PROG="$(type -P e4defrag)"
@@ -220,7 +219,6 @@ export UBIUPDATEVOL_PROG="$(type -P ubiupdatevol)"
 export THIN_CHECK_PROG="$(type -P thin_check)"
 export PYTHON3_PROG="$(type -P python3)"
 export SQLITE3_PROG="$(type -P sqlite3)"
-export TIMEOUT_PROG="$(type -P timeout)"
 export SETCAP_PROG="$(type -P setcap)"
 export GETCAP_PROG="$(type -P getcap)"
 export CAPSH_PROG="$(type -P capsh)"

> 
> Thanks,
> Zorro
> 
> > 
> > Reviewed-by: David Disseldorp <ddiss@suse.de>
> > 

