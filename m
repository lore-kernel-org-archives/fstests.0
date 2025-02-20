Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114BA20485D
	for <fstests@vger.kernel.org>; Thu, 20 Feb 2025 17:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740071182; cv=none; b=SFFK4yBIE5BZ6DpNmA37O879mYdUavraiCX+lwPBeRvljc/wI0WjVCRy+1lSXSHGWugEsZdtPKp+nUqxUD8i3QkPn6Dgd11DHmCVL1pyzd32Iq3n1+pJKEUeQuKDHN9VlRvbai2bvAH7hgAuupuQn8r277T7MDvA6gop06VaFTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740071182; c=relaxed/simple;
	bh=vTmRwoYTAl5MxPN8V7k5c11+lYv9p6uzrHkMcvFqmF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=miXnKX1fr8eAlT1Fk0p2IdptnW1+LJdi7uysvbRokd2GgJci4xzYBl5zZFdZOJrPLTFM+q21pnJlDDVHTy1t3ajsL2cYwGExwHaUV3HuYEiycBRDAPS7ZVP7L4yCKYzv9YuU5AuefqFqvHsBxskC9pihPkkQYEnNfe3x78MH4vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QnJ0nbNR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QnJ0nbNR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740071180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bB46Nm2kFD4Abk+k0kT/7LX3vbyAD2AErVJmnTHhl9w=;
	b=QnJ0nbNRj5WPdEAtkTZYhbd2x1drItBxfY5ZOOSDHjfLObj6ABGqLoCSHsui3n9tsz/B01
	kb1rdDf1aZi5I9/uGUaKP/9i+2ZMkp9V+T2LQPKoQJu2l9t5WYLn7aMZw/BFK2o0WXkX0i
	Dta+stMVlT6d4STvRslBVSJwhbP0Zfo=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-inNOW5BjPEqXFmNVQ0UHEQ-1; Thu, 20 Feb 2025 12:06:18 -0500
X-MC-Unique: inNOW5BjPEqXFmNVQ0UHEQ-1
X-Mimecast-MFC-AGG-ID: inNOW5BjPEqXFmNVQ0UHEQ_1740071177
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-54621912db4so784223e87.2
        for <fstests@vger.kernel.org>; Thu, 20 Feb 2025 09:06:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740071177; x=1740675977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bB46Nm2kFD4Abk+k0kT/7LX3vbyAD2AErVJmnTHhl9w=;
        b=B4kRDDFdXIEHZVxDrQWEbopyLWPZ1YF/I8Pl/4WFSOWgg3IZa86Y0hhNFN5EdRMiHf
         Y+PKaGWm6zlduU5e9V81b4u4raWN+PFZoYJgVuwHJg1Rp3pfmEhjdTxOm1xtDX9WeS8/
         1edYg6N36dvoDbLQoafbHMObQKYVK/nyceBxsnaQcIa6kCFb4zq6y18Q9AHronWXVOQG
         ENgA98UXLtxmgjeRyiM58WkdjrRAoazg2TsHIuwiOHItHRcQTNZDSdCrweDyWxALhWQW
         e6LYQK3NMPXBsZqzLrk8tv2uLzO37/mxy0W+EP3QafZolxhZsDNIluBYVW+r2wm5NP5l
         THpA==
X-Gm-Message-State: AOJu0YzTRt1g+s1crkTOOr6qZamTudLQyXADNVH3nJR7LPKez2NxuNUe
	sFlme3oCD8E9rj5yReUpGzufrztws+r4nV/vP5BQ0L8KvvLszvkoCmjLoO4FmLv/0k6c9kSZssc
	/DkVk7ad59Y2vA+r7w1TMFRIZbRNe16OEQhSmY8tx9telARlv4usRvgqrhOMg7SvtMf/H8elmKs
	rgP7yXxz3DHaSSivz4Z4t03bD8S3Xy5A==
X-Gm-Gg: ASbGnctxwdm5lgHxHUOvxfbZBV1Qhs6DnGpUKNiCqL3UokoJNk2SaRDwVGXPyMdxEWD
	P7FO87JmxphKYRczl7Vu2ek1Qrj6oRcv0yUrSZlEsAUml5YlDiNSiorOnLSh8MsQ=
