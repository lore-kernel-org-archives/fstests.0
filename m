Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0CC25765
	for <fstests@vger.kernel.org>; Fri, 17 Jan 2025 04:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737087081; cv=none; b=PI9zoQf3pRFK6gAQwP30dTH/SwTfxxZWz3jr9rvIFZBkT0IOofu12XjfqoJQ0wLzQ8EQ1PbrKDqPQyRbhBvxPB6ovmlfRXrv2RSLWRqPwckaIBD27Pb96mhs9GuzOlbxOj9cik/qqWF4nQVDcWs4TAdg5DZNlsg+/22TAWYdjyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737087081; c=relaxed/simple;
	bh=N5UrfYvIBPPNzZnxqDkGRPUZyAH/wvNde5Rg8Xzqvuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnpdDRtZdq1rjg33TbGXV/3j1gfgmD7YKB29507D0bNj7BCllanO1O2eIhSq954/ywqTpEFjcKTeov3hg9v4tdKmCBfF7XFvKAdE5/3JMhsDhjN/PsKZeMPy4tS6O6P72esG4jDRoqbD3OIErMYWK5WTNAXN3Fm3Iyd2JMAwp2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C9CmHsDZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C9CmHsDZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737087078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3GKid36pExIKM6SSvDXClZJolP/vClzEqLuiOEDcBQo=;
	b=C9CmHsDZ7T2aVhNEZ/WYEHb4gBi3T1bO+OYs7d40qYDEN3AldNXKTjavxtgnuO+VKb2Mro
	DKFKImW/yBVgG1tekRriN4rN3veMBaAxlDwIp22aFflHmiTQ6RwOu8zru7Tdg3LBd6mAs3
	Wv2U1SRW+Wg1zrL7mTvGshQlDPrlk3Y=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-pP1fjRqqMi-xwvmjKuw2sg-1; Thu, 16 Jan 2025 23:11:16 -0500
X-MC-Unique: pP1fjRqqMi-xwvmjKuw2sg-1
X-Mimecast-MFC-AGG-ID: pP1fjRqqMi-xwvmjKuw2sg
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2f46b7851fcso4754838a91.1
        for <fstests@vger.kernel.org>; Thu, 16 Jan 2025 20:11:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737087075; x=1737691875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GKid36pExIKM6SSvDXClZJolP/vClzEqLuiOEDcBQo=;
        b=FpeBhNHhSBzp+lElQD5bSFynVMQeGM3cPK7aUZOAiNdRz2hKbEnVt44O39/89uWuW6
         1UxSZZ+DHviBwNgA2N5/QNKNyUmVLtAsi3nggmMaLfn1NGOI68F7P3jEpVR6lI4nrQil
         9DglrcyF7Y0JWF1RfgPN4By0zHWKmzEE3/EwivMHkPZQGJ6A7JdeUyobWOo5SYXvSpxD
         tlk+avtMmL85OPZjlwVRg480RcywH2i52vTPmxb9dM5IQVxPbZPx5vEEMVjLbdPMbxga
         jUPm9WLyKGeARLkJtaevGW2RtvN8ZDMOlxLU3rISsR4O7SZoqty5PlyxcxXbzNBC8vmb
         NBtg==
X-Forwarded-Encrypted: i=1; AJvYcCUOKaiIh+G1LVUYf1lFd7Il2V/jXxenTd06gACBJqZ9G5GHrRtqmQeybDs/o9NrDcxTDk4bmscZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxnXTNj5Zmzo/sCLTUTc6XkUTHWonUc5Lvctj9wlcK+07UACudT
	8f+ivHwavQm1wUt+ot8KN6E5U4QmHqmbPmJ2mX4MM8JEdkPRieE0s8i9DXZy+nXFU48jkTVStoU
	ydZBoffxoy8CBsm6NwDzcg9eTw9HgbrH+Nw/LgTQqAfSKv8W64T06z2mKLH+n6lI=
X-Gm-Gg: ASbGncs8q/DQ4vsyT20e45PxJkSHeL5avO6Axx8pVI+Wp9FNrXaeZXbIAUU6OfNbNLm
	tgPMn5PCNeBI+3sVaNWB6PT0NCUL8sKhKTIDuzf2eNyKCYzXbRJtcerdP7XUK1m6OBMlR5eusnB
	JHlZb1HRgyEyGO9as4NyMDtLm7fndBeMzH3WHGhwkH1ZYzblzrlqhr7gWz8WPfn68NCo8TBU7Rv
	ZOCAbkTv8f65VM0VoiK4AjLVkm+DhxG/g51DSpeoGreLaUhPDuVJ9B4jP5ltmDI5RHuhQtakOxM
	x/VIH5cgmg8Z+rYXAydO1g==
X-Received: by 2002:a05:6a00:a38d:b0:725:eb85:f7f7 with SMTP id d2e1a72fcca58-72daf9be748mr1868091b3a.5.1737087075579;
        Thu, 16 Jan 2025 20:11:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyILsPD00DqZ06LS332oUz+RgvyZCbDh8PL8Yuuzh98POWHgPIpEvRqeJead3b4WZCn4dRNw==
