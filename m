Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818FE224F0
	for <fstests@vger.kernel.org>; Fri, 20 Sep 2024 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726842509; cv=none; b=WwD/ItMIMhdtTtT/SNZmlAJEiGR1uF9rISaNpDclc4YN60S4feC2E2eVUpbD8oaT1jMd4jtR73ZWYOnESg1nZo0BwVO6wUvc8/QgbIEVAri6w+uoPzf9xE6A/kf7lwRC+b4EbMWW4LGGLJPYj5fFsDlJDdZ+ZLkvImKqbbyApyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726842509; c=relaxed/simple;
	bh=tn7HXjRe7W0d7xFcff6BCHEkeo1rFVuPBgubP1QG+Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoZzs8DYFXs0Rf+7KOE8Uvbh18dow7kFWePuxLFiyvJxAp8vOgA4XfrrhhpnqjGJS0cZSD3ccb4LSbaixP8HLAFfbJ09U6PRHag2hJqAJjF5GipnoYxOt3uWPNkPqHBtVFilrxdWo1o3Nas9v5n7oedZym0vcvQJlm5XqhXzQFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hDtsllBx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hDtsllBx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726842506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/GReExtg5KEw9ycSI9NkUMs/+s53rIzyuqpEbR7Gx0A=;
	b=hDtsllBxFq5Nfl+Ojl/hcVkNe9BUNkC0J3zKkhQz0w8xmNnnVygBnZKnA7lg4oEZQ4Q10B
	xHk7LyZxs2Dgnb+ihUzsbTntubXNd/0o8xgegdTH/zNbkH69ipuldHrbJIh48s+RinG2UK
	JACdjFpR5b7kOWNQ6nb2WQvNlB3mfR8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-iMSiSuhaM1qAsWsSMkjndw-1; Fri, 20 Sep 2024 10:28:25 -0400
X-MC-Unique: iMSiSuhaM1qAsWsSMkjndw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2db6527b84aso2532707a91.3
        for <fstests@vger.kernel.org>; Fri, 20 Sep 2024 07:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726842504; x=1727447304;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/GReExtg5KEw9ycSI9NkUMs/+s53rIzyuqpEbR7Gx0A=;
        b=nxRgqrCAT0zGXBEx/zZ7RgJkTEVU7OVuIsB+DIK83pOyoUsxM5xkQzbbx8Yi/NLrYA
         tSEkPnCdDDYeVCTRRSx1Gy5uPfix7dr3W/x+fUEAScG7oAwQ/APm9cr8YB13/DiQY0SL
         +gGswRMs25rbrE2SiiNwWACG46KJsV9Inx+zEi2+yuClJMDch8LrRz6tofT5aWcBwyoM
         +gXAn94XdKFwCUbhwwut66mEWEXDi+LLvWPxiyVeuwzvKDpent1e5UKYw+YCgIAHXv10
         LfzqHScs2VOy89z2zEEhPO+E40iiIhsw/58o6QOE9gvgSXVr7XeXXQiajkkpZKutLE1z
         AGcw==
X-Forwarded-Encrypted: i=1; AJvYcCWX6IBzK0hcyVEq0QXFSAUJlYEX1y2qLTKIzVsQ14c2DrTLCVDx+NYcgeduHZq9jGROMVPsCNyQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyLrAJaUpF+qKMs3nRe3lX5vl/cvuPeIBMhqtMBEPcYLuaMdsNE
	+B0sV8/sqJIMOL4lw9WCntuvBHtZCzMvgqN4+dHXvWtcikWoA+EuFPuYIQAyAf6ZyKpulFqU0Rp
	NfE1daQ1pWGwxxqkxH9wRljEv+EXmmgg4zezcGjMuzRN3L+N5Uz6sFd4=
X-Received: by 2002:a17:90b:1c90:b0:2d8:e3f3:fd66 with SMTP id 98e67ed59e1d1-2dd7f71a7c2mr3400566a91.34.1726842504228;
        Fri, 20 Sep 2024 07:28:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvETce9oCqcBQJIFOR8Vcf7EYVuhByeRra4TmgPu5O8FyufAncggU2yHnxjpS+TUqNoA12Iw==
X-Received: by 2002:a17:90b:1c90:b0:2d8:e3f3:fd66 with SMTP id 98e67ed59e1d1-2dd7f71a7c2mr3400545a91.34.1726842503791;
        Fri, 20 Sep 2024 07:28:23 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd52e4f8d5sm4560497a91.1.2024.09.20.07.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 07:28:23 -0700 (PDT)
Date: Fri, 20 Sep 2024 22:28:19 +0800
From: Zorro Lang <zlang@redhat.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: An Long <lan@suse.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] btrfs/315: update 315.out to adapt mount cmd
Message-ID: <20240920142819.oczpp5iah5ojsycl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <bb85eb7d443b2da482b6087d8946f0efafa15f87.camel@suse.com>
 <20240919120156.apamqapyuytpf3ii@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H7VvysO7S6DxOUwoR-1TWT61NAeHBVcidZca_yiT+q3BQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H7VvysO7S6DxOUwoR-1TWT61NAeHBVcidZca_yiT+q3BQ@mail.gmail.com>

On Fri, Sep 20, 2024 at 11:12:12AM +0100, Filipe Manana wrote:
> On Thu, Sep 19, 2024 at 1:02 PM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Thu, Sep 19, 2024 at 01:07:53AM +0800, An Long wrote:
> > > Mount error info changed since util-linux v2.40
> > > (91ea38e libmount: report failed syscall name).
> > > So add "mount" before "system call failed".
> > >
> > > Signed-off-by: An Long <lan@suse.com>
> > > ---
> > >  tests/btrfs/315.out | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tests/btrfs/315.out b/tests/btrfs/315.out
> > > index 3ea7a35a..a19ae8d5 100644
> > > --- a/tests/btrfs/315.out
> > > +++ b/tests/btrfs/315.out
> > > @@ -1,7 +1,7 @@
> > >  QA output created by 315
> > >  ---- seed_device_must_fail ----
> > >  mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-
> > > only.
> > > -mount: TEST_DIR/315/tempfsid_mnt:  system call failed: File exists.
> > > +mount: TEST_DIR/315/tempfsid_mnt: mount system call failed: File
> >
> > This change will bring failure to downstream distro. Please refer to
> > _filter_error_mount (or other filters you like), add new filter to
> > it to help this test passed on old and new util-linux.
> 
> Isn't that what I said in my previous reply [1]?
> 
> [1] https://lore.kernel.org/fstests/CAL3q7H7fzCQE0qjZEgeAJ2jvBsJxbYN-S=XpWFu5KDoaXgqsZQ@mail.gmail.com/

Oh, sorry I replied directly due to I thought my old change when
I saw this patch.

  commit e937e23d202173d112cfe7621d8b860f691ce42d
  Author: Zorro Lang <zlang@kernel.org>
  Date:   Fri May 27 20:11:15 2022 +0800

      common/filter: filter out extra mount error output

Sure, you're right, thanks for reviewing :)

Thanks,
Zorro

> 
> >
> > Thanks,
> > Zorro
> >
> >
> > > exists.
> > >  ---- device_add_must_fail ----
> > >  wrote 9000/9000 bytes at offset 0
> > >  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > > --
> > > 2.43.0
> > >
> > >
> >
> >
> 

