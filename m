Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEE522ACEE
	for <fstests@vger.kernel.org>; Tue,  8 Apr 2025 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744122479; cv=none; b=tLJX/rngDj6Aw8m3FwERaY41ebXM1cXpY9jkqZIqv+jT9dp5IlIILD2ahOMDZ/cQ7v6jIPXSGAxzCpJrVqrv8A6+ZWJodUwsO8DxvNMkjxoIQgMkGguvDUEUq4zqzaMaJNQSFqYnYLYSXae5929jZX5UdpV6ifZDFRo9vhIxw+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744122479; c=relaxed/simple;
	bh=8sVTW6TceJNB34RYjY9n6ubg4DVVdtoWsa7Sh4zjrSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSL1kNF433NxBmRID3OUqduqNXV1CYGzTzDxlOSH0xC8vhrSrMGSSEAEnoNsJjQyYMTE4BAZZcbaizXod6YiqcwcZ6NRrEI+DGy0n1MaR59Ftz7VZ0c4Phlcp1G3VlhTavBrmjxi4JOw7yR7xJ66LCOkPnEyLiscP5/5y1/VOkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UMlmBo/V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UMlmBo/V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744122476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8RFZ7s3rxzl+Ts3s9RalLsIVjWLHrI7+8FF2waxdV8s=;
	b=UMlmBo/Va5211E5YuTyigYQairEMEX6tdxOla0xvf7yJezF9whPkZOfHPR/oe0fMOWWzVT
	nY13qB2mFIXPKgsbxqN3Xd/ogMG6b9X3tMKQdyv/K0QU1pSJsbdlhuQoJ1yjHznrfwhLNc
	l95e4w5q6SmYTpQi7aWbc13Rci/W6kM=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-ScCWlfRWNUis1-Q6IDZwWg-1; Tue, 08 Apr 2025 10:27:54 -0400
X-MC-Unique: ScCWlfRWNUis1-Q6IDZwWg-1
X-Mimecast-MFC-AGG-ID: ScCWlfRWNUis1-Q6IDZwWg_1744122473
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2262051205aso41345885ad.3
        for <fstests@vger.kernel.org>; Tue, 08 Apr 2025 07:27:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744122473; x=1744727273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RFZ7s3rxzl+Ts3s9RalLsIVjWLHrI7+8FF2waxdV8s=;
        b=rwicVathiU82KEYnpwqO3BDFQOnnwjSPeNkRZrmxHxFBtQb2/IZ6KOM0+pde9yYVvt
         ic/bvArJ86YRbnSEsLAoKeoa2JOcUJLcWvBW8E28L9aNa95zk32sCvXiRAfk0VPNUKXg
         dwgEifOpwZ86qOUsc7nCLqsxq81Z2UAfTOcQSugRvj2DSrQmWqxzGmDcTZfb13gHHGHk
         bHdUC6eChm2DwN3kImLUoNYxiMyiG4fkksFVOqU5jw+5xUN+9j0OtCHWntRx9K71rzge
         CClffA9+dYJGegawx+OqrB/q9B17EvrXWciud8z4s5c+aVubH5+yqP04Lx4RuM285BUk
         DTFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyWu9okhpnEYTR0inA1dD+lEvnRXW5j/YE3Yuoqmq+daCKyJLiPijO08ybTrcVUOspx8o2VLJ6@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1GS7djqA7jWf/tdec02t/3fVF93Bjs4RBWXxAvvFCZy1nnkOF
	t4V7u5RTgccFuGNGmcC0hTo9Y0dOegNlbMyyYHMLkiKBHbRLM675aSzFKx08QvEGl4OqH+C0GU1
	9T7hdAirDWenYoVM7xzveqrbFudC6hAYOwA3/St+GxQ86MJndhYs12eU4x7VM6QBNjg==
X-Gm-Gg: ASbGncs07rkhZcy7XjiG5tv4Pv9EBr0zS5NGq8npuCiT2sV9KY1SnkEa2SArTbod4H8
	GoEPkYvjTJFgN7XEEiZvTjKZdvo8B7wJQlHga7/E0UZfGZ7XmIQnbAEFErZCX7q0zY7RF/Dk5BZ
	zHlZwJ7x5RD3+DPakmkFPDLvI5Yo6I1P97bguZ1RLUombB6/aYIwv14qMDv2efRsWbNmVGZCnJz
	6slMQa0quR+f2uArdghdrZ1EZtrbU+xmOFUQAgesT8GxUv6qIQfHvybrz/yFrSJf8DWzZ2PTm/7
	Mi4bplX4J9shPUd60NX/u/CjYrSxIcoZWqipdql6zzCJPqWlAUoOLGGk