X-Received: by 2002:a05:6a00:a38d:b0:725:eb85:f7f7 with SMTP id d2e1a72fcca58-72daf9be748mr1868065b3a.5.1737087075220;
        Thu, 16 Jan 2025 20:11:15 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab848321sm824716b3a.76.2025.01.16.20.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 20:11:14 -0800 (PST)
Date: Fri, 17 Jan 2025 12:11:11 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Shiyang Ruan <ruansy.fnst@fujitsu.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] include/builddefs.in: ignore unused-result warning
Message-ID: <20250117041111.imwliminwcsk73xc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250106095906.330877-1-ruansy.fnst@fujitsu.com>
 <20250115153327.izjczrhtpd2yjfjc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20250115214547.GG3557695@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115214547.GG3557695@frogsfrogsfrogs>

On Wed, Jan 15, 2025 at 01:45:47PM -0800, Darrick J. Wong wrote:
> On Wed, Jan 15, 2025 at 11:33:27PM +0800, Zorro Lang wrote:
> > On Mon, Jan 06, 2025 at 05:59:06PM +0800, Shiyang Ruan wrote:
> > > When build xfstests, a lot of "unused result" warning are reported:
> > > 
> > >     [CC] write_log.lo
> > > write_log.c: In function 'wlog_record_write':
> > > write_log.c:205:13: warning: ignoring return value of 'write' declared with attribute 'warn_unused_result' [-Wunused-result]
> > >   205 |             write(wfile->w_afd, wbuf, reclen);
> > >       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > write_log.c:209:13: warning: ignoring return value of 'write' declared with attribute 'warn_unused_result' [-Wunused-result]
> > >   209 |             write(wfile->w_rfd, wbuf, reclen);
> > >       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >     [CC] random.lo
> > 
> > Hi,
> > 
> > I never hit this build warning:
> > 
> > # make
> > ...
> > Building lib
> >     [LTDEP]
> >     [CC] write_log.lo
> >     [LD]
> > Building ltp
> >     [CC]    doio
> >     [CC]    fsstress
> > ...
> > 
> > Besides that ...
> > 
> > > 
> > > Mostly are calused by not using the return value of read()/write()/...
> > > Ignore this warning by adding `-Wno-unused-result` to CCFLAGS.  This
> > > won't cause other problem but make the log clean.
> > > 
> > > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > > ---
> > >  include/builddefs.in | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/include/builddefs.in b/include/builddefs.in
> > > index 7274cde8d..edf87ff00 100644
> > > --- a/include/builddefs.in
> > > +++ b/include/builddefs.in
> > > @@ -75,7 +75,7 @@ HAVE_RLIMIT_NOFILE = @have_rlimit_nofile@
> > >  NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE = @need_internal_xfs_ioc_exchange_range@
> > >  HAVE_FICLONE = @have_ficlone@
> > >  
> > > -GCCFLAGS = -funsigned-char -fno-strict-aliasing -Wall
> > > +GCCFLAGS = -funsigned-char -fno-strict-aliasing -Wall -Wno-unused-result
> > 
> > I'm not an expert of gcc. From the manual of gcc, it says:
> > 
> >        -Wno-unused-result
> >            Do not warn if a caller of a function marked with attribute "warn_unused_result" does not use its return value. The default is -Wunused-result.
> > 
> > Looks like the "-Wno-unused-result" works for "a function marked with
> > attribute warn_unused_result", e.g.
> > 
> >     int __attribute__((warn_unused_result)) foo(void)
> > 
> > I think fstests doesn't use that attribute.
> 
> No, but unistd.h does for write():
> 
> extern ssize_t write (int __fd, const void *__buf, size_t __n) __wur
>     __attr_access ((__read_only__, 2, 3));
> 
> where "__wur" is a macro wrapping __attribute__
> ((__warn_unused_result__)) if available and FORTIFY_SOURCE is nonzero.

Oh, good to know that :)

> 
> But, uh, shouldn't we fix these programs either to fail the test because
> some part of its execution failed, or declare that the return value is
> irrelevant if that's the case?

The warning is not a big deal, /but/ I just found GCC-15 changed lots of
default things, especially use -std=gnu23 by default:

  https://gcc.gnu.org/gcc-15/porting_to.html


that causes xfstests can't be built with gcc-15 ... lots of build errors.

It can be "fixed"(skipped) by set -std=gnu17:

-GCCFLAGS = -funsigned-char -fno-strict-aliasing -Wall
+GCCFLAGS = -funsigned-char -fno-strict-aliasing -std=gnu17 -Wall

but I'm not sure if it's a good way. I'm wondering should we port to C23
totally... It needs to changes lots of "old style" C codes.

Thanks,
Zorro

> 
> --D
> 
> > Thanks,
> > Zorro
> > 
> > 
> > >  
> > >  ifeq ($(PKG_PLATFORM),linux)
> > >  PCFLAGS = -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 $(GCCFLAGS)
> > > -- 
> > > 2.43.0
> > > 
> > > 
> > 
> > 
> 

