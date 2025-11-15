Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B0B27A122
	for <fstests@vger.kernel.org>; Sat, 15 Nov 2025 09:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763199388; cv=none; b=ImAhfNgpzzg+tOPOwYyuCTltv2quXHTO8gbSkcXrKLG1Qa61WjKp29R4WRmUVCXQwYFH1u4Ccz1edHu3kDQTW/ICLkohLwKxN0Pz8eqdpJ4s+nY3lK52E4XtQljhXYdPNaFFQcKR+88qgGa/gWD/I+3mqzYOnPwvbcv47wB5tYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763199388; c=relaxed/simple;
	bh=ZTF59b2xNDDFgLhDYSsQMUX/BWRIBQ1xlcqM94AmZEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOcO89HIXmepvgwraPpVEZ8zWnQye5XqS38i2OQDtSM/k26pg7+LzP2+Is3SJNActppYqgswZIhL06JnHUMT4zB6bhwcM4SYn9INGCh2KbckSOwqs5tZvV+gK/FnZvQ8f9RV6oGBXyINz1gTb61nNq9n6LzxOYePX3uXG+vtQy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b0KPXVqu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SaY66EeQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b0KPXVqu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SaY66EeQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763199385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2P37KFvvmOE9DmPPuKba7HiL5DpBrnCOzu+gEYRDQI=;
	b=b0KPXVquJlI7pbK1Dhwc/aP/cAMuTn/U32pz8MaVQSZXEP8mcTammb6rAALcJcF7vTJwJn
	5+eUJt0khjUz1aClbRRLSdYB76q8+/obnFmnQQHDffiD6PZdbkGeLn4V5Tk+kXAfh0C2yR
	fTEW2LUW2ZtftgUP+cTMF+GGsCloJPo=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-p5ZrBBI-NXmDCP4tvbiHug-1; Sat, 15 Nov 2025 04:36:10 -0500
X-MC-Unique: p5ZrBBI-NXmDCP4tvbiHug-1
X-Mimecast-MFC-AGG-ID: p5ZrBBI-NXmDCP4tvbiHug_1763199369
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-297e66542afso86009395ad.3
        for <fstests@vger.kernel.org>; Sat, 15 Nov 2025 01:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763199369; x=1763804169; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y2P37KFvvmOE9DmPPuKba7HiL5DpBrnCOzu+gEYRDQI=;
        b=SaY66EeQN3rjI2ZZBAiUndZdFXGB/dNtZOwEx6DhaaiWz/3DH2gYkgOig/cE48RUSL
         u/DGPka9/MD+7DT405/axgamkb62xndmM8eZnVYicdzRSxSiEDq4YQoZv1Hpwqj3uR0a
         Fbkay+X6IZOto9TiDFOSkpbPh04QLOQ/uU3w1ujP/f6dckMlsOcbNBWmLU64s1jTDzJf
         lYdH0F3k11fNxJ6J266+ZZ5aTS9vVO7ZpGhTwmpyoVn0aX7pJ5+QvJqO160+kqLPgUC0
         vmNynJ6KdVdjDmD+dv0KStfpQfqJW7WeeoEr5xrL9CPO8AlG9L6jEIg00VJ+36jaKbdS
         dmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763199369; x=1763804169;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2P37KFvvmOE9DmPPuKba7HiL5DpBrnCOzu+gEYRDQI=;
        b=jCfZm6i3zvrGccHZ2F0H2fzpCOVyxbjqXyowqheDzF9n4W8tTigIFClbHdiUzx/fGK
         JLkD4Y5hS9wkDHH9MuChQu61au1Zr1oh6rKgNwcubw2N82fKCW1Qs/aM2StwmEabZpjO
         UH4EzxWI5QNMHk2b5emfYXz7KBm1Gy8i7uqjrIfLXLQ6qwe+9rPU/WQbuoLxdnV22pD5
         WqS7XOtsqEXBMfjBuP2wTM5kG3yzaESlR7kMBgHWSmGbwbHD6OO1KQbd44cp603e0Vc0
         ogZ+fsowFgKG3FH7/Wb46eJP9UKSDuxV44LBnHR/Z3CAsE9gaKju7QyXmVx1FNF6+MJS
         0LGA==
