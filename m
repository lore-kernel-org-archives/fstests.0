Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947672C3242
	for <fstests@vger.kernel.org>; Fri,  6 Jun 2025 10:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749206128; cv=none; b=Y3+pGS+qvfb19O2PWsDNQoCNl54669j+tV/nSDVvKw1F/UxyU/QMCvxGIVVU1Vif95yB8OfXhUwT2wVdAwcq4cAcipXUPUjFqwhnE0eIGEu0BxccRwoUUVIOjnd5POPDb9A13+XHHrWdnuZrDdMfF7m23Wgv4UqXEm9qcDhLFEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749206128; c=relaxed/simple;
	bh=6+1yCJgYO6QSkqKiy2kEpBhXB0Jd1F3xFE0TL2NfIm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bm8pAmCNYjK+ImLZTW4aX6lNd5OYI9tpBfPbj8Zzq6MiiPr6JaXO8Smb8qVLa52WAjKpIESnbFK0vngxQd6fG/AGl9mRd6EnKL3ppWx8L4E2HFYz6/cvRpEIWVB2VzsuE68F3V8m/gc1H+d3lqfvGvn72SumRvvhvcVeKLKaWTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X2n5x18N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2n5x18N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749206125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QMSELpZsrQed58tzuI0ADRlOo9zuJjaGh6ASywmRoDk=;
	b=X2n5x18NX1giQS5Zd35iUBSSJrFwLsVLa5i+yPT/8SpJgT1DzTxZfZhB8LLcSiz2jMUyf/
	YYE7/HkZP+PKaXdCFXONCP7HhIK/fVEu1c0weqOUGGzR8GOPU7UTi1BY3DqC8iolf24uEq
	EU3K3pGzWWKqQVxogIVh8m+Up/V9crM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-3B0w1C11PsuaCvcux5gmTw-1; Fri, 06 Jun 2025 06:35:24 -0400
X-MC-Unique: 3B0w1C11PsuaCvcux5gmTw-1
X-Mimecast-MFC-AGG-ID: 3B0w1C11PsuaCvcux5gmTw_1749206123
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-31327b2f8e4so1912431a91.1
        for <fstests@vger.kernel.org>; Fri, 06 Jun 2025 03:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749206123; x=1749810923;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QMSELpZsrQed58tzuI0ADRlOo9zuJjaGh6ASywmRoDk=;
        b=M5oblc1cL2pflpDdkvul8zGUZ8brDBDZOdX5mYUN9ysMjS1FiSKIrvz4dppb/p/J0U
         WJicwxAD23wXfcvjNbnc4P0J5IznwUKWYugwC+CdVbm4D2sxOvTRQU7ha/gTgQF2Lswj
         jzpYZS9lOW/otnqLKbMMK2WPMhiV6EsvYQN3sGpftScMKyxbuCwnZd+xN1mRSwYLNSsf
         b1HYZbO8EvRf+sMrsUuRY9qW3XmfDIfjk2TFZJZQhuvQKV/inQEGdD9aLjAy+qN+GLsr
         YJkcknzMT3FKihhjMlpg3eiTqgE7mURKCb12gn/ZQZUuIO3+OaZpSN7JUnSzW6HhlOBT
         y/OA==
X-Forwarded-Encrypted: i=1; AJvYcCXNqwnAmpl2tAr0IuYwpM+xq63o+b/OB6THamti93ksv+M8oB3upEbaYexJVNpWfi0tvNCZFRtO@vger.kernel.org
X-Gm-Message-State: AOJu0YxxlNrx1vKpNMoNJPXXWRPQYA62R5iw1KEbS1eAKNAzmdC1fxl9
	1cRfz0ja7NajwbCy5lehSU/LA8Ruj/ALBXVIzdh38v2zi2pM0Cu4wKJrlTQEklgaa4DrleLtWJE
	QkwJI/WlZ152bGOkNG1zbqSdTp/YpMj0Cp/Srx9J1WHNYgqHh0c3Plqquhbw=
X-Gm-Gg: ASbGncuIbleIr3Y5T+T6Zf1mIJTU7lYCsDmghA82LLvWRZH17IdhGNDbmYdhMV8Nm77
	9p5qsXwj6Rm9BHcWtTXIR6qa1mbw/KJbX2cd06yLHk5Ad57T5mst35SIGUv9poky6nOGlbbWBgT
	MRYxehHiMi+WlAqikWBqTEJ1Zt617PWSWaXrufkJa6YDv68MHDemqtZnrw9IbkyuEHQir6zx97n
	ZEJlDRk3SLagRumJd3cPc/qtQcSiKub+2Hs65n0o7NoAbwU1UV1oPh0v0HdA8NQkOYOkQZyGUV+
	MFAepvjfunxLki9j9BHEKemiSy2nfeZTV3gqj7k1BwzayglruiAV
