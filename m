Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3D3189BB1
	for <fstests@vger.kernel.org>; Sat, 12 Apr 2025 06:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744439186; cv=none; b=kIxyWbydYrqS0FMg6+BApMU1AH4QD5MfY+tPv4zmNRvs4EQo7YpY1+J7JlionFyTh/HmUWc2SdCv6b3fEqgWDOD3MF7R1g6bNfM3B+oAifh6yecxO1w2jBuEO2MOlHyM8Yt6IzE5ClLh5jJ0lIrNu8/LWnzV+bazW9kVCVDKc6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744439186; c=relaxed/simple;
	bh=rDUctU+eo2yFrQzJGJ9WESLdOn2HFEikKze7FvMeujI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pk6cbCNxuR9IUwEdSTt/dtfHB+IaQrpPAAriPkUyjUHYkn3alcGDwpk1GwSjAImS6AGlpwK7sv0ByI4zO8YaWwRZlJJ81RrLpLf55HuwviWQ20zhTclLm2ugLvrrNMK8hxTGFBHb6+9e3YeQODc2CtPWQKjrwsgUnN6kVkN2JXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M5kOqlTa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5kOqlTa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744439182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yhyCkAg3D5KBPITY+5+z3w4CInNBgsp1dI1Gv1I9h54=;
	b=M5kOqlTalJZBGFx0yhk7Z7iiu7pK9vNn6OnqCheK4a9ZQIEicMpvD1CbEfo1PigHG7WvmS
	MT5ft3pOAOw2tom38L9mscZa6tJX5JOR/wlVObqi2z6mLVpfFjSqj4LjEIv7Ll3BFb7LsF
	v6N7+mqO4kk1Ol/8dWzJHFwdHC6B/Bo=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-x7nXB0ZMMS6Gqcp4WQX0yw-1; Sat, 12 Apr 2025 02:26:20 -0400
X-MC-Unique: x7nXB0ZMMS6Gqcp4WQX0yw-1
X-Mimecast-MFC-AGG-ID: x7nXB0ZMMS6Gqcp4WQX0yw_1744439180
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2254bdd4982so36880955ad.1
        for <fstests@vger.kernel.org>; Fri, 11 Apr 2025 23:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744439180; x=1745043980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhyCkAg3D5KBPITY+5+z3w4CInNBgsp1dI1Gv1I9h54=;
        b=q3UmRVurHosqGI8/zmo3HoH4Dz3aKbQ/8FdHZFiukieFsRoFmsgx46jUyxOZZTY+fZ
         pLIpPYKtkx3jK9Fj9LZcE+bFdmmWiY/86+DPANz0vB+4MUdbS5ig7126/ZB1UcBkduSX
         L//QdJyeYwaBSqxz/AwN79icJQ7csjpcSNJ3QNMAFA7gDiK9zwCM0yUJZrbeJHKtkRzi
         /KpjFxX9N3ECvHuzIOgbPmfGUaZ7Bc+0btCnVvXetJgKiMXgAETLKr3f2Q4yRLFhShxY
         KoyaRg2l9JHPvalCsW9Z5pTuymLRcSq41doiLZbcrwg6n7aIXjYgFNnea977wAe+rayN
         cwCg==
X-Gm-Message-State: AOJu0YzIxKV3aR9S/oa1+qKqVRd1pQ9y/Jf53XOwI3Ybp66m/9B/cWLP
	hfwey0iioOut8VjwDI1Z4WKRqOa/9ko7c/B568cs62hilU1Ccrnj6d5FbooTzV9oD7dY0a73C/y
	cp6ucK2C9Bet8t4XYZZN5yp6MZ1Val/EhDHZo7QOSZHFF825UoQv6mIY=
X-Gm-Gg: ASbGnctBdLRLY4RSQ0/WL4z54/ANDONtRMSL0uT4ys+ldIWtw2QL5OUse9ESI5HxFZE
	Qil1W0ujq52GqtvZ1JeJlwObyHH3CjsvVQ2Z3rslReqfAfifEo2fOEXKJlXPVC4yHOVrUaiKrfS
	/StxsgofqMN4/PzBvnEA0ir2fWs2T7Ddn+nvDo3yPHLNNxzUvPPzfNoxnRorH2bpY5K9iXrYMtL
	5Nzc703RF4MdVQdnXlqkatagepsqgqO4aWTaBrHceQTQJxTXGVZmkHiTN36JO0zkUzfFeDPThoK
	D2v+0wKqxfXV1yldCGKJsmFNxAJG2N3mNMvWKsVSybugRKEEdNam
