Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF092222C4
	for <fstests@vger.kernel.org>; Fri, 29 Aug 2025 17:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756487396; cv=none; b=TZ+nYnJD0V1QIhTCcTzU1WzKjr3qE5NyI189AlUFb3Xq3G+1D2IeknKoGyf3/X7DCnLMyguglkYDBKzN4Om4S69DqCGGETw1GLngbm4+r6AMGaC3GbrrXbZSEXkwzEHqF4fVVwA1dIF5bZPlJymnWj8+r9smsa6MKQ5ZyrA5Isc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756487396; c=relaxed/simple;
	bh=V6IG8xjTAp9bkxNDzVSuXmPklejJGgMNhdpDbaBeZVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGrjivWOJY+slR6Y/tOjVUsLJU0agj/W1MhGvhbBW5V1T03TmWoNYtVlYxEP25JUuu3sLbsilW7rqH6CGYDiYQBe2NDVUvRwMaHyioHyOBCasZM/UYamlf/K7ESyF7WArltJ9VD7zKcJgwjWwE/guM6qcmQ6hP6czBa0ZN03I5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HphnJSXx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HphnJSXx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756487393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VhNmumfEbEx1PKNV5HcwHgIUa1nfK7FUOzlRwBuAlOg=;
	b=HphnJSXxrNBvjqySjcbfOw8TlvcHnNIlWaDRcb6fEs2jmWEF0JI8sWZVXXP/v3DmZLHenh
	AMSfgi1r3OJgRoCbyp3j5EqTZhn3spv77osNUf1x3hEO2Uz+w1xf06C9l68wqScvdT2u7U
	X7sJu3Ixk4T3Pio9PjQoj6CsgE6Vhgg=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-FWritX7hOViYqNmOxUnJJA-1; Fri, 29 Aug 2025 13:09:51 -0400
X-MC-Unique: FWritX7hOViYqNmOxUnJJA-1
X-Mimecast-MFC-AGG-ID: FWritX7hOViYqNmOxUnJJA_1756487391
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24456ebed7bso32212755ad.0
        for <fstests@vger.kernel.org>; Fri, 29 Aug 2025 10:09:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756487391; x=1757092191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhNmumfEbEx1PKNV5HcwHgIUa1nfK7FUOzlRwBuAlOg=;
        b=Idz1M42OPLTWJg/o/B3B4JcoJCfdEQhhwH+9gcicx4h1BrT6zgrKcPLK8rEfGYaxGm
         EI+aJJQvMKLmpEmxcgnMz9svHWnNJCzFEeX7lttZjPQHash82FCYk72efQ7Xq4h8wAkc
         IsQ2UuKDAtY3LbGWLRgBpZHBMzw00Y57rtKzmJCsmzEeUmWw9YvZUbCNGo32b9yItaMP
         CYVBiCz1MPEb+5FNcn2+eZRwFVTMSe+wXr9egj49cm2rinHb5VfgzkBUE45nKHsVi9y6
         6LnFOxHtwrWcJYAXRvIKC9qcq+haHMCt+4Ps40l5D8h2fNser2gJfZ99uhHgbfeNNJ5Y
         Rw/Q==
X-Gm-Message-State: AOJu0YyDF/yNFLIrHJM6oRwBW9Dy7RECGdb6Bu3QMGrJ4a8Y4A+zLd2h
	17x+sS/YJ5fjkRM8o1B7ZLMLC/5DHMjlgy8lY6y//ruPI5njqKfidVYTmSNEuTvmxqaNKf3TWP6
	vVL4qykCKnTgrkq1lmf1u5MKP47UqjZL4znxpvnA54TxKlV8QyOvLWfG1DzU=
X-Gm-Gg: ASbGncuuZiXnhX1mxAudubI0LHQuTlDUeuDXuuaPsgEOiA5vX0RPqmiigCOX5CucwBw
	g/1oT5k3xitKJmaDtgs+gEyYPjAA2q+Z1Jay5IBiI3H0HKbyCZh8uwbX3RMqcc1TYc/BioukXcz
	wxY6EfgE4Nf/KVtPi/qbnZQqnVTxOhUrzSI7Z5iU7Sqwotke7FAiVA+A4sMdXkHLbsVwwIprwPi
	hZ7K9i2XyrJR8xf8zOFamZNgfTbCRA2RcDfMmM5tGz+2T2NhZJc20mMfDBzoUDQmszwkt+DdcuR
	KHL8/TaYTqthq0cExin8vFW6K1IcpzorGSn6QuGV8oiYhITuVjEchRI78R1YeHr+Mvf9J7piu5x
	WzsIz
