Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E221A130AC6
	for <fstests@vger.kernel.org>; Tue,  6 Feb 2024 13:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707226364; cv=none; b=AhbBkzVD/mKIwihXu39Udyw9wKIL4NovLjhRTakGAGWP7IdhRuXzxAiAugCJdEjhmkd86oQ3QU5bJtKdAAAJCd/U1O1AdrMm/kh8ylFvbqz6Ew0pwollbBqpiQwS1/PGvULLhnKBdX1vVSsHFwPnCKHeJ7BJAUA7G0vj85+xp2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707226364; c=relaxed/simple;
	bh=SwHkAnz8ehUJIMgNPrGGQyE1nHrQwB1Z05/0ybQ3ypA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jziR5ihRkxgqVpOGpA5NZ7IKy0uq7vYYSBcqWaeyZmT+MEsJhXzqJPBrm5h8FGqaJNYwLDkEwYwtjhGgPd24CUfwWwMTrlP3D1b8hatskCFl4Zv7+xUH0mtnSwbuwyzYf0JjIiAVd4jMY69Fdrx0H2vhprPZ1Xkn647f6r8BBIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jLybdjEC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jLybdjEC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707226361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R6UzoqHKwSqz0Lycr7ptpsW/SoDnodm/EqacVsGC3Y4=;
	b=jLybdjECG1xGCsf6/qhjQ3JPtsSzMVQEulkbSY2NNGPOImq8/7oIf0Z1oef5O5u3Dz3WDc
	yslF4dQHfzoZr6GpFkujF6r34eeYl91FdravsifbGEIkaAfIkA3jcmnUYajJgCgHupxBu4
	WKXJB03V/H5WpRKTclR10oY/b3bcTWg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-N5zW-qd0Mye0FbN2xvLTNg-1; Tue, 06 Feb 2024 08:32:40 -0500
X-MC-Unique: N5zW-qd0Mye0FbN2xvLTNg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-29679438039so1897120a91.2
        for <fstests@vger.kernel.org>; Tue, 06 Feb 2024 05:32:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707226359; x=1707831159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6UzoqHKwSqz0Lycr7ptpsW/SoDnodm/EqacVsGC3Y4=;
        b=I5BB7MByd5wpWZQb0KMaltPyEFyDjNy7Tm4b74GwCseK6pYZuUXavtcIJuAT430vN9
         V7351fy3AhDIXlpts4qetEZFWmWasunxLKHKZCRgdazH1qxXBcMrZ5Ek4sMOMeofPThh
         M/qj6ocbACi/0ofr/mVgiXE81kagtcGhmnBXIcRko7h5+9POQbwrreyD+RYsXglVl21f
         SmE1dv7CUxKyHX/FdDsH3+vhBrNTW0/0UTZEhhRS+3rMsl60TZVHBIm6YvLeJQ+3sRTr
         TDuw87xhfWtATR39Cn49SSUTRzT/BI9EK9qqQUg+AqM9y0nZx183JqqlzittmE15phoA
         bqrQ==
X-Gm-Message-State: AOJu0YxMxUUpTsOqKoNQ1l3ueZMC8gOaENYw/VZWgbp//wPOyok6bDly
	X3GWFHtk2LQGTKoSd8MeKmUQGc/vI/clxbOg6GyZcuhMTbObNUbLrMK3efIlnhdolhOsuY8b8Vp
	0jtk1jTzES+g+AgH6aveK4bFXXnUW16dTH1oOPAnOWwCyvn/NsCSLxmE=
X-Received: by 2002:a17:90a:5646:b0:296:6e5b:1b52 with SMTP id d6-20020a17090a564600b002966e5b1b52mr2325463pji.3.1707226359366;
        Tue, 06 Feb 2024 05:32:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUy0/f/IrvgR01tLKEEX6eKI11M0kepWKOi9wjcVK5/V/Gz+Q7h92y1Y7FD0YhCUqFeQcGdg==