X-Received: by 2002:a17:902:d4ca:b0:223:5e76:637a with SMTP id d9443c01a7336-22a95539beamr160554625ad.23.1744122473107;
        Tue, 08 Apr 2025 07:27:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgjgb0MlkszrbH2eNw4gben2vOMbEpUncigfF9I1M6mhJaVYcdLSb8ZfEimongz+/9tzu4Rg==
X-Received: by 2002:a17:902:d4ca:b0:223:5e76:637a with SMTP id d9443c01a7336-22a95539beamr160554245ad.23.1744122472750;
        Tue, 08 Apr 2025 07:27:52 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d9ea0801sm10573244b3a.119.2025.04.08.07.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 07:27:52 -0700 (PDT)
Date: Tue, 8 Apr 2025 22:27:48 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
	david@fromorbit.com
Subject: Re: [PATCH v2 5/5] common: exit --> _exit
Message-ID: <20250408142747.tojq7dhv3ad2mzaq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1743487913.git.nirjhar.roy.lists@gmail.com>
 <f6c7e5647d5839ff3a5c7d34418ec56aba22bbc1.1743487913.git.nirjhar.roy.lists@gmail.com>
 <87mscwv7o0.fsf@gmail.com>
 <20250407161914.mfnqef2vqghgy3c2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <877c3vzu5p.fsf@gmail.com>
 <3c1d608d-4ea0-4e24-9abc-95eb226101c2@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c1d608d-4ea0-4e24-9abc-95eb226101c2@gmail.com>

On Tue, Apr 08, 2025 at 12:43:32AM +0530, Nirjhar Roy (IBM) wrote:
> 
> On 4/8/25 00:16, Ritesh Harjani (IBM) wrote:
> > Zorro Lang <zlang@redhat.com> writes:
> > 
> > > On Fri, Apr 04, 2025 at 10:34:47AM +0530, Ritesh Harjani wrote:
> > > > "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com> writes:
> > > > 
> > > > > Replace exit <return-val> with _exit <return-val> which
> > > > > is introduced in the previous patch.
> > > > > 
> > > > > Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> > <...>
> > > > > ---
> > > > > @@ -225,7 +225,7 @@ _filter_bmap()
> > > > >   die_now()
> > > > >   {
> > > > >   	status=1
> > > > > -	exit
> > > > > +	_exit
> > > > Why not remove status=1 too and just do _exit 1 here too?
> > > > Like how we have done at other places?
> > > Yeah, nice catch! As the defination of _exit:
> > > 
> > >    _exit()
> > >    {
> > >         status="$1"
> > >         exit "$status"
> > >    }
> > > 
> > > The
> > >    "
> > >    status=1
> > >    exit
> > >    "
> > > should be equal to:
> > >    "
> > >    _exit 1
> > >    "
> > > 
> > > And "_exit" looks not make sense, due to it gives null to status.
> > > 
> > > Same problem likes below:
> > > 
> > > 
> > > @@ -3776,7 +3773,7 @@ _get_os_name()
> > >                  echo 'linux'
> > >          else
> > >                  echo Unknown operating system: `uname`
> > > -               exit
> > > +               _exit
> > > 
> > > 
> > > The "_exit" without argument looks not make sense.
> > > 
> > That's right. _exit called with no argument could make status as null.
> Yes, that is correct.
> > To prevent such misuse in future, should we add a warning/echo message
> 
> Yeah, the other thing that we can do is 'status=${1:-0}'. In that case, for
                                           ^^^^^^^^^^^^^^
That's good to me, I'm just wondering if the default value should be "1", to
tell us "hey, there's an unknown exit status" :)

Thanks,
Zorro

> cases where the return value is a success, we simply use "_exit". Which one
> do you think adds more value and flexibility to the usage?
> 
> --NR
> 
> > if the no. of arguments passed to _exit() is not 1?
> > 
> > -ritesh
> 
> -- 
> Nirjhar Roy
> Linux Kernel Developer
> IBM, Bangalore
> 

