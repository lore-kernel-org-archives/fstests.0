Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53890157E99
	for <fstests@vger.kernel.org>; Fri,  6 Jun 2025 01:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749174366; cv=none; b=Q2HsSYAhWKAmJA9JNvqrFpR419VRytQ2gKUIMQBMcDkGLfBBcdcUABfwFoCZI87slcb8oJa7Nz6F3oynNb+RBnTzQJvyBTV1s4p37MeiMkdjZDbNslBNvrWozmlDCkMbpu1HvMYjbS4lmfRo4EqQidvIs8uGBNdSBAmT6q1s+xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749174366; c=relaxed/simple;
	bh=fRwX4NL71YKnC///tHUad0GYyW0jRy5qO3daiRA6QN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2Vx4ih6xbuUNJB6qSl7KcmMVGSYe91TG4RqRDvukQizLId+OkZGhoqZ49cmJyFPqN1sg9n5mMrVM42zkDyFwg10ClvBSyQvIeX8Da9WxhtM1uecyAifhjxl35HtDD5jM36TH3CWravkTDGMyYlvq0vZf2C5wfqEtwrI68izKHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c++OvkjV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c++OvkjV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749174360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VxFpMxItACBBhKv1mbalHBSHH0dg43+BeND5BLOlbp8=;
	b=c++OvkjVRwIb6P9t7Zq7ZsLyZwC4GYh1lXttZ2MvYGGJrdcegphFYxhvq1MMcJkPfnif3p
	uELOTsxTeRIvfojsMgwx3xaLhVulwWvbno3ONg8HAdM0ZpsFk//eH5xTz0GSnhxfDn3X5K
	nINSHL9qNFozuBKCzVt4GzfGWSbQPhs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-9VCD-CI8PbiV0n1vvXkfPQ-1; Thu, 05 Jun 2025 21:45:59 -0400
X-MC-Unique: 9VCD-CI8PbiV0n1vvXkfPQ-1
X-Mimecast-MFC-AGG-ID: 9VCD-CI8PbiV0n1vvXkfPQ_1749174359
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c5d608e6f5so377037685a.0
        for <fstests@vger.kernel.org>; Thu, 05 Jun 2025 18:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749174358; x=1749779158;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VxFpMxItACBBhKv1mbalHBSHH0dg43+BeND5BLOlbp8=;
        b=cn/3QaCcAxlV8HoaTZG4gsVgYNPJ9R4dP7aw0+lCQkFE9k7Ohox/TAjTCJUqK98s8p
         eMZPPWrXO7Sqw1aLOscaTYZkMvjnaauOb989HB4/HRPtK3Z6yTGAYuVO3j7Rl174oHVM
         ZP5KJDXN23edULBhe5cjEKy0376lI93rvzBFlXWMq2jF5SfQ1D8asVuCfgf4BHCTSZjs
         0rXNmFAyNkmDmPEvroXdS+AxVxHgNGBME/lZVy6G0lNTHm4IoUzU1xtdm4ormGcLv9ZW
         hSPQH2vaARVOAQwTvdKiKzO4Vgt7KrLm0Xqy6MQsa7Q22IjplXGhp7kvxkHTQFcJqzD3
         u3YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDTnoCKb7xkbBUmem6RkcKomAnLrsQ2Nwmf7NX2OgpBVvUtQVHyBja1PVW0TOQFAeo53u4sieQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/LO20PZHKiejevuIS7Wu77pSVWB6uRH4JiL9bJQxoWaewFvtp
	BEo3MgLyXPa8B/0G3UD7pA2JITsV8Hh6dfLLYA1akhEpOYTuGKv+16zSwFw+Rr5K5vmzhPVaoLy
	n5iBGvpoAMQTGbVaWkLa2IKRoIE7wO2I5rbNNFZBwh3cPb1B5cGo6AZGZycKp3Wc5u6I=
X-Gm-Gg: ASbGnctzVSEX3rcxmzlP9RkaZysBHznZDEzxwfvszkrQlYyQIfJrAoPo87X9/+nC+As
	9qy7ASt8LWQqveseE4AfzPRQrDJBt6rXAI2WnpCcghC+3xewJDm4Gd8XK9SOIyY6N1sEmdm1yoL
	9Qtj/yUIqF8Z8lW2hGrtIpC1R20PMBh58smHyYoNLhGzt4lhCSILipDG4e0TQk/9cqW9rx0tswc
	BIAclJnht9EMHhajiWq5RQvDcSVpJE3voxVbUELlql3v0QzaAJGXWMH/jiKJMQrdbHZpTERNog8
	0lDBWYIaZyTLeVTudgliosx2ZzVArK1qri1oxff7IwZCyKIjQKsw
