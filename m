Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7741917FB
	for <fstests@vger.kernel.org>; Thu,  5 Jun 2025 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749135555; cv=none; b=EEi04OfVrxklOTSxS5PIYOQSSAXccGGhIPMspxU/+elMTgsP2fhQ9V81IgBtmTKY2QuOulnpMCb64YF+oEgjhHP6q60Xnggj41n9pQVKpUN1Hfjc/Ho24eKDXzyR5tkeLqVX7xJpJ1TWUXJGadV6sQs43WhWV9CzGhEA+FS0gNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749135555; c=relaxed/simple;
	bh=A6zwAq8PsCy6ogTByByU9y43j+DOEWrTK1iW/IwzYtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMrh1qWmZYeSzmaVk6i8/JhHCnIdSiQ1xZGlU0XnkbRA3sLVhy7zx87L/aDCOVT404SfNOiRY80K5d8oCAw2V/E1eDogqmRsMlQoB/P7grjjydXUD93yLDtlrx/gFNBNyMNaNdnS68gFe6NAENt/WTFkPrbAwEZIugdjOQKLIDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MpGkSYgp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MpGkSYgp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749135552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LtJegDZZpvVJrHoSgPDrcL8lIN1kexbI8yNtAPoFmGQ=;
	b=MpGkSYgp0l5o2fdBjBRRm6Y1stWrt5Q4jrgekay7t+aC9QMsYGpELFbmoXG5KmPdnk67VH
	duhGKgjo0w3ND1OOyzu8+URIIpPk0IoWkaqPvETt/Yaz1vfXBGX32Fka0+AsEA1xQu2cBA
	lm0vqUogC5zQ+O3sPxRrqePm4ErfW8I=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-YVeEUqCnNTS1PJPRJrsSzA-1; Thu, 05 Jun 2025 10:59:11 -0400
X-MC-Unique: YVeEUqCnNTS1PJPRJrsSzA-1
X-Mimecast-MFC-AGG-ID: YVeEUqCnNTS1PJPRJrsSzA_1749135551
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7398d70abbfso1831325b3a.2
        for <fstests@vger.kernel.org>; Thu, 05 Jun 2025 07:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749135550; x=1749740350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtJegDZZpvVJrHoSgPDrcL8lIN1kexbI8yNtAPoFmGQ=;
        b=YHl2r0wLyaqKiO9Kcw4Tu8PgMuD0lNZS5GdHY/oj2+S2pMNlM/E98LMiQdiMqz1QBY
         RYK42jCIPQsCIktgnO1Cbo7EGaBj47TFEytXb3XVNUsmkawdfGscHCGAopTUPpaolesp
         qiqqSgVpacevp0pYafuKCm0LvaDj7Je/wnBgi+Qkatv1sI5bu2y+xXTU3hLE8s0oKQqh
         dWCaH3H4ewH45A6E/p8lcPmfSLXi7AyOmXFZXm+8Ptv/o8uhSYfkcgH8LnJyv24z1kHp
         0TYyYO8xjXpursBoDg7zSxlDUWkfBxdyYwHJ+7V5tdJsrcrw4+W/R8HVwfsoM/546B/v
         q7XQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4j+HuEn7k/1b9ejfTKBCDfTsDsrjoq0R7Boh9JsY2+0DnSJWCooKEOKA21Pnpeai7DwoAOlpC@vger.kernel.org
X-Gm-Message-State: AOJu0YxFyB+sOcTrlUjtst51QqVlCVHEjrbQuZ7wrZdVcESa2f13YoMj
	u+j3M4w9rE6AqEQHxiXMp8MyNJbKCZ693IOcdOFJA4xf/XwlcCXZaUptujwG/HJad/hxNY5+U5K
	L7xzru+tb45seS0ocXwibaYSD88IKhHKMAV2vb3NKvQp7el4W3+zmpw5DqwkmDXSHz9g=
X-Gm-Gg: ASbGncstA0Qez/uimMa8AiGwvRIO0HSkBjN8LWNRin6X/QR+yXaHxS+oaQdFE1UUkXN
	hVLQ/6xZPFQjgAfIDa7znSs6bO7NP2LOs2Ke02To2bnIbagSdfyMbyYgw2VZzsU5nfsSGeMNItV
	35ZC1Bu8XG7MfFtTK/yt7qRG0FXwHPa1m6EjYnfsxkudtwmsT8Z9WBmIPExPWtbsuhPw64gxLEF
	aVS5fGhVaIEGiFDsbeBqy4PiYCKlPnGJoCbJDoN69xS//GiU/uj7JWQK9qtGdrAWqyEh3cci/KY
	C/QFP9hGvbLRDBtitvBBlR+mKX2rfvdXKNNsG1CuHLpxcLURxr1BFH6Mh9jIgpU=
X-Received: by 2002:a05:6a00:3cc8:b0:746:25d1:b711 with SMTP id d2e1a72fcca58-74827f159a3mr51651b3a.17.1749135550685;
        Thu, 05 Jun 2025 07:59:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGc6FRa6YE95lQ3ghCbEFt0U2trev0i+0bQQuGFH/Mrk0+lNEo9HaABKHOJskJqjfucrNAtw==
X-Received: by 2002:a05:6a00:3cc8:b0:746:25d1:b711 with SMTP id d2e1a72fcca58-74827f159a3mr51628b3a.17.1749135550341;
        Thu, 05 Jun 2025 07:59:10 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2eceb35702sm8981296a12.33.2025.06.05.07.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 07:59:10 -0700 (PDT)
Date: Thu, 5 Jun 2025 22:59:06 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/740: add _require_scratch
Message-ID: <20250605145906.d6pfxngrgfjdtpkm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250604131922.848228-1-hch@lst.de>
 <20250605135210.zrezswl6qgc62mmq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20250605135443.GA2669@lst.de>
 <20250605140646.xzjyzkp3vkcbos4m@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20250605141201.GA3986@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605141201.GA3986@lst.de>

On Thu, Jun 05, 2025 at 04:12:01PM +0200, Christoph Hellwig wrote:
> On Thu, Jun 05, 2025 at 10:06:46PM +0800, Zorro Lang wrote:
> > On Thu, Jun 05, 2025 at 03:54:43PM +0200, Christoph Hellwig wrote:
> > > On Thu, Jun 05, 2025 at 09:52:10PM +0800, Zorro Lang wrote:
> > > > > +_require_scratch
> > > > 
> > > > There's a "_require_scratch_nocheck" in this test case, but it's called
> > > > after the "_require_block_device".
> > > 
> > > Yes.  But I looked at _require_scratch_nocheck and despite the name
> > > it doesn't seem to imply _require_scratch.
> > 
> > Due to _require_scratch calls _require_scratch_nocheck, not converse :)
> 
> Oh, I guess I should have looked deeper..

I saw you did below change in commit 3ae8a19f97d0 :

  -_require_scratch_nocheck
  -_require_no_large_scratch_dev
  +_require_block_device "${SCRATCH_DEV}"
   # not all the FS support zoned block device
   _require_non_zoned_device "${SCRATCH_DEV}"
 
  -# mkfs.btrfs did not have overwrite detection at first
  -if [ "$FSTYP" == "btrfs" ]; then
  -       grep -q 'force overwrite' `echo $MKFS_BTRFS_PROG | awk '{print $1}'` || \
  -               _notrun "Installed mkfs.btrfs does not support -f option"
  -fi
  +_require_scratch_nocheck
  +_require_no_large_scratch_dev

I don't know why you moved these two lines here, how about move them back :)

> 