X-Received: by 2002:a05:6512:ac2:b0:545:2d80:a47d with SMTP id 2adb3069b0e04-5452fe71bf3mr10041576e87.44.1740071176788;
        Thu, 20 Feb 2025 09:06:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyA30bz014XJj/nRlif0gi5qM7G4T5qaxOIYvMfUQw2BLjOMQnHr6/6n+iaVXCTIRaqfD5ygixtov3Jyz2Egk=
X-Received: by 2002:a05:6512:ac2:b0:545:2d80:a47d with SMTP id
 2adb3069b0e04-5452fe71bf3mr10041536e87.44.1740071176308; Thu, 20 Feb 2025
 09:06:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220072226.175071-1-bxue@redhat.com> <20250220151528.GC2150479@mit.edu>
In-Reply-To: <20250220151528.GC2150479@mit.edu>
From: Boyang Xue <bxue@redhat.com>
Date: Fri, 21 Feb 2025 01:06:04 +0800
X-Gm-Features: AWEUYZlnjsNAJNKxCl1HyEC8IV46gYA-VqIgKnbwax21ZTyNAzPBO2ixGB_2N5k
Message-ID: <CAHLe9YYjX-78hHCb9ftBc3=OsBJBpPmV+5_C=72BRbhOVH8qTg@mail.gmail.com>
Subject: Re: [PATCH v1] ext4: add test case 061 for ext3 to ext4 conversion
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ted,

Thanks for your reply. I learned a lot from the text.

On Thu, Feb 20, 2025 at 11:16=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wrot=
e:
>
> I'm curious why this is something that you care about this particular
> case?  Historically, Red Hat (nor any other enterprise distribution)
> has supported changing or adding ext4 feature flags.  What users were
> told to do was to create a new ext4 file system, and then copy the
> files (or do a backup/restore) to the new file system.

We had learned we did have customers insist on doing the conversion
rather than creating a fresh new ext4 and copying files for some
reason, so we hope our test can cover this use case.

> Over a decade ago, when I was at Google, we did do a transition of
> file sytems from ext2 to ext4 (in no-journal mode) for all files
> stored in our cluster file systems.  Our experience for our partcular
> workload is that the performance delta between an existing file system
> that was formatted w/o extents, and uninit_bg, and then converted to
> "ext4" using tune2fs, was roughly half the performance improvement of
> a file system that was freshly formatted to use ext4 once the file
> system was filled to roughly the same level, so that file system aging
> wastaken into account.
>
> So users who do the conversion won't get the full benefits of ext4.
> Also, the exact set of file system features that we changed was
> different from from what you are testing.  I'd also note that this
> test is just filling a 1G file system, then changing the file system
> features, and then running fsck on the file system, and then trying to
> mount the file system.
>
> This isn't actually a very exhaustive test of doing a "conversion".
> If you really want to do a "coversion" test, what I'd recommend is to
> fill the TEST_DEV to be about 50% full, and then make the changes to
> the file system features, and then running the xfstests using the ext4
> file system type without SCRATCH_DEV being set up.  This would do a
> much better job of testing this case, without needing to add a new
> test to xfstest that to be honest, isn't really all that effective at
> testing this case.

I'm curious why the TEST_DEV is about 50% full is more effective at
testing this case?

>
> What did we do, 10+ year ago?  Well, we ran xfstests using the a file
> system config[1] that didn't have flex_bg set, since that's one of the
> primary differences when using a "converted" file system.  We then
> using tune2fs to convert 1% of the file systems in a single failure
> domain of the cluster file system, and watched looking for potential
> problems, and measuring for any performances gains (or losses).  We
> then gradually increased the percentage of file systems converted to
> 2%, 5%, etc which is considered best practice[2] when doing this kind
> of feature rollout.
>

I'm wondering is the [1] ext4 config can be used to simulated a
tune2fs converted ext3 fs?

> [1] https://github.com/tytso/xfstests-bld/blob/master/test-appliance/file=
s/root/fs/ext4/cfg/ext3conv
> [2] https://books.google.com/books?id=3D81UrjwEACAAJ
>
> Cheers,
>
>                                                 - Ted
>

Cheers,
Boyang

