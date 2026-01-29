Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D966537B417
	for <fstests@vger.kernel.org>; Thu, 29 Jan 2026 08:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769675330; cv=none; b=NApRZcaIjNjH+gocxp9aHDyAJFXnSKTunMEhuw+JgGNGBhqEYXvT2cnlSachLMCI75+/kR3Jb0GmV8PgqhnMLWr8TvjJQcTpkBskEpkjqcIUTPsG2J1Nk/+z07wGMlEevc7ns6gIKbwmZCUCueDWJwG6w+0dRdF/cuqWFWRjm3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769675330; c=relaxed/simple;
	bh=oYrclBYwcLx07m86mPb+3u29j0/qpp5jiFq0BK4UWbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2sQlGPfSECt6cvfs/R1Phg5cyBJOt3QIrDeSjaA5fqK0/+kBbL6TiA5msrbTcRQclbegS4mitsX3IdHvRFGoD5jYr8vo/dzCGdTFpP3ldryF9eM41v3Nex3DpstfWO537a2VOjNorudzJsH7VJlESLjHk9a91L3YHE4sTMiuww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FCemeAjO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ePmD6F9h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FCemeAjO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ePmD6F9h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769675326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0YJmi1OAzukodfKJUTAQSnkLXHvbAKMCq1LzZsrBYA=;
	b=FCemeAjOYlMyozTrmLZFCsooZy54Nvsi91Bso7ZSwM/RJri0BTVDnirOtmeq9V4xV5rYMK
	JLdDuLlYjoWxur0+eClhfG9j8y6/hg+xTm05iUClqmbtqOvDX7V9UbaJxHX6tCGHTtelkM
	hcnJtio58MTPylZXRNA6PIKXbp4toB8=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-sAJpmuJZM_-rJ42OEiJT1g-1; Thu, 29 Jan 2026 03:28:44 -0500
X-MC-Unique: sAJpmuJZM_-rJ42OEiJT1g-1
X-Mimecast-MFC-AGG-ID: sAJpmuJZM_-rJ42OEiJT1g_1769675324
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a13be531b2so7256255ad.2
        for <fstests@vger.kernel.org>; Thu, 29 Jan 2026 00:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769675264; x=1770280064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0YJmi1OAzukodfKJUTAQSnkLXHvbAKMCq1LzZsrBYA=;
        b=ePmD6F9hTrrwTK94KRCMKAgA1ZCJRCwgCKUXAsiEcUynjUFHWs4E5LtfDmejH1wi5Z
         BO9NOjvaa1QhfemLS9jbHuI21qG2urK1miKs+NDhvxI7bYNFKvZBOR1JVw0O0TpLAgb4
         5as5ptbop7OT2Qr42ADS0a21udtqU5eoatn5RllCIZ2LzASdDWsWmiUsz7lY+WEynj6T
         CzxGULDyWLGIW/LDTyKDReK7Mom9eG1USX0hMWIQwIuYN17XooymraoGYQZxzKz8madr
         O7hJJBEUF6a7HCS0XlLXtD63aapO+KyrovZim8pvrikgYTjJ8FcnkOJqZwPSRQ7n4DMC
         Dslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769675264; x=1770280064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0YJmi1OAzukodfKJUTAQSnkLXHvbAKMCq1LzZsrBYA=;
        b=sE9NwVaEw5SuSARSTEWFI5wf23F5TRlZmXbatiE2PYSaLaqNoMKRnhaPbvulAr3x5W
         nxhc8JQ35t/9ry9TJzTLPmZREk2aJLaL16iRQwhN874ckj0tmSIbe4BkzsU3bK42j1Fq
         08ax4bLtqED6wCP1ZzkK2uTbiovMdooCL9KKbGxjbF+zwqQ0wySRMyJP2k+ND6lmqerR
         11U6eehoDCtg4Ls8ismXMRurNJt3DDOmaCa6p2fgrhSWJdRiyBANBGzcr08OBGyCJUVZ
         kLUV7m/khSdMGPa2NNrsLWs13G88l14uZvwAlaSiQxAfkAX8+Xa/vUpdTq0Qx7LtuyiC
         ZdCg==
