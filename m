Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1E72BEC20
	for <fstests@vger.kernel.org>; Wed, 11 Feb 2026 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770823777; cv=none; b=RShHnpwIM0iOUPM7ITuhnpsY84Fb1HuIVbdYVkL+RMQtByqqonraQ4wyehklHdSVjy9YV5/P42LbSAdKDQu2FjpKCFdfkY7PQ7e41YKi9xXAJ4X4TVihn9sYTP28xyd7b8D7eDsKujZ9wgF+R7476cC4De4d0kUzFlQLQgVUejc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770823777; c=relaxed/simple;
	bh=b64Xf2zMu8Hzoy98Z5bfuIchMV2mBnZdtWtUVUOjN1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1Fi0yTYeNvFfpZ/7RWuk+BdET+xjmU2m/hTxt5bIu5Iss2FIDZV3IcKU7uOalv96AUpNxivIcOTOmnnD/LfkbKsIF3Ysj8okBJmpcpFyr97J0L+RyYwi6FSmDbHemqwGsfAJv3h5EuVPaqVX7rYE7ugSiWH4AhHoIdkEhHWKaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TDZw8Aak; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=T6ERQ+4A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TDZw8Aak";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="T6ERQ+4A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770823775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SkZ0GRM5BgRNWScOudCv1dn4NmDkxX3Pikw1Zb7kdI4=;
	b=TDZw8Aaket9EwF7DxEchxGhEmNr/PDWPsfoH7rq7zyfUqWX/s7jFebGhtiDbDRQuS6hkov
	N05CB/sHQPIH259bQaqjhbY+J5cyY8aR8AugBCso3LGe5LaifNr9hTpBNvgC/Xl3AnloMM
	/cIOTfKH3ayTABp1vBO87Rtbqoa72dc=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-KhW6T686PICoywSdDr3sBA-1; Wed, 11 Feb 2026 10:29:33 -0500
X-MC-Unique: KhW6T686PICoywSdDr3sBA-1
X-Mimecast-MFC-AGG-ID: KhW6T686PICoywSdDr3sBA_1770823773
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a943e214daso170637645ad.3
        for <fstests@vger.kernel.org>; Wed, 11 Feb 2026 07:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770823772; x=1771428572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SkZ0GRM5BgRNWScOudCv1dn4NmDkxX3Pikw1Zb7kdI4=;
        b=T6ERQ+4AaOdAr+XvXqjxGDNDdrvwPfNNHyQtbS1M+QjwfujXTV9SQlvWMHUXKtJeZH
         IbJgSCAk3AEqdyMWkffKTCB1EqJaKbHNpAPrnUBVfKhHa91YoLz2/V7wzfVvu+q/393V
         0chltElA3Jl7C/JDcSFepk1ny+S3LaZEx2H6oQDNPuYoqj4r+/+IJS6UMbnpV+Dz7HtC
         f1gQ8UosbJFXr9pIIzyiqGXOsX009AVcYhztFnB8Jfv+Inh2aZaGSjWKHTvySQwWTDVF
         eDy8NMNleSxErH4lk/Qsx00YHJ9UJcQCx78c/OPVTxn1fL2StbOo+bQzjWhdy7iqhMbB
         PREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770823772; x=1771428572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkZ0GRM5BgRNWScOudCv1dn4NmDkxX3Pikw1Zb7kdI4=;
        b=q0NRZnVA280oWTYaxZJ9xxb5PsZCLbX3mfMQl/F3kZ6bFaK29arjmyI06d2N3SxDnA
         bDhJBIWFs6JQzqUl2xX768sfg+tAUOvMfUpDINx/JtUL0+TAIGBBykYZvTsWVaWGqHGR
         JhT4Q5sNZZ6ncbDIU3GzZvklqvDoEROtQ4IPNjto5BFm/XQR3UosYl1pUvbyxPyANfFa
         o9aSqjdy+UxREtuFiKG1c4XEru5CkwWd7MV+vHhTDk3oTqewntIo95AYQKqc8BTO2jVO
         GdocJeHa4pu1FJdPoB5fx7U/tLoovTsEZy0D9hj8uGAfEU4A5TRe3RRsQZmPclSvgOvE
         8XvQ==
