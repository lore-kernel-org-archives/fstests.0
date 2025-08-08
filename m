Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F052C26463B
	for <fstests@vger.kernel.org>; Fri,  8 Aug 2025 19:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754681336; cv=none; b=b40HmPAGmI5VyefqNPRLJ++T2UivC+6C329x+1q7Zdlzxy9MFHA6hcRx2B5JS1KJp39FlxuCLjB1zHtx/gwpeEhPttMndqAhX1bUHRisv9x7rMZyn1xRND0aquuDlfBSyLR/BG3TOiTn0VdGFKn49yYUfzi60dDCJF8MMn45W4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754681336; c=relaxed/simple;
	bh=QEXhxovWYUHVgBkEl/gTdcNOIaqUcKQWivj1PPJZ8ak=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PE86y0zlJtm9DAf23/c6oBZgsngfTuUreCTQJq9VeyYq6/tJWoNzas8NDA+MWohUE8Zqf4CRCjOPyCARp1YqOmOLcuGddXEAZAonxiQAuTIFiwS3zWEIl3ERFHqS6O9sygDcpcoOgsyoT4VxUaqRoAJr9YFVg+EUstebQsp9nZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DUi1BPrs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUi1BPrs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754681333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=z+VJfc5dyu/GsDQ2jOZqvhe7ZEO+uEqdgkyy6rtOglw=;
	b=DUi1BPrsTUrsFwjKg9jL03qCweG0xA1/hE9kg+yLPLTjzogdLZFbg7c/3eXWZplIGeqh5a
	bC2zVKu9jar8k3oRJ6mNNP9qlHqWcHyji5xpu08S0p0UcCYbWySt4sfexo0uGSjaqo5fT5
	dG8X7ftAdwFc4Q9YFXm2MC+1Y/Q6GYM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-d0Y7cf6vOgOLD4w_2Fvt7A-1; Fri, 08 Aug 2025 15:28:52 -0400
X-MC-Unique: d0Y7cf6vOgOLD4w_2Fvt7A-1
X-Mimecast-MFC-AGG-ID: d0Y7cf6vOgOLD4w_2Fvt7A_1754681331
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b8dac70703so1267311f8f.1
        for <fstests@vger.kernel.org>; Fri, 08 Aug 2025 12:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754681331; x=1755286131;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z+VJfc5dyu/GsDQ2jOZqvhe7ZEO+uEqdgkyy6rtOglw=;
        b=SyNeI/OPKSv9bkBx5E6or0jyIFImyiUA3GGpBadVkMl3NBDrmtofMw9xAJJDpThkJD
         M3zptFyZ/Du2LoFK7FyD9vbA7ND9YL+aO30iNbxalpS3ic0DBhoBgsVarvB1Ga5oNrkS
         IWjhAAx1MyPxJ8u26YF+fer+HF77xohcsM6YClj7puRG90dxfAWGFAQ/YkM1nnKpb02p
         eC03DjdYuq1kofCgtTGOWv9cVQkmJJBswJsRFnoljPiVnjk+JT+jAo1sk1LLFvvcYixs
         MBYXJN3kvLCvUvw8qbO/wOxvxBRliJ72clQIwvhW29kBwLAkBdvmAqHGZIjODh3WwgEU
         IC0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgzcCsSTswhW1/odApyT1gzeoBBGvOnVGM4hyzlVI5mYZ3OM8GgFzvlB7bbOddHnSbEsfUF4MM@vger.kernel.org
X-Gm-Message-State: AOJu0YwhOEGdPeaJbLrdXze+FnKcIaDtL6PGCzBJu6uIaTOOAezYAWde
	AcCQy3otiosODvmeCAEnABgnpxOz2IgeVOb/Dhbbb8CZbf9s1SGjzxGYakrfI4gVObcLJIzQ5WP
	b4/xvnTIHKItg//pYx+5FzLOvyVOSi8jEcHKMF52r06IEj7xuX8NhHaKxM79yQ9kKmg==
X-Gm-Gg: ASbGncuTyNhhvpwdjnZnTaKxLQlKHpq591CDJhVrlEiwe6aAO6npxj0PSvVWlGYz/vh
	SdqjjLXM70jor7v5pnqj7yVsShxom16UrEtPDp4au3v47aPqW3yhZASc0mRwfUGEz7iH0Lp2ckm
	LyKosgAL+258VgOGGw+HsSd3O/xchR2NRnJh5lfHgN6WMknRnZVheqAbRX8gO+Xq7auvl2wE1WW
	fdE3Dfp4+FA2gzd8GmRVIlCnpgiPg4jdRg6gibThMtfp+E+9uYHsqrIRxBPWZgBSRHnEsiRuvrE
	v0QRWKbrQ0+s2xle1EiSbs4yBJvhmhEui+EJlDT1wnD+pIKDIx36gZWVMGc=
X-Received: by 2002:a05:6000:2209:b0:3a4:cec5:b59c with SMTP id ffacd0b85a97d-3b8f97f4ba4mr8240464f8f.25.1754681331218;
        Fri, 08 Aug 2025 12:28:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFI9xY/6Qpbd5IKobjzePxeB3jT7K8h08kAJrvDGyK5ww5Cu3HFMUyCZu/kR3Zamj5WJ7zjng==
X-Received: by 2002:a05:6000:2209:b0:3a4:cec5:b59c with SMTP id ffacd0b85a97d-3b8f97f4ba4mr8240451f8f.25.1754681330861;
        Fri, 08 Aug 2025 12:28:50 -0700 (PDT)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3ad803sm31036606f8f.6.2025.08.08.12.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 12:28:50 -0700 (PDT)
Date: Fri, 8 Aug 2025 21:28:44 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	fstests@vger.kernel.org
Subject: Tests for file_getattr()/file_setattr() and xfsprogs update
Message-ID: <lgivc7qosvmmqzcq7fzhij74smpqlgnoosnbnooalulhv4spkj@fva6erttoa4d>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

This two patchsets are update to xfsprogs to utilize recently added
file_getattr() and file_setattr() syscalls.

The second patchset adds two tests to fstests, one generic one on
these syscals and second one is for XFS's original usecase for these
syscalls (projects quotas).

-- 
- Andrey

