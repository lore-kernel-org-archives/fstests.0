Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E94A13248D
	for <fstests@vger.kernel.org>; Tue,  6 Feb 2024 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707233545; cv=none; b=jUpeexjrpzGuV0RvPnsNLXxv/IaPm710aIp2WTfWbectraiTaAjn6ROD82gLA/B430v+CE7fbQs+5We26peWigUJNmOYgdWEWM/REKzZ1AvtN1XTVJGovlZkRSFYdsuMy4rYD7FumYhMy08cBmPm0cE/2F+TePJ+okoEcuSvjQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707233545; c=relaxed/simple;
	bh=htugNKRtAjDwWUOcNqrI1Z/+Fg56uIKOC2oofj1LI8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHpwAmbhSztxDa/Izx415JH5124ULeTIbqzv38yThlWo3n+ELiz+PfKZosuR5DlYwzm9qfnG2WHzAzJDIYuZG2A5kMafCKi0lfFti/ASzyyHswM0emoOAi1sB8Pa4OsIn10IUi9uUCF5j7go6o+nwZ+LsQVT3t1UplXHEZwnLjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JADjTGjL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JADjTGjL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707233542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TwNbIvQp9WKki6i/Bhj1rpyc5/m7hrq9Fqpz1dobI6s=;
	b=JADjTGjL9Wb9/7fnQ/aYZuu2dq+oZQcKjw1cbonnQUyosRsgu3zvL8Bcu41zTxuBjA6Bte
	28BkA8BOSa1nYWCXFLaFQy18nitVMrSJQcP+yAGOYYCoeGSnFD3UpanLmECkjCEs5BWWPZ
	xnQbJDYZjtBxiyZUGTr2iau2RKWFBFE=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-Jo5jEnuJMgGsnLUfzDIRkQ-1; Tue, 06 Feb 2024 10:32:20 -0500
X-MC-Unique: Jo5jEnuJMgGsnLUfzDIRkQ-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-360c3346ecbso39671135ab.1
        for <fstests@vger.kernel.org>; Tue, 06 Feb 2024 07:32:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707233539; x=1707838339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwNbIvQp9WKki6i/Bhj1rpyc5/m7hrq9Fqpz1dobI6s=;
        b=oTDmLr2GNOUVysFVL3WWZDi9YsCNK+dBwhBviO6RDr8uII4W+O1PIn4npg/Gw0/zpY
         LqTKcBRmxGrY9v93C9svmiLkQwti8uuOaAj3ypEIfWG+b/tizQXp4V8ABDXXhSmfe4qI
         IkOKkJBl0Xg/9gTFuUPYgJl+Rycanbq/BMLLzwXkGSmXqGdDGmftdjjTY2vbybR2VzGw
         mZ3JjHDTdBkikUBqJ8Ov01PoRne//gEqQFk/zZYvv79jyuUseXtyuswrWSEd8LOBU+1w
         VTIT3OSEqRumtpVv7aq0haiGx8GZhE/GAyrmR7vTdsJgL3c8DuqhtNKrJJkCdS/6C2YU
         E3vA==
X-Gm-Message-State: AOJu0Ywjw610QkwgbpclNBtyC6WbDfiV7b3jxE8NLAKJ2XZ0w77GeQXf
	9xIfYdg50TuKJ66gmim+ZqbBeDkSIu0yRuTsSCUDuhr66j4l6QS5SDS76a/itE9gHb0udxJrTeb
	MWi9ro8s3av49fYZrw3JFtRQMu/fogJ0rN2Har9PAm3TxXeSMwkv3xQ+DIftMXxt59Q==
X-Received: by 2002:a92:cf0f:0:b0:363:bf96:560 with SMTP id c15-20020a92cf0f000000b00363bf960560mr3195995ilo.15.1707233538744;
        Tue, 06 Feb 2024 07:32:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFk3nAsAhunUYLoB5bLEdrBenTx/Cn1YVJ9bMn8wV9vdazRRbMwlmytflY1NKryKxbAOhn7uw==
X-Received: by 2002:a92:cf0f:0:b0:363:bf96:560 with SMTP id c15-20020a92cf0f000000b00363bf960560mr3195980ilo.15.1707233538481;
        Tue, 06 Feb 2024 07:32:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVRxCocyMNjTKcRwK8mYBcPOVJm3H8A0Q7kLXU/aBSXy9xjOY1SgjyCptTtZZJgsRo+8aC3hBI7ZvW/Rcmi2dkqkY7OzGPl+SOvbQ1oTAqCYraYEdy40NATNBn0eb1Amn7oEEm8
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e3-20020a63db03000000b005d66caee3d0sm2249168pgg.22.2024.02.06.07.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 07:32:18 -0800 (PST)
Date: Tue, 6 Feb 2024 23:32:14 +0800
From: Zorro Lang <zlang@redhat.com>
To: David Sterba <dsterba@suse.cz>
Cc: Yang Xu <xuyang2018.jy@fujitsu.com>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] t_snapshot_deleted_subvolume: add check for
 BTRFS_IOC_SNAP_DESTROY_V2
