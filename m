Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6D22882BF
	for <fstests@vger.kernel.org>; Fri,  6 Jun 2025 11:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749210168; cv=none; b=nGXL9VWhY6OljnFfEDeLaXVEDuMt7+lr1J7+nf/bXHotRxMya8D4e38dUnwnH/+e87elQQy4PDWoDblq3spYVQAiAX4vBGbuF+dDk6HB8lTjrv8bytsCbGfzPcAvybgRrcNo8Vl5kNigCvvT3iS8RJVSO/UEdPlJHmGpxcDyqq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749210168; c=relaxed/simple;
	bh=gzYfdGVfPkugVnZ/A6SnyK8iY10Yx3bSAO7zCzq3BK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hu6/ac4RiI51eDXwbKx0EzAxO5NEVSK9LLOokn0YJIUizffIqDOHbxCF8upZ5zrzbnyI6SQt1S9lDUxvmPOV+X0ikINsS3TIBUtMOZh29TEIQmtmpGAQMQmAqpry26KC+rMgNxMiVaM+GFcz96ry71TN2UTkRUvU1x2TGOhvp7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GT4GqtY5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GT4GqtY5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749210165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0su2jZD9IPYPYpC5ndJddWr41xxjTkGsLCKUTYL/W1M=;
	b=GT4GqtY59gr+GQE9JRONxnkRFejgoo/NjMwz+f9H+PbOnTfX2zAlIIX4frw1p9txaMMNIV
	5b7kmPGS9PODRMJfB39dAzVvykYqBtOQOxEf1b4USTi6bcDuNloYYlXPLcMWmUQMwczy1J
	kyh9TyVm5TY0sQ1gq9H8CLj6dUj2X0o=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-1hhYwgAvO6C-V9Z-E_MlZw-1; Fri, 06 Jun 2025 07:42:44 -0400
X-MC-Unique: 1hhYwgAvO6C-V9Z-E_MlZw-1
X-Mimecast-MFC-AGG-ID: 1hhYwgAvO6C-V9Z-E_MlZw_1749210163
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-2e8e969090aso1831251fac.0
        for <fstests@vger.kernel.org>; Fri, 06 Jun 2025 04:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749210163; x=1749814963;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0su2jZD9IPYPYpC5ndJddWr41xxjTkGsLCKUTYL/W1M=;
        b=ib+nmwTChGJj1aXvbfaLpw5wsfoADNKyqk4HfZnltH5cdjNoCgR9Vw6+XhxqL9EEGs
         oqHl/QAyili+F6gCOhnc0LI9dtLQn1t5u5CLxUnH2HRhnMA0sB/9g6dBTejMfodm8N+/
         ExL4fBMaWEk3e0E0Mwgy3poALaIckA5eTvj2rn69ECbp3IIAapjztLJbu6U5janiHf0S
         t6o+xU58tck4wqgwMXli4tPLAUpFL7fA78epZFnJHtabjcSOl0F8Z0YjDEOD7ku898U8
         Rp9SnVRWuvhwWVMUiLsAbVH/wWncK7Q8eWvqjRa0RheJgdlMcGRtym8hsq+RZOV4d8uh
         FGhw==
X-Forwarded-Encrypted: i=1; AJvYcCVvunqX5jVmg4oDnMo8wxVsC513R4s+ubtewapFMTKoXgsvsgZaI3MwLsVZpD2QVUFQsPlM7snQ@vger.kernel.org
X-Gm-Message-State: AOJu0YysSXEeTewM7d+3i4ycPCTDK6r48FEESDmkh+ZyXLt2OnYVC1K/
	XDZHEXSE9Uw2RwwuNBTk+fDsqI6l5LnfuZmOqrnDmSOlQhjagWt+sNoxPcMfkQiUnxuFJmPEnDU
	R9OAVqGMRYBU8ubM6E6rFYIvJcZVKDMWSQJZghBDAflZEcWYJra/tgdwqtvxS77Yru9tOoQ==
