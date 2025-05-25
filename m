Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFE11A0BE1
	for <fstests@vger.kernel.org>; Sun, 25 May 2025 11:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748171714; cv=none; b=N/VTC8yYWadrjNyluvUE3L/ldnhkk6N6hrKf5fcJH26SkQZbScaQ3/YS2WnQXfiE6DSnElxgCcS9bqFCCiOvm/ofOlnemh/yrRrXrNlcQgCYhSx3cFPnbQpxUnBjgxEPrSQbNC4tQO+QyDCY56L+lfKdo4LcA43G+jnxyzSwADo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748171714; c=relaxed/simple;
	bh=8K8gGumro8YNQNSBEm58E6Q9/5tBTHwHBKUpB1fJ76I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsDzXRjNYygp6wlhIced+kNKGLS6RKeM3hn2Bddmy0cHAeyk6Yan6u6MkicPd+UOvDyaB5YdNXv3TpqSbrbAfGr81wHVfx2Vs0ukv5su1JTWBRHDl1LWS4YEwcXfs+TlPfSfeoONn0xpQHukcsB4VQnjdHQ2ctwDJWeIBfKC1AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PoolPRNm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PoolPRNm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748171708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AE1YaJMOHLhTRnb9U6H2SlT+l2tAdPIWHRyi8gGw+fI=;
	b=PoolPRNmVBAscE5ZA/K24At494b+YVzrQzeHdIf1ayYRm3cZO772Q8QYkv6BQ2VH5go3rf
	EwVPkvXh9U3kTPCise1Al12HOrj1zhzDRN+dAH+K2whrj25spUYMAPkfQX06NCsAG7WPZa
	0LreXaT0uIILb6YgBAnkUWBK79bXBn0=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-_okokTOONsulxp1VMV91dQ-1; Sun, 25 May 2025 07:15:05 -0400
X-MC-Unique: _okokTOONsulxp1VMV91dQ-1
X-Mimecast-MFC-AGG-ID: _okokTOONsulxp1VMV91dQ_1748171704
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-23446aa30d1so4482615ad.3
        for <fstests@vger.kernel.org>; Sun, 25 May 2025 04:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748171704; x=1748776504;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AE1YaJMOHLhTRnb9U6H2SlT+l2tAdPIWHRyi8gGw+fI=;
        b=g0okCUu+wrJxUYjVBEEnHjL1SZcV8ir3+2/FLtr7zzG5u2y6yjF0b1ey506OeHCg5i
         wMOtrrYb2mEYUDpmVaY81aIzmAo7Qk35V0JBLScohCvnvfDXCiiIeUfaYYG/MUdcWvHW
         JERl9FdQHx5kDuu40aFCfONvnAQzGoTARojmrE6Kla3VkPgN/nFthFjADc+41lYlwskm
         +A3rRlCP2z9pjx2eHWdNFsSm5KafQCk2hCDQzOliRckj8asBP1mWse3AY1huZNHLlTbz
         UkLO5pVANg9BnoW7T4GWyh/SNaMPgwdYHTR86p2WrL4Dl+JnpSIDs8m/rLokNdeCmo1a
         5Mmw==
X-Forwarded-Encrypted: i=1; AJvYcCWb1XvgjpD3pwWU7rP3ZkaToTpIyIUBKtZGDY/bqNLwYGmPuaO1ehbL8+T3FLhaj+eAXTxB/8A3@vger.kernel.org
X-Gm-Message-State: AOJu0YzayU4H64S3mD/SfSyOaDH0rIzK7yOta2jm583OMlz2Ftnk7iuH
	9p8L/GrFa/JgGJ3oxUVdhY6F82YO3ZXs3eCJevGvEdCCUo1SBB/pIrvxPSJFytfpUwnTRoH03A1
	AnisDRvVOnQPcSdOBPrT4zBn1p6/VF+AD1tuOij/CNrbM4V8cn/NaJjAPamk=
X-Gm-Gg: ASbGncsIfIiD0bOLk8V1TuzY4j0hDnQZdtolnxWNirGtZGjJr2dXvoYWtPzGyT3iMCS
	pjdFVP3WCVK7p/190TTL/LPHRMakxUFnuLoCLWUVY+swh0R+ugJfB/sEF1rhLDEK/PnZsJAL/eo
	mqQq5oWzLIGTw+lepCv5P5fkncqi+Hj5G9blPW1a3W0HBQ7hWFxW77JmJehmYTQr1IOaRbHSC+V
	5mnDiVbZm6P+IgSzaBg03ZTBqDbBA4ga/HV+A8L0uJ8dhCZ9PwSDvw2gk7HhO1bx4TxP2Q7pGYf
	VMzjz0e9tSesXByfKzHC/nsoVNaTjQV6iZZb4LopNyAVfPf2tZmQ
X-Received: by 2002:a17:902:e807:b0:224:910:23f0 with SMTP id d9443c01a7336-23415001067mr84073065ad.49.1748171704175;
        Sun, 25 May 2025 04:15:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEd3GxDPBxapVEFODlhqwF9sebuCoxsLJ4BYELDs+USvDS59FKieVbbrxysnqNHK33DMzaQjg==
X-Received: by 2002:a17:902:e807:b0:224:910:23f0 with SMTP id d9443c01a7336-23415001067mr84072875ad.49.1748171703816;
        Sun, 25 May 2025 04:15:03 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-310f86909ccsm3592360a91.29.2025.05.25.04.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 04:15:03 -0700 (PDT)
Date: Sun, 25 May 2025 19:14:59 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: Re: [GIT PULL] fstests: btrfs changes for for-next staged-20250523
Message-ID: <20250525111459.bpi6zisqetjpxxd4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250524040850.832087-1-anand.jain@oracle.com>
 <26d4ea00-3ea0-469d-b6e1-a58f717f4013@gmx.com>
 <b8e4f687-809c-47d6-8534-e2ffe0e85596@gmx.com>
 <20250524065222.v5ivpxkh5q57ke2v@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <f4c2b83f-cc13-45f3-9f16-03095b56e175@oracle.com>
 <20250525052802.pwujhzxdyj3on6l3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <97d6425e-dd3d-4949-b63e-a53a6e210069@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97d6425e-dd3d-4949-b63e-a53a6e210069@oracle.com>

On Sun, May 25, 2025 at 01:41:11PM +0800, Anand Jain wrote:
> On 25/5/25 13:28, Zorro Lang wrote:
> > On Sat, May 24, 2025 at 03:52:54PM +0800, Anand Jain wrote:
> > > 
> > > >     3bbdf4241 fstests: btrfs: a new test case to verify scrub and rescue=idatacsums
> > > 
> > > There’s an additional fix on top of this patch that doesn’t have
> > > an R-b yet, so I haven’t included it.
> > > 
> > > https://www.spinics.net/lists/fstests/msg29195.html
> > 
> > I saw you talked about it with Qu, not sure if you've reached a
> > consensus or will send a v2 :)
> 
> 3bbdf4241 above has a bug, which the patch in the link also fixes.

Oh, you tried to fix a bug of an un-pushed patch. Why not review and fix
it in the patch itself? As you've prepared a seperated patch for that, I
suppose we can merge the previous patch at first, is that good to you?

> Others need to comment for the RB. IMO, we should have the error
> code in the golden output to make sure we're not breaking the KABI.
> 
> 

