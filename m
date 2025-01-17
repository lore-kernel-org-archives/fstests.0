Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5977DA73
	for <fstests@vger.kernel.org>; Fri, 17 Jan 2025 04:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737086495; cv=none; b=ndwFiDxQaqZYfdMO4RRBg5XEYNvW47SR9hDlhYo2rnMpqJPN0WGZAwxWhg6EQwwixLPBlqQIlUW3HZsmhVRUAJfUyRbipjZtj0zdILHQPMLuBba0SLvn3lTm178HeaG7zPtclaPzjwKIlxrkB7iH/BJaq6Akasew2UwbaLZsfK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737086495; c=relaxed/simple;
	bh=ojeNQsxBaT8qpd+jQF2ZYBUPDk7UpG7XdwMD/p4Vb5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCf69ICPrY86ju8EsDyShSwHf2PSBSnI1FfgIPYbGok2Szy1RFAdtvMpZnY8J5/W19G3zzHoNojDHyjNcE/3glMcmicXanQgaRYF/WCzNU26hIpqGpFkHRNucVu/T0JWa/iIJeBC6xsxVX9T/Cqr9PvqNV8vPFyLpwDxjze1JnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g7yozf6G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7yozf6G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737086492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nWGSeYRpqY8sgeU8DL8czvgzRAdDFZk73N8rvj/kBQc=;
	b=g7yozf6G91eMSWcmjMEIzd6hlqiMWbEzdypV19Y87PU8BrC+mNzBlWeb4k0H7EK8xm/5/V
	KSzVX0EUk2dTgYZPhRYVlpTITncLnGJuVf41BEHeuEBF1KvQGt3gL27i+sJAY5/+Lgh2Jg
	FP7Ok938+wf65fou1ZclDlf7w8XsMH8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-hXnJn9aVOXOcSGpL5SdfCg-1; Thu, 16 Jan 2025 23:01:30 -0500
X-MC-Unique: hXnJn9aVOXOcSGpL5SdfCg-1
X-Mimecast-MFC-AGG-ID: hXnJn9aVOXOcSGpL5SdfCg
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ee86953aeaso3313762a91.2
        for <fstests@vger.kernel.org>; Thu, 16 Jan 2025 20:01:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737086489; x=1737691289;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWGSeYRpqY8sgeU8DL8czvgzRAdDFZk73N8rvj/kBQc=;
        b=sjz20kQV0X8GehP/zTESF33uU5labHz6JmAw94Eerq+LDqRZk5Mfo8YbvOrMuS8baT
         7JBfgH3ifXcqDFZjF2sx/ZYtZe2A29ps37hvjZvVH4xPAtSMUDw2ckjE9Rst+3MUjt79
         S1b+Jpf0vybndwCJBoa9bwlatgld+EKKpZUUsi4usdsJ6PNjuBbIHrJ+dhLS7ZLRMSrv
         /0Fe3HySO0BEpnqSeEF4RzRG6i4YgRSqe+pZaMTsSIRwtmT21nEhf7SceJnoGiUolDVn
         nH9/KkS82DPLLbRWyF5an1Q5TqutpsIXSvylq0SSLunsjh1NJkHu0UIUzkA0r7qZWNjo
         3MXg==
X-Gm-Message-State: AOJu0Yxd8VnqSlUJDquNSVl5nBSRioUbc7VvKqoqLn0oDML+6LNFgI7S
	pzxaZjUK9ADbvG+Scdmac5bNARdVm1dUBMQwedrkDBV65gLC1woM7BUPg/lt2AzwsSfYbiZFZ9A
	Eb2ZDzbYVcc832bl9w5+0MNAoxruDeuFD5resxqtuk/EOUl5t9kctrz4=
X-Gm-Gg: ASbGncvksfC8ilt7J4TkJkFAGps57EbcEXIf4iwCLhEQfwYjl6ksykXVnXyHoW8kFO6
	pAaYxJCbRmTYMkNBbCYjZF2Rn+4iIjOBPacHE50o4yOiF/5DeyXlizWcAXXekPP2W2XfgUltEFp
	yGJRz6IyBtRkNmFXrw9YW3cwImuVAs8rg1Ly/N5cvE0xK4Ky9IQ8MQtKWQ4yGW0GMp0SnoNYU+M
	xCRBdL3ZEDQHtQ32O7M8QjHqLss5yz3TBUDvUXvuCchyh/0lZIi8nJ50Kh8iKU+kGOxtMU8E8yf
	ZIs1+VINUfBj5P0dFjwzJQ==