X-Gm-Gg: ASbGncsz0t45zaJq4AE6F17z6fqenZSZa/COSTjMHOw+9XY8hsa4ao122FWCVlNccP1
	FyRr5N2JVQSTk981s5NOa91+P8IQyoXucUKD2nnTMr186G9CMW+WXim3zdn/xg382UGZyszEb33
	81MiGs3wIzVK3UArDwQeNLiD7YV+vAQmCnOn+qXXnmKwcoFZ4p6BVNNByqIpHQLA7IIxjmYGQAA
	4pVHBRJLtu79CXYOFOdHGXBrT+twMbAk0MPvZ6SIqFuIdmSke7tYioKqnj/4Fy46iNxN3nj6iYU
	mmdv8hIMtDM7u4WN8q2Hd9/6xtXxPGzxXlA8PFBROpEyWfG7UF9gz/qOidP+c+A=
X-Received: by 2002:a05:6830:668f:b0:72a:10ec:3637 with SMTP id 46e09a7af769-73888e1f6a3mr2057933a34.15.1749210151639;
        Fri, 06 Jun 2025 04:42:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfLbcDHPoXuPeFRYx5fp5q9Ccq3WJRTPtk55xmwaOfHk2VG5uOtB2vDzo9EX+BAO8GbFT/Og==
X-Received: by 2002:a05:6a21:9990:b0:1f5:889c:3cbd with SMTP id adf61e73a8af0-21ee2619e98mr4557090637.35.1749210139095;
        Fri, 06 Jun 2025 04:42:19 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2f5f782283sm1018482a12.54.2025.06.06.04.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 04:42:18 -0700 (PDT)
Date: Fri, 6 Jun 2025 19:42:13 +0800
From: Zorro Lang <zlang@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	linux-unionfs@vger.kernel.org, fstests@vger.kernel.org,
	Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH v2 1/6] overlay: workaround libmount failure to remount,ro
Message-ID: <20250606114213.luz33dqezeuimxic@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250603100745.2022891-1-amir73il@gmail.com>
 <20250603100745.2022891-2-amir73il@gmail.com>
 <20250605175129.oqqzr5qluxv52m6b@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAOQ4uxg2D-ED3vy=jedEKbpEJvWBLD=QYtfp=DCU3pQGGCaGog@mail.gmail.com>
 <20250606011223.gx6xearyoqae5byp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAOQ4uxh9b285dnw+SO2h6HqtNC5Xog0TQSqhFAQaV1brBnVxVQ@mail.gmail.com>
 <20250606103518.c3xklsm2ksjl5w4u@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAOQ4uxi-ZTzatP-iVbWjzYVnv7_JA1F7WjTfjjBUTCmhoWCr-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxi-ZTzatP-iVbWjzYVnv7_JA1F7WjTfjjBUTCmhoWCr-g@mail.gmail.com>