X-Forwarded-Encrypted: i=1; AJvYcCX7eA2xSvUCaPcyVvIDh9h8/f8fZryaOLvnjiCVVWFCpsf+V4+C4Q8n3M6J5gJNkv/XY3TBlqWf@vger.kernel.org
X-Gm-Message-State: AOJu0YydGmoLgDdCMkyNDvClU9Ny3bvqk8Pz0Cgm8ReAoWpgLmSOAqpj
	F6M/RmtVx4numfW3Ws69B6nYf5WZSWGTPgIxRTzfTCDELLQXvIFHzU6IcpWl1ayMHmDw88SriHu
	aNWpJnL138yxoZjs53RewibjrLujPnbhpdinDv1z3Cpua/goyvkY1qobK3ns=
X-Gm-Gg: AZuq6aI23N6z/6/IiU/2P+/hnm7gZXUuU+QKc4E5XbT9xsheebvFXZdQjEvj9aSM/0S
	LtpLq5cU1lu50YEfUo00Le31VJZjoGwiAwK2lCn8lJMwbaZ3xB6fKhubno7Fi2V/m0HbNayRFN4
	jzfzKHOEPm3xFK/rEpn6kvBNVAhmIsydMl6njXzUxQ+bGnulNO2Vs1WN4OsGfT3C6++C6b6AxPW
	D5MeOTPNw5XSuPO1BsgUCfRnNxb3uN4lq/hssBDZ7ArzxMRtasqzd4ydBbo8W17KrNrSOO28FLy
	9L5umVFDCw9IISysqV3yAhpmyPa8xFQB7ej3a3mBcmdATYxKGDequZvtwmm6EgqYZMy37kHW2+v
	V643qZd9MFi2mtoGMDmHGF+er5Gbn3+XIkj4N4vsDipIRlk9SfA==
X-Received: by 2002:a17:903:13ce:b0:2a7:bbe0:f01c with SMTP id d9443c01a7336-2a870d7765fmr76674895ad.17.1769675263661;
        Thu, 29 Jan 2026 00:27:43 -0800 (PST)
X-Received: by 2002:a17:903:13ce:b0:2a7:bbe0:f01c with SMTP id d9443c01a7336-2a870d7765fmr76674795ad.17.1769675263231;
        Thu, 29 Jan 2026 00:27:43 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a9f3d98sm4222129a12.24.2026.01.29.00.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 00:27:42 -0800 (PST)
Date: Thu, 29 Jan 2026 16:27:37 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, zlang@kernel.org,
	linux-xfs@vger.kernel.org, fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH] xfs/841: fix the fsstress invocation
Message-ID: <20260129082737.mq64ngmxehtp7ck5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20260126130816.11494-1-hch@lst.de>
 <20260126194404.GY5945@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126194404.GY5945@frogsfrogsfrogs>

On Mon, Jan 26, 2026 at 11:44:04AM -0800, Darrick J. Wong wrote:
> [cc fstests]
> 
> On Mon, Jan 26, 2026 at 02:08:16PM +0100, Christoph Hellwig wrote:
> > xfs/841 fails for me with:
> > 
> > +/root/xfstests-dev/tests/xfs/841: line 79: -f: command not found
> > 
> > Looks like the recent edits missed a \ escape.  Fix that.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Doh!
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

Thanks Christoph and Darrick, sorry I failed to push the lastest for-next
branch. You might find this failure on old patches-in-queue branch.
I did basic regression test on that branch, and I think I've found and
fixed this issue before merging into for-next last week. Could you please
pull the latest for-next branch again and see if the issue persists?

Thanks,
Zorro

> 
> --D
> 
> > ---
> >  tests/xfs/841 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tests/xfs/841 b/tests/xfs/841
> > index b4bf538f1526..ee2368d4a746 100755
> > --- a/tests/xfs/841
> > +++ b/tests/xfs/841
> > @@ -64,7 +64,7 @@ _create_proto_dir()
> >  	rm -rf "$PROTO_DIR"
> >  	mkdir -p "$PROTO_DIR"
> >  
> > -	FSSTRESS_ARGS=`_scale_fsstress_args -d $PROTO_DIR -s 1 -n 2000 -p 2 -z
> > +	FSSTRESS_ARGS=`_scale_fsstress_args -d $PROTO_DIR -s 1 -n 2000 -p 2 -z \
> >  		-f creat=15 \
> >  		-f mkdir=8 \
> >  		-f write=15 \
> > -- 
> > 2.47.3
> > 
> > 
> 

