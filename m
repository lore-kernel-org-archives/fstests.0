Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ADD2556E
	for <fstests@vger.kernel.org>; Sat, 18 Oct 2025 14:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760796331; cv=none; b=HfuLNTiCueowRnuYWbNw+9V/CxV7vZ4o+rQsEGEdSvmFRPsNQbJSwiamdKantx9Mp7hqnq00i3FYRb1eHvuzDswTYV69CDQbLhQTyfyFtQluxiiDfQCMYzQ3TVHjz78Il9fEuKsoddLwkARr3ayTDj5oV+2ka342vyKOqDNVYHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760796331; c=relaxed/simple;
	bh=VjP9NuW/CobZTSxmZflLMUjqw7SjbBzZHVXQVkXKk2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orbGYXJZmbfTG4yCCxoSPuwVwQ7P2Oqub7PNCN8iOQIVCNSaE3nTEUdcbk8jBj/hQ2rBBAmkOanMdwKrT8tq/n2BJ5xaJJ01A4xYkMDleYuKlMSZ7MngQYLEcfAdJ4c+7QsI8bXSJRnAl+4SFIRaMy/7WNsbuN7bWSyeZsU8I7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QvTeiHwC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QvTeiHwC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760796328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PhSauSM2IFyBlTKpDxEEF7KFbZU2eE7CTjj0cSZwp7k=;
	b=QvTeiHwCGh06tFbyuO4Nl6rNKOs/wGBV0ISGzEZd5S6hOQEFNXne9zQ8YTwSJgPmum+qdF
	FB4+QesL9m1Ybk670duAMTUzf+YImtxL1oRKKchMuM2ap7QuKi4rSdp8ik1tuf7QF49nc0
	vzmNVF0GbjJwh3iQKE8n6pQ33y62Lss=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-AyCnIgacMZSVahmEaS82uQ-1; Sat, 18 Oct 2025 10:05:27 -0400
X-MC-Unique: AyCnIgacMZSVahmEaS82uQ-1
X-Mimecast-MFC-AGG-ID: AyCnIgacMZSVahmEaS82uQ_1760796326
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-33d75897745so736307a91.0
        for <fstests@vger.kernel.org>; Sat, 18 Oct 2025 07:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760796326; x=1761401126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhSauSM2IFyBlTKpDxEEF7KFbZU2eE7CTjj0cSZwp7k=;
        b=m1ElBGsnwDhCko5LYfVt0IAwebEb2gPhlff6nOBeppDVcQgqLjJuwwLcvL28j48nyV
         ug6c72Yss/xd3j4JDDs+Kb7FIHYr5rsgOlv8no+YXehHROlBfe0eea2MNzcgZz68yJ8y
         kxnhalBZQOB5PmVoFS9i4YGwDKNcB5/PxWP79Cspex6+Y2CbfEP4gWW4ARXa7iEnW2lk
         wtOxFQNMSnHvFsH8FnnZ/pJeleBB/XSI3kCk/AZOLf2ORLTFF/VO388DYf4ZgV3w/ZpF
         6iM4s2v+irxpbiq7SIOq2/McMB/tPCmB4EHcT7Lo+NT15G3FlUBvHh2I9w1Zxqk+nJgU
         qFIg==
X-Forwarded-Encrypted: i=1; AJvYcCUSly7Rv+52yYpc25EewNGRPUX4dpal85cdr0dXSkR7r52EhGxo/CeYIS1AqI9mY1PRvAqi5JDy@vger.kernel.org
X-Gm-Message-State: AOJu0YwxVftJRSpmDcHHV/ecsW+5CiGWSHSFsOp0kxNweRr0JmV8J4jW
	DGd+mYWN/yviIqEL9zBKRDEnaOvH5WMiIh2s3FpV7SbRBjsLZIsfCH44VDcCwKJbj/+9HTlC37c
	O+Pc1rAeX3S3hvCmvbCjccG0pSuof1+vhLzGmtlgBU+STcc17d17Ull4UIKqmCSE4PZl0xg==
X-Gm-Gg: ASbGncvECUeHNO4wqjpiKQQ8nul0lbnBknroz4WSMcy4gtvTfTWVgoLNFpnqwQ94lMT
	DMI/U0hb/FaEwhmhqj7za95OX/RkJBG0RN5mx+ezsN+DYaTbrnyv6GPqihOvdye5h3NZ2NivxTO
	wEQLhaPgal+S96rM/WKlbqUhDFPBVq8gCZclVJHhcfng+3kYrZUBsBtaya2nxvIKILynkZkIA0q
	mrU74ZjcoLjlc2xsP6fqX13KX5GIL149Ya2hmjJgt9IX0rAH4hNBFeRDZGIABB1yKH9f2q7VZa3
	t93AtwFNZzrU3mtFJalF0VTj1J4XyRjBBY77tjX+VCLASztBBn2bTAfyB6NxxgKqL6xqbIC+j+i
	TkBxQnxfHA1RF2WF8jUR/L2MCrkdDASkJPFdjsKA=
X-Received: by 2002:a17:90b:2d8b:b0:33b:c172:6b1a with SMTP id 98e67ed59e1d1-33bcf87c4d6mr9992949a91.12.1760796325742;
        Sat, 18 Oct 2025 07:05:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8P1OnvVde6Urgu/5G/IcNIm4QzhIalGuckBWRj7z3lbY2W8XWPFOFmdKeThbLievb//Hz4w==
X-Received: by 2002:a17:90b:2d8b:b0:33b:c172:6b1a with SMTP id 98e67ed59e1d1-33bcf87c4d6mr9992890a91.12.1760796325279;
        Sat, 18 Oct 2025 07:05:25 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2300f254esm2894383b3a.45.2025.10.18.07.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 07:05:24 -0700 (PDT)
Date: Sat, 18 Oct 2025 22:05:18 +0800
From: Zorro Lang <zlang@redhat.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: hch <hch@lst.de>, Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Hans Holmberg <Hans.Holmberg@wdc.com>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH v5 3/3] generic: basic smoke for filesystems on zoned
 block devices
Message-ID: <20251018140518.2xlpmmqajgaeg7xq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251016152032.654284-1-johannes.thumshirn@wdc.com>
 <20251016152032.654284-4-johannes.thumshirn@wdc.com>
 <20251017185633.pvpapg5gq47s2vmm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <0d05cde5-024b-4136-ad51-9a56361f4b51@wdc.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d05cde5-024b-4136-ad51-9a56361f4b51@wdc.com>

On Sat, Oct 18, 2025 at 11:13:03AM +0000, Johannes Thumshirn wrote:
> On 10/17/25 8:56 PM, Zorro Lang wrote:
> > Does this mean the current FSTYP doesn't support zoned?
> >
> > As this's a generic test case, the FSTYP can be any other filesystems, likes
> > nfs, cifs, overlay, exfat, tmpfs and so on, can we create zloop on any of them?
> > If not, how about _notrun if current FSTYP doesn't support.
> 
> I did that in v1 and got told that I shouldn't do this.

This's your V1, right?
https://lore.kernel.org/fstests/20251007041321.GA15727@lst.de/T/#u

Which line is "_notrun if current FSTYP doesn't support zloop creation"? And where is
the message that told you don't to that? Could you provides more details, I'd like
to learn about more, thanks :)

Thanks,
Zorro

> 