On Fri, Jun 06, 2025 at 12:58:24PM +0200, Amir Goldstein wrote:
> On Fri, Jun 6, 2025 at 12:35 PM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Fri, Jun 06, 2025 at 09:35:36AM +0200, Amir Goldstein wrote:
> > > On Fri, Jun 6, 2025 at 3:12 AM Zorro Lang <zlang@redhat.com> wrote:
> > > >
> > > > On Thu, Jun 05, 2025 at 08:30:53PM +0200, Amir Goldstein wrote:
> > > > > On Thu, Jun 5, 2025 at 7:51 PM Zorro Lang <zlang@redhat.com> wrote:
> > > > > >
> > > > > > On Tue, Jun 03, 2025 at 12:07:40PM +0200, Amir Goldstein wrote:
> > > > > > > libmount >= v1.39 calls several unneeded fsconfig() calls to reconfigure
> > > > > > > lowerdir/upperdir when user requests only -o remount,ro.
> > > > > > >
> > > > > > > Those calls fail because overlayfs does not allow making any config
> > > > > > > changes with new mount api, besides MS_RDONLY.
> > > > > > >
> > > > > > > We workaround this problem with --options-mode ignore.
> > > > > > >
> > > > > > > Reported-by: André Almeida <andrealmeid@igalia.com>
> > > > > > > Suggested-by: Karel Zak <kzak@redhat.com>
> > > > > > > Link: https://lore.kernel.org/linux-fsdevel/20250521-ovl_ro-v1-1-2350b1493d94@igalia.com/
> > > > > > > Link: https://lore.kernel.org/fstests/CAJfpegtJ3SDKmC80B4AfWiC3JmtWdW2+78fRZVtsuhe-wSRPvg@mail.gmail.com/
> > > > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > > > ---
> > > > > > >
> > > > > > > Changes since v1 [1]:
> > > > > > > - Change workaround from LIBMOUNT_FORCE_MOUNT2 to --options-mode=ignore
> > > > > > >
> > > > > > > [1] https://lore.kernel.org/fstests/20250526143500.1520660-1-amir73il@gmail.com/
> > > > > >
> > > > > > I'm not sure if I understand clearly. Does overlay list are fixing this issue
> > > > > > on kernel side, then providing a workaround to fstests to avoid the issue be
> > > > > > triggered too?
> > > > > >
> > > > >
> > > > > Noone agreed to fix it on the kernel side.
> > > > > At least not yet.
> > > >
> > > > If so, I have two questions:)
> > > > 1) Will overlay fix it on kernel or mount util side?
> > >
> > > This is not known at this time.
> >
> > Oh, I thought it's getting fix :-D
> >
> > >
> > > > 2) Do you plan to keep this workaround until the issue be fixed in one day?
> > > >    Then revert this workaround?
> > >
> > > Maybe, but keep in mind that the workaround is simply
> > > telling the library what we want to do.
> > >
> > > We want to remount overlay ro and nothing else and that is exactly
> > > what  "--options-mode ignore" tells the library to do.
> > >
> > > I could have just as well written a test helper src/remount_rdonly.c
> > > and not have to deal with the question of which libmount version
> > > the test machine is using.
> > >
> > > Note that the tests in question are not intended to test the remount,ro
> > > functionality itself, they are intended to test the behavior of fs in
> > > some scenarios involving a rdonly mount.
> > >
> > > I do not want to lose important test coverage of these scenarios
> > > because of regressions in the kernel/libmount API.
> > >
> > > We can add a new test that ONLY tests remount,ro and let that
> > > test fail on overlayfs to keep us reminded of the real regresion that
> > > needs to be fixed, but the "workaround" or as I prefer to call it
> > > "using the right tool for the test case" has to stay for those other tests.
> >
> > OK, I just tried to figure out if "hide this error output on new mount APIs"
> > is what overlay list wants. If overlay list (or vfs) acks this patch, and
> > will track this issue. I'm good to merge this workaround for testing :)
> >
> 
> This workaround in v2 was suggested by libmount maintainer
> and approved by overlayfs maintainer:
> 
> "> So, you do not need LIBMOUNT_FORCE_MOUNT2= workaround, use
> > "--options-mode ignore" or source and target ;-)
> 
> Yeah, that's definitely a better workaround.
> 
> I wouldn't call it a fix, since "mount -oremount,ro /overlay" still
> doesn't work the way it is supposed to, and the thought of adding code
> to the kernel to work around the current libmount behavior makes me go
> bleah."

OK, just to make sure overlay/vfs folks know why these failures gone :)

Reviewed-by: Zorro Lang <zlang@redhat.com>

With this patch, I've merged 5 patches of this patchset. Now only 4/6
still need more reviewing (I've provided my suggestion about that). If
patch 4/6 can't catch up the release of this week, don't worry, I'll
push these 5 patches at first, feel free to send patch 4/6 singly later :)

Thanks,
Zorro

> 
> Thanks,
> Amir.
> 
> [1] https://lore.kernel.org/linux-unionfs/CAJfpegtJ3SDKmC80B4AfWiC3JmtWdW2+78fRZVtsuhe-wSRPvg@mail.gmail.com/
> 

