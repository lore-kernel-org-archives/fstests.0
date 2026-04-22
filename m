Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DF820A5F3
	for <fstests@vger.kernel.org>; Wed, 22 Apr 2026 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776864717; cv=none; b=jXXWIFc7iFawCAuDJGLJW+EEy1OJ0aG8/Rnh5JiVUwVTF5Gem6++tIP0YryqjGr89oblZz/galjvpPw1AgZdG6EwMvQkzsKRZt7uc2SuC5KiRepOj1Pslzc8HojczDGtG8VZtnpewMM6Lv4jWP2gNASPc4JOvn9svuIvlRk6jV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776864717; c=relaxed/simple;
	bh=TsylkPPgRWWxPNtCn3oqaJn5OS6yI/eGV1IHmZH306c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDsNalB1TXLkyB9Eq+FkDbywIA+SyBV5fZ9kPEvYgirJHzAAxCrJE/UZmiekxgz2/ZnS+OYCu+j5udX+cJermua1RdRvzdH2SSPTLEVLXF58graFRQ+eXuV7LEumr7+i90Bor0AFQ3gNRE4Vp3g6ndYdXOC1zPDxEHl02bto0BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jIdAaSBa; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=J22BTkS5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jIdAaSBa";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="J22BTkS5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776864714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r55woItgcSN/921GWGJAOvXIu6ZnxSOsPT1nq4l7hg4=;
	b=jIdAaSBah6RCbUxnUhDaJtRParOWJNFKemTbvb1pJpmfRss2i2MekF+OdXX8JywF7Mbad5
	Fxk1KfXmTUXfc7ErD4AvMFckgtG1T0G9AWY2J8GfkJYPZ7yOohoGPoMMtpSR5ZhxfTOPsH
	bMnS6AfU9lx+o/9Ba1OpVWthoZWba98=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-GsDRNlg1MdWg2avO5T5C_w-1; Wed, 22 Apr 2026 09:31:53 -0400
X-MC-Unique: GsDRNlg1MdWg2avO5T5C_w-1
X-Mimecast-MFC-AGG-ID: GsDRNlg1MdWg2avO5T5C_w_1776864712
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-440d12a472eso2925110f8f.3
        for <fstests@vger.kernel.org>; Wed, 22 Apr 2026 06:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776864712; x=1777469512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r55woItgcSN/921GWGJAOvXIu6ZnxSOsPT1nq4l7hg4=;
        b=J22BTkS5QlOBjp8hE8MZzrwg8CNd/x5rsT+hmsxjNy+A/Up5mE6RRmkTvsq7wC6B0W
         n+3zGJU5hebkIRgC6SeFYotbVyMtGZwLG6rO28muJ+c33dMmo87NCpt1b1lV65cZLEXS
         7rbxtaLfvNHy0WuNpcK7rPmpRRe5SjinEoxoUwIdJbHHEeFdKWuPiBdPAp07omxUQ4E3
         rqQ4Zc5jB9tT/GOfne+l6feJElQeuOgz7f80xqvlZZz2+SRK03ENsHIs8+QDFLzMhCTr
         g6PduNm+hVRakF4Xbc6Ag/SvVRuD4y19mhrZFUOD/2yXLpx0y+i6PxrDPj6eeSjsdlSd
         ursQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776864712; x=1777469512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r55woItgcSN/921GWGJAOvXIu6ZnxSOsPT1nq4l7hg4=;
        b=cDP5IFxbMirABX6CB0EoZLND6qbzG6Jp+zOYjpKnL7kqVZ7KWfpVATdpm196x2hf4v
         I/Fra0I4HCk9Gwqoc5A4XINVdXK53TdNy3sfxafxFKKpiLMGK0aae+8nHOe14vqwubRU
         xIZhx0MJMlbx0u/rHkpr7m5p0aWXnIzFxqxhMlpWsft4OVSfuq31CeMglFEJwdCmCHfn
         poY+0/PCm2aGtaZHPvXa2mgIFbWtP9Ft/LztOcqVdHOAUYEHmWNQFclh5UwQImsPV00C
         htYkZ23Ef+YaJJ8S7+k3ya84KrQ0pH2GWsBdZS3cc4Q/l8zTOacyccDIFlkSK2ehOfPy
         qoIQ==
