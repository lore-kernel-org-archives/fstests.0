Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6751F755B
	for <fstests@vger.kernel.org>; Fri, 21 Feb 2025 06:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740117773; cv=none; b=EjoFzFUF9Yej4GCH07Y7KrwVjmELfz/DmTFfd1xETwISYo7IAITgIKCV+JGfYl8GsbN0r+2K6sVrLw4XMtAxkJdqr3cJJc/wh4v13Eugh0cHjFInG4pT9T3tC2U8JbmLz5n1tmoBtnPvA6mdupzqSYpZNIKgrmdJU9n3nmWfJSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740117773; c=relaxed/simple;
	bh=naxkgafUE/uoKz1c65LlObiDAc87O5jI+9ZZKZQPH4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eR6IpwY/YBslUJ2D8PE8yWe4K/Ohr7GA8aEQEHyS4/+WUDFyFBJfdXj/LrSdqN+Y9Uao38obR+yvJXWZREMTv7E4sdhPl38gyrYNGCL+ETICTu0iXQwzNALTtukD1z6IrpJhO2BPAhSMVSBQOE1gesmIKtr4+sUnNPQZZD46No0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LUAp+NKD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LUAp+NKD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740117771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=obxFJfu8iolYPLgoAFCeQGWsCqsjY31pMoZ5UMKcarQ=;
	b=LUAp+NKDkf/vY7o7Ae2tjLMJc5V6nw1aVYK1/iwwBxB0t/iomymwnhklkOY0BR0Zr8fkW0
	IB4/xkSAfzRKXNIhnq9JHNpvjvsDeUFV7TwdSDD7HoBAuZ+pJjZKKzmq3RcSDjOd1/Hyok
	GH4P/qovdpQ+GWfUCmtd57bz4io08hE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-ctZBMKZRNfOOkxloMIXVvQ-1; Fri, 21 Feb 2025 01:02:49 -0500
X-MC-Unique: ctZBMKZRNfOOkxloMIXVvQ-1
X-Mimecast-MFC-AGG-ID: ctZBMKZRNfOOkxloMIXVvQ_1740117768
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-22109f29c99so36281445ad.1
        for <fstests@vger.kernel.org>; Thu, 20 Feb 2025 22:02:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740117768; x=1740722568;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=obxFJfu8iolYPLgoAFCeQGWsCqsjY31pMoZ5UMKcarQ=;
        b=C+eWIOcjiXqgRBxKM5e+L9+ebOfcFeF1wH9syecojXulj/itWK1K0UDWAdifKVl/x3
         3Ek2UaGA4TjFXuJBSqnCuMssruvpY25jfiU4ZidxAlHItviGHQwkR0CP2XtUDhz4uKo1
         fByWjbTc0kEALyJ4Cx2d2tDlS6ndaFUFluP/q+ATSCpvZ7PkxQKp9/Rg54vKRHuqF+xa
         cIwHYELplIIYvhS/hQAWvqGvNFPVQaiOdoJXuntFBS5qTcoR+m9rThn7XCa2rUB7m37C
         aBP2FF2MUcE4wgbyA1cnh/j2hZUAiaNoIUAcODv1zfsAtu1LsoWdAr3VqduvCvhZ6/LO
         qEyw==
X-Forwarded-Encrypted: i=1; AJvYcCW6pVW2Cql04KDnIyZX6FhG7RvZt0OKyPsmWHWyXnN2vbkc6jUwOX+dq1XuKG5y3L0x9DFMQNPb@vger.kernel.org
X-Gm-Message-State: AOJu0YyRr1noWO0q9q2u7w+wWtUzf6bI7hLJuPqCI8BK7jQHhdDn/WH6
	B7l+Roal0EcwZwGMlB4nL8m6MDJ5lIlHRWIob2z/6f9oUI+R4cmbkuc1t0KjyJGqAix4sc+m5qW
	UkcsJwz93QfVcn0sZcp/u3bUWGr17GaVRI2Csx1jXHFZzsVe3+kx13TA=
X-Gm-Gg: ASbGnctMin2cxJd/l42nyhMkLA8Jss0JwfONI3AwRQu3XK0jr3BwQPoHPRcYxEzWThm
	FksM04N5VQvNfuhJewrGYQqOzXegXo74FkXUjcupzXjK3IjEShjpHCp3QJ72P54+/dahItM/hHU
	DNJGdm17NYvqV0ruMEosZoMlK4ggaxsx/ha1xPsMZcGCiFPHue3eI9cb3MoOKxTA1KTO49DpEZn
	aYBoLRsISKnR0Jp568Z8gZNDm8xb6Kjk8bRmvbcTyODnYIimjL2cl/gLe6z30ukI46u7Ok4p66Z
	zLHDzC2Frp+ZbPobR3q05BjiM+yOkcrjIxZLTrh7waQUbNgnKOeQfpbU