X-Forwarded-Encrypted: i=1; AJvYcCVvcqHvBTT/nBdIDqRKbtn13W1HgLFh7gVMQ1o7t8ro+yk+vd95uWx5YuNno9FMLZxotmrKTmMB@vger.kernel.org
X-Gm-Message-State: AOJu0YwMQknTCCQdLuo/4ZXrrTFoHCF9/UW7YxpJ4N10vOk3LM0gWEPU
	PRwlB4vYrPxgZkZlShUdVWiD9yw8+vAvdvfty1bvoPKSIJQogBTtfyGv51Xv76TrArDX+d3glmy
	vH9cda0f2lXHxZNdXblvafSmzHpgIOS9vnLcnHjKlXD8+iiUmJiofZ4NwQ8w=
X-Gm-Gg: ASbGnctkbS2Z7OePvqV7uYDcFj9h9qsJwHgYaoFh1vi8QY+b2FUNGtSFmOcug30USEJ
	FSETQqzSzSLGOqb1HCqD/5B5SsOZkMae0+xp2UkkRRoN4EOtw56+iQqi5xqo9XSQcEYDtZMOBl7
	o1tPNb993b67naprQCC955d3P4MFINDCHLHUwA4/Fo920BUTrxrVqyOWXU1bGtLCFQRxmNT6kWO
	G79pLStoelY9H+59G4G9rEFe2ve+/YqmFZmmPwB2OZifnZJKWA0OQn7qVK7HJEb5zNgfU0bZXTZ
	V+j/u8Ti6a5KcP/WXc8T5IPZANyVJ67ekfqhR1hZ7I4r1PFEj5ilqgX6La/x3Pkw3AZiRJJWTg7
	pcrskPtmrjHiFntuyed/tRMP+5vRRWEWBQvIalfoHNkCCs9SUyA==
X-Received: by 2002:a17:902:d4c4:b0:26a:8171:dafa with SMTP id d9443c01a7336-2986a6d225dmr72565415ad.21.1763195248459;
        Sat, 15 Nov 2025 00:27:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMbZzwsVejum2cvopjzBYNN7ahllxuix+DaBpHGx5GQCjCruGNPprcS65m6kyAR6Bvr2FAcw==
X-Received: by 2002:a17:902:d4c4:b0:26a:8171:dafa with SMTP id d9443c01a7336-2986a6d225dmr72565255ad.21.1763195248016;
        Sat, 15 Nov 2025 00:27:28 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c245e04sm77947555ad.38.2025.11.15.00.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 00:27:27 -0800 (PST)
Date: Sat, 15 Nov 2025 16:27:22 +0800
From: Zorro Lang <zlang@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	linux-unionfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2] overlay: add tests for casefolded layers
Message-ID: <20251115082722.vyqrtmnrabnnl2qd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251114194852.1344740-1-amir73il@gmail.com>
 <20251115071102.pelohvzihg4aafse@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAOQ4uxjWWTm7wYK9737V89ToYgF6gSZ4TD1=tr58nNehk5rcoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjWWTm7wYK9737V89ToYgF6gSZ4TD1=tr58nNehk5rcoA@mail.gmail.com>

