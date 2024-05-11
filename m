Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B063E4501F
	for <fstests@vger.kernel.org>; Sat, 11 May 2024 05:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715403852; cv=none; b=WTwTfFsCteZM80XyBab4kQXoXdksuSvoq6exlrrNm3T0wtlUss0imprBTz8mNRFEcxeXZlFBTSR1h3zQuWOcSSBiIu5C1e6lBJAM7ZWv1MmZROd/8+2ZXxvVEYfsM3zmTMYqTEYraBVr37z8tXN8QJtT+O54cuaqirrK11HCvzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715403852; c=relaxed/simple;
	bh=VvQfF1iVq2ACxMa5giFnD4Jy+m+w68vt3Eo+bm6/yWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Txz30RFcibTuwBil/mDJ0QHEgkxwh57ss2Ikuewt9sj8PdVwjKyPP6fh98/k22jzR/k5WdRY24VZ/yeQY5So9NEwqy6LUQEDVvW1uZsB7NSct7FQEDx3F9Af59q1DgbCNMSuxIvp1X9mqCrAfIOSu0QgmE2zZjNrny5dsTHe2A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AyTIjqIO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AyTIjqIO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715403849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sOsMJbaZrG1qFibWjSXHaHYPvs0QarO9dsj6cuYzVxA=;
	b=AyTIjqIOvP0rEByptzMjSjfg7tBmRDs+9NSu6kfX1nVPqcwaBCdWNSrkr5wTgtcbavMjX1
	Lis38cKI5v9u3LRAkN1NX9zvEv1VzGRQNzhvFnMeeDa5r1nrSWmIrx0O4JRrGyUuSrZzzS
	ecT1s00JjsnenkKuZm9eQR3t7O4qTbo=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-nNy01KGaPMy49435nWb61A-1; Sat, 11 May 2024 01:04:08 -0400
X-MC-Unique: nNy01KGaPMy49435nWb61A-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1ec620ccf77so18709715ad.0
        for <fstests@vger.kernel.org>; Fri, 10 May 2024 22:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715403847; x=1716008647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOsMJbaZrG1qFibWjSXHaHYPvs0QarO9dsj6cuYzVxA=;
        b=iZC4gJu6sAColFLvo5/uXcDLGvP2ATYfoXEs3DJ5uRhgTeiy0hTWOgZBCveLWHtFVj
         ftA3qo+eEZvsGCf6ujniAVEn8WoYtuhlKsCEAmXSZ7BLi1xgXhYwVkp4P+zOfDjH4R2j
         a7ao5pUdARVIHJzI1aK9r81JsNIhSp9u/RKgcOqGzK4bnMVShLlufxX5IlXn/ACgOqy+
         ftuO8P58Ok1Qrr0I3QVgz3Gr0qP3eq16R2G57in5KAwkHz05TWdgusL5waW+xBSdbwDV
         XUO7uS1Jrgads8H8kNksRKFvxfuByy8JjZ9H7ohkKhvlz4m9XphZIY/TeecRLdHL9LOF
         lQ5g==
X-Gm-Message-State: AOJu0YzSiOACJL61TtWO4Rxy7MmMu8vVjvh16b06W2ZLQo2Ao22tuWyJ
	9kmZsitw/vAys8ug1UuZdegq2QI9LH3m7uZyEUoO+x49/iOQqMNP4MT3npxmirLQI+mm0TsQdlS
	5TnxXf8M9wAYhUmLFz03ox/MlRoVyHzj52U1jcXUl+5h10X7SHhfFLqs=
X-Received: by 2002:a17:902:650e:b0:1e9:a0ce:f618 with SMTP id d9443c01a7336-1ef442ba9c5mr45271185ad.69.1715403846893;
        Fri, 10 May 2024 22:04:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcuLqqUaT2qPMgkHcGSqH8K+TIhy5jhlNn3v3fmnYiNrB6/tQ2jAzlCCh9FxLxMMOUZL27vw==
X-Received: by 2002:a17:902:650e:b0:1e9:a0ce:f618 with SMTP id d9443c01a7336-1ef442ba9c5mr45271065ad.69.1715403846399;
        Fri, 10 May 2024 22:04:06 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c13823asm41078525ad.263.2024.05.10.22.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 22:04:06 -0700 (PDT)
Date: Sat, 11 May 2024 13:04:02 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: fstests@vger.kernel.org, djwong@kernel.org, gost.dev@samsung.com,
	mcgrof@kernel.org, ritesh.list@gmail.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 0/3] more lbs test fixes
Message-ID: <20240511050402.mx6ljj3be6zcp33y@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240506150119.184097-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506150119.184097-1-kernel@pankajraghav.com>

Hi Pankaj,

Although this patchset got RVB, but looks like you still want to
change it a bit, so I won't merge this patchset this week, will
wait for your next version :)

Thanks,
Zorro

On Mon, May 06, 2024 at 05:01:16PM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> These are some of the tests that failed when we were working on LBS
> patches [1].
> 
> generic/436 and xfs/008 are adapted to work with bs > ps systems.
> 
> xfs/161 is an upstream failure, and it happens even on bs <= ps systems.
> 
> [1] https://lore.kernel.org/linux-xfs/20240503095353.3798063-1-mcgrof@kernel.org/
> 
> Pankaj Raghav (3):
>   xfs/161: adapt the test case for 64k FS blocksize
>   generic/436: round up bufsz to nearest filesystem blksz
>   xfs/008: use block size instead of the pagesize
> 
>  src/seek_sanity_test.c |  8 ++++----
>  tests/xfs/008          | 19 ++++++++++---------
>  tests/xfs/008.out      |  8 ++++----
>  tests/xfs/161          | 10 ++++++++--
>  4 files changed, 26 insertions(+), 19 deletions(-)
> 
> 
> base-commit: b26d68da08e47e6508a96bee72b25823040ab67e
> -- 
> 2.34.1
> 
> 