X-Received: by 2002:a17:903:2286:b0:220:cd9f:a186 with SMTP id d9443c01a7336-2219fdc2dfcmr36260715ad.0.1740117768477;
        Thu, 20 Feb 2025 22:02:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYlbRZFFuOUDgIJ24tagzyso/dkqWf2mfOc8u3dr9nscIjeUfbiBUC8oyWfSN9pNrRVlMTbg==
X-Received: by 2002:a17:903:2286:b0:220:cd9f:a186 with SMTP id d9443c01a7336-2219fdc2dfcmr36260425ad.0.1740117768109;
        Thu, 20 Feb 2025 22:02:48 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-221822094adsm31120035ad.195.2025.02.20.22.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 22:02:47 -0800 (PST)
Date: Fri, 21 Feb 2025 14:02:43 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Filipe Manana <fdmanana@kernel.org>, Anand Jain <anand.jain@oracle.com>,
	fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 1/2] btrfs/254: don't leave mount on test fs in case of
 failure/interruption
Message-ID: <20250221060243.4wgr4s64mz7qaxlf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1739989076.git.fdmanana@suse.com>
 <9aa6c8318d11b2fd1c2e208d85b2f83ea81ff88d.1739989076.git.fdmanana@suse.com>
 <d2d72753-5bf2-48cf-b2f0-cfe184ec75a7@oracle.com>
 <20250220170333.GV21799@frogsfrogsfrogs>
 <CAL3q7H6cH26jarU+YEogd5O5FuHi+YNtaWgmsV72NuXacPQU6w@mail.gmail.com>
 <20250221041819.GX21799@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250221041819.GX21799@frogsfrogsfrogs>

On Thu, Feb 20, 2025 at 08:18:19PM -0800, Darrick J. Wong wrote:
> On Thu, Feb 20, 2025 at 06:22:57PM +0000, Filipe Manana wrote:
> > On Thu, Feb 20, 2025 at 5:03 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > >
> > > On Thu, Feb 20, 2025 at 01:27:32PM +0800, Anand Jain wrote:
> > > > On 20/2/25 02:19, fdmanana@kernel.org wrote:
> > > > > From: Filipe Manana <fdmanana@suse.com>
> > > > >
> > > > > If the test fails or is interrupted after mounting $scratch_dev3 inside
> > > > > the test filesystem and before unmounting at test_add_device(), we leave
> > > > > without being unable to unmount the test filesystem since it has a mount
> > > > > inside it. This results in the need to manually unmount $scratch_dev3,
> > > > > otherwise a subsequent run of fstests fails since the unmount of the
> > > > > test device fails with -EBUSY.
> > > > >
> > > > > Fix this by unmounting $scratch_dev3 ($seq_mnt) in the _cleanup()
> > > > > function.
> > > > >
> > > > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > > > ---
> > > > >   tests/btrfs/254 | 1 +
> > > > >   1 file changed, 1 insertion(+)
> > > > >
> > > > > diff --git a/tests/btrfs/254 b/tests/btrfs/254
> > > > > index d9c9eea9..6523389b 100755
> > > > > --- a/tests/btrfs/254
> > > > > +++ b/tests/btrfs/254
> > > > > @@ -21,6 +21,7 @@ _cleanup()
> > > > >   {
> > > > >     cd /
> > > > >     rm -f $tmp.*
> > > > > +   $UMOUNT_PROG $seq_mnt > /dev/null 2>&1
> > >
> > > This should use the _unmount helper that's in for-next.
> > 
> > Sure, it does the same, except that it redirects stdout and stderr to
> > $seqres.full.
> > 
> > Some tests are still calling  $UMOUNT_PROG directly. And that's often
> > what we want, so that if umount fails we get a mismatch with the
> > golden output instead of ignoring the failure.
> > But in this case it's fine.
> 
> <groan> You're right, I'd repressed that Chinner decided to introduce
> _unmount so that he could improve logging of unmount failures but then
> he only bothered converting tests/{generic,xfs} because he didn't give
> a damn about anyone else.
> 
> Now fstests is stuck with a half finished conversion and no clarity
> about whether the rest of the $UMOUNT_PROG invocations should be
> converted to _umount or if those are somehow intentional.
> 
> Hey Zorro, do you have any opinion on this?  Should someone just finish
> the $UMOUNT_PROG -> _unmount conversion next week?

The release of this week will have your big randome-fixes. Next release will
deal with your 10 PRs mainly :) So I'll deal with the "$UMOUNT_PROG ->
_unmount conversion" after that. Anyway, we still can review the "conversion"
patch at first.

Thanks,
Zorro

> 
> --D
> 
> > Anand, since you've already merged this patch into your repo, can you
> > please replace that line with the following?
> > 
> > _unmount $seq_mnt
> > 
> > Thanks.
> > 
> > >
> > > --D
> > >
> > > > >     rm -rf $seq_mnt > /dev/null 2>&1
> > > > >     cleanup_dmdev
> > > > >   }
> > > >
> > > >
> > > > Reviewed-by: Anand Jain <anand.jain@oracle.com>
> > > >
> > > >
> > > >
> > 
> 