X-Received: by 2002:a17:90b:47:b0:313:27b2:f729 with SMTP id 98e67ed59e1d1-31346f5aca6mr3696412a91.23.1749206123525;
        Fri, 06 Jun 2025 03:35:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH927SPWfwXAqw8PdY19LL+gj+K9vYbOwiozadU0b2YBkEo51//zMjarZsTt3/Moxexek2oaQ==
X-Received: by 2002:a17:90b:47:b0:313:27b2:f729 with SMTP id 98e67ed59e1d1-31346f5aca6mr3696385a91.23.1749206123101;
        Fri, 06 Jun 2025 03:35:23 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31349fdfe63sm1049878a91.37.2025.06.06.03.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 03:35:22 -0700 (PDT)
Date: Fri, 6 Jun 2025 18:35:18 +0800
From: Zorro Lang <zlang@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	linux-unionfs@vger.kernel.org, fstests@vger.kernel.org,
	Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH v2 1/6] overlay: workaround libmount failure to remount,ro
Message-ID: <20250606103518.c3xklsm2ksjl5w4u@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250603100745.2022891-1-amir73il@gmail.com>
 <20250603100745.2022891-2-amir73il@gmail.com>
 <20250605175129.oqqzr5qluxv52m6b@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAOQ4uxg2D-ED3vy=jedEKbpEJvWBLD=QYtfp=DCU3pQGGCaGog@mail.gmail.com>
 <20250606011223.gx6xearyoqae5byp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAOQ4uxh9b285dnw+SO2h6HqtNC5Xog0TQSqhFAQaV1brBnVxVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxh9b285dnw+SO2h6HqtNC5Xog0TQSqhFAQaV1brBnVxVQ@mail.gmail.com>

On Fri, Jun 06, 2025 at 09:35:36AM +0200, Amir Goldstein wrote:
> On Fri, Jun 6, 2025 at 3:12 AM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Thu, Jun 05, 2025 at 08:30:53PM +0200, Amir Goldstein wrote:
> > > On Thu, Jun 5, 2025 at 7:51 PM Zorro Lang <zlang@redhat.com> wrote:
> > > >
> > > > On Tue, Jun 03, 2025 at 12:07:40PM +0200, Amir Goldstein wrote:
> > > > > libmount >= v1.39 calls several unneeded fsconfig() calls to reconfigure
> > > > > lowerdir/upperdir when user requests only -o remount,ro.
> > > > >
> > > > > Those calls fail because overlayfs does not allow making any config
> > > > > changes with new mount api, besides MS_RDONLY.
> > > > >
> > > > > We workaround this problem with --options-mode ignore.
> > > > >
> > > > > Reported-by: André Almeida <andrealmeid@igalia.com>
> > > > > Suggested-by: Karel Zak <kzak@redhat.com>
> > > > > Link: https://lore.kernel.org/linux-fsdevel/20250521-ovl_ro-v1-1-2350b1493d94@igalia.com/
> > > > > Link: https://lore.kernel.org/fstests/CAJfpegtJ3SDKmC80B4AfWiC3JmtWdW2+78fRZVtsuhe-wSRPvg@mail.gmail.com/
> > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > ---
> > > > >
> > > > > Changes since v1 [1]:
> > > > > - Change workaround from LIBMOUNT_FORCE_MOUNT2 to --options-mode=ignore
> > > > >
> > > > > [1] https://lore.kernel.org/fstests/20250526143500.1520660-1-amir73il@gmail.com/
> > > >
> > > > I'm not sure if I understand clearly. Does overlay list are fixing this issue
> > > > on kernel side, then providing a workaround to fstests to avoid the issue be
> > > > triggered too?
> > > >
> > >
> > > Noone agreed to fix it on the kernel side.
> > > At least not yet.
> >
> > If so, I have two questions:)
> > 1) Will overlay fix it on kernel or mount util side?
> 
> This is not known at this time.

Oh, I thought it's getting fix :-D

> 
> > 2) Do you plan to keep this workaround until the issue be fixed in one day?
> >    Then revert this workaround?
> 
> Maybe, but keep in mind that the workaround is simply
> telling the library what we want to do.
> 
> We want to remount overlay ro and nothing else and that is exactly
> what  "--options-mode ignore" tells the library to do.
> 
> I could have just as well written a test helper src/remount_rdonly.c
> and not have to deal with the question of which libmount version
> the test machine is using.
> 
> Note that the tests in question are not intended to test the remount,ro
> functionality itself, they are intended to test the behavior of fs in
> some scenarios involving a rdonly mount.
> 
> I do not want to lose important test coverage of these scenarios
> because of regressions in the kernel/libmount API.
> 
> We can add a new test that ONLY tests remount,ro and let that
> test fail on overlayfs to keep us reminded of the real regresion that
> needs to be fixed, but the "workaround" or as I prefer to call it
> "using the right tool for the test case" has to stay for those other tests.

OK, I just tried to figure out if "hide this error output on new mount APIs"
is what overlay list wants. If overlay list (or vfs) acks this patch, and
will track this issue. I'm good to merge this workaround for testing :)

Thanks,
Zorro

> 
> Thanks,
> Amir.
> 