X-Forwarded-Encrypted: i=1; AJvYcCX99bINw7W/WcPVqLLdfDV1qFmm/St/Jd02XveMzBt1mpxjGenz6BoGNAXuu8rhWQHYwxsNHbDN@vger.kernel.org
X-Gm-Message-State: AOJu0YyCkZ70TWtuxpXlWBDXRaje4XyvtZ9JQkoBRysZKkQ9fOSDIhqq
	QZmoloDcOg1YcuQQhGKg63DL2ozBrqY4mw2S8GL+qPYwrUC/tt1JvkQPJhH8BEVDTWw1XwSrT8L
	YyXxIW0Ga5xagLxNEifAPw0Mf7HvWl3JpR60GFiNnlmO3/qvt2Vx7ti/DBQI=
X-Gm-Gg: AZuq6aLVAvcjVA97BpgLKBuy6QFF0pWBvxL6Qah+XBmzgORop+at01vR42xpWEMoqoP
	dyLvBQ6HwZS/6Lyy1n7WM44Qt5xqV17ElqT/MsZtlXk5OJxaWUxkCxoP9Lb9RdjXT+85Sh3HZ88
	ALeCfHSVRL6c75rpNJ1Hl+iOP0CzgddzTWRybGJ/rouyoWSwgnxtlhedWHSWCH5U72qsu8RbT/5
	krc1Cq0NCQudTNvyiA+fzjT/XJgpd/SK+kUpxk8nbj3P4RZJY7CY4caBdKvcxlevDF2i8W7e7pS
	2h2yS/Dl1MIvseQ1aFx7A/2VrVrL200/xtKyOup5YXFP324DCfnJ1zp2QON2OLtzvaadgSd+kGL
	YypjTThm8HtY5LlrpP2yCG6ZPB1FrNzDqNGMmSJ0tBwytsVz+gBezJepMULF1DA==
X-Received: by 2002:a17:903:46cc:b0:2aa:e1f0:5495 with SMTP id d9443c01a7336-2ab2acb68c9mr22395575ad.45.1770823772500;
        Wed, 11 Feb 2026 07:29:32 -0800 (PST)
X-Received: by 2002:a17:903:46cc:b0:2aa:e1f0:5495 with SMTP id d9443c01a7336-2ab2acb68c9mr22395395ad.45.1770823772110;
        Wed, 11 Feb 2026 07:29:32 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab29998b74sm28624615ad.84.2026.02.11.07.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 07:29:31 -0800 (PST)
Date: Wed, 11 Feb 2026 23:29:26 +0800
From: Zorro Lang <zlang@redhat.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: hch <hch@lst.de>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	Hans Holmberg <Hans.Holmberg@wdc.com>,
	Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] fstests: test premature ENOSPC in zoned garbage
 collection
Message-ID: <20260211152926.goznos4fsehl6xip@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20260210111103.265664-1-johannes.thumshirn@wdc.com>
 <20260210155123.GA3552@lst.de>
 <676f3219-c4f8-430f-b479-904cbb64d6b6@wdc.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <676f3219-c4f8-430f-b479-904cbb64d6b6@wdc.com>

On Tue, Feb 10, 2026 at 03:58:06PM +0000, Johannes Thumshirn wrote:
> On 2/10/26 4:52 PM, Christoph Hellwig wrote:
> > On Tue, Feb 10, 2026 at 12:11:03PM +0100, Johannes Thumshirn wrote:
> >> diff --git a/tests/generic/783 b/tests/generic/783
> >> new file mode 100755
> >> index 000000000000..f996d78803a1
> >> --- /dev/null
> >> +++ b/tests/generic/783
> > What tree is this against?  generic/783 has already been added to
> > xfstests in Nov 2025.
> 
> Apparently I haven't re-based in a while, should be generic/788 with 
> today's master.

Please always rebase on for-next branch, or you can use a large number temporarily
(e.g. generic/999) to avoid conflict, I'll give it a proper number when I merge it.

Thanks,
Zorro

> 
> 
> >> +if [ "$FSTYP" = btrfs ]; then
> >> +	_fixed_by_kernel_commit XXXXXXXXXXXX \
> > Can we please finally clean up all this mess with a
> > _fixed_by_fs_commit <fstype> <commitid> helper?
> >
> >
> Maybe but that's a different topic.
> 

