Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EF3171089
	for <fstests@vger.kernel.org>; Tue, 30 Apr 2024 12:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714481136; cv=none; b=hHx30UrkdUazIsnewI/+qqSDI1gb7nPeRrMbUNkpMxWuBEUayv4zM4YkOV5quqfB1xREmA3wDHBy/3BPFTAKZuIU+eGL01SAAIe71WtsNauqxcFyKel2a6+wncQLQAAtpE+ThOAYieQuaf3cWEeOLb706PWrZEXfnm7hgBWliSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714481136; c=relaxed/simple;
	bh=sBwO4tPURPfK/Tpoqq7ijMiBEHW84wlDyIODrCdIFCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/kK0hj41euxcPGqrF6YUh2YPJTkb0VUDGssQwAoH3Fh11KDMspPTbEXPLl6QCUUGdl7ZFMWio7cdW+ts+fe/jnAKkE8GrgEil/NEhTA1gGw2Vu7kQclbes8xv/LJerX35J5O6S9ButbUsQmI6rADL83Vvsw5kzcGnxJWDKl6ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HDCOFFrv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDCOFFrv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714481133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R4X6n0pLuVBUf+BlkM+ca3r2rZEzvEw8vYRriJB7tN4=;
	b=HDCOFFrvaj8c3/90tyF8lTssXiGQVLHf1YRgOnhF7Rb/0VKdGKomL3Vvf7GLoBb6fGZqNu
	rwsSImXjGVJEVNV+4+0Rwz9YBeKB0rMGU429XXA7J/p/uPZLENOdH3fdz4EcF2xqUXXXfJ
	pFqxbIi847JLAki7KSTAKNus6W1Dp2M=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-ALAaA_K8PdWxaff7tGHn4Q-1; Tue, 30 Apr 2024 08:45:32 -0400
X-MC-Unique: ALAaA_K8PdWxaff7tGHn4Q-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a592c35ac06so63807166b.0
        for <fstests@vger.kernel.org>; Tue, 30 Apr 2024 05:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714481131; x=1715085931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4X6n0pLuVBUf+BlkM+ca3r2rZEzvEw8vYRriJB7tN4=;
        b=CRrEjDzL0Xltfh/SAF1Tm9QQ1gSgnB1WT1Jx27JKQeAT5Fe6d0o9byGQVEswGZOiAz
         +XAk/sTWYxmanthqyh+VAHUgPbVEaFY8IFBVWNg97sxSPZEO5KK3/QEeWy6QcZW0uDpH
         FST9780hG9Jjhq2a99durGcM2tKye8mnL6JPOHsZpPOKY3BGxBWt2fp9COvhjwxuuRKt
         ZWe/pBJnBMv1ZmjNdicKTgls0XX2w5mhCQEZFfDHPNwBkJP6cMscVKM+eK7lsSiNrPOb
         cL8mF7EGHgDzexzDNXK3MUij1nKb9LdWtBDwMImf4oDMQUzmkMDuwcSVh/EVpve2fd+T
         OrfA==
X-Forwarded-Encrypted: i=1; AJvYcCUUNEBSSF+0F7O6vs6rcxEISfid8dexuJnCa/f6euZb+8XhnaPspjXBNREOt8PIIDLWzvTKtupdiFpldscuUoSj24Ahr7SvRQ==
X-Gm-Message-State: AOJu0YwHuBejbQ09V0qCQbfsid/0MTMQYlOI+u5C4McCraT4H5JcLkV5
	Ol6e4EXJdywFakHhOClPiIlEaDKUpuWThdCmX+YmEenGzff1mkTPijEMXNIpya5Mh2VTEWPlH2v
	xjlUMfn7wbKhrIvCdg7XBFpqwRwt/y9IpZxhjsTgOScfdWJj1ORMR+w==
X-Received: by 2002:a17:906:384b:b0:a58:7172:1ab0 with SMTP id w11-20020a170906384b00b00a5871721ab0mr2477675ejc.16.1714481130920;
        Tue, 30 Apr 2024 05:45:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTDZWzi552+qruMRrzcUaprNH9Uh7FvvQtJYCo7WBIUu82K3ES4iheNJ+29jVddUBCcqoTNQ==
X-Received: by 2002:a17:906:384b:b0:a58:7172:1ab0 with SMTP id w11-20020a170906384b00b00a5871721ab0mr2477642ejc.16.1714481130382;
        Tue, 30 Apr 2024 05:45:30 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id a4-20020a1709062b0400b00a58bf7c8de8sm5776845ejg.201.2024.04.30.05.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 05:45:30 -0700 (PDT)
Date: Tue, 30 Apr 2024 14:45:29 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, ebiggers@kernel.org, fsverity@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, guan@eryu.me, linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 3/6] xfs/122: adapt to fsverity
Message-ID: <wrxpj5cduflmsthmgrlbdewpis5mkpz6rnrcsmgapybtznavxp@dryj5f364uxa>
References: <171444687971.962488.18035230926224414854.stgit@frogsfrogsfrogs>
 <171444688024.962488.13214660928692324111.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171444688024.962488.13214660928692324111.stgit@frogsfrogsfrogs>

On 2024-04-29 20:41:34, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Add fields for fsverity ondisk structures.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  tests/xfs/122.out |    2 ++
>  1 file changed, 2 insertions(+)
> 
> 
> diff --git a/tests/xfs/122.out b/tests/xfs/122.out
> index 019fe7545f..22f36c0311 100644
> --- a/tests/xfs/122.out
> +++ b/tests/xfs/122.out
> @@ -65,6 +65,7 @@ sizeof(struct xfs_agfl) = 36
>  sizeof(struct xfs_attr3_leaf_hdr) = 80
>  sizeof(struct xfs_attr3_leafblock) = 88
>  sizeof(struct xfs_attr3_rmt_hdr) = 56
> +sizeof(struct xfs_attr3_rmtverity_hdr) = 36
>  sizeof(struct xfs_attr_sf_entry) = 3
>  sizeof(struct xfs_attr_sf_hdr) = 4
>  sizeof(struct xfs_attr_shortform) = 8
> @@ -120,6 +121,7 @@ sizeof(struct xfs_log_dinode) = 176
>  sizeof(struct xfs_log_legacy_timestamp) = 8
>  sizeof(struct xfs_map_extent) = 32
>  sizeof(struct xfs_map_freesp) = 32
> +sizeof(struct xfs_merkle_key) = 8
>  sizeof(struct xfs_parent_rec) = 12
>  sizeof(struct xfs_phys_extent) = 16
>  sizeof(struct xfs_refcount_key) = 4
> 
> 

Shouldn't this patch be squashed with previous one?

-- 
- Andrey