X-Received: by 2002:a17:903:2f82:b0:220:e896:54e1 with SMTP id d9443c01a7336-22bea4bd51fmr62788755ad.26.1744439179468;
        Fri, 11 Apr 2025 23:26:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwykgm1FHlVAYRYCNvtGCZ72xv/Yq/NfJh6r0aCsqgS4KLXIoLtijsNVpq3rMRkWF2I5R09w==
X-Received: by 2002:a17:903:2f82:b0:220:e896:54e1 with SMTP id d9443c01a7336-22bea4bd51fmr62788555ad.26.1744439178916;
        Fri, 11 Apr 2025 23:26:18 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccca88sm60972915ad.256.2025.04.11.23.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 23:26:18 -0700 (PDT)
Date: Sat, 12 Apr 2025 14:26:14 +0800
From: Zorro Lang <zlang@redhat.com>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org, David Sterba <dsterba@suse.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] README: add supported fs list
Message-ID: <20250412062614.cvq4dqbcpkmwtzmh@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250328164609.188062-1-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328164609.188062-1-zlang@kernel.org>

On Sat, Mar 29, 2025 at 12:46:09AM +0800, Zorro Lang wrote:
> To clarify the supported filesystems by fstests, add a fs list to
> README file.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> Acked-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
> 
> The v1 patch and review points:
> https://lore.kernel.org/fstests/20250227200514.4085734-1-zlang@kernel.org/
> 
> V2 did below things:
> 1) Fix some wrong english sentences
> 2) Explain the meaning of "+" and "-".
> 3) Add a link to btrfs comment.
> 4) Split ext2/3/4 to 3 lines.
> 5) Reorder the fs list by "Level".

Any more review points on this patch? If no more, I'll merge it as it got
an ACK at least. We still can update it later if anyone need.

Thanks,
Zorro

> 
> Thanks,
> Zorro
> 
>  README | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
> 
> diff --git a/README b/README
> index 024d39531..5ceaa0c1e 100644
> --- a/README
> +++ b/README
> @@ -1,3 +1,93 @@
> +_______________________
> +SUPPORTED FS LIST
> +_______________________
> +
> +History
> +-------
> +
> +Firstly, xfstests is the old name of this project, due to it was originally
> +developed for testing the XFS file system on the SGI's Irix operating system.
> +When xfs was ported to Linux, so was xfstests, now it only supports Linux.
> +
> +As xfstests has many test cases that can be run on some other filesystems,
> +we call them "generic" (and "shared", but it has been removed) cases, you
> +can find them in tests/generic/ directory. Then more and more filesystems
> +started to use xfstests, and contribute patches. Today xfstests is used
> +as a file system regression test suite for lots of Linux's major file systems.
> +So it's not "xfs"tests only, we tend to call it "fstests" now.
> +
> +Supported fs
> +------------
> +
> +Firstly, there's not hard restriction about which filesystem can use fstests.
> +Any filesystem can give fstests a try.
> +
> +Although fstests supports many filesystems, they have different support level
> +by fstests. So mark it with 4 levels as below:
> +
> +L1: Fstests can be run on the specified fs basically.
> +L2: Rare support from the specified fs list to fix some generic test failures.
> +L3: Normal support from the specified fs list, has some own cases.
> +L4: Active support from the fs list, has lots of own cases.
> +
> +("+" means a slightly higher than the current level, but not reach to the next.
> +"-" is opposite, means a little bit lower than the current level.)
> +
> ++------------+-------+---------------------------------------------------------+
> +| Filesystem | Level |                       Comment                           |
> ++------------+-------+---------------------------------------------------------+
> +| XFS        |  L4+  | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Btrfs      |  L4   | https://btrfs.readthedocs.io/en/latest/dev/Development-\|
> +|            |       | notes.html#fstests-setup                                |
> ++------------+-------+---------------------------------------------------------+
> +| Ext4       |  L4   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Ext2       |  L3   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Ext3       |  L3   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| overlay    |  L3   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| f2fs       |  L3-  | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| tmpfs      |  L3-  | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| NFS        |  L2+  | https://linux-nfs.org/wiki/index.php/Xfstests           |
> ++------------+-------+---------------------------------------------------------+
> +| Ceph       |  L2   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| CIFS       |  L2-  | https://wiki.samba.org/index.php/Xfstesting-cifs        |
> ++------------+-------+---------------------------------------------------------+
> +| ocfs2      |  L2-  | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Bcachefs   |  L1+  | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Exfat      |  L1+  | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| AFS        |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| FUSE       |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| GFS2       |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Glusterfs  |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| JFS        |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| pvfs2      |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Reiser4    |  L1   | Reiserfs has been removed, only left reiser4            |
> ++------------+-------+---------------------------------------------------------+
> +| ubifs      |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| udf        |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Virtiofs   |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| 9p         |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +
>  _______________________
>  BUILDING THE FSQA SUITE
>  _______________________
> -- 
> 2.47.1
> 
> 

