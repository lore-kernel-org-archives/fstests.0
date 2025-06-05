Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A784D2AD13
	for <fstests@vger.kernel.org>; Thu,  5 Jun 2025 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749132421; cv=none; b=g/a3w9BswxeGyaElho0MB7XhK6SAng9uyy8ki1G06S5Amhm7mJmc0ppQP54JgDKp+Sre8WjUx2UbPoKjjudg4jEqbexJ8TusEXQ0SCPIPvKKhEO5OkEyyusCfDHQGVTZrqb3XiWds8yLoLezPxzmE4+h6IaIe1zcb8Mfs9SWoSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749132421; c=relaxed/simple;
	bh=W3ocXS17LNmoSzOzK71QcTtVaBdxGJdcNmNs2gTZiAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbM9FkmB5N10B9ovC5XLyPC+oSCNoAH9EvqHrwdP4x2UECKpoDAS6gHfsedQI6hy7BHotpgkc8B9RBxpHJAtuXteq6q6QviaUIIzY5ScDOWucE3UaUptkZEtUiwyFPR5Ky8DqgKtBPAJGvGY1FoLnCNmZgcXmN3R/st/I+a1yAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L9g4vPjw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L9g4vPjw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749132418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UsW94cAPSRjIE4pVnUepFSqmwLE8cB0R/zjC7yrJtmo=;
	b=L9g4vPjwee0AsKDc4dOXvCgdESx1++YB14ILiabKE6tfajn4zxnmjkbhBgkKQVMqLbJSwO
	X0a6f65Ae90MowqPK9VwPGD86Wbhcq7lg2hrq9uDFk5b8sRGf+2B+Tk4laM3PZn7tZyhip
	iInMwrmNWmKDYWuJLL+96eRyV3rTYuI=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-HuSBGgw4P8eCd8t2oqOfCg-1; Thu, 05 Jun 2025 10:06:52 -0400
X-MC-Unique: HuSBGgw4P8eCd8t2oqOfCg-1
X-Mimecast-MFC-AGG-ID: HuSBGgw4P8eCd8t2oqOfCg_1749132411
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-747ddba7c90so895257b3a.0
        for <fstests@vger.kernel.org>; Thu, 05 Jun 2025 07:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749132411; x=1749737211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsW94cAPSRjIE4pVnUepFSqmwLE8cB0R/zjC7yrJtmo=;
        b=JxadFP6Es9xmwxC4z9wP+owNfHuvIDNsK0l0L4lAuenN6+smXujLbLIlXazYqFx42v
         biXlmCTSK1AfvEnD2K0WTKtvgqwktApshQIVM1AZ2TobC6g+FwFSmFX31On6fMQp9Jyl
         uFCfNoKHbxO2quTsp+G2UMIcF5GNfHIq7XISKBTJhbgFJMTz0PhVG/1aMhPyD50KNcRF
         GU8Hij7yrlmLApqSlPv96Jkrz6ueM+fKqqtuons//32yO93Crkw9+0zU2/m4W511vtfv
         UO8P3JO3riUmtLHJPP7twr3FOQKOWOyuOd8NeszGOgUzo14ax68fDJ2qQDb6UCs8VidN
         cPlg==
X-Forwarded-Encrypted: i=1; AJvYcCUFjm9ylpldmx0Kad9FpML1d3+s0aCCczrKvzWgaSm/5Lw7NmCVAVTJeoYcN86oet96BBpWumBg@vger.kernel.org
X-Gm-Message-State: AOJu0YwWPL5E/e73JqjV3yl5KQgHw9t8oFKzjrQCqcyv9K+C9ofB9g44
	UMAhz7XnocTLzpQM1aN+/Hu7WJzg24+HkpaC8kOBt8JLzVqATUjIL4clzVZJwbF1YDFXFGdDj8/
	qNkJd95Gg2ZtOAdbATRTVAGseeag3ugtPM5ezfnwlsmWSY0lKvaExQjlPPDY=
X-Gm-Gg: ASbGnctTXNYlbkffty1G5VL4fQKjfgWVTe0ckT5GJY4zYxKd2szTiH987IE7twjUDa1
	l2GqETWE76WeV84xR4uuw5YIJtHw0zWrDIXUYjd1omBvh6IwfkvaxsPQyi7Dirk1+dz38kPXYkl
	VN+yGRGYwvU53LWJ7a/FzT4gFszLJVwQw6tJfcoRPiX6MeU6OBnK1cCKWDpi7SlhDq+khrp9NZq
	93J2tPTnxDitizX8MFrokWqVPG/raLbFyebjUDLAaR4uejw9mdb8rn5RpQPPuSSZrylM2gwslJL
	rDUsz0Bqg7iDppYp+6BDC3cXimb3hjLdDE6Qx+wqdM4lh/Md/Y2j
X-Received: by 2002:a05:6a00:3c8f:b0:736:6ecd:8e34 with SMTP id d2e1a72fcca58-7480b434bc3mr9619241b3a.18.1749132411076;
        Thu, 05 Jun 2025 07:06:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYoXpgk1sEvJrw5FgDYoyd1oQrxgdY1ysgH4Uwd4QwTcLiut5dfsf08P0Y5/7FHjKlbPuBoA==
X-Received: by 2002:a05:6a00:3c8f:b0:736:6ecd:8e34 with SMTP id d2e1a72fcca58-7480b434bc3mr9619229b3a.18.1749132410766;
        Thu, 05 Jun 2025 07:06:50 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747cdb9a0b0sm10192922b3a.99.2025.06.05.07.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 07:06:50 -0700 (PDT)
Date: Thu, 5 Jun 2025 22:06:46 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/740: add _require_scratch
Message-ID: <20250605140646.xzjyzkp3vkcbos4m@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250604131922.848228-1-hch@lst.de>
 <20250605135210.zrezswl6qgc62mmq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20250605135443.GA2669@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605135443.GA2669@lst.de>

On Thu, Jun 05, 2025 at 03:54:43PM +0200, Christoph Hellwig wrote:
> On Thu, Jun 05, 2025 at 09:52:10PM +0800, Zorro Lang wrote:
> > > +_require_scratch
> > 
> > There's a "_require_scratch_nocheck" in this test case, but it's called
> > after the "_require_block_device".
> 
> Yes.  But I looked at _require_scratch_nocheck and despite the name
> it doesn't seem to imply _require_scratch.

Due to _require_scratch calls _require_scratch_nocheck, not converse :)

_require_scratch()
{
        _require_scratch_nocheck
        touch ${RESULT_DIR}/require_scratch
}


> 
> 

