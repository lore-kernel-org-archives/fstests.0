Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867B515D5B1
	for <fstests@vger.kernel.org>; Fri, 21 Jun 2024 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718985079; cv=none; b=COl+Wo5EJ2Es87GIISthtMQGbuprra7SANrEdc1CVzu1CeRbvMN7iJxosqy4wwCwLDXdPO36AQF64fMZcRtduz6KzEMgkh3U1w9+VbehMVsf0MCnVuvS9GJ+6oZqbAL4Np3ah/epqXRQMTr9jHjYINPg5UkWvZNHbqzeUd0ywzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718985079; c=relaxed/simple;
	bh=Q4JeixHt095+wHwE6exyIhpYWKk1DKaTAnNiLr2llZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmbhylWQLnPj+2fm/luB20YtsOe2S20maGldNkQ36upXSUmUHCDTz3xf/sShfiJJZAlmI6Sn+mQCaEpyvVgzDJh5Zn4GJxG/tJDg3qcc7Urdg/foWaNVOD0xHcfJsJ5e3tNqhRe/W9zLg8WBfN70jewxLSjc9o47rOYsD8M37yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DwGYE5PE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DwGYE5PE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718985076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9aJsinrpnEoi0dQhdnv8mnMovyrI1s2WrKlR7ZpEdJE=;
	b=DwGYE5PEIZ1/rXuCv1OFK08Icl45VuCkcxVL/dYmTBA1jAAqrQgzFlZ8TkLBHVUNcMxtlx
	yGJXBM5Z0kkMCX2vmkRWx2vjb40krI5HwokDa418hhloDgWqULn5gA+m0bOX7l6dZPGPOt
	cHOaLw1qkJXQl6+b4JnlEJjNioZ3RDc=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-rXmZzJRvOoqrf0ShMYA7pA-1; Fri, 21 Jun 2024 11:51:15 -0400
X-MC-Unique: rXmZzJRvOoqrf0ShMYA7pA-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7062bf6db72so2038404b3a.0
        for <fstests@vger.kernel.org>; Fri, 21 Jun 2024 08:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718985074; x=1719589874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9aJsinrpnEoi0dQhdnv8mnMovyrI1s2WrKlR7ZpEdJE=;
        b=NCj9Qy49fxPTYsZ/6WIQ0LOkEIvnzQDsJUmlTx1pPElmxA6DBmfNNpEQ08hIvN0g+x
         w0/j3lI3OjnbBCPmNAlt+0ZVN/jYZewX8ERJa9EKIQT8UUjXNgRJZmtkhE2/Brhql8dJ
         ljqKicgtavyTAqyJ0SslQBRob9eMvE0wo2GTTQ+rsMn6Aub9e8I8SJr709Z0tc/IZVki
         qyYbnY+2bwTZG0CwK572F3BZR+flzkRwGOrB+oiN95b45G/q2qnAeNGzGy7MIeLflSDr
         COf7bppWlAWFl95Akn47lk7ZGSqQYdrrEIcl7cnGCr2TtQeM4W97xivk927syTerTbZG
         1blg==
X-Forwarded-Encrypted: i=1; AJvYcCU1uEQSlurzeuttvBfZ0jYAAbVhC9qi5h/5PIzjv4YZfxpqOmQEnY1CJetm8Li+JfU2WK9Oz6+hS4mX+nCkFqwkyagCbIycTg==
X-Gm-Message-State: AOJu0YwgPFDcsS/gCCTUvRwPUDwp+Ucg2/EkwykxMTcM5CoD2f5t9Je8
	IMqjsCeH1N/kQxlJWdDGvMJubIunN2cx9PWfEQW55Uy31MdTRBioBaVvVopOpa0ppS/Tfbgmc5R
	cd7b7mcP1VYHeypDwEcVDL2UovFBIcGiRJ6pX8cFcmWzJJ4HZbyIB2AM=
X-Received: by 2002:aa7:80cb:0:b0:705:b922:280c with SMTP id d2e1a72fcca58-7062c0d8a6dmr8706766b3a.18.1718985073602;
        Fri, 21 Jun 2024 08:51:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLPAgqnXqB16whRL57ynbbybQgiy2QW4UGSNGoba344QeMOOBsJkjsH946c2CHWnsyoILDIQ==
X-Received: by 2002:aa7:80cb:0:b0:705:b922:280c with SMTP id d2e1a72fcca58-7062c0d8a6dmr8706731b3a.18.1718985073046;
        Fri, 21 Jun 2024 08:51:13 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7065130078dsm1554019b3a.204.2024.06.21.08.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 08:51:12 -0700 (PDT)
Date: Fri, 21 Jun 2024 23:51:09 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, zlang@kernel.org,
	linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/073: avoid large recurise diff
Message-ID: <20240621155109.6ckzs7mfzgsej442@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240620124844.558637-1-hch@lst.de>
 <20240620152306.GV103034@frogsfrogsfrogs>
 <20240621050416.GA15463@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621050416.GA15463@lst.de>

On Fri, Jun 21, 2024 at 07:04:16AM +0200, Christoph Hellwig wrote:
> Looking at the reply I noticed I misspelled recursive in the subject,
> so maybe this can get fixed up when applying the patch?

Sure, I've noticed that and have changed it in my local branch :)

Thanks,
Zorro

> 
> 

