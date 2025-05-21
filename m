Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D304D25B695
	for <fstests@vger.kernel.org>; Wed, 21 May 2025 10:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747822050; cv=none; b=fa2aIJtA5mrMWBvukG7Fal5cfJMiNLXidzi+jJK8EjGDxrv8iNQK1Cw8SS5pFCH7zj2mgs2kN4zEbsxKciw5FZCS8j0Cu2ZvNcIWvn4INsj7toxtXY2G0FTO7Mjj18RIlam+UKbNS7HET1rBIT1G3DgFoZxNoPTH0wbrGi60rNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747822050; c=relaxed/simple;
	bh=au5E+mI/v6t54yTejGsLkulW96qm4tTm7SNzSZu1Gik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3fFVE0ehX91rQIQKR6q9AKPEYfyDfcUGit3oqETZsm77C3fuY1zzSRWnVo9nbJf+8WT1TEFbCf3HUyF4bioFk6mIL7TS+glIJGX8iT0DqP3JlO1QRnABgyR/OCwVXDiDR0ZvLEvTBANzh7PdW33EcZPHOgopgy71e0RXRbftOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=o3QKYP1g; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="o3QKYP1g"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22c336fcdaaso52601105ad.3
        for <fstests@vger.kernel.org>; Wed, 21 May 2025 03:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1747822048; x=1748426848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i3ifWkGoSJYonSUVfpuLFbG6R8mHdpVynk4fWzSZqjw=;
        b=o3QKYP1gsqZfQQxI6afVZCNSFdo4gqXDir4X9jUkHSuGv7PyMXozvRecIBUvElBROb
         lhx00UgVbwWTgcoNUFkv/XU+Xde1xy00woF1X1Pg0axv1P1ygH0eB4Q5sR86r1wcpRrW
         jC9spozYeQr0IRokczyV6pumzS6O/zzg3T3Pg3uG1AOYamKAmiRy4VohjkW2anH4kGFJ
         v+UhBap05Zt9GnCYhvOUwYvZ+DmsYj+i57K+8v+xP3RKI7bKWSGaPvCs94zYDHsW2XLu
         +XTvM8Wg0ZDa6X7PFCsJy1YHoTliYus814ohRtyLDLvENVNpd6U/Hy4M7Ykip7BaUYDR
         X2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747822048; x=1748426848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3ifWkGoSJYonSUVfpuLFbG6R8mHdpVynk4fWzSZqjw=;
        b=ptE35b7WO/XbMb1Eczd9jyFJolcA56KfWRfnqf7jFzq0MRmTZz0jJ0fad4ke3XQNAY
         QBLS4pCTXNyPJzhnKzgf+dudQpGcnwzK8fPl6q2IXmSTUM2KzQUz2/TDMCrMtcqiOn1i
         bzbqD5/jSX8aYvyq4eyZ6VrFCMje7FjUVJ9TJ2K8SNA96fpjVxBrdS92P48+IXTLciJ8
         cJyztCvhz2ZysmtVNj1oBeAo/3TrAs71LQ3KUvC+UV+KjVLRlFYNWFVOfvGzF6AAMGRF
         tJO+N1iRmMsVqJA73Fv0Vx+ieS0BYFz4zzbSUc+TORn4S1n3frDs+uCswbVwyiQuyoGG
         vfWw==
X-Gm-Message-State: AOJu0Ywmgmq8GjgYTnbM567n9+N30xf+b+z5d/ygHFXaiXcZ+37ozhrm
	zKFA30urnbt73L5nPXihgpur1R3lJnGc1ZtLpstu7Au2uozXo08kUvNTj/6ElGjSdI4=
