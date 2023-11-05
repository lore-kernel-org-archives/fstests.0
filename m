Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED6C210B
	for <fstests@vger.kernel.org>; Sun,  5 Nov 2023 18:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="etLQ09rl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3498BD
	for <fstests@vger.kernel.org>; Sun,  5 Nov 2023 10:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699209839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C31LV91D1OrAfFLo6We9wWevVuBg5TXcTrMnrxGm5ek=;
	b=etLQ09rlXT26PjwnHBV7r28Ms2g3H5TcD8HlXlA+IFgBEglA86r33HNUMF5vyZvBWycHzI
	mtMbU+iv/nPwxs9pTlrn0RLsA2K98ZR+1mat1FhcA+Yy6t/BT+SCVzdRSCAh7btggwE6Gi
	aehUz+CQvIdQgR391csxxygk8lXEiJw=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-xHMb2fk8PVGBXfPgmwlUfw-1; Sun, 05 Nov 2023 13:43:56 -0500
X-MC-Unique: xHMb2fk8PVGBXfPgmwlUfw-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3b2e4f3defaso5375200b6e.2
        for <fstests@vger.kernel.org>; Sun, 05 Nov 2023 10:43:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699209836; x=1699814636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C31LV91D1OrAfFLo6We9wWevVuBg5TXcTrMnrxGm5ek=;
        b=WxNLfklq7rPjCLPJ7hkYyVJc6mQewxR1ItYpKKATnBSPGIfr1z3IxfprUs4EdH1ha9
         7uMBoSPQdjW/hZgECRyrJG8VJXGrNdORBFXEtkx/btlggi84MmUtJMjDbkUcNMxp/id1
         FcgkI48MACoVfWG31wkvilQgylxwUELI8xAZu5j0Rb0rkCBI9uBOFqZqewhs3Ix3gcJL
         8MKSk3i6nnI7LUtyck4IZFfqigpaY6+8+hPkjvgrN6f5lYN8cXB1A/r4JrZsPjJQHSSH
         g0v9Xp1pIa6+zbZln5+IJUg7LsiL8gT1I0Cdbjd89ukG7ssAOsq00g8ssq1xy2lU5cAa
         Th9w==
X-Gm-Message-State: AOJu0YzhnIGwUOqcspDjoccgCcKr9WghrP3bmcHkJDVOwkihHea+bOi1
	7Dr/9vzxU1gaayOlxrUu5IkhDV1AX3v4ixkewxwr/euSRQcS491AzlqfdLj+3j2QHsJCKnx03at
	IjIOZbydFW56aKPd+vw==
X-Received: by 2002:a05:6808:2a68:b0:3b2:e624:43a0 with SMTP id fu8-20020a0568082a6800b003b2e62443a0mr27267319oib.15.1699209836223;
        Sun, 05 Nov 2023 10:43:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5nRgYcuTflfG5TNg2cjYC/iKomshbTrr7bFd3uECMjhmIn0Stn4T5+LVo9TracRGUQDZJvQ==
X-Received: by 2002:a05:6808:2a68:b0:3b2:e624:43a0 with SMTP id fu8-20020a0568082a6800b003b2e62443a0mr27267309oib.15.1699209835908;
        Sun, 05 Nov 2023 10:43:55 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u4-20020aa78484000000b006bd8f4e398csm4321870pfn.135.2023.11.05.10.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 10:43:55 -0800 (PST)
Date: Mon, 6 Nov 2023 02:43:52 +0800
From: Zorro Lang <zlang@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: fstests@vger.kernel.org, Yongcheng Yang <yoyang@redhat.com>
Subject: Re: [PATCH] generic/732: fix mount option munging
Message-ID: <20231105184352.j7u526d4kyjmwhm3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20231101-master-v1-1-08bbe2f83307@kernel.org>
 <20231102080640.bntmfreb7t5rh4wp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <f3c14dc1db7b4aa5d348cd0ccdfb63117c6e2d86.camel@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3c14dc1db7b4aa5d348cd0ccdfb63117c6e2d86.camel@kernel.org>

On Thu, Nov 02, 2023 at 02:59:07PM -0400, Jeff Layton wrote:
> On Thu, 2023-11-02 at 16:06 +0800, Zorro Lang wrote:
> > On Wed, Nov 01, 2023 at 02:17:13PM -0400, Jeff Layton wrote:
> > > With NFS in particular, we are usually testing with some mount options.
> > > Ensure that we preserve those and just add "nosharecache" onto the end
> > > of the string.
> > > 
> > > Cc: Yongcheng Yang <yoyang@redhat.com>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  tests/generic/732 | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tests/generic/732 b/tests/generic/732
> > > index 785aac58f361..ae49152e42dc 100755
> > > --- a/tests/generic/732
> > > +++ b/tests/generic/732
> > > @@ -40,7 +40,7 @@ mkdir -p $testdir1 $testdir2
> > >  # Don't share the data and attribute caches among mount points for NFS.
> > >  # This caching behavior is necessary to reproduce this issue as we're
> > >  # checking the alignment of each mount point's own unique cache.
> > > -[ "$FSTYP" = "nfs" ] && MOUNT_OPTIONS="-o nosharecache"
> > > +[ "$FSTYP" = "nfs" ] && MOUNT_OPTIONS="$MOUNT_OPTIONS -o nosharecache"
> > 
> > Good to me, and looks like the later option replaces the former one, if
> > there're same options (e.g. -o sharecache -o nosharecache).
> > 
> > Reviewed-by: Zorro Lang <zlang@redhat.com>
> > 
> > 
> 
> Thanks, Zorro.
> 
> Now that I look more closely, I'm not sure this test will ever pass
> properly on NFS. It's basically doing this:
> 
> client1: A/f -> B/f
> client2: B/f -> A/f
> client1: A/f -> B/f
> 
> ...and the two clients aren't aware of the changes the other is making
> (because they were mounted using -o nosharecache). The 3rd rename ends
> up thinking that the B/f dentry is still positive, and the rename
> syscall fails with EEXIST.
> 
> The really confusing bit is that this test passes against servers
> running older kernels, because the rename response had the wrong change
> info in it and that tricks the client into invalidating the directory
> caches when it shouldn't need to do that.

Hi Jeff,

Thanks for this information.

Do you mean this case tests passed on nfs due to a bug, and that bug
will be fixed soon?

I remember yoyang@ wrote this case for a known nfs issue. And this case
tests passed on most filesystems. If it won't be suitable for newer nfsd,
can we change it for new nfs? Or _notrun it by someone condition?

> 
> We fixed that in fdd2630a7398 (nfsd: fix change_info in NFSv4 RENAME
> replies), and now this test pretty reliably fails when testing against
> modern nfsd.
> 
> We have some longer term plans to add support for directory delegations
> eventually, which may make it easier to keep the caches more coherent,
> in this situation, but until then we might want to skip this test.

Is there any chance (change it a bit) to make this case still works for nfs?

Thanks,
Zorro

> 
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

