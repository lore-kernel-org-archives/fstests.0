Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25402B9A4
	for <fstests@vger.kernel.org>; Thu, 12 Feb 2026 08:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770885661; cv=none; b=fPJFvEpHCZ28sP27V70LLQuCproQ2df5pqInltGNJEGKiRK2bULC0qJO2oELbk81XW7gwVKnOWIjMX+JiNEiUFIYndz5CW7nlg4ONdU+deL3E6W9X+gDwxo2kp03kd4CE8RgmbIuyQydoNUxTmGD2ECUTIy836FMBB0niwXtpMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770885661; c=relaxed/simple;
	bh=cl938Ti4asykzJQfcH9dcu74Ycfktb4FZovTLe3ueao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OM6FMHGOglax2Ne7QopHR5fkRl53dIuI7SLThU46O81FpJu1EVwI9/GJUQtMRJ4Pyoy+JD8REy+pREH4K0DS+WAH9LRKl76rzX9qhN4RJLHAmrLOieSTMSYta8YwFLe46mQDeCe577DyiESc7eWANFuXavgSS1Sm3Pp81f2rCL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=faAd35MR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bu5FSjOi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="faAd35MR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bu5FSjOi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770885658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JL7NTSnX4xVSvnxCNOmwrKaXtUHlYFRCmkMorjX+mX4=;
	b=faAd35MRsKyV3cXeFpw88Fkmp65H10saq9Bg6GDjh2oaVJay8j8tlXnhgmBru912whtp3m
	vcGKMhM975RoZUiOT1+fgSI1WSvKQijRlEbYl2DnwpXm8AwSvpaf+KMqth0mg/Inpo38aW
	dvOYRUlqkL53Dywtr0w8GR31FvT8ciI=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-_24RlMN3MDejAirEhk866Q-1; Thu, 12 Feb 2026 03:40:57 -0500
X-MC-Unique: _24RlMN3MDejAirEhk866Q-1
X-Mimecast-MFC-AGG-ID: _24RlMN3MDejAirEhk866Q_1770885656
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2aad60525deso127161165ad.1
        for <fstests@vger.kernel.org>; Thu, 12 Feb 2026 00:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770885656; x=1771490456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JL7NTSnX4xVSvnxCNOmwrKaXtUHlYFRCmkMorjX+mX4=;
        b=bu5FSjOiUj99GO6dPtW8BuTAPaM8b7i4+uiRbFDZ9sSY1/9q2mR91QrA1giZmRsB+h
         azW7kviqd0COCBzFy8JPmcZabcSXgM4UqyRrguXTXBi+5CsVUuBpehhETLg5KwUX0n0O
         HFFoY5zScfqSbtf0BSs8dA4BsbDfA/zA6diml/WETkidpynYoxDh4KhoU1mrnYvEi7Tu
         atJysZkqQfAdStuJuEZGTMq7hy0lXapuDmDvr/MlNxuaQAKzpFQsK16LwvcBHi9MiLjp
         kreGKg9j5MZqyd603VOSDN9oR14uYWyCwUAfbc8C6oLL46FadmmaM/GPxoKZ8QSVoHUm
         LW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770885656; x=1771490456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JL7NTSnX4xVSvnxCNOmwrKaXtUHlYFRCmkMorjX+mX4=;
        b=VLsvfhxKFEsbXnfxk6Wn9+yR40EJnIDrXQCAdcSkVNbrieOe5lzOgTiHW01nZat8v6
         cenYMO975Xm8upi7k9iiiDWufqKTccXLEmmIzuzjNTAPsoA4L6N2zztusZowcIzpRlQR
         CwNRSDn2oOcKBf76MPEPnUp9T+ukrz1jgREb4ga971nC3EfYB/hlsHmybKQFLz1pefE8
         /yooG6RQnKXMY03wKpXi7HLL2r1YTZWoi2vonzeYSYorrbkC/Z0H8rA3J7XywOW2Uy6Z
         MXgV5f/7o1AvODx6uW6KrEOT5qLaDTWaJ1+qjFKV9K4UMZyJwLi7Dar7Jz2l+KNHXj12
         0RpA==