X-Gm-Gg: ASbGncuI5+DSd2t/r7wo5No4Vyg3/6mKrqdA9lNO7Ht3/4/zWGMyWH6b0DrxHZnRlNX
	NCDV6U3uUMRDyXW8ii+F6dlsaRRWDlW64rUzm3C74yQJKS95cROqYxhV0H5V2W9l9DEeOOT2RNu
	SoxQVhRZBAqPAeaP4UpW/ogOSqBrB5bVIf99LkMHswlET1Tmz1TAofCBRxmxnjy8wof/+2ZVetA
	wJwMxQZUEl343qq+Iz1hmxfGGBubmKYXSUtkP5XUIze1wsxAsYpbVQ1IOioCgDErFCn80fxZOvr
	NertJXdLDAa8gA06F8JTx6zl6qEp/efhzsYF1fQl2YhaTcYkYJZc+oVBQAaVg3H/d+yHVIfbOav
	icgeLiUgKnzWOXOAkSnr6gsEwZqY=
X-Google-Smtp-Source: AGHT+IG69uLxbKHZsjSvchgGhouBuKLvgow3ydk+Vh6aeH5o1MHxh1h5ZrKQjMnP71FcenYUHZqclw==
X-Received: by 2002:a17:903:2f45:b0:21f:507b:9ad7 with SMTP id d9443c01a7336-231d452797dmr304593085ad.25.1747822047997;
        Wed, 21 May 2025 03:07:27 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-184-88.pa.nsw.optusnet.com.au. [49.180.184.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ed576esm90004635ad.242.2025.05.21.03.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 03:07:27 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uHgM8-00000006GXm-3DrK;
	Wed, 21 May 2025 20:07:24 +1000
Date: Wed, 21 May 2025 20:07:24 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org
Subject: Re: [PATCH 08/28] check-parallel: add logwrite device support
Message-ID: <aC2l3D-mqGT2Ae_d@dread.disaster.area>
References: <20250417031208.1852171-1-david@fromorbit.com>
 <20250417031208.1852171-9-david@fromorbit.com>
 <3c71d313d13fab780425304c118bd86f534fefe6.camel@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c71d313d13fab780425304c118bd86f534fefe6.camel@gmail.com>

On Wed, May 07, 2025 at 01:48:03PM +0530, Nirjhar Roy (IBM) wrote:
> On Thu, 2025-04-17 at 13:00 +1000, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > Every logwrite test will use the same /dev/mapper/<dev>
> > name for the logwrites device, so we also need to convert
> > common/dmlogwrite to use per-test device names as we have done for
> > other dm devices.
> > 
> > Then add a per-test-runner LOGWRITES_DEV so that all tests using
> > dm-logwrites now get run by check-parallel.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
.....
> > diff --git a/common/dmlogwrites b/common/dmlogwrites
> > index a27e1966a..7c3ad95c9 100644
> > --- a/common/dmlogwrites
> > +++ b/common/dmlogwrites
> > @@ -4,6 +4,9 @@
> >  #
> >  # common functions for setting up and tearing down a dm log-writes device
> >  
> > +LOGWRITES_NAME=logwrites-$seq
> if 2 different runners are running tests with the same $seq, won't
> there be a conflict? For example runner-0 is running xfs/xyz and
> runner-1 is running generic/xyz ? 

Yes, it could happen, but it won't happen right now as there is no
overlap in test numbers using dmlogwrites between different test
directories.

I do need to solve this generically (i.e. for all the dm device
types) in the near future because I want to be able to run the same
test N times in parallel. e.g do flakey test profiling really
quickly over thousands of iterations by running 64 instances of the
test at the same time.

For this use case, the dm device name cannot rely on the test
name/sequence number at all, and so I'm going to have to come up
with a unique ID of some kind for this purpose. It may be as simple
as encoding the unique runner ID along with the test sequence number
into the device name - it's not a difficult issue to solve.

Hence I haven't spent much more thought on it than that, because
I've answered the two main questions that were relevant: "can
I solve it?" (yes) and "do I need to solve it now?" (no).

-Dave.
-- 
Dave Chinner
david@fromorbit.com