X-Received: by 2002:a05:6a00:179b:b0:729:a31:892d with SMTP id d2e1a72fcca58-72daf94f5bdmr2310942b3a.8.1737086489551;
        Thu, 16 Jan 2025 20:01:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHg8Son/33RY2Xsn7+OSDNR8LigYTZPiQa9+hTU8mz4tFK7SehXr4Au/B9vX7jKTr4MPg+KPg==
X-Received: by 2002:a05:6a00:179b:b0:729:a31:892d with SMTP id d2e1a72fcca58-72daf94f5bdmr2310908b3a.8.1737086489099;
        Thu, 16 Jan 2025 20:01:29 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab7f06f1sm811482b3a.4.2025.01.16.20.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 20:01:28 -0800 (PST)
Date: Fri, 17 Jan 2025 12:01:25 +0800
From: Zorro Lang <zlang@redhat.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc: fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] include/builddefs.in: ignore unused-result warning
Message-ID: <20250117040125.376lvwkd6ntvdc4o@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250106095906.330877-1-ruansy.fnst@fujitsu.com>
 <20250115153327.izjczrhtpd2yjfjc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <f514fa8b-0ed7-40c7-82ed-71fc54dd2dd6@fujitsu.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f514fa8b-0ed7-40c7-82ed-71fc54dd2dd6@fujitsu.com>

On Thu, Jan 16, 2025 at 05:55:49PM +0800, Shiyang Ruan wrote:
> 
> 
> 在 2025/1/15 23:33, Zorro Lang 写道:
> > On Mon, Jan 06, 2025 at 05:59:06PM +0800, Shiyang Ruan wrote:
> > > When build xfstests, a lot of "unused result" warning are reported:
> > > 
> > >      [CC] write_log.lo
> > > write_log.c: In function 'wlog_record_write':
> > > write_log.c:205:13: warning: ignoring return value of 'write' declared with attribute 'warn_unused_result' [-Wunused-result]
> > >    205 |             write(wfile->w_afd, wbuf, reclen);
> > >        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > write_log.c:209:13: warning: ignoring return value of 'write' declared with attribute 'warn_unused_result' [-Wunused-result]
> > >    209 |             write(wfile->w_rfd, wbuf, reclen);
> > >        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >      [CC] random.lo
> > 
> > Hi,
> > 
> > I never hit this build warning:
> > 
> > # make
> > ...
> > Building lib
> >      [LTDEP]
> >      [CC] write_log.lo
> >      [LD]
> > Building ltp
> >      [CC]    doio
> >      [CC]    fsstress
> > ...
> > 
> > Besides that ...
> 
> Could you share me the info of your build environment?  Such as OS, kernel,
> gcc version.  I'd like to find out what wrong with mine.

Do you use gcc-15?

> 
> 
> --
> Thanks,
> Ruan.
> 
> > 
> > > 
> > > Mostly are calused by not using the return value of read()/write()/...
> > > Ignore this warning by adding `-Wno-unused-result` to CCFLAGS.  This
> > > won't cause other problem but make the log clean.
> > > 
> > > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > > ---
> > >   include/builddefs.in | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/include/builddefs.in b/include/builddefs.in
> > > index 7274cde8d..edf87ff00 100644
> > > --- a/include/builddefs.in
> > > +++ b/include/builddefs.in
> > > @@ -75,7 +75,7 @@ HAVE_RLIMIT_NOFILE = @have_rlimit_nofile@
> > >   NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE = @need_internal_xfs_ioc_exchange_range@
> > >   HAVE_FICLONE = @have_ficlone@
> > > -GCCFLAGS = -funsigned-char -fno-strict-aliasing -Wall
> > > +GCCFLAGS = -funsigned-char -fno-strict-aliasing -Wall -Wno-unused-result
> > 
> > I'm not an expert of gcc. From the manual of gcc, it says:
> > 
> >         -Wno-unused-result
> >             Do not warn if a caller of a function marked with attribute "warn_unused_result" does not use its return value. The default is -Wunused-result.
> > 
> > Looks like the "-Wno-unused-result" works for "a function marked with
> > attribute warn_unused_result", e.g.
> > 
> >      int __attribute__((warn_unused_result)) foo(void)
> > 
> > I think fstests doesn't use that attribute.
> > 
> > Thanks,
> > Zorro
> > 
> > 
> > >   ifeq ($(PKG_PLATFORM),linux)
> > >   PCFLAGS = -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 $(GCCFLAGS)
> > > -- 
> > > 2.43.0
> > > 
> > > 
> > 
> 