Message-ID: <20240206153214.kskmv2ug7b7rmtdq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240201042348.147733-1-xuyang2018.jy@fujitsu.com>
 <20240205154907.GH355@twin.jikos.cz>
 <20240206101005.u2mrxlg4pg3cdoxq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240206120201.GL355@twin.jikos.cz>
 <20240206133235.rizvxggjnsv2ppcf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240206134713.GO355@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206134713.GO355@twin.jikos.cz>

On Tue, Feb 06, 2024 at 02:47:13PM +0100, David Sterba wrote:
> On Tue, Feb 06, 2024 at 09:32:35PM +0800, Zorro Lang wrote:
> > On Tue, Feb 06, 2024 at 01:02:01PM +0100, David Sterba wrote:
> > > On Tue, Feb 06, 2024 at 06:10:05PM +0800, Zorro Lang wrote:
> > > > On Mon, Feb 05, 2024 at 04:49:07PM +0100, David Sterba wrote:
> > > > > On Wed, Jan 31, 2024 at 11:23:48PM -0500, Yang Xu wrote:
> > > > > > @@ -20,11 +20,6 @@
> > > > > >  #define BTRFS_IOCTL_MAGIC 0x94
> > > > > >  #endif
> > > > > >  
> > > > > > -#ifndef BTRFS_IOC_SNAP_DESTROY_V2
> > > > > > -#define BTRFS_IOC_SNAP_DESTROY_V2 \
> > > > > > -	_IOW(BTRFS_IOCTL_MAGIC, 63, struct btrfs_ioctl_vol_args_v2)
> > > > > > -#endif
> > > > > > -
> > > > > >  #ifndef BTRFS_IOC_SNAP_CREATE_V2
> > > > > >  #define BTRFS_IOC_SNAP_CREATE_V2 \
> > > > > >  	_IOW(BTRFS_IOCTL_MAGIC, 23, struct btrfs_ioctl_vol_args_v2)
> > > > > > @@ -58,6 +53,11 @@ struct btrfs_ioctl_vol_args_v2 {
> > > > > >  };
> > > > > >  #endif
> > > > > >  
> > > > > > +#if !HAVE_DECL_BTRFS_IOC_SNAP_DESTROY_V2
> > > > > 
> > > > > This is right for AC_CHECK_DECLS. Other macros like AC_CHECK_HEADERS do
> > > > > not define the HAVE_... in case it's not found so the #if !HAVE_...
> > > > > would be wrong. Slightly confusing.
> > > > 
> > > > Won't AC_CHECK_HEADERS define the HAVE_... ? But how do we get the ...
> > > > 
> > > >   /* Define to 1 if you have the <linux/falloc.h> header file. */
> > > >   #define HAVE_LINUX_FALLOC_H 1
> > > > 
> > > > in include/config.h file?
> > > 
> > > Yes the HAVE_ macros are defined, just that it actually also defines
> > > 
> > > #define HAVE_LINUX_FALLOC_H 0
> > 
> > Oh I didn't find that in my local fstests code (has been built), I got
> > something likes this in include/config.h (for defined or un-defined):
> > 
> >   /* Define to 1 if you have the <cifs/ioctl.h> header file. */
> >   /* #undef HAVE_CIFS_IOCTL_H */
> > 
> >   /* Define to 1 if you have the declaration of `BTRFS_IOC_SNAP_DESTROY_V2', and
> >      to 0 if you don't. */
> >   #define HAVE_DECL_BTRFS_IOC_SNAP_DESTROY_V2 1
> > 
> > > 
> > > if not found, unlike other macros result in
> > > 
> > > /* #undef HAVE_SOME_FUNCTION */
> > > 
> > > What you did will work, the inconsistency is in the autoconf macros.
> > 
> > But I'm not familar with these AC_CHECK things:) Maybe its behavior isn't
> > sure, AC_CHECK_DECLS is sure to define HAVE_.... to 1, AC_CHECK_HEADERS is
> > sure to have a definition but not sure what's defined. Do you mean that?
> > 
> > BTW, I think you're not nacking this patch, right? :)
> 
> No I'm not, sorry if this was confusing, it was a comment about the
> autoconf macros and how are the defines supposed to be checked. We once
> had a bug where
> 
> #ifdef MACRO
> 
> vs
> 
> #if MACRO
> 
> was not doing the same thing because of the sometimes/always defined
> semantics.

Sure, thanks for this clarification, and the double checking from you :)

> 