X-Received: by 2002:a17:90a:5646:b0:296:6e5b:1b52 with SMTP id d6-20020a17090a564600b002966e5b1b52mr2325446pji.3.1707226359028;
        Tue, 06 Feb 2024 05:32:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXG3EbpjmLsi5HrZ8WAU0uIXPJBvwgUCwCLDdXY0YmLk8HLIp5xvZ+0YGVhfgpG5XufDxKQfv7qOowxPW+/km73beKGcibv1wo9l6clBj0tDuNgLcmSoDClONpmyjbe/FRSi40i
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id v13-20020a17090abb8d00b002966248d75bsm1563924pjr.49.2024.02.06.05.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 05:32:38 -0800 (PST)
Date: Tue, 6 Feb 2024 21:32:35 +0800
From: Zorro Lang <zlang@redhat.com>
To: David Sterba <dsterba@suse.cz>
Cc: Yang Xu <xuyang2018.jy@fujitsu.com>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] t_snapshot_deleted_subvolume: add check for
 BTRFS_IOC_SNAP_DESTROY_V2
Message-ID: <20240206133235.rizvxggjnsv2ppcf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240201042348.147733-1-xuyang2018.jy@fujitsu.com>
 <20240205154907.GH355@twin.jikos.cz>
 <20240206101005.u2mrxlg4pg3cdoxq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240206120201.GL355@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206120201.GL355@twin.jikos.cz>

On Tue, Feb 06, 2024 at 01:02:01PM +0100, David Sterba wrote:
> On Tue, Feb 06, 2024 at 06:10:05PM +0800, Zorro Lang wrote:
> > On Mon, Feb 05, 2024 at 04:49:07PM +0100, David Sterba wrote:
> > > On Wed, Jan 31, 2024 at 11:23:48PM -0500, Yang Xu wrote:
> > > > @@ -20,11 +20,6 @@
> > > >  #define BTRFS_IOCTL_MAGIC 0x94
> > > >  #endif
> > > >  
> > > > -#ifndef BTRFS_IOC_SNAP_DESTROY_V2
> > > > -#define BTRFS_IOC_SNAP_DESTROY_V2 \
> > > > -	_IOW(BTRFS_IOCTL_MAGIC, 63, struct btrfs_ioctl_vol_args_v2)
> > > > -#endif
> > > > -
> > > >  #ifndef BTRFS_IOC_SNAP_CREATE_V2
> > > >  #define BTRFS_IOC_SNAP_CREATE_V2 \
> > > >  	_IOW(BTRFS_IOCTL_MAGIC, 23, struct btrfs_ioctl_vol_args_v2)
> > > > @@ -58,6 +53,11 @@ struct btrfs_ioctl_vol_args_v2 {
> > > >  };
> > > >  #endif
> > > >  
> > > > +#if !HAVE_DECL_BTRFS_IOC_SNAP_DESTROY_V2
> > > 
> > > This is right for AC_CHECK_DECLS. Other macros like AC_CHECK_HEADERS do
> > > not define the HAVE_... in case it's not found so the #if !HAVE_...
> > > would be wrong. Slightly confusing.
> > 
> > Won't AC_CHECK_HEADERS define the HAVE_... ? But how do we get the ...
> > 
> >   /* Define to 1 if you have the <linux/falloc.h> header file. */
> >   #define HAVE_LINUX_FALLOC_H 1
> > 
> > in include/config.h file?
> 
> Yes the HAVE_ macros are defined, just that it actually also defines
> 
> #define HAVE_LINUX_FALLOC_H 0

Oh I didn't find that in my local fstests code (has been built), I got
something likes this in include/config.h (for defined or un-defined):

  /* Define to 1 if you have the <cifs/ioctl.h> header file. */
  /* #undef HAVE_CIFS_IOCTL_H */

  /* Define to 1 if you have the declaration of `BTRFS_IOC_SNAP_DESTROY_V2', and
     to 0 if you don't. */
  #define HAVE_DECL_BTRFS_IOC_SNAP_DESTROY_V2 1

> 
> if not found, unlike other macros result in
> 
> /* #undef HAVE_SOME_FUNCTION */
> 
> What you did will work, the inconsistency is in the autoconf macros.

But I'm not familar with these AC_CHECK things:) Maybe its behavior isn't
sure, AC_CHECK_DECLS is sure to define HAVE_.... to 1, AC_CHECK_HEADERS is
sure to have a definition but not sure what's defined. Do you mean that?

BTW, I think you're not nacking this patch, right? :)

Thanks,
Zorro

> 

