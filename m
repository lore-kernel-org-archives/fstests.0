Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F234712DDAB
	for <fstests@vger.kernel.org>; Tue,  6 Feb 2024 10:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214214; cv=none; b=XJw1m4yQcx7fQPy62BREetXp5ZRX5s6fDs0gkKPHWZ7vnsus8Oz/SGnJ6jJ8Y5D5b6P5psNH4Ikd70j0ydQVezEPoDvbZih1+sJHqhFcsYdJUtc4wfaje+iyI7imsn6CW6Zoqh1id3nKjcQAV0kvcbieAg5HK2g1MFeGKh+sML0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214214; c=relaxed/simple;
	bh=EgSUeGebQnSRJfUEx2dIrzdteRsVOxSkT50qhRTUuLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTAlfitPNHujRNkZHehgKklov9qWoLQWFBMAqQH7M3A34Mep5wcPIHeQU3FzAvw9BBhbVsYVAP8ztjz00gVSxe/tgtlHPFxQG4koyY7TGoy98WBcYqxe+D49VViecutl8uxVeIGPycTHLbhdcbl/qAgj8DPTYFF8KstQy3e2WVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LVboTe33; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LVboTe33"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707214211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vHtubRirqOovtn7kGFulpYpT0oD4rdJIknKtVCq1HNs=;
	b=LVboTe33gbozDwWK4PVB2Yc7qEkXnOAaG0iCZXPuoVfqsKgyQrLYwT1CzTM2sx8WWmCllT
	6HcmwKi7fyi1T9uj1maA62sBN607kEKlsLzUSbS9cVqzfMu4ETFEhe077rtM+pJCM3v2v9
	KGyvHL384hzHJ32OPuvd3B/kIn/3MYs=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-a_ECz4nsPou1mZbQklZykA-1; Tue, 06 Feb 2024 05:10:09 -0500
X-MC-Unique: a_ECz4nsPou1mZbQklZykA-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3bfdc3758a0so2308356b6e.3
        for <fstests@vger.kernel.org>; Tue, 06 Feb 2024 02:10:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707214209; x=1707819009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHtubRirqOovtn7kGFulpYpT0oD4rdJIknKtVCq1HNs=;
        b=FyeK3T6184xKR7O2RPg4M8QdzZFv8OMcmf+I5k/ojPMrU+48Dxp5R2AEBRxaYCFtb3
         q+EQRrgcI4GWaAQaEBAYQw82oWvRB2etZxW4lw6veSqe4n5zqTQnGGVND0Krhq7GdQwk
         zXPejzu+RBGuYI+Mx1P4eefY1dKKS4toeCpG19aRAXftuh/gQwQkYWb92bg41+LTstiR
         kvI5Om3FHbygze6joTiQQ7+cnx6CMzKIY+XN9H0Rv30t5YKc0NqRWlRZWNWmtp/5ADqK
         SH0Rl52gT2G0M0AvqWZ9z++2dW2BYqTScoaQwWNHA6oE0dp4ohN6to4dmILylNu6/yYa
         U5mw==
X-Gm-Message-State: AOJu0Yw3VoST4ZRyKLagUh3oscrJJzpSefX38UO17hJ4T5DUrTfbHqps
	MhzAyFJvUBURplKPVcfpalYSvaCRFkhQ+j9ukqIL2CO3+VeNYw/upXGLKC7O+dF2tv6Y/LaCS2V
	zl1lm/frv/QRwnzuTbCYVaVotDR7h0WNw3oD9CFRnAVYMm79XpS+SaCU=
X-Received: by 2002:a05:6808:114c:b0:3be:84c0:4914 with SMTP id u12-20020a056808114c00b003be84c04914mr2745688oiu.48.1707214209039;
        Tue, 06 Feb 2024 02:10:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5JRmV9GM91w6Df9+3fnPlVXZWNXgGBIg/A343mhio+WZJ+cVuOn9aarDPeUtYwLZZrf9yyA==
X-Received: by 2002:a05:6808:114c:b0:3be:84c0:4914 with SMTP id u12-20020a056808114c00b003be84c04914mr2745680oiu.48.1707214208800;
        Tue, 06 Feb 2024 02:10:08 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWKs6VEdt2xevWNpO1w1J8AK1OSYhvpqjHx+ZdjzGx7yIa0ND3m91OnLBwNtqqPgxumjPB2UucwrbQqzZ0YPH3wyq2/aQ/vn5t7bN3UXHmyzejpLzFLZCqNMU/RbePRpcJcm7kj
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id w20-20020aa78594000000b006e046c04b81sm1505292pfn.147.2024.02.06.02.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 02:10:08 -0800 (PST)
Date: Tue, 6 Feb 2024 18:10:05 +0800
From: Zorro Lang <zlang@redhat.com>
To: David Sterba <dsterba@suse.cz>
Cc: Yang Xu <xuyang2018.jy@fujitsu.com>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] t_snapshot_deleted_subvolume: add check for
 BTRFS_IOC_SNAP_DESTROY_V2