X-Forwarded-Encrypted: i=1; AFNElJ9qrEFpJVsejpN5vo3ZMll1a42TnO+EbIgYB7geBihoIlI/V82lJpTqmuyVlw+28yoRyOxBKvLD@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7RpwuAE4neQRHNhVlUMbB5Y9CCInV6EciVnHR0Yj08XNZoHYn
	RUjloivemH+zPbmCFMJ+bhfkt/sX26P2g9mvF6EhudenGmgTi5fSFD8nMYZKW7ncTSoxXUKebY4
	aeQfZNc5BbHlPYQz1gdnYYO/zVl5VkdUeYGhPK/93sEKxkEVxbXxO9PrnES40azTrGg==
X-Gm-Gg: AeBDies5oBgGJQze/em29keul/2pytLDzxB4yA91cloOkksdx5a8aN4t+2enpuNIDeI
	548u4SPJ1m5wJIMjJzv4a8aH1yqjXN+sESJ+JCCD2OJ29WV3Zo7rUO6FAVQwWsz9+IJf2AqS6lx
	mqfiOuXRWxHnbDxjt2y4WAuqSebm1/wwe53lDHIs3yJ0X8j3oXVIzlJgfAJptWhaoBRbHCq0amF
	MGGWBetspv1MxrjtTwDv5BuIqvPtIeR8tyhRzXHHJaugWby7cS0fgmpCDGbN0TQzK97iPA44iT2
	UfAoIx6NDWLEUPpUcxt/IC4Cw/kYwOyXKvGdXe5kPYyPToDhZCqKX7kKdzZzaF1rKHC9TtCyv0L
	+Cj+r4MdVc5pMN0kOaC15Vw==
X-Received: by 2002:a5d:4111:0:b0:43f:e43a:f4a6 with SMTP id ffacd0b85a97d-43fe43af4ebmr22844680f8f.6.1776864711951;
        Wed, 22 Apr 2026 06:31:51 -0700 (PDT)
X-Received: by 2002:a5d:4111:0:b0:43f:e43a:f4a6 with SMTP id ffacd0b85a97d-43fe43af4ebmr22844626f8f.6.1776864711252;
        Wed, 22 Apr 2026 06:31:51 -0700 (PDT)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d5b1sm49690091f8f.30.2026.04.22.06.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 06:31:50 -0700 (PDT)
Date: Wed, 22 Apr 2026 15:31:50 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, fstests@vger.kernel.org, 
	zlang@kernel.org, djwong@kernel.org
Subject: Re: [PATCH] xfs/653: require realtime
Message-ID: <cwrs4wnknrwofumnhqjbl3ka3r3rdhvurtrfm4db7ixd2lj7hj@au6vwxxvifqz>
References: <20260417162245.690716-2-aalbersh@kernel.org>
 <20260422060553.GE5391@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422060553.GE5391@lst.de>

On 2026-04-22 08:05:53, Christoph Hellwig wrote:
> On Fri, Apr 17, 2026 at 06:22:43PM +0200, Andrey Albershteyn wrote:
> > This test fails to mount without CONFIG_XFS_RT.
> 
> It would also fail without zone device support

The CONFIG_BLK_DEV_ZONED? Seems to pass if XFS_RT=y

> , and the || _notrun
> should handle that.  I guess it doesn't for you?

I suppose mkfs.xfs is fine with formatting the device even when
XFS_RT=n, but mount then fails, so _notrun doesn't catch it.

-- 
- Andrey

-- 

[root@kd:~]# mkfs.xfs -b size=4k -r zoned=1,size=2040928b -f /dev/vdb
meta-data=/dev/vdb               isize=512    agcount=4, agsize=32768 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=1
         =                       reflink=0    bigtime=1 inobtcount=1 nrext64=1
         =                       exchange=1   metadir=1
data     =                       bsize=4096   blocks=131072, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1, parent=1
log      =internal log           bsize=4096   blocks=16384, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =internal               extsz=4096   blocks=2359296, rtextents=2359296
         =                       rgcount=36   rgsize=65536 extents
         =                       zoned=1      start=131072 reserved=56224
Discarding blocks...Done.

[root@kd:~]# mount /dev/vdb /mnt/scratch
XFS (vdb): EXPERIMENTAL zoned RT device feature enabled.  Use at your own risk!
XFS (vdb): Not built with CONFIG_XFS_RT
XFS (vdb): RT mount failed
mount: /mnt/scratch: fsconfig() failed: Function not implemented.
       dmesg(1) may have more information after failed mount system call.

