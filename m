Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ThzBf1qL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01FA19D
	for <fstests@vger.kernel.org>; Wed, 15 Nov 2023 18:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700102028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=njZ5atozwy9G0BrydKv0/iZq4RwpVGfhN97xeS0VssM=;
	b=ThzBf1qLD8PMoiyIajO2MQ0tob9Mlrls+MEGw5CeiLeomuOBQJtwaSeZHklNCzssS9ip4A
	SiyNFLZAKezyUqFqMftYioLau4TzWwgpiIAzDZD+tZtuap7YqOMgBiKJUXZPoxXhKqb358
	Qpwe62bDUkIs36FmW9htA/KcVGQOJgU=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-7UeAkre6OpeAEop4CETYNg-1; Wed, 15 Nov 2023 21:33:46 -0500
X-MC-Unique: 7UeAkre6OpeAEop4CETYNg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6c337ce11ceso478488b3a.1
        for <fstests@vger.kernel.org>; Wed, 15 Nov 2023 18:33:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700102025; x=1700706825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njZ5atozwy9G0BrydKv0/iZq4RwpVGfhN97xeS0VssM=;
        b=e5tCF20JvvFYoLgciCi66EcPuBXR5F67TLGIcy5Yh+nVc8RztSxjh6TWq4LhW1TEl4
         nvaZiqZGXaUZra/8BjIiXwB0FTt1e/7wEZvGwE9LCvItY3uwq4/4soW8OVPEFfDVSrqr
         M8Zdk7NiJPFmfI+tUZS1PZLNYeutP91EAg+Y+uJNjjgl+dTChjvvWqHAh2THa8Ohhp4+
         +/+PKblyQzsUKeM/X+7HH4s5Q2fzuetZI852I5s14lCEI7UV5xi4dscnvgFzCfVUQolG
         UqU1x+otgZetKs/ZZuIBGGzjuq0rhF0B2od+w2DZYugbYE5vwqybb11MZKe2qCzbGgco
         c4Ug==
X-Gm-Message-State: AOJu0YziuNmuoHrEuzU3ii/qSRjVAh+BOUwIYLSsnX8CVMQ5CQxuULmd
	6KVEHexzz9+0YCRl1GyWtwO6sScBLqF6WxX6uYmNknZRon27PQXc2DqkfEB6STSQNQ6DhHBsq6f
	dnlfiD9crisJ2ID/b7A==
X-Received: by 2002:a05:6a21:3389:b0:16b:afc2:3b68 with SMTP id yy9-20020a056a21338900b0016bafc23b68mr18121011pzb.25.1700102025554;
        Wed, 15 Nov 2023 18:33:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPbo3bkxCwD0UIyozTUHawbpeKC1QMiVlpUA/KYQ+JbWBMb4Uy3GoAefXWDIpSoUKakX+AJA==
X-Received: by 2002:a05:6a21:3389:b0:16b:afc2:3b68 with SMTP id yy9-20020a056a21338900b0016bafc23b68mr18120998pzb.25.1700102025223;
        Wed, 15 Nov 2023 18:33:45 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id a16-20020a62bd10000000b006b725b2158bsm3417588pff.41.2023.11.15.18.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 18:33:44 -0800 (PST)
Date: Thu, 16 Nov 2023 10:33:41 +0800
From: Zorro Lang <zlang@redhat.com>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/263: increase data section size to 1024M
Message-ID: <20231116023341.4be2u2dtpghe5tan@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20231115055659.2027-1-xuyang2018.jy@fujitsu.com>
 <20231115160543.GD36175@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115160543.GD36175@frogsfrogsfrogs>

On Wed, Nov 15, 2023 at 08:05:43AM -0800, Darrick J. Wong wrote:
> On Wed, Nov 15, 2023 at 12:56:59AM -0500, Yang Xu wrote:
> > On machine with using raid, this case will trigger
> > the following error:
> > ==== NO CRC ====
> > +mkfs.xfs: small data volume, ignoring data volume stripe unit 512 and stripe width 512
> > == Options: rw ==
> > == Options: usrquota,rw ==
> > 
> > mkfs.xfs generates this error since xfsprogs commit 42371fb36
> > ("mkfs: ignore data blockdev stripe geometry for small filesystems").
> > It disables automatic detection of stripe unit and width if the
> > data device is less than 1GB.
> > 
> > To slove false poistive, just increase data section size to 1G.
> 
> Is there a particular reason why this test needs -d size= at all?
> 
> There's a single comment about "Control size to control inode numbers"
> but then filter_quota_state() seds the inode numbers to #XXX.  So
> perhaps that part of the mkfs argument isn't necessary anymore?

As we've filter out the inode number, so the "inode numbers control" doesn't
make sense anymore. It's fine for me to remove the "-d size=xxx" part (if it's
still test passed).

Thanks,
Zorro

> 
> --D
> 
> > Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> > ---
> >  tests/xfs/263 | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tests/xfs/263 b/tests/xfs/263
> > index fadd6280..48581bac 100755
> > --- a/tests/xfs/263
> > +++ b/tests/xfs/263
> > @@ -73,11 +73,11 @@ function test_all_state()
> >  
> >  echo "==== NO CRC ===="
> >  # Control size to control inode numbers
> > -_scratch_mkfs_xfs "-m crc=0 -n ftype=0 -d size=512m" >> $seqres.full
> > +_scratch_mkfs_xfs "-m crc=0 -n ftype=0 -d size=1024m" >> $seqres.full
> >  test_all_state
> >  
> >  echo "==== CRC ===="
> > -_scratch_mkfs_xfs "-m crc=1 -d size=512m" >>$seqres.full
> > +_scratch_mkfs_xfs "-m crc=1 -d size=1024m" >>$seqres.full
> >  test_all_state
> >  
> >  status=0
> > -- 
> > 2.39.1
> > 
> > 
> 