Message-ID: <20240206101005.u2mrxlg4pg3cdoxq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240201042348.147733-1-xuyang2018.jy@fujitsu.com>
 <20240205154907.GH355@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205154907.GH355@twin.jikos.cz>

On Mon, Feb 05, 2024 at 04:49:07PM +0100, David Sterba wrote:
> On Wed, Jan 31, 2024 at 11:23:48PM -0500, Yang Xu wrote:
> > On some platform, struct btrfs_ioctl_vol_args_v2 is defined, but the
> > macros BTRFS_IOC_SNAP_DESTROY_V2 is not defined. This will cause
> > compile error. Add check for BTRFS_IOC_SNAP_DESTROY_V2 to solve this
> > problem.
> > 
> > BTRFS_IOC_SNAP_CREATE_V2 and BTRFS_IOC_SUBVOL_CREATE_V2 were
> > introduced together with struct btrfs_ioctl_vol_args_v2 by the
> > commit 55e301fd57a6 ("Btrfs: move fs/btrfs/ioctl.h to
> > include/uapi/linux/btrfs.h"). So there is no need to check them.
> > 
> > Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> > ---
> >  configure.ac                       |  1 +
> >  src/t_snapshot_deleted_subvolume.c | 10 +++++-----
> >  2 files changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/configure.ac b/configure.ac
> > index b22fc52b..b14b1ab8 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -109,6 +109,7 @@ AC_CHECK_MEMBERS([struct btrfs_ioctl_vol_args_v2.subvolid], [], [], [[
> >  #include <stddef.h>
> >  #include <linux/btrfs.h>
> >  ]])
> > +AC_CHECK_DECLS([BTRFS_IOC_SNAP_DESTROY_V2],,,[#include <linux/btrfs.h>])
> >  
> >  AC_CONFIG_HEADERS([include/config.h])
> >  AC_CONFIG_FILES([include/builddefs])
> > diff --git a/src/t_snapshot_deleted_subvolume.c b/src/t_snapshot_deleted_subvolume.c
> > index c3adb1c4..402c0515 100644
> > --- a/src/t_snapshot_deleted_subvolume.c
> > +++ b/src/t_snapshot_deleted_subvolume.c
> > @@ -20,11 +20,6 @@
> >  #define BTRFS_IOCTL_MAGIC 0x94
> >  #endif
> >  
> > -#ifndef BTRFS_IOC_SNAP_DESTROY_V2
> > -#define BTRFS_IOC_SNAP_DESTROY_V2 \
> > -	_IOW(BTRFS_IOCTL_MAGIC, 63, struct btrfs_ioctl_vol_args_v2)
> > -#endif
> > -
> >  #ifndef BTRFS_IOC_SNAP_CREATE_V2
> >  #define BTRFS_IOC_SNAP_CREATE_V2 \
> >  	_IOW(BTRFS_IOCTL_MAGIC, 23, struct btrfs_ioctl_vol_args_v2)
> > @@ -58,6 +53,11 @@ struct btrfs_ioctl_vol_args_v2 {
> >  };
> >  #endif
> >  
> > +#if !HAVE_DECL_BTRFS_IOC_SNAP_DESTROY_V2
> 
> This is right for AC_CHECK_DECLS. Other macros like AC_CHECK_HEADERS do
> not define the HAVE_... in case it's not found so the #if !HAVE_...
> would be wrong. Slightly confusing.

Won't AC_CHECK_HEADERS define the HAVE_... ? But how do we get the ...

  /* Define to 1 if you have the <linux/falloc.h> header file. */
  #define HAVE_LINUX_FALLOC_H 1

in include/config.h file?

> 
> > +#define BTRFS_IOC_SNAP_DESTROY_V2 \
> > +	_IOW(BTRFS_IOCTL_MAGIC, 63, struct btrfs_ioctl_vol_args_v2)
> > +#endif
> > +
> >  int main(int argc, char **argv)
> >  {
> >  	if (argc != 2) {
> > -- 
> > 2.39.3
> > 
> 