On Sat, Nov 15, 2025 at 09:11:33AM +0100, Amir Goldstein wrote:
> On Sat, Nov 15, 2025 at 8:11 AM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Fri, Nov 14, 2025 at 08:48:52PM +0100, Amir Goldstein wrote:
> > > Overalyfs did not allow mounting layers with casefold capable fs
> > > until kernel v6.17 and did not allow casefold enabled layers
> > > until kernel v6.18.
> > >
> > > Since kernel v6.18, overalyfs allows this kind of setups,
> > > as long as the layers have consistent encoding and all the directories
> > > in the subtree have consistent casefolding.
> > >
> > > Create test cases for the following scenarios:
> > > - Mounting overlayfs with casefold disabled
> > > - Mounting overlayfs with casefold enabled
> > > - Lookup subdir in overlayfs with mismatch casefold to parent dir
> > > - Change casefold of underlying subdir while overalyfs is mounted
> > > - Mounting overlayfs with strict enconding, but casefold disabled
> > > - Mounting overlayfs with strict enconding casefold enabled
> > > - Mounting overlayfs with layers with inconsistent UTF8 version
> > >
> > > Co-developed-by: André Almeida <andrealmeid@igalia.com>
> > > Signed-off-by: André Almeida <andrealmeid@igalia.com>
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >
> > > Hi Zorro,
> > >
> > > I fixed the bug you found with tmpfs.
> > >
> > > Please note that I did not assign a sequential test number because
> > > I wanted to let you assign a non conflicting number when you merge it.
> >
> > Thanks Amir :) This version looks good to me, just one question below...
> >
> > >
> > > Thanks,
> > > Amir.
> > >
> > > Chages since v1:
> > > - Fix test run with tmpfs (needed _scratch_mount_casefold_strict)
> > > - unmount MNT1/MNT2 in cleanup
> > > - Use _mount _unmount helpers
> > >
> > >  tests/generic/999     | 242 ++++++++++++++++++++++++++++++++++++++++++
> > >  tests/generic/999.out |  13 +++
> > >  2 files changed, 255 insertions(+)
> > >  create mode 100755 tests/generic/999
> > >  create mode 100644 tests/generic/999.out
> > >
> > > diff --git a/tests/generic/999 b/tests/generic/999
> > > new file mode 100755
> > > index 00000000..c315b8ba
> > > --- /dev/null
> > > +++ b/tests/generic/999
> > > @@ -0,0 +1,242 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (C) 2025 CTERA Networks. All Rights Reserved.
> > > +#
> > > +# FS QA Test 999
> > > +#
> > > +# Test overlayfs error cases with casefold enabled layers
> > > +#
> > > +# Overalyfs did not allow mounting layers with casefold capable fs
> > > +# until kernel v6.17 and with casefold enabled until kernel v6.18.
> > > +# Since kernel v6.17, overalyfs allows the mount, as long as casefolding
> > > +# is disabled on all directories.
> > > +# Since kernel v6.18, overalyfs allows the mount, as long as casefolding
> > > +# is consistent on all directories and encoding is consistent on all layers.
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick mount casefold
> > > +
> > > +# Override the default cleanup function.
> > > +_cleanup()
> > > +{
> > > +     cd /
> > > +     _unmount $merge 2>/dev/null
> > > +     _unmount $MNT1 2>/dev/null
> > > +     _unmount $MNT2 2>/dev/null
> >
> > ... I saw you mount $MNT1 and $MNT2 at first, then mount $merge:
> >
> >   mount_casefold_version "utf8-12.1.0" $MNT1
> >   mount_casefold_version "utf8-11.0.0" $MNT2
> >   ...
> >   mount_overlay $lowerdir (which mount on $merge)
> >
> > So I think unmount $merge after umount $MNT1 and $MNT2 might (looks)
> > make more sense, although I saw you've tried to do unmount_overlay
> > before _cleanup :)
> >
> 
> Conceptually, overlayfs mount is a stack, so the correct order is
> to unmount the top of the stack ($merge) first and then to unmounted
> the base fs of the stack ($MNT1,$MNT2).
> 
> In practice, the order does not matter because overlayfs mount does
> not prevent unmount of the mounts that were used as upper/lower,
> but there is certainly no reason to require unmounting them first.

Oh, my brain went blank, Sure, you're right :)

> 
> Thanks,
> Amir.
> 

