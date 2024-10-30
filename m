Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A82D1E0E03
	for <fstests@vger.kernel.org>; Wed, 30 Oct 2024 08:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730276662; cv=none; b=WNdrxb6an19ZDi2nU0oABh0QEeS8oF78n0KR9GeyL/fdf0ETpCey4h+JBadIPphOxRCc02Vv2VrpWAZw+S/9U41RHCIFE3IPHldQn5rw56qb67WQJiM+PP7DMN08M+IkXMG31ZPLwqvnSQ4oMFf3M+2j3yP+FPzF50bqYrpnOpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730276662; c=relaxed/simple;
	bh=6/KCSEHL0bPeV8vkebornipfXAVIx3D8A9g61In7qK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEkZDoz5k6omEXUKzam05AUJuDoap2JjsC7O2Ob5VA6mDqaSkTHX68R2tKMERZPrAi3E251y7Xf2Q2bWYIFurCXS9tsocqyJLLkyGOAkXGjYEuJHSSp1DWzeUZIKTKTBCvk+kUGGS1zhYP8pxT5cE7YXVLOgDRVZfZJNTt6wPKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FQP1nm68; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FQP1nm68"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730276658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8HzENhThXZJHw7HEXI2tc2W81wApxk4YUtVOooW4Y4Q=;
	b=FQP1nm68c1mjQo/zobOJ6njqs1oWVDFL0kg2Fm1UAn5F023ridM2TnsApPHh6dm822rM/l
	t6OEtlXQl2jGla1DA66ZXwuBHWKmGXbT+Ax0ZpzkZwGGw6H2H6fS4Zd3zrb0gHl4QLqlPz
	bX6lxL+FqiXhT7HTy1QB2yypYWV9mLk=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-lGD_eiQBPuaMUfhlX0M3Ew-1; Wed, 30 Oct 2024 04:24:16 -0400
X-MC-Unique: lGD_eiQBPuaMUfhlX0M3Ew-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-71e5a1eefeeso6952832b3a.3
        for <fstests@vger.kernel.org>; Wed, 30 Oct 2024 01:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730276656; x=1730881456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HzENhThXZJHw7HEXI2tc2W81wApxk4YUtVOooW4Y4Q=;
        b=iJaI4pQpB/go2IzBikgx1zyTG9Vr00/cmkcNjRfiDNfVqls5gcWb8yrad1MbT0xz99
         YIBrZjXlA7O1FEoLaioAX2bPHwUbUijmkUY1XjiQtj1hamQ09jCwjKs8bFX3DOuXQIfY
         rTEySpAwznz3b/nHzZ69YPnyGa0KoKaYGIRvO2JgVF1tyBObiT7f+DpRVB90bKDtC2HZ
         otSmgHTUWCUiFX8EEF/JXGjRvTqzNMlvLU74AnmZaHeAzavhMIlQ6+2smtbfBC9dA28V
         aF+RQcyeEQVbeUBwBGKAH8D6g2TMDMNO2qEdpefwFLhSmmkXgL7NLjAiZgAukT4atUHF
         2TSw==
X-Forwarded-Encrypted: i=1; AJvYcCV/GnVOUarDsL9z+lfzYeBLROqB7+sVWklEpKgeGV5FlRvqYsL6NCettMec8lUkb3H4XahRwtyg@vger.kernel.org
X-Gm-Message-State: AOJu0YxUa+10Q/8iaQhxciMHrH1C0SFZaOcEGb98sVSgaRhQM/FUH6yb
	dVRzxPWpohtpsFf5wPcNw0lBTdKRYJB4ZzDCTMD1NXY/MobHHw4CZmMnvg+R0kgv1hE1eDxv3cu
	gY+GbB1ruT9A1wLRN9L2tW24fnHaeH3Li2QboZGXNbdwbTxKBPASzuwQ=
X-Received: by 2002:a05:6a20:e68c:b0:1d9:1907:aa2b with SMTP id adf61e73a8af0-1d9a83a66a8mr17082997637.1.1730276655927;
        Wed, 30 Oct 2024 01:24:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF60KwfWN++axEaCcsvJO5Y9cIzs1Hv8qXkFcnK7G3o2DhylVm293dchMNOmA9djrRPAx9XFg==
X-Received: by 2002:a05:6a20:e68c:b0:1d9:1907:aa2b with SMTP id adf61e73a8af0-1d9a83a66a8mr17082986637.1.1730276655630;
        Wed, 30 Oct 2024 01:24:15 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0b82asm8790222b3a.111.2024.10.30.01.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 01:24:15 -0700 (PDT)
Date: Wed, 30 Oct 2024 16:24:11 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Brian Foster <bfoster@redhat.com>, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH v2 0/2] fstests/xfs: a couple growfs log recovery tests
Message-ID: <20241030082411.nadgz24gjilmzsop@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241029172135.329428-1-bfoster@redhat.com>
 <20241030043659.GA32170@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030043659.GA32170@lst.de>

On Wed, Oct 30, 2024 at 05:36:59AM +0100, Christoph Hellwig wrote:
> Still looks good to me (but I'm a horrible test reviewer, so that
> might not count much :)):

You review always counts much :)

> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