X-Received: by 2002:ac8:759a:0:b0:4a5:9cb6:28c5 with SMTP id d75a77b69052e-4a5b9a04a18mr30329541cf.5.1749174347673;
        Thu, 05 Jun 2025 18:45:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzvVnqK85H5jYTjl3WCvx6ZmoQtL1a+k07+d4E49a38gG8UumJFmbRLLaLUqAuSiBYs7TizA==
X-Received: by 2002:a17:90b:1c0e:b0:311:ff18:b84b with SMTP id 98e67ed59e1d1-31347681484mr2066449a91.25.1749174336424;
        Thu, 05 Jun 2025 18:45:36 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31349fc374asm363694a91.29.2025.06.05.18.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 18:45:36 -0700 (PDT)
Date: Fri, 6 Jun 2025 09:45:31 +0800
From: Zorro Lang <zlang@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	linux-unionfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2 4/6] generic/623: do not run with overlayfs
Message-ID: <20250606014531.d5t4gwx4iymqiqlo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250603100745.2022891-1-amir73il@gmail.com>
 <20250603100745.2022891-5-amir73il@gmail.com>
 <20250605173233.ndqsjo77ds3e35p5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAOQ4uxgQi6ciXtoKV7Nrw5_ECBOwS_m8h2KXT-ieJ4x4t04qag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgQi6ciXtoKV7Nrw5_ECBOwS_m8h2KXT-ieJ4x4t04qag@mail.gmail.com>

On Thu, Jun 05, 2025 at 08:38:30PM +0200, Amir Goldstein wrote:
> On Thu, Jun 5, 2025 at 7:32 PM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Tue, Jun 03, 2025 at 12:07:43PM +0200, Amir Goldstein wrote:
> > > This test performs shutdown via xfs_io -c shutdown.
> > >
> > > Overlayfs tests can use _scratch_shutdown, but they cannot use
> > > "-c shutdown" xfs_io command without jumping through hoops, so by
> > > default we do not support it.
> > >
> > > Add this condition to _require_xfs_io_command and add the require
> > > statement to test generic/623 so it wont run with overlayfs.
> > >
> > > Reported-by: André Almeida <andrealmeid@igalia.com>
> > > Tested-by: André Almeida <andrealmeid@igalia.com>
> > > Link: https://lore.kernel.org/linux-fsdevel/20250521-ovl_ro-v1-1-2350b1493d94@igalia.com/
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >  common/rc         | 8 ++++++++
> > >  tests/generic/623 | 1 +
> > >  2 files changed, 9 insertions(+)
> > >
> > > diff --git a/common/rc b/common/rc
> > > index d8ee8328..bffd576a 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -3033,6 +3033,14 @@ _require_xfs_io_command()
> > >               touch $testfile
> > >               testio=`$XFS_IO_PROG -c "syncfs" $testfile 2>&1`
> > >               ;;
> > > +     "shutdown")
> > > +             if [ $FSTYP = "overlay" ]; then
> > > +                     # Overlayfs tests can use _scratch_shutdown, but they
> > > +                     # cannot use "-c shutdown" xfs_io command without jumping
> > > +                     # through hoops, so by default we do not support it.
> > > +                     _notrun "xfs_io $command not supported on $FSTYP"
> > > +             fi
> > > +             ;;
> >
> > Hmm... I'm not sure this's a good way.
> > For example, overlay/087 does xfs_io shutdown too,
> 
> Yes it does but look at the effort needed to do that properly:
> 
> $XFS_IO_PROG -x -c "open $(_scratch_shutdown_handle)" -c 'shutdown -f
> ' -c close -c syncfs $SCRATCH_MNT | \
>         grep -vF '[00'
> 
> > generally it should calls
> > _require_xfs_io_command "shutdown" although it doesn't. If someone overlay
> > test case hope to test as o/087 does, and it calls _require_xfs_io_command "shutdown",
> > then it'll be _notrun.
> 
> If someone knows enough to perform the dance above with _scratch_shutdown_handle
> then that someone should know enough not to call
> _require_xfs_io_command "shutdown".
> OTOH, if someone doesn't know then default is to not run.

Sure, I can understand that, just this logic is a bit *obscure* :) It sounds like:
"If an overlay test case wants to do xfs_io shutdown, it shouldn't call
_require_xfs_io_command "shutdown". Or call that to skip a shutdown test
on overlay :)"

And the expected result of _require_xfs_io_command "shutdown" will be totally
opposite with _require_scratch_shutdown on overlay, that might be confused.
Can we have a clearer way to deal with that?

> 
> >
> > If g/623 is not suitable for overlay, how about skip it for overlay clearly, by
> > `_exclude_fs overlay` ?
> >
> 
> I do not personally mind doing this _exclude_fs overlay, but it is usually
> prefered to require what the test needs.
> 
> Whatever you prefer is fine by me.

I don't perfer "_exclude_fs overlay", just before we have a clear way to deal with
overlay shutdown, this might be simple and forthright :)

Thanks,
Zorro

> 
> Thanks,
> Amir.
> 

