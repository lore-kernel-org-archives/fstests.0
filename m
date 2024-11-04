Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BC61B6D0B
	for <fstests@vger.kernel.org>; Mon,  4 Nov 2024 13:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730725486; cv=none; b=GROjnGVKSScW/KiY/ZQWq9OdSyuexjplXnSgfFVmXgHLR8qEjPcxMD4a5Oq1+VQ4EMBdvGbVj0a7GWtVeU7r88cIjCAi1kFyKOwgBbvaWMzeqRKgNNRuX49q9O0e7lYvDj6pEbzwCxiCdz/X7Iw0MCBCxJ2qzTWAudTa0D1+9xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730725486; c=relaxed/simple;
	bh=JIVJerlRTlFpljSApZVHeEHrB07LV3HDpmzwjykp3CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYB7uiANjBzl+R2gm2ff6asP5u7cZu0gmscZ5F6VJLtIMnCT6gg2JnnsnY23/bSKg3eubiqR9ni81vpo8pCxjtwaKpSycs0Kfmbu8Gz4fzfl0LVAfPTMxnkmPSzZLg2PgnFoGZq0qGNIvD9no1h6RNY1seqn0JYUF23wEOfU0Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J2/wjfKd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J2/wjfKd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730725483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=69MZgo53xdQTUuf4KildLTNyR8uOmDtjJkAS/qyAx6o=;
	b=J2/wjfKdZ4DkEFNvN51VAgWJYuvc/nE/m0iqMIl/7JzrFiTdRKGAbbF9qnOla7vdFxNNxm
	ez8Vuhso77NdVEvor7fRcPsBC1XFAVYQtMIO/U8GRlyVKB7eDcZmGSCWlmZZ1rVaBZQ2Fs
	iv+l20NSP7GyCd+ssw7LCK6fk8H4jLs=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-IP9V7fWPMDmzJndKz3Cfhw-1; Mon, 04 Nov 2024 08:04:42 -0500
X-MC-Unique: IP9V7fWPMDmzJndKz3Cfhw-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-20cc1fddb87so43942895ad.0
        for <fstests@vger.kernel.org>; Mon, 04 Nov 2024 05:04:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730725481; x=1731330281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69MZgo53xdQTUuf4KildLTNyR8uOmDtjJkAS/qyAx6o=;
        b=d9NmpS6GWkPnusPhNIVHTpiroVWc7nkL//IILfjAwFNJjixgl44QLNs45IUJYKeSYc
         ldS6wdWm5upOUleW2a3Ieoh5AEC11alN21bADBKF6wevO6AC1UIZu46+FFPTEk5x8MHJ
         HLEbYApt7SG4qVweuL5q2qzZcAbmiIxvi+QK7ouGTqCRJRVrnCVCzp5E0C74o72pbVtT
         aB+REEoRaKyT3Lt9FBq9A9FbilxiUXQ+12gNkrlf73tMBDsMm3ubBXlNiUNp9qeuFvRF
         CWP2hBQWhRfoOxSdKJOzqlEYd/6R4/J58R/n0HTLHN0OK4TNfUhOBZYVuxFzSalf97Sh
         u98Q==
X-Forwarded-Encrypted: i=1; AJvYcCVneTE1OcWjmqislPF8GZsQgEAw80pIEfcEqZ2A4/3Vv+3QcpoiSXxrF2oiJS9LJEvDYaKEWRW1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2CtwMuSqdK+0xw+GL3aPIlJ8E+AR6c/m38d8BNAdxuwwY97QD
	nzeXoeTggMRARbSvtdkL0iFExCEwATsxAV53iIx9gxF7YIH/q+jZjgBt7e7GmXSluVVwVw3GcKJ
	5IF333y16TL5BzHyJxgXAbqg2W4zsgVb62PrcCdB3S+VA3ljTApeitgw=
X-Received: by 2002:a17:902:d2c8:b0:20c:a055:9f07 with SMTP id d9443c01a7336-21103b1a5cfmr231305665ad.26.1730725481505;
        Mon, 04 Nov 2024 05:04:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1zB7hshLmK3bdT9vv7eF/CePpsM2Sm9znYFsEIhEEn0Uu66xnZ1JLP4KUhI4jAsGI5ThCFw==
X-Received: by 2002:a17:902:d2c8:b0:20c:a055:9f07 with SMTP id d9443c01a7336-21103b1a5cfmr231305335ad.26.1730725481125;
        Mon, 04 Nov 2024 05:04:41 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057c728asm60164885ad.231.2024.11.04.05.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 05:04:40 -0800 (PST)
Date: Mon, 4 Nov 2024 21:04:37 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH] xfs/157: mkfs does not need a specific fssize
Message-ID: <20241104130437.mutcy5mqzcqrbqf2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241031193552.1171855-1-zlang@kernel.org>
 <20241031220821.GA2386201@frogsfrogsfrogs>
 <20241101054810.cu6zsjrxgfzdrnia@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20241101214926.GW2578692@frogsfrogsfrogs>
 <Zyh8yP-FJUHKt2fK@infradead.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zyh8yP-FJUHKt2fK@infradead.org>

On Sun, Nov 03, 2024 at 11:50:32PM -0800, Christoph Hellwig wrote:
> On Fri, Nov 01, 2024 at 02:49:26PM -0700, Darrick J. Wong wrote:
> > > How about unset the MKFS_OPTIONS for this test? As it already tests rtdev
> > > and logdev by itself. Or call _notrun if MKFS_OPTIONS has "rmapbt=1"?
> > 
> > That will exclude quite a few configurations.  Also, how many people
> > actually turn on rmapbt explicitly now?
> > 
> > > Any better idea?
> > 
> > I'm afraid not.  Maybe I should restructure the test to force the rt
> > device to be 500MB even when we're not using the fake rtdev?
> 
> All of this is really just bandaids or the fundamental problem that:
> 
>  - we try to abitrarily mix config and test provided options without
>    checking that they are compatible in general, and with what the test
>    is trying to specifically
>  - some combination of options and devices (size, block size, sequential
>    required zoned) fundamentally can't work
> 
> I haven't really found an easy solution for them.  In the long run I
> suspect we need to split tests between those that just take the options
> from the config and are supposed to work with all options (maybe a few
> notruns that fundamentally can't work).  And those that want to test
> specific mkfs/mount options and hard code them but don't take options
> from the input.

So how about unset extra MKFS_OPTIONS in this case ? This test has its own
mkfs options (-L label and logdev and rtdev and fssize).

Thanks,
Zorro

> 
> 