X-Received: by 2002:a17:903:1d0:b0:248:ac4d:239a with SMTP id d9443c01a7336-248ac4d29admr134380435ad.18.1756487390711;
        Fri, 29 Aug 2025 10:09:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwPauW0UNTbV6kOtOK0r/Ikpq9mSMUymzOmaAALiKobM7vgBocnpYpJ9qP/FZi4M3qLVUyJQ==
X-Received: by 2002:a17:903:1d0:b0:248:ac4d:239a with SMTP id d9443c01a7336-248ac4d29admr134380155ad.18.1756487390263;
        Fri, 29 Aug 2025 10:09:50 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24905da4d44sm30296025ad.83.2025.08.29.10.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 10:09:49 -0700 (PDT)
Date: Sat, 30 Aug 2025 01:09:45 +0800
From: Zorro Lang <zlang@redhat.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	djwong@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic/365: Fix false failure when mapping ends with
 free space
Message-ID: <20250829170945.dhxvuxeesyop375v@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cc80fdb62151d677809f2eb36eadebd3720c8701.1754385487.git.ojaswin@linux.ibm.com>
 <20250825152925.tcbbn5rxbjpk4ts7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aLBvK4I7uhYI3bsZ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLBvK4I7uhYI3bsZ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Thu, Aug 28, 2025 at 08:30:59PM +0530, Ojaswin Mujoo wrote:
> On Mon, Aug 25, 2025 at 11:29:25PM +0800, Zorro Lang wrote:
> > On Tue, Aug 05, 2025 at 02:55:56PM +0530, Ojaswin Mujoo wrote:
> > > If we have a small FS where the first free space mapping is also the
> > > last mapping of the FS, then the following sub-test fails:
> > > 
> > >   echo "test whatever came after freesp"
> > >   $XFS_IO_PROG -c "fsmap -d $((freesp_end + 2)) $((freesp_end + 3))" $SCRATCH_MNT
> > > 
> > > since there is nothing after the freespace. Fix this by punching a 1M
> > > hole in a 3M file to ensure that the first free space is always
> > > surrounded by allocated blocks.
> > > 
> > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > ---
> > >  tests/generic/365 | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/tests/generic/365 b/tests/generic/365
> > > index 36cb2530..bbadae71 100755
> > > --- a/tests/generic/365
> > > +++ b/tests/generic/365
> > > @@ -32,6 +32,10 @@ if ((blksz < 2048)); then
> > >  	_notrun "test requires at least 4 bblocks per fsblock"
> > >  fi
> > >  
> > > +# This makes sure there is free space surrounded by allocated blocks, which
> > > +# is needed for some sub tests.
> > > +$XFS_IO_PROG -fc 'falloc 0 3M' -c 'fpunch 1M 1M' -c 'fsync' $SCRATCH_MNT/f
> > 
> > If you add "falloc" and "fpunch" operations, you need to:
> > 
> > _require_xfs_io_command "falloc"
> > _require_xfs_io_command "fpunch"
> 
> Hey Zorro thanks for the review and sorry I keep missing this helper :/ 
> I'll fix it.
> 
> > 
> > Due to not all fileystems support these two fs operations.
> > 
> > BTW, I'm wondering how small (and what kind of) the fs you use, cause there's only
> > one unused region, even this's a clean fs, there're some still many different
> > metadatas. I even tried a 100M ext2 fs (which doesn't has log space), there're
> > many free space regions. So I'm curious, how can you hit this issue? And if the
> > SCRATCH_DEV is too small (e.g. 10M), do we really need to test with that fs size:)
> 
> Right so actually we used the standard 5G SCRATCH_DEV however we were
> testing for 64kb blocksize as well as ext4 bigalloc:
> 
>  $ mkfs.ext4 -b 65536 -O bigalloc $SCRATCH_DEV
> 
> which can actually format an ext4 FS that can hold 65528 * 64KB = ~40G
> in a single block group, so we end up with 1 block group where metadata
> is at the top and free space is in the end.
> 
> Adding a small file like above seems like a easy and universal way of
> getting around this issue.

Thanks Ojaswin, if so I think we can accept this change :)

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> Regards,
> ojaswin
> 
> > 
> > Thanks,
> > Zorro
> 
> > 
> > > +
> > >  $XFS_IO_PROG -c 'fsmap' $SCRATCH_MNT >> $seqres.full
> > >  
> > >  find_freesp() {
> > > -- 
> > > 2.49.0
> > > 
> > 
> 