X-Gm-Message-State: AOJu0YzA4mz8xVmE4dDao4qaG4WkwVZmsTyqTbUINZJRUL0Eqil8R9Ye
	jy2cYyPw1p76cOY1DkA5d+nsfCPvsfUZFFIiMq9gUQN5JZ5q4Z8QZJ2dgozsQaa6pSJe09zIzka
	opVbX4xh64yFRWNpjUpDiv+GP88vzpboDukt3EM/DNkCQdzlIjzDVMEE+thI=
X-Gm-Gg: AZuq6aIusYeH/ssoMXpOLaRqZatRhWBbCCmdbQtjNgmoriPC2Jzecmz24k5Ubqdkt5x
	bapb2HIWs4Aq+x5ZVYypwR1UszZGn+3Cu4mqw5D6Fv2aMgEouaAwJRT1nGiiSdrc4bYSAtPwyzP
	0+g4nkcj2yI8pgH7uZzhPrt5P5TZBhMFkWEBe46/dTuzDVB3cFCJbqiugeTqZ2hgN5qdVUQzYth
	T5m/d/w0sUHUdqzOA/O0Z7CwWjZZGGkRq9+OyaKEcLupqUqfn4EzDiqcTHctLgEI81ChBp1igSW
	F/uWmTlLdGP7cKvTex4eSxm/1yhcqWcFUydX+lhKQ6/gOkOLZBN/5BvWABlTAAuLfHQqN09906E
	C5drrJYaxeD2xO5Re+C5KYD5tF2QJbaPnCgU+bbpANYiOeu5g6BSp2xwEnGgMSQ==
X-Received: by 2002:a17:902:ef45:b0:2a8:2c4a:3570 with SMTP id d9443c01a7336-2ab39b12efcmr18314265ad.49.1770885656186;
        Thu, 12 Feb 2026 00:40:56 -0800 (PST)
X-Received: by 2002:a17:902:ef45:b0:2a8:2c4a:3570 with SMTP id d9443c01a7336-2ab39b12efcmr18313965ad.49.1770885655690;
        Thu, 12 Feb 2026 00:40:55 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab29965c27sm69782145ad.57.2026.02.12.00.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 00:40:55 -0800 (PST)
Date: Thu, 12 Feb 2026 16:40:50 +0800
From: Zorro Lang <zlang@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 0/4] Avoid failing shutdown tests without a journal
Message-ID: <20260212084050.uim52ck6zhffd5kl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20260210111707.17132-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210111707.17132-1-jack@suse.cz>

On Tue, Feb 10, 2026 at 12:20:17PM +0100, Jan Kara wrote:
> Hello,
> 
> this patch series adds requirement for metadata journalling to couple
> of tests using filesystem shutdown. After shutdown a filesystem without
> a journal is not guaranteed to be consistent and thus tests often fail.

Hi Jan,

This patchset makes sense to me, thanks for fixing them :)

Since you brought this up, I just tried to check all cases using _require_scratch_shutdown
but lack _require_metadata_journaling, I got this:

$ for f in `grep -rsnl _require_scratch_shutdown tests/`;do grep -q _require_metadata_journaling $f || echo $f;done
tests/ext4/051       <=== fixed by this patchset
tests/generic/050
tests/generic/461
tests/generic/474
tests/generic/536
tests/generic/599
tests/generic/622
tests/generic/635    <=== fixed by this patchset
tests/generic/646    <=== fixed by this patchset
tests/generic/705    <=== fixed by this patchset
tests/generic/722
tests/generic/730
tests/generic/737
tests/generic/775
tests/generic/778
tests/overlay/078
tests/overlay/087
tests/xfs/270
tests/xfs/546

g/050 tests ro mount, so it might not need _require_metadata_journaling.
g/461 doesn't care the fs consistency, so ignore it too.
g/730 looks like doesn't need _require_metadata_journaling.
overlay/087 looks like can ignore _require_metadata_journaling.

Others, include g/474, g/536, g/599, g/622, g/722, g/737, g/775, g/778, overlay/078
look like all need a journal fs.

About x/270 and x/546, if we don't suppose other fs would like to run
xfs cases, then xfs always support journal.

I initially considered calling _require_metadata_journaling directly inside
_require_scratch_shutdown. However, I decided against it because some cases might
only need the shutdown ioctl and don't strictly require a journal.

Does these make sense to you?

Thanks,
Zorro

> 
> 							Honza
> 

