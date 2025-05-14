Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31863EA98
	for <fstests@vger.kernel.org>; Wed, 14 May 2025 05:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747199772; cv=none; b=jv30BZoYhCbY6lVVKLk/lCwzKeu/1QYr+0VNdR0C9KrZEHJZjvt+R7h93C8SKg97XFtgI/P0X+rTEc5RRVhF86TXcfSej+EMp6ATDBQa4OB9v20BkwwZOnm1LXfbgGXR/AnzlpNf/wbo77Wnl1GFWsDX5P1OaqKKhM1iYgHVnak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747199772; c=relaxed/simple;
	bh=ZYWfRoUNdCbMMtF+BzpN03zk/VJ8HtJCHtEmMns4WK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBFHm3vWeIEt8yxE2z+vvTad1S23GE9GRiz/7gXfC+/ik3ZAvK5wDabZkYyAvtenydlcbC3j3ur5ljK8sIPZw9SgD6Ps1GW/Of5Ieh5sH7l+Fvel2mw0AITQrHqhIeGrU4+qoU3w/TbYEch1HcaRSBDIIsaC1vcuqYVoI/lD1s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C5umeuRX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C5umeuRX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747199769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GrxAGHg+YeGRcnPC87DHevJMZf8wlrTQXSUswW5GY/o=;
	b=C5umeuRXJsZlUhhTFqOWqQqxNYteTjW9knFfbafLkh5+Av0gBSLrBNPtMAlzN0moHgdFX5
	jNN0EsaiADqExgxR2PUu1GXTT6lQeHYrzZ8aHCOcNU57eTkjmPWmoWMuHaSJOQP5TR+uzq
	hbtQ4ijCvr7H9tTdJ6EdX+svx0Uzh1c=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-9hfQl3BQNbuxW8MzXjpS2g-1; Wed, 14 May 2025 01:16:08 -0400
X-MC-Unique: 9hfQl3BQNbuxW8MzXjpS2g-1
X-Mimecast-MFC-AGG-ID: 9hfQl3BQNbuxW8MzXjpS2g_1747199767
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-74089884644so5730477b3a.3
        for <fstests@vger.kernel.org>; Tue, 13 May 2025 22:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747199767; x=1747804567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrxAGHg+YeGRcnPC87DHevJMZf8wlrTQXSUswW5GY/o=;
        b=Ke5k3fZ5bRscgyarhx4KboO6IgUSzJZ3VoCEdLEOa9s0Pz7D+kwmNhXKoE2tD926AQ
         r8QsrKbx1AheqyBq6+mO4ZxjpJldskLgFoYUeK/0itA0sxDKunCPw4A9zjNJbO1uIef6
         +JId1b0VLszPzgWxjmQdzY9xu7HFZvypGCp9B1dnnRlZePxRjYKlSL7R78IvjC+AnkjS
         Tih1Ywp3nFbDwm+oirhD8Z1mskaK87G6leFDUrf7Kd7HI2PmRmPaTy0Afvq7Oxo5S+vU
         p5Lcw6jQa6J45IIdRacXut7ULiuTKa6V/lQUwqLuBnRhc8Mypz8j95AyK1fSKT+XNFV2
         OlYw==
X-Gm-Message-State: AOJu0YymG3vdBQUwc6Dr/KNlJYCFY4gGAFRu1yHloNhYyRaszDCqv/rt
	SMsGP+sxPf7SHLNpYxlxQjhdqzQgdCiRgbbvoWH4FddBUht/1fZyJr6dgcO9NB0J4SYdVTxqzO/
	ZFR27+hf7GwfwKRQcRIVnLCx4ZfHYIgMDxqC4KTjV5FSD51xA3cmk89E=
X-Gm-Gg: ASbGncvySyG7JANhxP9nO+d1TwHWyXzMD83uhdtnzbYhbv3Eri0ocEAZ7pzrCiNP/1z
	yxTMb9MCxzpJOpEEIkF5SyxtWgM8Sox16RjaqQaGEL2dIvpmrNObQG+o6iDJ0aAkIz07FXUZnzI
	ZuhEW8DQf7HcJX4kvl//eQT6or+Rw8wZJmGhZ8/8w56Shz9eXL5BDmG/v0q6wubEYePiOGdugRd
	BoeOhUtjalijYj6Vq/FyO57EeCTaUL8wRYsYqX0lJvDAGIFHRIP57YkS9cdGLIi7MczA3aKw8tq
	mdzLV4T8dqLYysergAF8K2lb8XayNmQRwjv7CtLV3aVZevD3pa1w
X-Received: by 2002:a05:6a20:258c:b0:1f5:7eb5:72dc with SMTP id adf61e73a8af0-215ff088295mr3149755637.3.1747199767324;
        Tue, 13 May 2025 22:16:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpp7Lh1H7QdSXACO08YRZOZ54s4dp4ICWCaeCGfReWKcc3fDzy5gX5ZLHst/pvYxZN431xkA==
X-Received: by 2002:a05:6a20:258c:b0:1f5:7eb5:72dc with SMTP id adf61e73a8af0-215ff088295mr3149727637.3.1747199767021;
        Tue, 13 May 2025 22:16:07 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b234ab540f0sm8077793a12.34.2025.05.13.22.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 22:16:06 -0700 (PDT)
Date: Wed, 14 May 2025 13:16:01 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
	david@fromorbit.com
Subject: Re: [PATCH v1 3/3] new: Run make after adding a new test file
Message-ID: <20250514051601.xj2lzfcmvruovorm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1747123422.git.nirjhar.roy.lists@gmail.com>
 <cf589731ad93deb067f6dadf0d80604884fb330a.1747123422.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf589731ad93deb067f6dadf0d80604884fb330a.1747123422.git.nirjhar.roy.lists@gmail.com>

On Tue, May 13, 2025 at 08:10:12AM +0000, Nirjhar Roy (IBM) wrote:
> Once a new test file is created, it needs to explicitly
> added to the group.list file in tests/<FSTYPE> directory
> in order for it to get run. Automate
> that by running make by as a part of creation of the new
> test file in the "new" script.

I think it's not necessary to force to do that, the users can do "make -jN"
when they need :)

> 
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---
>  new | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/new b/new
> index e55830ce..647763c1 100755
> --- a/new
> +++ b/new
> @@ -191,5 +191,13 @@ QA output created by $id
>  Silence is golden
>  End-of-File
>  
> +echo "Adding test $tdir/$id to the test list..."
> +make >> /dev/null 2>&1 || true
> +
> +if ! grep -q $id $tdir/group.list; then
> +	echo "$tdir/$id created but not added to the $tdir/group.list."
> +	echo "Possible reason is make failure. Please ensure a clean build"
> +fi
> +
>  echo " done."
>  exit 0
> -- 
> 2.34.1
> 
> 

